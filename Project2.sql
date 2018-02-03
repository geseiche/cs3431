-- Grace Seiche and Anthony Topper
-- CS 3431 Project 2




-- Question #1


create or replace view NoLabMgr as
select count(A.accountName) as staffCount, locationID
from
        (select L.locationID, C.accountName
        from locations L, CSStaff C
        where L.locationType = 'Office' and C.officeID = L.locationID) A,
        (select distinct accountName
        from CSStaffTitles
        where acronym <> 'Lab1' and acronym <> 'Lab2') B
where A.accountName = B.accountName    
group by locationID
having count(*) > 1;  




-- Question #2


set serveroutput on;


CREATE OR REPLACE PROCEDURE NumberOfStaff (offID VARCHAR2) IS
c NUMBER;
BEGIN    
        SELECT COUNT(*) INTO c
        FROM CSStaff
        WHERE CSStaff.officeID = offID;
        dbms_output.put_line(c);
END NumberOfStaff;
/


-- just a check to see if it works, should return 3
exec NumberOfStaff(233); 


-- Question #3


create or replace trigger TitleLimit
before insert or update on CSStaffTitles
for each row
declare
        cursor C1 is (Select accountName, count(*) as C
                        from CSStaffTitles natural join
                            (Select accountName
                            from CSStaffTitles
                            where acronym like '%Prof')
                        group by accountName);
        tempvalue NUMBER;
begin
        for rec in C1 loop
            if (rec.C > 3) then
                RAISE_APPLICATION_ERROR(-20003, rec.accountName || ' already has 3 titles');
            end if;
            if rec.accountName = :new.accountName and rec.C >= 3 then
                RAISE_APPLICATION_ERROR(-20003, rec.accountName || ' already has 3 titles');
            end if;
        end loop;
        select count(*) into tempvalue
        from CSStaffTitles
        where accountName = :new.accountName;
        if :new.acronym like '%Prof' and tempvalue >= 3 then
            RAISE_APPLICATION_ERROR(-20003, :new.accountName || ' already has 3 titles');
        end if;
end;
/




-- Question #4


create or replace trigger MustBeOffice
before insert on Offices
for each row
declare
        cursor C1 is (select O.officeID as offID, L.locationType as locType
                    from Offices O, Locations L
                    where O.officeID = L.locationID);
        tempvalue varchar2(15);
begin
        For rec in C1 loop
            if rec.locType <> 'Office' then
                RAISE_APPLICATION_ERROR(-20004, rec.offID || ' is not an office');
            end if;
        end loop;
        select locationType INTO tempvalue
        from Locations
        where locationID = :new.officeID;
         if tempvalue <> 'Office' then
            RAISE_APPLICATION_ERROR(-20004, :new.officeID || ' is not an office');
         end if;
end;
/




-- Question #5


create or replace trigger NoSameLocations
before insert on Edges
for each row
begin
        if :new.startingLocationID = :new.endingLocationID then
            RAISE_APPLICATION_ERROR(-20005, 'Same start and end location');
        end if;
end;
/




-- Question #6


create or replace trigger CrossFloorEdge
before insert on Edges
for each row
declare
        startLocType varchar2(15);
        endLocType varchar2(15);
        startLocFloor char(1);
        endLocFloor char(1);
begin
        select locationType, mapFloor into startLocType, startLocFloor
        from Locations
        where locationID = :new.startingLocationID;
        select locationType, mapFloor into endLocType, endLocFloor
        from Locations
        where locationID = :new.endingLocationID;
        if ((startLocFloor <> endLocFloor)
            and not ((startLocType = 'Staircase' and endLocType = 'Staircase')
                or (startLocType = 'Elevator' and endLocType = 'Elevator'))) then
                RAISE_APPLICATION_ERROR(-20006, 'Locations on different floors, but not stairs or elevator');
        end if;
end;
/




-- Question #7 Test Insert Statements


-- Question 3: TitleLimit
-- test with professor
 -- b/c cew has only 2 titles, the following should succeed
insert into CSStaffTitles values('cew', 'Lab1');
 -- b/c cew now has 3 titles, the following should fail
insert into CSStaffTitles values('cew', 'Lab2');
-- test with non-professor
-- all should succeed b/c rcane is NOT a variation of a professor
insert into CSStaffTitles values('rcane', 'Lab1');
insert into CSStaffTitles values('rcane', 'Lab2');
insert into CSStaffTitles values('rcane', 'Admin 5');
-- test with non-professor who becomes a professor in 4th title
-- ghamel is NOT a variation of a professor
-- following two should succeed
insert into CSStaffTitles values ('ghamel', 'Lab1');
insert into CSStaffTitles values ('ghamel', 'Lab2');
 -- the following should fail b/c adding title Prof as 4th title
insert into CSStaffTitles values ('ghamel', 'Prof');


-- Question 4: MustBeOffice
-- insert non-offices, should fail
insert into Offices values ('222');
insert into Offices values ('2E1');


-- Question 5: NoSameLocations
-- same locations, the following should fail
insert into Edges values ('344', '222', '222'); 
-- different locations, the following should work
insert into Edges values ('123', '222', '231'); 


-- Question 6: CrossFloorEdge
--different floors, the following should fail
insert into Edges values ('a', '319', '244'); 
 --stair to elevator, the following should fail
insert into Edges values ('b', '2S1', '3E1');
--stair to stair, the following should succeed
insert into Edges values ('c', '2S1', '3S1');