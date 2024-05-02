USE screen_time
GO

CREATE SCHEMA [zoila];
GO

--DROP TABLE IF EXISTS zoila.app_screen_time;
--DROP TABLE IF EXISTS zoila.app_categories;
--GO

CREATE TABLE zoila.app_categories (
	app varchar(50) NOT NULL PRIMARY KEY,
	category varchar(40) NOT NULL
);

INSERT INTO zoila.app_categories VALUES 
('Discover','Finance'),('Etsy','Shopping'),('Gmail','Productivity'),('Goodnotes','Productivity'),
('Google Calendar','Productivity'),('Google Earth','Entertainment'),('Hoopla','Reading'),('Hulu','Entertainment'),
('Instagram','Entertainment'),('Kindle','Reading'),('Libby','Reading'),('Maps','Other'),
('Messages','Entertainment'),('Minesweeper','Games'),('Netflix','Entertainment'),('Phone','Entertainment'),
('Photos','Other'),('Reddit','Entertainment'),('Safari','Research'),('Settings','Other'),('Spider Solitaire','Games'),
('SoFi','Finance'),('Spotify','Entertainment'),('Sudoku','Games'),('Webtoon','Entertainment'),('Wells Fargo','Finance'),('WhatsApp','Entertainment'),
('Worddle','Games'),('YouTube','Entertainment')
GO

CREATE TABLE zoila.app_screen_time (
	entry_id int IDENTITY(72400,1) NOT NULL PRIMARY KEY,
	entry_date date NOT NULL,
	device varchar(10) NOT NULL,
	app varchar(50) REFERENCES zoila.app_categories (app) ON UPDATE CASCADE,
	ST_hours int NOT NULL, --ST: screen time
	ST_minutes int NOT NULL,
	total_ST_hours AS Round((Cast(ST_minutes AS float) / 60) + Cast(ST_hours AS float),2),
	InsertedTime datetime DEFAULT getdate(),
	InsertedBy nvarchar(128) DEFAULT suser_name()
);

BEGIN TRY
	INSERT INTO zoila.app_screen_time (entry_date,device,app,ST_hours,ST_minutes) VALUES
	('2024-03-22','iPhone','Credit Karma',0,30); -- Error: Foreign Key constraint > Must first add 'Wells Fargo' to zoila.app_categories table
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_MESSAGE() AS ErrorMessage
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_STATE() AS ErrorState
		,ERROR_SEVERITY() AS ErrorSeverity   
		,ERROR_LINE() AS ErrorLine
		,getdate() AS ErrorDateTime
		,suser_name() AS ErrorUser
END CATCH

INSERT INTO zoila.app_categories VALUES
('Credit Karma','Finance')

INSERT INTO zoila.app_screen_time (entry_date,device,app,ST_hours,ST_minutes) VALUES
('2024-03-22','iPhone','Credit Karma',0,30); --SUCCESS!
GO

SELECT app FROM zoila.app_categories WHERE app LIKE 'Wor%';

UPDATE zoila.app_categories
SET app = 'Wordle'
WHERE app = 'Worddle';
GO

INSERT INTO zoila.app_screen_time (entry_date,device,app,ST_hours,ST_minutes) VALUES
('2024-02-25','iPad','Kindle',1,39),('2024-02-25','iPad','Spider Solitaire',0,11),('2024-02-25','iPad','Goodnotes',0,3),
('2024-02-26','iPad','Spotify',1,8),('2024-02-26','iPad','YouTube',0,18),
('2024-02-27','iPad','YouTube',0,15),('2024-02-27','iPad','Kindle',0,48),
('2024-02-28','iPad','Kindle',1,28),('2024-02-28','iPad','Spotify',0,53),('2024-02-28','iPad','Safari',0,19),('2024-02-28','iPad','Reddit',0,10),
('2024-02-29','iPad','Minesweeper',0,9),('2024-02-29','iPad','Spotify',0,3),
('2024-03-01','iPad','Kindle',0,53),('2024-03-01','iPad','Photos',0,10),('2024-03-01','iPad','Spider Solitaire',0,7),('2024-03-01','iPad','Spotify',0,3),
('2024-03-02','iPad','YouTube',0,42),('2024-03-02','iPad','Goodnotes',0,29),('2024-03-02','iPad','Photos',0,3),('2024-03-02','iPad','Safari',0,1),

