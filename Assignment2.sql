--Grace Seiche (geseiche) CS3431 Assignment 2

--Part 1
drop table ReservedTours;
drop table Locations;
drop table Customers;
drop table Tours;
drop table Guides;

--Part 2
create table Customers (
	customerID number(3) Primary Key,
	firstName varchar2(15),
	lastName varchar2(20),
	address varchar2(30),
	phone number(10) Unique,
	age number(3) NOT NULL
);

insert into Customers values(1, 'Michael', 'Davis', '8711 Meadow St.', 2497873464, 67);
insert into Customers values(2, 'Lisa', 'Ward', '17 Valley Drive', 9865553232, 20);
insert into Customers values(3, 'Brian', 'Gray', '1212 8th St.', 4546667821, 29);
insert into Customers values(4, 'Nicole', 'Myers', '9 Washington Court', 9864752346, 18);
insert into Customers values(5, 'Kelly', 'Ross', '98 Lake Hill Drive', 8946557732, 26);
insert into Customers values(6, 'Madison', 'Powell', '100 Main St.', 8915367188, 57);
insert into Customers values(7, 'Ashley', 'Martin', '42 Oak St.', 1233753684, 73);
insert into Customers values(8, 'Joshua', 'White', '1414 Cedar St.', 6428369619, 18);
insert into Customers values(9, 'Tyler', 'Clark', '42 Elm Place', 1946825344, 22);
insert into Customers values(10, 'Anna', 'Young', '657 Redondo Ave.', 7988641411, 25);
insert into Customers values(11, 'Justin', 'Powell', '5 Jefferson Ave.', 2324648888, 17);
insert into Customers values(12, 'Bruce', 'Allen', '143 Cambridge Ave.', 5082328798, 45);
insert into Customers values(13, 'Rachel', 'Sanchez', '77 Massachusetts Ave.', 6174153059, 68);
insert into Customers values(14, 'Dylan', 'Lee', '175 Forest St.', 2123043923, 19);
insert into Customers values(15, 'Austin', 'Garcia', '35 Tremont St.', 7818914567, 82);

create table Tours (
	tourID number(2) Primary Key,
	tourName varchar2(25),
	description varchar2(35),
	city varchar2(25),
	state char(2),
	vehicleType varchar2(10),
	price number(5,2),
	Constraint Tours_vehicleTypeVal check (vehicleType in ('bus', 'boat', 'car'))
);

insert into Tours values (1, 'Alcatraz', 'Alcatraz Island', 'San Francisco', 'CA', 'boat', 75.5);
insert into Tours values (2, 'Magnificent Mile', 'Tour of Michigan Ave', 'Chicago', 'IL', 'bus', 22.75);
insert into Tours values (3, 'Duck Tour', 'Aquatic tour of the Charles River', 'Boston', 'MA', 'boat', 53.99);
insert into Tours values (4, 'Freedom Trail', 'Historic tour of Boston', 'Boston', 'MA', 'car', 34.25);
insert into Tours values (5, 'NY Museums', 'Tour of NYC Museums', 'New York', 'NY', 'bus', 160.8);

create table Locations (
	locationID char(3) Primary Key, 
	locationName varchar2(40),
	locationType varchar2(15),
	address varchar2(40),
	tourID number(2) References Tours (tourID) on delete cascade
);

insert into Locations values('AI1', 'San Francisco Pier 33', 'Historic', 'Pier 33 Alcatraz Landing', 1);
insert into Locations values('AI2', 'Alcatraz Ferry Terminal', 'Historic', 'Ferry Terminal', 1);
insert into Locations values('AI3', 'Agave Trail', 'Park', 'Alcatraz Agave Trail', 1);
insert into Locations values('MM1', 'Art Institute', 'Museum', '111 S Michigan Avenue', 2);
insert into Locations values('MM2', 'Chicago Tribune', 'Historic', '435 N Michigan Avenue', 2);
insert into Locations values('MM3', 'White Castle', 'Restaurant', 'S Wabash Avenue', 2);
insert into Locations values('DT1', 'Charles River', 'Historic', '10 Mass Avenue', 3);
insert into Locations values('DT2', 'Salt and Pepper Bridge', 'Historic', '100 Broadway', 3);
insert into Locations values('FT1', 'Boston Common', 'Park', '139 Tremont Street', 4);
insert into Locations values('FT2', 'Kings Chapel', 'Historic', '58 Tremont Street', 4);
insert into Locations values('FT3', 'Omni Parker House', 'Restaurant', '60 School Street', 4);
insert into Locations values('FT4', 'Paul Revere House', 'Historic', '19 North Square', 4);
insert into Locations values('FT5', 'Bunker Hill Monument', 'Historic', 'Monument Square', 4);
insert into Locations values('NY1', 'Metropolitan Museum of Art', 'Museum', '1000 5th Ave', 5);
insert into Locations values('NY2', 'Museum of Modern Art', 'Museum', '11 W 53rd St', 5);
insert into Locations values('NY3', 'New York Botanical Garden', 'Park', '2900 Southern Boulevard', 5);
insert into Locations values('NY4', 'New Museum', 'Museum', '235 Bowery', 5);

