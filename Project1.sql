
-- Anthony Topper
-- Grace Seiche
-- Project 1, Phase 1
-- p1.sql

drop table Paths;
drop table DirectedEdges;
drop table StaffMembers;
drop table FLocations;
drop table JobTitles;

create table JobTitles(
	fullTitle varchar2(50),
	acronym varchar2(20),
	constraint JOBTITLES_PK Primary Key (fullTitle),
	constraint JOBTITLES_ACRONYM_U Unique (acronym)
);

create table FLocations(
	locationID number,
	locationName varchar2(25),
	Xcoord number,
	Ycoord number,
	floor char(1),
	locationType varchar2(25),
	roomNumber varchar2(10),
	constraint FLOCATIONS_PK Primary Key (locationID)
);
    

create table StaffMembers(
	accountName varchar2(25),
	firstName varchar2(25) NOT NULL,
	lastName varchar2(25) NOT NULL,
	phoneExt number(4),
	fullTitle varchar2(50) default 'Professor',
	officeID number,
	constraint STAFFMEMBERS_PK Primary Key (accountName),
	constraint STAFFMEMERS_FULLTITLE_FK Foreign Key (fullTitle) References JobTitles(fullTitle),
	constraint STAFFMEMBERS_OFFICEID_FK Foreign Key (officeID) References FLocations(locationID)
);

create table DirectedEdges(
	edgeID number,
	startLocID number,
	endLocID number,
	constraint DIRECTEDEDGES_PK Primary Key (edgeID),
	constraint DIRECTEDEDGES_STARTLOCID_FK Foreign Key (startLocID) References FLocations(locationID),
	constraint DIRECTEDEDGES_ENDLOCID_FK Foreign Key (endLocID) References FLocations(locationID)
);

create table Paths(
	pathID number,
	startLocID number,
	endLocID number,
	sequenceNumber number,
	edgeID number,
	constraint PATHS_PK Primary Key (pathID),
	constraint PATHS_STARTLOCID_FK Foreign Key (startLocID) References FLocations(locationID),
	constraint PATHS_ENDLOCID_FK Foreign Key (endLocID) References FLocations(locationID),
	constraint PATHS_EDGEID_FK Foreign Key (edgeID) References DirectedEdges(edgeID)
);


insert into JobTitles values ('Adjunct Associate Professor', 'Adj Assoc Prof'); 
insert into JobTitles values ('Administrative Assistant V', 'Admin 5'); 
insert into JobTitles values ('Administrative Assistant VI', 'Admin 6'); 
insert into JobTitles values ('Assistant Professor', 'Asst Prof');
insert into JobTitles values ('Assistant Teaching Professor', 'Asst TProf'); 
insert into JobTitles values ('Associate Professor', 'Assoc Prof'); 
insert into JobTitles values ('Coordinator of Mobile Graphics Research Group', 'C-MGRG');
insert into JobTitles values ('Department Head', 'DeptHead'); 
insert into JobTitles values ('Director of Data Science', 'Dir-DS'); 
insert into JobTitles values ('Director of Learn Sciences and Technologies', 'Dir-LST'); 
insert into JobTitles values ('Graduate Admin Coordinator', 'GradAdmin'); 
insert into JobTitles values ('Lab Manager I', 'Lab1'); 
insert into JobTitles values ('Lab Manager II', 'Lab2'); 
insert into JobTitles values ('Professor', 'Prof'); 
insert into JobTitles values ('Senior Instructor', 'SrInst'); 
insert into JobTitles values ('Teaching Professor', 'TProf'); 