('2024-03-03','iPad','Kindle',4,10),('2024-03-03','iPad','Spider Solitaire',0,14),('2024-03-03','iPad','Safari',0,4),('2024-03-03','iPad','Libby',0,1),('2024-03-03','iPad','Google Earth',0,1),('2024-03-03','iPad','YouTube',0,1),('2024-03-03','iPad','Spotify',0,1),
('2024-03-04','iPad','Etsy',1,6),('2024-03-04','iPad','Kindle',1,4),('2024-03-04','iPad','YouTube',0,23),('2024-03-04','iPad','Google Calendar',0,7),
('2024-03-05','iPad','YouTube',0,15),('2024-03-05','iPad','Etsy',0,47),('2024-03-05','iPad','Minesweeper',0,39),('2024-03-05','iPad','Kindle',0,13),
('2024-03-06','iPad','YouTube',0,43),
('2024-03-07','iPad','Spider Solitaire',0,37),('2024-03-07','iPad','Goodnotes',0,15),('2024-03-07','iPad','Safari',0,12),
('2024-03-08','iPad','YouTube',0,49),('2024-03-08','iPad','Goodnotes',0,32),('2024-03-08','iPad','Spider Solitaire',0,20),
('2024-03-09','iPad','Kindle',0,51),('2024-03-09','iPad','Goodnotes',0,45),('2024-03-09','iPad','Safari',0,14),('2024-03-09','iPad','Etsy',0,3),

('2024-03-10','iPad','Spotify',0,17),('2024-03-10','iPad','YouTube',0,15),('2024-03-10','iPad','Goodnotes',0,5),('2024-03-10','iPad','Libby',0,1),
('2024-03-11','iPad','Spotify',3,49),('2024-03-11','iPad','YouTube',1,32),('2024-03-11','iPad','Goodnotes',0,7),
('2024-03-12','iPad','Spotify',0,54),('2024-03-12','iPad','Spider Solitaire',0,12),('2024-03-12','iPad','Safari',0,4),
('2024-03-13','iPad','Spotify',1,32),('2024-03-13','iPad','YouTube',0,49),('2024-03-13','iPad','Goodnotes',0,24),('2024-03-13','iPad','Spider Solitaire',0,10),('2024-03-13','iPad','Safari',0,3),
('2024-03-14','iPad','Libby',0,25),
('2024-03-16','iPad','Spider Solitaire',0,25),('2024-03-16','iPad','Goodnotes',0,9),

('2024-03-17','iPad','Safari',0,1),
('2024-03-18','iPad','Messages',0,16),('2024-03-18','iPad','Spotify',0,4),
('2024-03-19','iPad','YouTube',0,24),
('2024-03-20','iPad','Goodnotes',0,37),('2024-03-20','iPad','Spotify',0,34),('2024-03-20','iPad','Spider Solitaire',0,25),
('2024-03-21','iPad','YouTube',1,2),('2024-03-21','iPad','Spotify',1,29),('2024-03-21','iPad','Safari',0,23),('2024-03-21','iPad','Goodnotes',0,20),
('2024-03-22','iPad','Safari',0,26),('2024-03-22','iPad','YouTube',0,18),
('2024-03-23','iPad','Goodnotes',1,8),

('2024-03-24','iPad','Spotify',0,42),('2024-03-24','iPad','YouTube',0,18),('2024-03-24','iPad','Goodnotes',0,15),
('2024-03-25','iPad','Spotify',0,22),('2024-03-25','iPad','Libby',0,17),
('2024-03-26','iPad','Etsy',0,16),('2024-03-26','iPad','Safari',0,14),
('2024-03-27','iPad','YouTube',0,26),('2024-03-27','iPad','Kindle',0,56),('2024-03-27','iPad','Libby',0,32),('2024-03-27','iPad','Spotify',0,14),('2024-03-27','iPad','Spider Solitaire',0,7),
('2024-03-28','iPad','Kindle',0,21),
('2024-03-29','iPad','Spotify',0,31),
('2024-03-30','iPad','Goodnotes',0,18),('2024-03-30','iPad','Google Earth',0,5),

