use elidek;
show tables;

CREATE TABLE Stelehos
(
  name VARCHAR(45)NOT NULL,
  stelehos_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (stelehos_id)
);

CREATE TABLE Research_Field
(
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (name)
);

CREATE TABLE Programm
(
  name VARCHAR(45) NOT NULL,
  address VARCHAR(45) NOT NULL,
  programm_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (programm_id)
);

CREATE TABLE Organisation
(
  name VARCHAR(45) NOT NULL,
  postcode INT DEFAULT NULL,
  street VARCHAR(45) DEFAULT NULL,
  city VARCHAR(45) NOT NULL,
  short VARCHAR(15) DEFAULT NULL,
  organisation_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (organisation_id)
);

alter table Organisation add constraint check(postcode > 0); 

CREATE TABLE Company
(
  idia_kefalaia INT NOT NULL,
  organisation_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (organisation_id),
  CONSTRAINT `fk_company_organisation` FOREIGN KEY (organisation_id) REFERENCES Organisation(organisation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table Company add constraint check(idia_kefalaia > 0); 

CREATE TABLE University
(
  Proupologismos_apo_Ypourgeio_Paideias INT NOT NULL,
  organisation_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (organisation_id),
  CONSTRAINT `fk_university_organisation` FOREIGN KEY (organisation_id) REFERENCES Organisation(organisation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table University add constraint check(Proupologismos_apo_Ypourgeio_Paideias > 0); 


CREATE TABLE Research_Center
(
  Proupologismos_apo_Idiotikes_draseis INT NOT NULL,
  Proupologismos_apo_Ypourgeio_Paideias INT NOT NULL,
  organisation_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (organisation_id),
  CONSTRAINT `fk_research_center_organisation` FOREIGN KEY (organisation_id) REFERENCES Organisation(organisation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

alter table Research_Center add constraint check(Proupologismos_apo_Ypourgeio_Paideias > 0); 
alter table Research_Center add constraint check(Proupologismos_apo_Idiotikes_draseis > 0); 


CREATE TABLE Organisation_Phones
(
  phones VARCHAR(20) NOT NULL,
  organisation_id SMALLINT unsigned NOT NULL,
  PRIMARY KEY (phones, organisation_id),
  CONSTRAINT `fk_phone_organisation` FOREIGN KEY (organisation_id) REFERENCES Organisation(organisation_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Researcher
(
  sex VARCHAR(10) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  date_of_birth date NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  researcher_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT NOT NULL,
  organisation_id SMALLINT unsigned NULL,
  PRIMARY KEY (researcher_id),
  CONSTRAINT `fk_researcher_organisation` FOREIGN KEY (organisation_id) REFERENCES Organisation(organisation_id) ON DELETE set NULL ON UPDATE CASCADE
);

CREATE TABLE Project
(
  amount INT NOT NULL,
  title VARCHAR(45) NOT NULL,
  beginning date NOT NULL,
  ending date NOT NULL,
  duration SMALLINT NOT NULL,
  summary VARCHAR(200) NOT NULL,
  project_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  grade INT NOT NULL,
  date_of_grading date NOT NULL,
  stelehos_id SMALLINT UNSIGNED NULL,
  programm_id SMALLINT unsigned NULL,
  supervisor_id SMALLINT UNSIGNED NULL,
  grader_id SMALLINT UNSIGNED NULL,
  organisation_id SMALLINT unsigned NULL,
  PRIMARY KEY (project_id),
  CONSTRAINT `fk_project_stelehos` FOREIGN KEY (stelehos_id) REFERENCES Stelehos(stelehos_id) ON DELETE set NULL ON UPDATE cascade,
  CONSTRAINT `fk_project_programm` FOREIGN KEY (programm_id) REFERENCES Programm(programm_id) ON DELETE set NULL ON UPDATE cascade,
  CONSTRAINT `fk_project_supervisor` FOREIGN KEY (supervisor_id) REFERENCES Researcher(researcher_id) ON DELETE set NULL ON UPDATE cascade,
  CONSTRAINT `fk_project_grader` FOREIGN KEY (grader_id) REFERENCES Researcher(researcher_id) ON DELETE set NULL ON UPDATE cascade,
  CONSTRAINT `fk_project_organisation` FOREIGN KEY (organisation_id) REFERENCES Organisation(organisation_id) ON DELETE set NULL ON UPDATE CASCADE
);

CREATE TABLE Delivered
(
  title VARCHAR(45) NOT NULL,
  summary VARCHAR(45) NOT NULL,
  delivered_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  project_id SMALLINT unsigned NOT NULL ,
  PRIMARY KEY (delivered_id),
  CONSTRAINT `fk_delivered_project` FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Project_Research_Field
(
  project_id SMALLINT UNSIGNED NOT NULL ,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (project_id, name),
  CONSTRAINT `fk_pr_research_field_project` FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE ON UPDATE cascade,
  CONSTRAINT `fk_pr_research_field_research_field` FOREIGN KEY (name) REFERENCES Research_Field(name) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Works_in_Project
(
  project_id SMALLINT UNSIGNED NOT NULL ,
  researcher_id SMALLINT UNSIGNED NOT NULL ,
  PRIMARY KEY (project_id, researcher_id),
  CONSTRAINT `fk_works_in_project_project` FOREIGN KEY (project_id) REFERENCES Project(project_id) ON DELETE CASCADE ON UPDATE cascade,
  CONSTRAINT `fk_works_in_project_researcher` FOREIGN KEY (researcher_id) REFERENCES Researcher(researcher_id) ON DELETE CASCADE ON UPDATE cascade
);

alter table Project add constraint check(amount between 100000 and 1000000);

alter table Project add constraint check(beginning < ending);

alter table Project add constraint check(grade > 0);



INSERT INTO Programm
	(`Name`,`Address`,`Programm_id`) 
VALUES 
	('Simple Solution','Science','1'),
	('Bean Blowers','Science','2'),
	('Milk Science','Science','3'),
	('Octopusus','Science','4'),
	('The Fig Neutrons','Science','5'),
	('Guardian Team','Science','6'),
	('Great Society','Society','7'),
	('Bilingual Education Act','Society','8'),
	('DC Commission on the Arts and Humanities','Society','9'),
	('Economic Opportunity Act of 1964','Society','10'),
	('Elementary and Secondary Education Act','Society','11'),
	('Higher Education Act of 1965','Society','12'),
	('Support Central','Administration services','13'),
	('The Office Management Team','Administration services','14'),
	('Office Agents','Administration services','15'),
	('Better Business Assistants','Administration services','16'),
	('Smooth Operators','Administration services','17'),
	('Agents of Reception','Administration services','18'),
	('Pillar Staff','Administration services','19'),
	('Secureoffice','Administration services','20'),
	('Amazon Lab126','Research & Innovation Center','21'),
	('Verizon 5G Labs','Research & Innovation Center','22'),
	('Volkswagen Automative Innovation Lab','Research & Innovation Center','23'),
	('Capital One Labs','Research & Innovation Center','24'),
	('Canadian Food Inspection Agency','Research & Innovation Center','25'),
	('Palo Alto Research Center ','Research & Innovation Center','26'),
	('AT&T Research','Research & Innovation Center','27'),
	('MIT Media Lab','Research & Innovation Center','28'),
	('Boston Dynamics','Research & Innovation Center','29'),
	('IBM Research','Research & Innovation Center','30');

INSERT INTO Stelehos 
	(`name`,`stelehos_id`) 
VALUES 
	('Johnny Depp','1'),
	('Katy Vlacha','2'),
	('Perry Platipodas','3'),
	('Nick Thegreek','4'),
	('Vikaki Glampidaki','5'),
	('Marios Nananis','6'),
	('Captain Ntontoros','7'),
	('Giannis Kitsis','8'),
	('Iliana Chatzi','9'),
	('Pinelopi Katsarea','10'),
	('Manos Chatzak','11'),
	('Oraia Koimomeni','12'),
	('Kiki Kotoula','13'),
	('loula Kaloula','14'),
	('Peggy Gou','15');

INSERT INTO Research_Field
	(`name`) 
VALUES 
	('Mathematics'),
	('History'),
	('Physics'),
	('Economics'),
	('Chemistry'),
	('Sociology'),
	('Polics'),
	('Astrology');


INSERT INTO Organisation 
	(`name`,`postcode`,`street`,`city`,`short`,`organisation_id`) 
VALUES 
	('Adidas','34521','Armatolwn&klefton 55','Athens','Adi','1'),
	('Nike','43564','Aleksandrou Palli 16','Ioannina','N','2'), 
	('Adobe','12345','Oropos 43','Tokyo','Ado','3'),
	('Amazon','76890','Themistoklhs 76','Milan','Am','4'), 
	('AMC Theaters','37896','Clean 98','Barcelona','AMC','5'), 
	('Arbys','14567','Kapodistrias 111','London','Ar','6') ,
	('ArmHammer','25432','Kitsis 23','Rome','Arm','7'),
	('Atari','45333','kyknos 45','Liverpool','At','8'), 
	('Audi','21212','Gonzeght 58','Munchen','A','9') ,
	('Canon','86535','Arsher 90','Rio','C','10'),
	('Coca-Cola','55555','Lex 200','Larisa','C&C','11') ,
	('ConocoPhillips','67765','DojaCat 54','Chios','C&P','12'), 
	('eBay','21777','Kapodistrias 1','Madrid','e','13'),
	('Garmin','61000','Papandreou 2','New York','G','14'),
	('Geico','50912','Kwlokotronis 3','Los Angeles','G','15'),
	('Hasbro','44309','Ntontoros 69','Salonica','Adi','16') ,
	('IBM','10753','Hawkeye 32','Sevilla','IBM','17'),
	('Ikea','11259','Geror 32-34','Paris','Ikea','18') ,
	('Kia','34768','Armetit 21','Mexico city','Kia','19') ,
	('Lego','27190','Armadilo 56','Miami','Lego','20'),
	('Nikon','32567','Elephant 77','Lyon','Nik','21') ,
	('Nintendo','71811','Pekintot 22','Peking','Nit','22') ,
	('Nissan','12678','Mpakou 23','Kalamata','Nis','23'), 
	('Pepsi','15023','Themistokleous 33','Athens','Pep','24'), 
	('Qualcomm','07652','Downhill 45-46','Lyon','Q','25'),
	('Reebok','45003','Streetman 41','Miami','R','26') ,
	('Saab','17754','Mpsotriker 2','Cairo','S','27'),
	('Sega','66654','Yodaryot','New York','Sega','28') ,
	('Sony','20202','Aouts 33','Athens','Sony','29') ,
	('Starbucks','29298','Priceless 44','Tokyo','Star','30');
	

INSERT INTO Company
	(`idia_kefalaia`,`organisation_id`) 
VALUES 
	('1000000','1'),
	('2000000','2'),
	('1200000','3'),
	('4380000','4'),
	('5400000','5'),
	('6532000','6'),
	('7899000','7'),
	('1222000','8'),
	('5420000','9'),
	('6580000','10');

INSERT INTO University
	(`Proupologismos_apo_Ypourgeio_Paideias`,`organisation_id`) 
VALUES 
	('6444000','11'),
	('1000000','12'),
	('5500000','13'),
	('1420000','14'),
	('2580000','15'),
	('2100000','16'),
	('3090000','27'),
	('2016000','28'),
	('6260000','29'),
	('1112000','30');

INSERT into Research_Center 
	(`Proupologismos_apo_Idiotikes_draseis`,`Proupologismos_apo_Ypourgeio_Paideias`,`organisation_id`) 
VALUES 
	('2445000','3874209','17'),
	('2000700','1000000','18'),
	('2100000','9283000','19'),
	('1190000','3000000','20'),
	('2110000','2000000','21'),
	('7700000','1000000','22'),
	('2445000','9999999','23'),
	('2000700','1234567','24'),
	('2100000','987654','25'),
	('1190000','8000000','26');

INSERT into Organisation_Phones  
	(`phones`,`organisation_id`) 
VALUES 
	('(802) 898-8461','1'),
	('(338) 302-6974','2'),
	('(474) 993-6962','3'),
	('(735) 587-7459','4'),
	('(220) 551-9007','5'),
	('(845) 409-4381','6'),
	('(296) 743-5326','7'),
	('(994) 202-9026','8'),
	('(870) 591-9632','9'),
	('(569) 487-2723','10'),
	('(432) 253-6502','11'),
	('(911) 560-4301','12'),
	('(576) 926-4811','13'),
	('(539) 981-5542','14'),
	('(712) 951-7958','15'),
	('(491) 928-3296','16'),
	('(659) 917-1478','17'),
	('(390) 780-3535','18'),
	('(864) 305-1398','19'),
	('(817) 778-2763','20'),
	('(528) 219-2927','21'),
	('(607) 625-1524','22'),
	('(502) 522-2287','23'),
	('(615) 688-0270','24'),
	('(220) 698-3130','25'),
	('(497) 934-9029','26'),
	('(474) 864-5314','27'),
	('(610) 548-6189','28'),
	('(649) 564-7200','29'),
	('(253) 207-8495','30'),
	('(591) 416-7969','2'),
	('(399) 895-4995','2'),
	('(776) 850-7974','5'),
	('(634) 988-0225','6'),
	('(237) 462-4545','10'),
	('(562) 754-9733','10'),
	('(423) 581-7906','14'),
	('(359) 866-1105','17'),
	('(596) 841-4948','18'),
	('(574) 542-7174','19'),
	('(814) 778-6656','19'),
	('(877) 830-5668','27'),
	('(367) 694-9211','27'),
	('(373) 377-7789','30'),
	('(678) 801-0357','30'),
	('(301) 912-5633','22'),
	('(934) 336-3549','21'),
	('(300) 408-3092','20'),
	('(445) 807-4497','4'),
	('(516) 978-4903','4');

INSERT into Researcher
	(`sex`,`last_name`,`date_of_birth`,`first_name`,`researcher_id`,`organisation_id`) 
VALUES 
	('male','Papadopoulos','1970-01-03','Petros','1','1'),
	('male','Snoop','1974-04-04','Dog','2','2'),
	('male','Leventis','1980-12-01','Alekos','3','3'),
	('male','Mitsotakis','1990-05-03','Koulis','4','4'),
	('male','Tsipras','1987-03-04','Alex','5','5'),
	('male','Koutsoubas','1950-12-02','Mitsos','6','6'),
	('male','Arrow','1963-01-10','Nikolas','7','7'),
	('male','Man','1969-01-05','Bat','8','8'),
	('male','Tiesto','1982-04-08','Giorgos','9','9'),
	('male','Road','1997-01-01','Runner','10','10'),
	('male','Panos','1931-01-11','Panagiotis','11','11'),
	('male','Crazy','1990-09-09','Thomas','12','12'),
	('male','Persis','2001-01-01','Propersis','13','13'),
	('male','Kamir','2001-11-08','Omar','14','14'),
	('male','Gravanis','1996-05-02','Marios','15','15'),
	('male','Kitsakos','1977-08-03','Theo','16','16'),
	('male','Maggouras','1980-01-06','Stavros','17','17'),
	('male','Kostadaras','1984-11-03','Petros','18','18'),
	('male','Variabasis','1980-05-03','Lampros','19','19'),
	('male','Kapetanakis','1999-07-03','Mimis','20','20'),
	('male','Mitropanos','1990-09-03','Mitsos','21','21'),
	('male','Kouridakis','1988-01-15','Leonardo','22','22'),
	('male','Kiamos','1976-04-13','Panagiotis','23','23'),
	('male','Vertis','1970-05-09','Nikolaos','24','24'),
	('male','Tsiknakis','1976-02-03','Emanouil','25','25'),
	('female','Anyfanti','1984-01-06','Xenia','26','26'),
	('female','Kiori','1990-01-08','Sara','27','27'),
	('female','Tsagri','1993-01-11','Efro','28','28'),
	('female','Katsarea','1970-04-03','Milena','29','29'),
	('female','Paparizoy','1979-11-08','Elena','30','30'),
	('female','Kalifoni','1971-01-03','Garifalia','31','1'),
	('female','Salamouri','1990-07-07','Liana','32','2'),
	('female','Miziou','1992-04-03','Keisi','33','3'),
	('female','Spinoula','1980-05-03','Sofiana','34','4'),
	('female','Mouse','1978-08-23','Mini','35','5'),
	('female','Hadid','1970-06-06','Bella','36','6'),
	('female','Hadid','1978-05-05','Gigi','37','7'),
	('female','Kardasian','1999-01-03','Kim','38','8'),
	('female','Kendall','1973-07-26','Jenner','39','9'),
	('female','Queen','1979-01-24','Viktoria','40','10'),
	('female','Diva','1980-01-03','Konstantina','41','11'),
	('female','Barbenia','1993-05-07','Barbie','42','12'),
	('female','Klouni','1990-06-12','Georgia','43','13'),
	('female','Ronaldo','1987-05-13','Christiana','44','14'),
	('female','Kennedy','1976-05-12','Ioanna','45','15'),
	('female','Vern','1979-06-15','Ioulia','46','16'),
	('female','Romea','1982-12-04','Ioulieta','47','17'),
	('female','Pedozali','1976-07-17','Koula','48','18'),
	('female','Kritikia','1988-07-12','Stefania','49','19'),
	('female','Aggelidou','1994-01-05','Aggeliki','50','20'),
	('male','Georgoulas','1990-11-08','Petros','51','21'),
	('male','Patsiouras','1974-04-04','Dog','52','22'),
	('male','Muska','1980-10-01','Alekos','53','23'),
	('male','Mitsotakis','1990-05-03','Giannis','54','24'),
	('male','Georgiou','1987-02-03','Alex','55','25'),
	('male','Koutsoubas','1950-12-02','Dimitris','56','26'),
	('male','Mac','1963-01-10','Nikolas','57','27'),
	('male','Man','1969-01-05','Bat','58','28'),
	('male','Tiesto','1982-04-08','Giorgos','59','29'),
	('male','Mpimpos','1997-01-01','Runner','60','30'),
	('male','Panos','1911-01-11','Babis','61','1'),
	('male','Devil','1990-09-09','Thomas','62','2'),
	('male','Persis','2001-01-01','Jackson','63','3'),
	('male','Kamir','2001-12-01','Omar','64','4'),
	('male','Gravanis','1996-05-02','Marios','65','5'),
	('male','Kitsis','1974-10-05','Theo','66','6'),
	('male','Maggouras','1978-01-08','Stavros','67','7'),
	('male','Kostadaras','1980-05-05','Petros','68','8'),
	('male','Vasis','1971-11-01','Lampros','69','9'),
	('male','kapetanos','1979-10-06','Mimis','70','10'),
	('male','Panos','1980-06-06','Mitsos','71','11'),
	('male','Di Vinci','1990-01-05','Leonardo','72','12'),
	('male','Kiamos','1975-05-05','Panos','73','13'),
	('male','Motsis','1988-11-08','Nikolaos','74','14'),
	('male','Tsiknakis','1988-02-04','Emanouil','75','15'),
	('female','Maria','1970-01-12','Xenia','76','16'),
	('female','Paparizoy','1975-05-03','Sara','77','17'),
	('female','Tsagri','1950-04-03','Ioanna','78','18'),
	('female','Iiadou','1972-01-12','Milena','79','19'),
	('female','Kiori','1971-01-03','Elena','80','20'),
	('female','Kalifoni','1980-11-10','Maria','81','21'),
	('female','Liatsou','1972-02-12','Liana','82','22'),
	('female','Miziou','1971-04-04','Keisi','83','23'),
	('female','Pianou','1971-11-11','Nicky','84','24'),
	('female','Mouse','1973-01-03','Mini','85','25'),
	('female','Hadid','1979-01-08','Bella','86','26'),
	('female','Hadid','1978-01-08','Gigi','87','27'),
	('female','Kardasian','1970-10-05','Kim','88','28'),
	('female','Kendall','1976-06-06','Jenner','89','29'),
	('female','Queen','1975-01-25','Viktoria','90','30'),
	('female','Diva','1999-03-03','Konstantina','91','1'),
	('female','Barbenia','1971-11-21','Barbie','92','2'),
	('female','Klouni','1972-01-02','Georgia','93','3'),
	('female','Ronaldo','1977-01-15','Christin','94','4'),
	('female','Kennedy','1978-01-07','Ioanna','95','5'),
	('female','Vern','1977-02-13','Ioulia','96','6'),
	('female','Romea','1970-08-12','Ioulieta','97','7'),
	('female','Delaporta','1970-01-13','Koula','98','8'),
	('female','Kirki','1972-01-04','Kleopatra','99','9'),
	('female','Aggeliou','1974-01-04','Aggeliki','100','10');
	

INSERT INTO elidek.Project (amount,title,beginning,ending,duration,summary,grade,date_of_grading,stelehos_id,programm_id,supervisor_id,grader_id,organisation_id) VALUES
	 (391820,'African fish eagle','2000-01-01','2001-02-01',13,'consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien',3,'1999-12-01',1,1,1,80,1),
	 (143448,'African ground squirrel (unidentified)','2000-02-01','2001-04-01',14,'tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse',4,'2000-01-01',2,2,2,81,2),
	 (216332,'American badger','2000-03-01','2001-06-01',15,'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere',5,'2000-01-30',3,3,3,82,3),
	 (856065,'Antelope ground squirrel','2000-04-01','2001-08-01',16,'varius ut blandit non interdum in ante vestibulum ante ipsum primis in',6,'2000-03-01',4,4,4,83,4),
	 (682063,'Arthritazin Pain Relieving','2000-05-01','2001-10-01',17,'laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus',7,'2000-03-31',5,5,5,84,5),
	 (988639,'Asian foreset tortoise','2000-06-01','2001-12-01',18,'tempus semper est quam pharetra',8,'2000-05-01',6,6,6,85,6),
	 (652217,'Bandicoot, southern brown','2000-07-01','2002-02-01',19,'mattis pulvinar nulla pede ullamcorper augue',9,'2000-05-31',7,7,7,86,7),
	 (953419,'Blesbok','2000-08-01','2002-04-01',20,'vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus',10,'2000-07-01',8,8,8,87,8),
	 (130522,'Bontebok','2000-09-01','2002-06-01',21,'proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum',3,'2000-08-01',9,9,9,88,9),
	 (540893,'California sea lion','2000-10-01','2002-08-01',22,'lectus in est risus auctor',4,'2000-08-31',10,10,10,89,10),
	 (669594,'Cefepime','2000-11-01','2002-10-01',23,'imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris',5,'2000-10-01',1,11,11,90,11),
	 (542354,'Cherry Birch Pollen','2000-12-01','2002-12-01',24,'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula',6,'2000-10-31',2,12,12,91,12),
	 (679829,'Ciprofloxacin','2001-01-01','2003-02-01',25,'non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate',7,'2000-12-01',3,13,13,92,13),
	 (438769,'Clindamycin in 5 Percent Dextrose','2001-02-01','2003-04-01',26,'vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget',8,'2001-01-01',4,14,14,93,14),
	 (905398,'Cormorant, king','2001-03-01','2003-06-01',27,'et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante',9,'2001-01-29',5,15,15,94,15),
	 (307785,'Deer, mule','2001-04-01','2003-08-01',28,'mattis odio donec vitae nisi nam',10,'2001-03-01',6,16,16,95,16),
	 (627997,'Deer, white-tailed','2001-05-01','2003-10-01',29,'ut ultrices vel augue vestibulum ante ipsum primis in faucibus',3,'2001-03-31',7,17,17,96,17),
	 (152025,'Detrol LA','2001-06-01','2003-12-01',30,'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper',4,'2001-05-01',8,18,18,97,18),
	 (668211,'Dove, mourning collared','2001-07-01','2004-02-01',31,'orci vehicula condimentum curabitur in libero ut massa',5,'2001-05-31',9,19,19,98,19),
	 (589991,'Enalapril Maleate','2001-08-01','2004-04-01',32,'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere',6,'2001-07-01',10,20,20,99,20),
	 (932425,'Endometrin','2001-09-01','2004-06-01',33,'tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed',7,'2001-08-01',1,21,21,100,21),
	 (909993,'Etomidate','2001-10-01','2004-08-01',34,'vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent',8,'2001-08-31',2,22,22,1,22),
	 (456697,'European beaver','2001-11-01','2004-10-01',35,'potenti cras in purus eu magna vulputate luctus cum sociis natoque',9,'2001-10-01',3,23,23,2,23),
	 (206061,'European wild cat','2001-12-01','2004-12-01',36,'velit vivamus vel nulla eget eros elementum',10,'2001-10-31',4,24,24,3,24),
	 (244556,'Fanapt','2002-01-01','2005-02-01',37,'turpis sed ante vivamus tortor duis mattis egestas metus aenean',3,'2001-12-01',5,25,25,4,25),
	 (760211,'Francolin, swainson''s','2002-02-01','2005-04-01',38,'nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis',4,'2002-01-01',6,26,26,5,26),
	 (433644,'Goose, snow','2002-03-01','2005-06-01',39,'felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec',5,'2002-01-29',7,27,27,6,27),
	 (879641,'Great kiskadee','2002-04-01','2005-08-01',40,'non quam nec dui luctus rutrum nulla',6,'2002-03-01',8,28,28,7,28),
	 (504423,'Greater blue-eared starling','2002-05-01','2005-10-01',41,'commodo placerat praesent blandit nam nulla integer pede justo lacinia eget',7,'2002-03-31',9,29,29,8,29),
	 (811767,'Green vine snake','2002-06-01','2005-12-01',42,'in felis donec semper sapien a libero nam dui proin leo odio',8,'2002-05-01',10,30,30,9,30),
	 (460197,'Halcion','2020-01-01','2021-01-01',12,'bibendum morbi non quam nec dui luctus rutrum nulla tellus in',9,'2019-12-01',1,1,31,10,1),
	 (958356,'honey bee hymenoptera venom','2020-02-01','2021-03-01',13,'elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor',10,'2020-01-01',2,2,32,11,2),
	 (839283,'Hornbill, southern ground','2020-03-01','2021-05-01',14,'consequat dui nec nisi volutpat eleifend donec',3,'2020-01-30',3,3,33,12,3),
	 (680431,'Indian jackal','2020-04-01','2021-07-01',15,'morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis',4,'2020-03-01',4,4,34,13,4),
	 (388790,'Jaguar','2020-05-01','2021-09-01',16,'aenean lectus pellentesque eget nunc donec quis',5,'2020-03-31',5,5,35,14,5),
	 (933593,'Kiskadee, great','2020-06-01','2021-11-01',17,'imperdiet et commodo vulputate justo in blandit',6,'2020-05-01',6,6,36,15,6),
	 (434938,'LACTULOSE','2020-07-01','2022-01-01',18,'justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo',7,'2020-05-31',7,7,37,16,7),
	 (424892,'Leeks','2020-08-01','2022-03-01',19,'morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate',8,'2020-07-01',8,8,38,17,8),
	 (123433,'Legaan, ground','2020-09-01','2022-05-01',20,'odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede',9,'2020-08-01',9,9,39,18,9),
	 (276677,'Levofloxacin','2020-10-01','2022-07-01',21,'vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus',10,'2020-08-31',10,10,40,19,10),
	 (146435,'Lion, asian','2020-11-01','2022-09-01',22,'amet eleifend pede libero quis orci nullam molestie',3,'2020-10-01',1,11,41,20,11),
	 (499193,'METHADONE HYDROCHLORIDE','2020-12-01','2022-11-01',23,'pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est',4,'2020-10-31',2,12,42,21,12),
	 (759060,'Native cat','2021-01-01','2023-01-01',24,'justo in blandit ultrices enim lorem ipsum dolor sit',5,'2020-12-01',3,13,43,22,13),
	 (753823,'NovoLog','2021-02-01','2023-03-01',25,'in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum',6,'2021-01-01',4,14,44,23,14),
	 (689462,'Olay Fresh Effects Soak Up the Sun Protection','2021-03-01','2023-05-01',26,'amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis',7,'2021-01-29',5,15,45,24,15),
	 (546606,'Pain Relief PM','2021-04-01','2023-07-01',27,'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue',8,'2021-03-01',6,16,46,25,16),
	 (901879,'Parakeet, rose-ringed','2021-05-01','2023-09-01',28,'fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis',9,'2021-03-31',7,17,47,26,17),
	 (782905,'Phalarope, red','2021-06-01','2023-11-01',29,'facilisi cras non velit nec nisi vulputate',10,'2021-05-01',8,18,48,27,18),
	 (603913,'Pigeon, wood','2021-07-01','2024-01-01',30,'in consequat ut nulla sed accumsan',3,'2021-05-31',9,19,49,28,19),
	 (507299,'Pintail, white-cheeked','2021-08-01','2024-03-01',31,'sodales sed tincidunt eu felis fusce posuere felis',4,'2021-07-01',10,20,50,29,20),
	 (714401,'Plains zebra','2021-09-01','2024-05-01',32,'dolor vel est donec odio justo sollicitudin ut suscipit a',5,'2021-08-01',1,21,51,30,21),
	 (595821,'PREP (AND) PRIME CC COLOR CORRECT ','2021-10-01','2024-07-01',33,'nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat',6,'2021-08-31',2,22,52,31,22),
	 (884549,'Proparacaine Hydrochloride','2021-11-01','2024-09-01',34,'ultrices posuere cubilia curae nulla dapibus dolor vel est donec',7,'2021-10-01',3,23,53,32,23),
	 (249468,'Red and blue macaw','2021-12-01','2024-11-01',35,'vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra',8,'2021-10-31',4,24,54,33,24),
	 (674838,'Red brocket','2022-01-01','2025-01-01',36,'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum',9,'2021-12-01',5,25,55,34,25),
	 (492934,'Red lava crab','2022-02-01','2025-03-01',37,'maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien',10,'2022-01-01',6,26,56,35,26),
	 (781742,'Red phalarope','2022-03-01','2025-05-01',38,'orci luctus et ultrices posuere',3,'2022-01-29',7,27,57,36,27),
	 (470555,'Red sheep','2022-04-01','2025-07-01',39,'ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla',4,'2022-03-01',8,28,58,37,28),
	 (917230,'Snake, tiger','2022-05-01','2025-09-01',40,'commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus',5,'2022-03-31',9,29,59,38,29),
	 (810004,'Softlips Peach Mango','2022-06-01','2025-11-01',41,'pede ac diam cras pellentesque volutpat dui maecenas tristique est et',6,'2022-05-01',10,30,60,39,30),
	 (309511,'Starfish, crown of thorns','2022-07-01','2026-01-01',42,'odio curabitur convallis duis consequat dui nec nisi volutpat eleifend',7,'2022-05-31',1,1,61,40,1),
	 (166984,'Stila Hydrating Primer Oil-Free SPF 30','2022-08-01','2026-03-01',43,'nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta',8,'2022-07-01',2,2,62,41,2),
	 (148630,'Surmontil','2022-09-01','2026-05-01',44,'vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',9,'2022-08-01',3,3,63,42,3),
	 (351760,'Tecfidera','2022-10-01','2026-07-01',45,'orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin',10,'2022-08-31',4,4,64,43,4),
	 (697758,'Theophylline in Dextrose','2022-11-01','2026-09-01',46,'vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac',3,'2022-10-01',5,5,65,44,5),
	 (868566,'TLB-Matrix','2022-12-01','2026-11-01',47,'posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec',4,'2022-10-31',6,6,66,45,6),
	 (491776,'Tortoise, radiated','2023-01-01','2027-01-01',48,'euismod scelerisque quam turpis adipiscing lorem vitae',5,'2022-12-01',7,7,67,46,7),
	 (677021,'Tropical buckeye butterfly','2023-02-01','2027-02-01',48,'nunc viverra dapibus nulla suscipit ligula in lacus curabitur',6,'2023-01-01',8,8,68,47,8),
	 (603151,'Tsessebe','2023-03-01','2027-03-01',48,'curabitur gravida nisi at nibh',7,'2023-01-29',9,9,69,48,9),
	 (444879,'Two-toed sloth','2023-04-01','2027-04-01',48,'pulvinar nulla pede ullamcorper augue a suscipit',8,'2023-03-01',10,10,70,49,10),
	 (418070,'Vancomycin Hydrochloride','2023-05-01','2027-05-01',48,'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis',9,'2023-03-31',1,11,71,50,11),
	 (880383,'Wallaby, agile','2023-06-01','2027-06-01',48,'volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc',10,'2023-05-01',2,12,72,51,12),
	 (601962,'WHITE LAVENDER AND MINT ANTIBACTERIAL ','2023-07-01','2027-07-01',48,'quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna',3,'2023-05-31',3,13,73,52,13),
	 (982457,'White-eye, pale','2023-08-01','2027-08-01',48,'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent',4,'2023-07-01',4,14,74,53,14),
	 (869816,'White-winged tern','2023-09-01','2027-09-01',48,'ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus',5,'2023-08-01',5,15,75,54,15),
	 (822343,'Wild boar','2023-10-01','2027-10-01',48,'orci nullam molestie nibh in',6,'2023-08-31',6,16,76,55,16),
	 (141068,'Wombat, common','2023-11-01','2027-11-01',48,'a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id',7,'2023-10-01',7,17,77,56,17),
	 (780046,'Wombat, southern hairy-nosed','2023-12-01','2027-12-01',48,'sed justo pellentesque viverra pede ac diam',8,'2023-10-31',8,18,78,57,18),
	 (813608,'XEROSTOM','2024-01-01','2028-01-01',48,'malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin',9,'2023-12-01',9,19,79,58,19);
-- INSERT into Project
-- 	(`amount`,`title`,`beginning`,`ending`,`duration`,`summary`,`project_id`,`grade`,`date_of_grading`,`stelehos_id`,`programm_id`,`supervisor_id`,`grader_id`,`organisation_id`) 
-- VALUES 
-- 	('200.000','Mopping the sea','01-01-2020','01-01-2023','3','lorem ipsum','1','1','1','1','1','1'),
	
-- INSERT into Delivered
-- 	(`title`,`summary`,`delivered_id`,`project_id`) 
-- VALUES 

-- INSERT into Project_research_field 
-- 	(`project_id`,`name`) 
-- VALUES 

-- INSERT into Works_in_project  
-- 	(`project_id`,`researcher_id`) 
-- VALUES 