insert into FLocations values (1, 'FL129', NULL, NULL, '1', 'Office', '129'); 
insert into FLocations values (2, 'FL130', NULL, NULL, '1', 'Office', '130'); 
insert into FLocations values (3, 'FL132', NULL, NULL, '1', 'Office', '132'); 
insert into FLocations values (4, 'FL133', NULL, NULL, '1', 'Office', '133'); 
insert into FLocations values (5, 'FL135', NULL, NULL, '1', 'Office', '135'); 
insert into FLocations values (6, 'FL137', NULL, NULL, '1', 'Office', '137'); 
insert into FLocations values (7, 'FL138', NULL, NULL, '1', 'Office', '138'); 
insert into FLocations values (8, 'FL139', NULL, NULL, '1', 'Office', '139'); 
insert into FLocations values (9, 'FL144', NULL, NULL, '1', 'Office', '144'); 
insert into FLocations values (10, 'IMGD Lab', NULL, NULL, '2', 'Lab', '222'); 
insert into FLocations values (11, 'FL231', NULL, NULL, '2', 'Office', '231'); 
insert into FLocations values (12, 'FL232', NULL, NULL, '2', 'Office', '232'); 
insert into FLocations values (13, 'FL233', NULL, NULL, '2', 'Office', '233'); 
insert into FLocations values (14, 'FL234', NULL, NULL, '2', 'Office', '234'); 
insert into FLocations values (15, 'FL235', NULL, NULL, '2', 'Office', '235'); 
insert into FLocations values (16, 'FL236', NULL, NULL, '2', 'Office', '236'); 
insert into FLocations values (17, 'FL237', NULL, NULL, '2', 'Office', '237'); 
insert into FLocations values (18, 'FL243', NULL, NULL, '2', 'Office', '243'); 
insert into FLocations values (19, 'FL244', NULL, NULL, '2', 'Office', '244'); 
insert into FLocations values (20, 'FL245', NULL, NULL, '2', 'Office', '245'); 
insert into FLocations values (21, 'Beckett', NULL, NULL, '3', 'Conference Room', '300'); 
insert into FLocations values (22, 'FL311', 902, 374, '3', 'Conference Room', '311'); 
insert into FLocations values (23, 'FL320', 895, 922, '3', 'Lecture Hall', '320'); 
insert into FLocations values (24, 'Zoo Lab', NULL, NULL, 'A', 'Lab', 'A21'); 
insert into FLocations values (25, 'FLB19', NULL, NULL, 'B', 'Office', 'B19'); 
insert into FLocations values (26, 'FLB20', NULL, NULL, 'B', 'Office', 'B20'); 
insert into FLocations values (27, 'FLB24', NULL, NULL, 'B', 'Office', 'B24'); 
insert into FLocations values (28, 'FLB25a', NULL, NULL, 'B', 'Office', 'B25a'); 
insert into FLocations values (29, 'FLB25b', NULL, NULL, 'B', 'Office', 'B25b'); 
insert into FLocations values (30, 'Upper Perrault Hall', NULL, NULL, '2', 'Lecture Hall', 'PHUPR'); 
insert into FLocations values (31, 'Lower Perrault Hall', NULL, NULL, '2', 'Lecture Hall', 'PHLWR'); 
insert into FLocations values (32, 'FL316', 850, 757, '3', 'Other Room', '316'); 
insert into FLocations values (33, 'FL319', 925, 733, '3', 'Other Room', '319'); 
insert into FLocations values (34, 'FL318', 956, 704, '3', 'Other Room', '318'); 
insert into FLocations values (35, 'FL317', 925, 669, '3', 'Other Room', '317'); 
insert into FLocations values (36, 'FL314', 850, 662, '3', 'Other Room', '314'); 
insert into FLocations values (37, 'FL312', 943, 508, '3', 'Other Room', '312'); 
insert into FLocations values (38, 'FL307', 902, 440, '3', 'Other Room', '307'); 
insert into FLocations values (39, 'FL308', 902, 337, '3', 'Other Room', '308'); 
insert into FLocations values (40, 'FLH11', 842, 967, '3', 'Hallway', NULL); 
insert into FLocations values (41, 'FLH10L', 795, 922, '3', 'Hallway', NULL); 
insert into FLocations values (42, 'FLH10R', 842, 922, '3', 'Hallway', NULL); 
insert into FLocations values (43, 'FLH9', 795, 757, '3', 'Hallway', NULL); 
insert into FLocations values (44, 'FLH8L', 795, 704, '3', 'Hallway', NULL); 
insert into FLocations values (45, 'FLH8R', 924, 704, '3', 'Hallway', NULL); 
insert into FLocations values (46, 'FLH7', 795, 662, '3', 'Hallway', NULL); 
insert into FLocations values (47, 'FLH6', 902, 508, '3', 'Hallway', NULL); 
insert into FLocations values (48, 'FLH5L', 795, 469, '3', 'Hallway', NULL); 
insert into FLocations values (49, 'FLH5R', 902, 469, '3', 'Hallway', NULL); 
insert into FLocations values (50, 'FLH4L', 795, 417, '3', 'Hallway', NULL); 
insert into FLocations values (51, 'FLH4R', 821, 417, '3', 'Hallway', NULL); 
insert into FLocations values (52, 'FLH3', 795, 374, '3', 'Hallway', NULL); 
insert into FLocations values (53, 'FLH2L', 795, 342, '3', 'Hallway', NULL); 
insert into FLocations values (54, 'FLH2R', 833, 342, '3', 'Hallway', NULL); 
insert into FLocations values (55, 'FLH1', 795, 151, '3', 'Hallway', NULL); 