('2024-03-31','iPad','Goodnotes',0,26),('2024-03-31','iPad','Safari',0,22),('2024-03-31','iPad','Google Earth',0,6),
('2024-04-01','iPad','Spotify',1,19),('2024-04-01','iPad','Goodnotes',0,4),
('2024-04-02','iPad','Safari',0,57),('2024-04-02','iPad','Spotify',0,16),
('2024-04-03','iPad','Safari',1,10),('2024-04-03','iPad','Spider Solitaire',0,27),('2024-04-03','iPad','Goodnotes',0,11),
('2024-04-04','iPad','Spotify',0,57),('2024-04-04','iPad','Spider Solitaire',0,36),
('2024-04-05','iPad','Kindle',0,14),('2024-04-05','iPad','YouTube',0,8),('2024-04-05','iPad','Spider Solitaire',0,8),
('2024-04-06','iPad','Kindle',1,52),

('2024-04-07','iPad','Kindle',1,13),('2024-04-07','iPad','YouTube',0,57),
('2024-04-08','iPad','Kindle',0,26),('2024-04-08','iPad','Goodnotes',0,23),
('2024-04-09','iPad','Spotify',1,19),('2024-04-09','iPad','Safari',0,33),
('2024-04-10','iPad','YouTube',0,25),('2024-04-10','iPad','Safari',0,24),('2024-04-10','iPad','Spotify',0,22),('2024-04-10','iPad','Spider Solitaire',0,12),
('2024-04-11','iPad','Spider Solitaire',0,48),('2024-04-11','iPad','Netflix',0,9),
('2024-04-12','iPad','Netflix',0,21),('2024-04-12','iPad','Goodnotes',0,18),
('2024-04-13','iPad','Goodnotes',0,21),('2024-04-13','iPad','Hoopla',0,16),

('2024-04-14','iPad','Hoopla',0,18),('2024-04-14','iPad','Goodnotes',0,15),
('2024-04-15','iPad','Safari',0,18),('2024-04-15','iPad','Spotify',0,7),('2024-04-15','iPad','Netflix',0,6),
('2024-04-16','iPad','Goodnotes',0,57),('2024-04-16','iPad','Spider Solitaire',0,22),('2024-04-16','iPad','Safari',0,20),
('2024-04-17','iPad','Spotify',0,25),
('2024-04-18','iPad','Minesweeper',0,4),
('2024-04-19','iPad','Netflix',1,51),('2024-04-19','iPad','Minesweeper',0,29),('2024-04-19','iPad','Goodnotes',0,23),
('2024-04-20','iPad','Goodnotes',0,3),

('2024-04-21','iPad','Netflix',3,43),('2024-04-21','iPad','Safari',0,12),
('2024-04-22','iPad','Netflix',1,48),('2024-04-22','iPad','Minesweeper',0,18),
('2024-04-23','iPad','Safari',0,54),
('2024-04-24','iPad','Goodnotes',1,47),('2024-04-24','iPad','Etsy',0,31),('2024-04-24','iPad','Safari',0,27),('2024-04-24','iPad','Spotify',0,23),
('2024-04-25','iPad','Etsy',1,40),('2024-04-25','iPad','Goodnotes',0,50),('2024-04-24','iPad','Safari',0,46),('2024-04-24','iPad','Spotify',0,27),
('2024-04-26','iPad','Safari',1,42),('2024-04-26','iPad','Etsy',0,53),('2024-04-26','iPad','Goodnotes',0,17),

--------- iPhone -------------
('2024-02-25','iPhone','Maps',0,53),('2024-02-25','iPhone','Instagram',0,38),('2024-02-25','iPhone','Kindle',0,29),('2024-02-25','iPhone','Messages',0,29),('2024-02-25','iPhone','Safari',0,20),('2024-02-25','iPhone','Webtoon',0,18),
('2024-02-26','iPhone','Webtoon',0,23),('2024-02-26','iPhone','Kindle',0,18),
('2024-02-27','iPhone','Instagram',0,17),('2024-02-27','iPhone','Safari',0,17),
('2024-02-28','iPhone','Kindle',0,39),('2024-02-28','iPhone','Instagram',0,16),('2024-02-28','iPhone','Webtoon',0,10),
('2024-02-29','iPhone','YouTube',1,9),('2024-02-29','iPhone','Instagram',0,11),
('2024-03-01','iPhone','Kindle',0,43),('2024-03-01','iPhone','Instagram',0,39),('2024-03-01','iPhone','Webtoon',0,20),('2024-03-01','iPhone','Messages',0,15),('2024-03-01','iPhone','Spider Solitaire',0,6),
('2024-03-02','iPhone','Kindle',2,21),('2024-03-02','iPhone','Instagram',0,52),('2024-03-02','iPhone','Messages',0,23),('2024-03-02','iPhone','Safari',0,23),('2024-03-02','iPhone','Spider Solitaire',0,12),('2024-03-02','iPhone','Webtoon',0,7),