create table Guides (
	guideID number(2) Primary Key, 
	firstName varchar2(15), 
	lastName varchar2(20),
	driverLicense number(8) Unique NOT NULL, 
	title varchar2(15),
	salary number(7,2), 
	licenseType varchar2(10), 
	Constraint Guides_licenseTypeVal check (licenseType in ('land', 'sea', 'both'))
);

insert into Guides values(1, 'Emily', 'Williams', 74920983, 'Senior Guide', 24125, 'land');
insert into Guides values(2, 'Ethan', 'Brown', 72930684, 'Guide', 30500, 'sea');
insert into Guides values(3, 'Chloe', 'Jones', 50973848, 'Senior Guide', 27044, 'both');
insert into Guides values(4, 'Ben', 'Miller', 58442323, 'Junior Guide', 32080, 'both');
insert into Guides values(5, 'Mia', 'Davis', 56719583, 'Junior Guide', 49000, 'land');
insert into Guides values(6, 'Noah', 'Garcia', 93291234, 'Guide', 22000, 'land');
insert into Guides values(7, 'Liam', 'Rodriguez', 58799394, 'Junior Guide', 31750, 'sea');
insert into Guides values(8, 'Mason', 'Wilson', 88314545, 'Senior Guide', 45000, 'land');
insert into Guides values(9, 'Olivia', 'Smith', 82391452, 'Junior Guide', 25025, 'sea');
insert into Guides values(10, 'Sofia', 'Johnson', 12930638, 'Guide', 47000, 'both');

create table ReservedTours (
	reservedTourID number(3) Primary Key,
	travelDate date, 
	customerID number(3) References Customers (customerID) on delete set null, 
	tourID number(2) References Tours (tourID) on delete set null,
	guideID number(2) References Guides (guideID) on delete set null,
	price number(6,2)
);

insert into ReservedTours values(1, '6-Feb-18', 6, 1, 2, null);
insert into ReservedTours values(2, '31-Aug-18', 14, 3, 5, null);
insert into ReservedTours values(3, '10-Apr-19', 11, 4, 1, null);
insert into ReservedTours values(4, '29-Jul-18', 7, 2, 4, null);
insert into ReservedTours values(5, '15-Mar-18', 14, 3, 2, null);
insert into ReservedTours values(6, '28-Feb-19', 12, 4, 6, null);
insert into ReservedTours values(7, '3-Jun-18', 14, 4, 2, null);
insert into ReservedTours values(8, '17-May-18', 5, 1, 10, null);
insert into ReservedTours values(9, '11-Apr-19', 9, 5, 3, null);
insert into ReservedTours values(10, '24-Nov-18', 13, 4, 9, null);
insert into ReservedTours values(11, '3-Aug-18', 3, 5, 7, null);
insert into ReservedTours values(12, '13-Dec-17', 2, 1, 7, null);
insert into ReservedTours values(13, '9-Nov-17', 4, 5, 1, null);
insert into ReservedTours values(14, '21-Jan-19', 10, 2, 10, null);
insert into ReservedTours values(15, '11-Dec-17', 5, 1, 7, null);
insert into ReservedTours values(16, '12-Aug-18', 1, 3, 5, null);
insert into ReservedTours values(17, '22-Jun-18', 5, 3, 8, null);
insert into ReservedTours values(18, '1-Feb-19', 8, 2, 9, null);
insert into ReservedTours values(19, '15-Oct-17', 15, 4, 8, null);
insert into ReservedTours values(20, '8-Mar-18', 4, 1, 3, null);

-- Part 3a
Update ReservedTours
Set price = (select price
		from Tours t
		where ReservedTours.tourID = t.tourID);
		
-- Part 3b
Select title, count(*)
From Guides G, ReservedTours R, Tours T
Where G.guideID = R.guideID and R.tourID = T.tourID
	and ((G.licenseType = 'land' and T.vehicleType = 'boat') or (G.licenseType = 'sea' and T.vehicleType <> 'boat'))
Group By title 
Order By title;

-- Part 3c
Select firstName, lastName, to_char(sum(price), 9999.99) As TotalLandPrice
From Customers C, (Select customerID, price
	from ReservedTours
	where tourID in (select tourID
		from Tours
		where vehicleType <> 'boat')) D
Where C.customerID = D.customerID
Group By firstName, lastName
Order By lastName, firstName;

-- Part 3d
Select firstName, lastName, totalLocations as Visits
from Customers C, (Select customerID, totalLocations
		From  (Select customerID, sum(numLocations) as totalLocations
		   	 from ReservedTours R, 
        			(Select tourID, count(*) as numLocations		
				    from Locations
				    Group by tourID) D
			    where R.tourID = D.tourID
			    group by customerID) A
		where totalLocations = (select max(totalLocations) 
					    from (Select customerID, sum(numLocations) as totalLocations
   						 from ReservedTours R,
       							 (Select tourID, count(*) as numLocations
					   		 from Locations
	   						 Group by tourID) D
				   		 where R.tourID = D.tourID
				   		 group by customerID))) T
where C.customerID = T.customerID;