insert into StaffMembers values ('ruiz','Carolina','Ruiz',5640,'Associate Professor',12);
insert into StaffMembers values ('rich','Charles','Rich',5945,'Professor',29);
insert into StaffMembers values ('ccaron','Christine','Carone',5678,'Administrative Assistant VI',13);
insert into StaffMembers values ('cshue','Craig','Shue',4933,'Associate Professor',16);
insert into StaffMembers values ('cew','Craig','Wills',5357, '5622','Professor, Department Head',14);
insert into StaffMembers values ('dd','Daniel','Dougherty',5621,'Professor',11);
insert into StaffMembers values ('deselent','Douglas','Selent',5493,'Assistant Teaching Professor',9);
insert into StaffMembers values ('rundenst','Elke','Rundensteiner',5815,'Professor, Director of Data Science',5);
insert into StaffMembers values ('emmanuel','Emmanuel','Agu',5568,'Associate Professor, Coordinator of Mobile Graphics Research Group',8);
insert into StaffMembers values ('heineman','George','Heineman',5502,'Associate Professor',26);
insert into StaffMembers values ('ghamel','Glynis','Hamel',5252,'Senior Instructor',3);
insert into StaffMembers values ('lauer','Hugh','Lauer',5493,'Teaching Professor',9);
insert into StaffMembers values ('jleveillee','John','Leveillee',5822,'Lab Manager I',19);
insert into StaffMembers values ('josephbeck','Joseph','Beck',6156,'Associate Professor',7);
insert into StaffMembers values ('kfisler','Kathryn','Fisler',5118,'Professor',2);
insert into StaffMembers values ('kven','Krishna','Venkatasubramanian',6571,'Assistant Professor',6);
insert into StaffMembers values ('claypool','Mark','Claypool',5409,'Professor',27);
insert into StaffMembers values ('hofri','Micha','Hofri',6911,'Professor',4);
insert into StaffMembers values ('ciaraldi','Michael','Ciaraldi',5117,'Senior Instructor',1);
insert into StaffMembers values ('mvoorhis','Michael','Voorhis',5669, '5674','Lab Manager II',20);
insert into StaffMembers values ('meltabakh','Mohamed','Eltabakh',6421,'Associate Professor',15);
insert into StaffMembers values ('nth','Neil','Heffernan',5569,'Professor, Director of Learn Sciences and Technologies',17);
insert into StaffMembers values ('nkcaligiuri','Nicole','Caligiuri',5357,'Administrative Assistant V',13);
insert into StaffMembers values ('rcane','Refie','Cane',5357,'Graduate Admin Coordinator',13);
insert into StaffMembers values ('tgannon','Thomas','Gannon',5357,'Adjunct Associate Professor',18);
insert into StaffMembers values ('wwong2','Wilson','Wong',5706,'Assistant Teaching Professor',25);