('2024-03-03','iPhone','Kindle',0,23),('2024-03-03','iPhone','YouTube',0,17),('2024-03-03','iPhone','Safari',0,14),('2024-03-03','iPhone','Reddit',0,12),
('2024-03-04','iPhone','Instagram',0,47),('2024-03-04','iPhone','Hulu',0,41),('2024-03-04','iPhone','Spider Solitaire',0,24),('2024-03-04','iPhone','Kindle',0,21),('2024-03-04','iPhone','Safari',0,18),('2024-03-04','iPhone','Webtoon',0,13),('2024-03-04','iPhone','Wells Fargo',0,10),
('2024-03-05','iPhone','Safari',0,27),('2024-03-05','iPhone','Gmail',0,24),('2024-03-05','iPhone','Spider Solitaire',0,22),('2024-03-05','iPhone','Kindle',0,17),('2024-03-05','iPhone','Webtoon',0,8),
('2024-03-06','iPhone','Spider Solitaire',0,35),('2024-03-06','iPhone','Instagram',0,34),('2024-03-06','iPhone','Safari',0,17),('2024-03-06','iPhone','Webtoon',0,4),
('2024-03-07','iPhone','YouTube',1,24),('2024-03-07','iPhone','Instagram',1,14),('2024-03-07','iPhone','Spider Solitaire',0,33),('2024-03-07','iPhone','Webtoon',0,20),('2024-03-07','iPhone','Safari',0,9),
('2024-03-08','iPhone','Safari',0,30),('2024-03-08','iPhone','Spider Solitaire',0,29),('2024-03-08','iPhone','Sudoku',0,15),
('2024-03-09','iPhone','Maps',0,41),('2024-03-09','iPhone','Webtoon',0,26),('2024-03-09','iPhone','Safari',0,13),('2024-03-09','iPhone','Sudoku',0,12),

('2024-03-10','iPhone','Messages',0,45),('2024-03-10','iPhone','Webtoon',1,11),('2024-03-10','iPhone','Instagram',0,43),('2024-03-10','iPhone','Safari',0,18),
('2024-03-11','iPhone','YouTube',0,47),('2024-03-11','iPhone','Safari',0,33),
('2024-03-12','iPhone','Webtoon',1,52),('2024-03-12','iPhone','YouTube',0,53),('2024-03-12','iPhone','Safari',0,27),('2024-03-12','iPhone','Instagram',0,24),('2024-03-12','iPhone','Sudoku',0,11),
('2024-03-13','iPhone','Discover',0,10),('2024-03-13','iPhone','Instagram',0,5),
('2024-03-14','iPhone','Safari',0,33),('2024-03-14','iPhone','Webtoon',0,17),('2024-03-14','iPhone','Netflix',0,11),
('2024-03-15','iPhone','Instagram',1,7),('2024-03-15','iPhone','Phone',0,41),('2024-03-15','iPhone','Webtoon',0,32),('2024-03-15','iPhone','Safari',0,24),
('2024-03-16','iPhone','YouTube',1,11),('2024-03-16','iPhone','Webtoon',0,53),('2024-03-16','iPhone','Messages',0,35),('2024-03-16','iPhone','Safari',0,30),('2024-03-16','iPhone','Instagram',0,20),('2024-03-16','iPhone','Wells Fargo',0,4),

('2024-03-17','iPhone','Instagram',0,27),('2024-03-17','iPhone','Webtoon',0,21),
('2024-03-18','iPhone','YouTube',0,35),('2024-03-18','iPhone','Messages',1,59),('2024-03-18','iPhone','Instagram',0,56),('2024-03-18','iPhone','Spider Solitaire',0,40),('2024-03-18','iPhone','Spotify',0,18),('2024-03-18','iPhone','Safari',0,12),('2024-03-18','iPhone','Webtoon',0,6),
('2024-03-19','iPhone','Messages',0,53),('2024-03-19','iPhone','Safari',0,36),('2024-03-19','iPhone','Netflix',0,35),('2024-03-19','iPhone','Instagram',0,31),('2024-03-19','iPhone','Spider Solitaire',0,9),('2024-03-19','iPhone','Webtoon',0,4),
('2024-03-20','iPhone','YouTube',1,43),('2024-03-20','iPhone','Messages',0,19),('2024-03-20','iPhone','Instagram',0,11),('2024-03-20','iPhone','Wells Fargo',0,7),('2024-03-20','iPhone','Spotify',0,3),
('2024-03-21','iPhone','Webtoon',0,16),('2024-03-21','iPhone','Safari',0,15),('2024-03-21','iPhone','Spider Solitaire',0,11),('2024-03-21','iPhone','Instagram',0,8),
('2024-03-22','iPhone','YouTube',0,20),('2024-03-22','iPhone','Instagram',0,55),('2024-03-22','iPhone','Safari',0,42),('2024-03-22','iPhone','Spotify',0,13),
('2024-03-23','iPhone','YouTube',1,2),('2024-03-23','iPhone','Safari',0,18),('2024-03-23','iPhone','Webtoon',0,10),

('2024-03-24','iPhone','YouTube',1,10),('2024-03-24','iPhone','Messages',1,44),('2024-03-24','iPhone','Instagram',0,27),('2024-03-24','iPhone','Gmail',0,22),('2024-03-24','iPhone','Safari',0,16),
('2024-03-25','iPhone','YouTube',1,14),('2024-03-25','iPhone','Instagram',1,32),('2024-03-25','iPhone','Messages',0,57),('2024-03-25','iPhone','Safari',0,34),('2024-03-25','iPhone','Wells Fargo',0,2),
('2024-03-26','iPhone','WhatsApp',0,51),('2024-03-26','iPhone','Safari',0,21),('2024-03-26','iPhone','Spotify',0,16),('2024-03-26','iPhone','Gmail',0,7),('2024-03-26','iPhone','Webtoon',0,5),
('2024-03-27','iPhone','Safari',0,28),('2024-03-27','iPhone','Instagram',0,22),('2024-03-27','iPhone','WhatsApp',0,7),('2024-03-27','iPhone','Spotify',0,2),
('2024-03-28','iPhone','Messages',1,2),('2024-03-28','iPhone','Instagram',0,30),('2024-03-28','iPhone','Spotify',0,17),('2024-03-28','iPhone','Safari',0,13),
('2024-03-29','iPhone','Kindle',0,21),('2024-03-29','iPhone','Instagram',0,17),('2024-03-29','iPhone','Safari',0,11),
('2024-03-30','iPhone','Messages',0,52),('2024-03-30','iPhone','Webtoon',0,30),('2024-03-30','iPhone','Safari',0,12),('2024-03-30','iPhone','Instagram',0,6),

('2024-03-31','iPhone','Messages',0,59),('2024-03-31','iPhone','Maps',0,38),('2024-03-31','iPhone','Safari',0,19),('2024-03-31','iPhone','Webtoon',0,13),('2024-03-31','iPhone','Credit Karma',0,9),
('2024-04-01','iPhone','Safari',0,52),('2024-04-01','iPhone','Instagram',0,34),
('2024-04-02','iPhone','YouTube',0,45),('2024-04-02','iPhone','Messages',0,37),('2024-04-02','iPhone','Instagram',0,23),
('2024-04-03','iPhone','Instagram',0,50),('2024-04-03','iPhone','Safari',0,28),('2024-04-03','iPhone','WhatsApp',0,19),
('2024-04-04','iPhone','YouTube',0,34),('2024-04-04','iPhone','Messages',1,22),('2024-04-04','iPhone','Safari',0,22),('2024-04-04','iPhone','Instagram',0,14),('2024-04-04','iPhone','Spider Solitaire',0,14),('2024-04-04','iPhone','WhatsApp',0,11),
('2024-04-05','iPhone','Sudoku',0,28),('2024-04-05','iPhone','WhatsApp',0,24),('2024-04-05','iPhone','Spider Solitaire',0,22),
('2024-04-06','iPhone','YouTube',0,56),('2024-04-06','iPhone','WhatsApp',0,26),('2024-04-06','iPhone','Instagram',0,21),('2024-04-06','iPhone','Safari',0,10),