insert into DirectedEdges values (1,55,53);
insert into DirectedEdges values (2,53,52);
insert into DirectedEdges values (3,52,32);

insert into DirectedEdges values (4,22,46);
insert into DirectedEdges values (5,46,50);
insert into DirectedEdges values (6,50,51);
insert into DirectedEdges values (7,51,33);

insert into DirectedEdges values (8,39,22);
insert into DirectedEdges values (9,22,43);
insert into DirectedEdges values (10,43,44);
insert into DirectedEdges values (11,44,45);

insert into DirectedEdges values (12,23,54);
insert into DirectedEdges values (13,54,55);
insert into DirectedEdges values (14,54,53);
insert into DirectedEdges values (15,53,52);
insert into DirectedEdges values (16,53,52);
insert into DirectedEdges values (17,52,50);
insert into DirectedEdges values (18,50,51);
insert into DirectedEdges values (19,51,33);
insert into DirectedEdges values (20,51,34);
insert into DirectedEdges values (21,51,35);
insert into DirectedEdges values (22,50,48);
insert into DirectedEdges values (23,48,36);
insert into DirectedEdges values (24,48,46);
insert into DirectedEdges values (25,46,47);
insert into DirectedEdges values (26,47,37);
insert into DirectedEdges values (27,47,38);
insert into DirectedEdges values (28,46,44);
insert into DirectedEdges values (29,44,45);
insert into DirectedEdges values (30,44,43);
insert into DirectedEdges values (31,44,22);
insert into DirectedEdges values (32,22,39);
insert into DirectedEdges values (33,43,41);
insert into DirectedEdges values (34,41,42);
insert into DirectedEdges values (35,41,40);


insert into DirectedEdges values (36,53,55);
insert into DirectedEdges values (37,52,53);
insert into DirectedEdges values (38,32,52);
insert into DirectedEdges values (39,46,22);
insert into DirectedEdges values (40,50,46);
insert into DirectedEdges values (41,51,50);
insert into DirectedEdges values (42,33,51);
insert into DirectedEdges values (43,22,39);
insert into DirectedEdges values (44,43,22);
insert into DirectedEdges values (45,44,43);
insert into DirectedEdges values (46,45,44);
insert into DirectedEdges values (47,54,23);
insert into DirectedEdges values (48,55,54);
insert into DirectedEdges values (49,53,54);
insert into DirectedEdges values (50,52,53);
insert into DirectedEdges values (51,52,53);
insert into DirectedEdges values (52,50,52);
insert into DirectedEdges values (53,51,50);
insert into DirectedEdges values (54,33,51);
insert into DirectedEdges values (55,34,51);
insert into DirectedEdges values (56,35,51);
insert into DirectedEdges values (57,48,50);
insert into DirectedEdges values (58,36,48);
insert into DirectedEdges values (59,46,48);
insert into DirectedEdges values (60,47,46);
insert into DirectedEdges values (61,37,47);
insert into DirectedEdges values (62,38,47);
insert into DirectedEdges values (63,44,46);
insert into DirectedEdges values (64,45,44);
insert into DirectedEdges values (65,43,44);
insert into DirectedEdges values (66,22,44);
insert into DirectedEdges values (67,39,22);
insert into DirectedEdges values (68,41,43);
insert into DirectedEdges values (69,42,41);
insert into DirectedEdges values (70,40,41);


insert into Paths values (1,55,32,0,1);
insert into Paths values (1,55,32,0,2);
insert into Paths values (1,55,32,0,3);

insert into Paths values (2,22,33,0,4);
insert into Paths values (2,22,33,0,5);
insert into Paths values (2,22,33,0,6);
insert into Paths values (2,22,33,0,7);

insert into Paths values (3,39,45,0,8);
insert into Paths values (3,39,45,0,9);
insert into Paths values (3,39,45,0,10);
insert into Paths values (3,39,45,0,11);