('2024-04-07','iPhone','Kindle',2,12),('2024-04-07','iPhone','YouTube',0,34),('2024-04-07','iPhone','Messages',0,30),('2024-04-07','iPhone','Sudoku',0,25),('2024-04-07','iPhone','Safari',0,17),
('2024-04-08','iPhone','Safari',0,43),('2024-04-08','iPhone','Messages',0,26),
('2024-04-09','iPhone','Messages',0,55),('2024-04-09','iPhone','YouTube',0,50),('2024-04-09','iPhone','Instagram',0,20),('2024-04-09','iPhone','Kindle',0,16),('2024-04-09','iPhone','SoFi',0,9),('2024-04-09','iPhone','Safari',0,8),
('2024-04-10','iPhone','Messages',0,38),
('2024-04-11','iPhone','Messages',0,24),('2024-04-11','iPhone','Webtoon',0,19),
('2024-04-12','iPhone','Webtoon',0,48),('2024-04-12','iPhone','SoFi',0,28),('2024-04-12','iPhone','Wells Fargo',0,21),('2024-04-12','iPhone','Safari',0,15),('2024-04-12','iPhone','Instagram',0,13),
('2024-04-13','iPhone','Messages',0,44),('2024-04-13','iPhone','Instagram',0,33),('2024-04-13','iPhone','WhatsApp',0,26),('2024-04-13','iPhone','Safari',0,23),('2024-04-13','iPhone','Webtoon',0,14),

('2024-04-14','iPhone','Messages',0,33),('2024-04-14','iPhone','Safari',0,19),('2024-04-14','iPhone','Sudoku',0,15),
('2024-04-15','iPhone','Instagram',0,50),('2024-04-15','iPhone','Hulu',0,35),('2024-04-15','iPhone','Messages',0,32),('2024-04-15','iPhone','Wordle',0,31),('2024-04-15','iPhone','Safari',0,19),('2024-04-15','iPhone','Sudoku',0,17),('2024-04-15','iPhone','WhatsApp',0,13),
('2024-04-16','iPhone','Instagram',0,32),('2024-04-16','iPhone','Webtoon',0,21),('2024-04-16','iPhone','Safari',0,20),
('2024-04-17','iPhone','Safari',0,36),('2024-04-17','iPhone','Instagram',0,22),('2024-04-17','iPhone','Spider Solitaire',0,19),('2024-04-17','iPhone','Wordle',0,15),
('2024-04-18','iPhone','WhatsApp',0,34),('2024-04-18','iPhone','Safari',0,24),('2024-04-18','iPhone','Messages',0,13),('2024-04-18','iPhone','Instagram',0,10),
('2024-04-19','iPhone','Kindle',0,52),('2024-04-19','iPhone','WhatsApp',0,20),('2024-04-19','iPhone','Instagram',0,15),('2024-04-19','iPhone','Sudoku',0,7),
('2024-04-20','iPhone','Kindle',1,7),('2024-04-20','iPhone','Hulu',0,56),('2024-04-20','iPhone','Messages',0,26),

('2024-04-21','iPhone','Instagram',0,19),('2024-04-21','iPhone','Messages',0,17),
('2024-04-22','iPhone','Webtoon',0,32),('2024-04-22','iPhone','Messages',0,24),('2024-04-22','iPhone','Instagram',0,13),('2024-04-22','iPhone','Spider Solitaire',0,9),
('2024-04-23','iPhone','Messages',0,37),('2024-04-23','iPhone','Safari',0,16),('2024-04-23','iPhone','Sudoku',0,14),
('2024-04-24','iPhone','Wells Fargo',0,49),('2024-04-24','iPhone','Messages',0,22),('2024-04-24','iPhone','Safari',0,20),('2024-04-24','iPhone','Instagram',0,15),
('2024-04-25','iPhone','Hulu',1,38),('2024-04-25','iPhone','YouTube',1,13),('2024-04-25','iPhone','Messages',0,22),('2024-04-25','iPhone','Webtoon',0,6),
('2024-04-26','iPhone','YouTube',0,25),('2024-04-26','iPhone','Messages',0,50),('2024-04-26','iPhone','Safari',0,17),('2024-04-26','iPhone','Hoopla',0,9),
('2024-04-27','iPhone','Etsy',0,36),('2024-04-27','iPhone','Safari',0,17),('2024-04-27','iPhone','Spotify',0,15),('2024-04-27','iPhone','Messages',0,13),('2024-04-27','iPhone','Webtoon',0,10)
GO

CREATE VIEW zoila.app_ST
AS
SELECT 
	entry_id,
	entry_date,
	device,
	app,
	total_ST_hours
FROM zoila.app_screen_time;
GO

DROP TABLE IF EXISTS zoila.time_is_money;
CREATE TABLE zoila.time_is_money (
	[Week #] int,
	[Total Screen Time (hours)] float,
	[Cost of Screen Time] varchar(10),
	[App I Spent the Most Time Using] varchar(40),
	[Total App Screen Time (Hours)] float,
	[Cost of App Screen Time] varchar(10),
	[Most Used App Compared to Total Screen Time] AS FORMAT([Total App Screen Time (Hours)]/[Total Screen Time (hours)],'P')
);
GO

CREATE PROCEDURE zoila.compute_time_as_money
AS
--Returns total screen time (sums screen time across all apps and devices) each week
DROP TABLE IF EXISTS #weekly_total_screen_time
SELECT 
	DATEPART(week,entry_date) week_#,
	SUM(total_ST_hours) total_ST,
	FORMAT(SUM(total_ST_hours) * 20,'C','en-US') total_ST_cost --assuming my time is worth $20/hr
INTO #weekly_total_screen_time
FROM zoila.app_ST
GROUP BY DATEPART(week,entry_date);

--Returns the total hours spent on each app during each week
DROP TABLE IF EXISTS #weekly_app_totals;
SELECT 
	DATEPART(week,entry_date) week_#,
	app,
	SUM(total_ST_hours) app_total_ST
INTO #weekly_app_totals
FROM zoila.app_ST t1
GROUP BY DATEPART(week,entry_date), app;

--Returns the app with the highest amount of screen time each week
DROP TABLE IF EXISTS #max_app_screen_time
SELECT
	t1.*,
	FORMAT(t1.app_total_ST * 20,'C','en-US') app_ST_cost
INTO #max_app_screen_time
FROM #weekly_app_totals t1
INNER JOIN (
	SELECT week_#, max(app_total_st) max_app_ST
	FROM #weekly_app_totals
	GROUP BY week_#
) t2
ON t1.week_# = t2.week_# AND t1.app_total_ST = t2.max_app_ST
ORDER BY t1.week_#;

/* Updates Time Is Money table with the total weekly screen time, weekly screen time cost
   most used app each week, most used app screen time, and most used app cost
 -> Table also computes the percentage of total weekly screen time spent on the most used app that week*/
TRUNCATE TABLE zoila.time_is_money;
INSERT INTO zoila.time_is_money 
SELECT 
	t1.week_#,
	t1.total_ST,
	t1.total_ST_cost ,
	t2.app,
	t2.app_total_ST,
	t2.app_ST_cost
FROM #weekly_total_screen_time t1
INNER JOIN #max_app_screen_time t2 ON t1.week_# = t2.week_#
ORDER BY t1.week_#;

SELECT *
FROM zoila.time_is_money
ORDER BY [Week #];
GO

EXEC zoila.compute_time_as_money;
GO


CREATE PROCEDURE zoila.weekday_as_money @weekday varchar(10)
AS
DECLARE	@weekday_int int;

SELECT @weekday_int = 
		CASE @weekday
			WHEN 'Sunday'		THEN 1 
			WHEN 'Monday'		THEN 2
			WHEN 'Tuesday'		THEN 3
			WHEN 'Wednesday'	THEN 4
			WHEN 'Thursday'		THEN 5
			WHEN 'Friday'		THEN 6
			ELSE 7 
		END;

SELECT [Category], ISNULL([iPad],0) [iPad], ISNULL([iPhone],0) [iPhone]
FROM (
	SELECT t1.device, t2.Category, ROUND(AVG(t1.total_ST_hours),2) total_ST_hours
	FROM zoila.app_ST t1
	INNER JOIN zoila.app_categories t2 ON t1.app = t2.app
	WHERE DATEPART(weekday, entry_date) = @weekday_int
	GROUP BY device, t2.category) src
PIVOT (
		SUM(total_ST_hours)
		FOR device IN ([iPad],[iPhone])
	) pivot_table
GO

EXEC zoila.weekday_as_money @weekday = 'Sunday'
