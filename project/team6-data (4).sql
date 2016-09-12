INSERT INTO user VALUES ('ryanpeck239@gmail.com', 'password', 'Ryan','Peck',true,false,'1800 American Way',NULL,'Marietta','30062','USA');
INSERT INTO user VALUES ('jorge@gmail.com', 'jorgepass','Jorge','Armenteros',false,false,'711 Techwood Dr',NULL,'Metz','30062','USA');


INSERT INTO reservation VALUES (1,'Paris','2018-07-06 15:00:00','2018-07-06 18:00:00',95,4),
(2,'Paris','2018-07-07 10:15:00','2018-07-07 17:15:00',90,4)

;

INSERT INTO public_trans VALUES('Republique','Place de la République', NULL,'Metz'),
('Gare de l est','Place du 11 Novembre 1918, Rue du 8 Mai 1945', NULL,'Paris'),
('Interlaken Zentralplatz','Centralplatz', NULL,'Interlaken')

;

INSERT INTO attraction VALUES ('Allez Les Bleus','Place Saint-Jacques', NULL,'Metz','57000','France','Watch the French national soccer team or the local Metz team take on whoever in the Metz square. The crowd is wildly passionate. Open Fridays and Saturdays from 8:00 PM until midnight.',0,false,NULL,'Republique'),
('Cathedral','Place d"Armes', NULL, 'Metz','57000','France','A beautiful cathedral completed in 1550. Open every day from 9:30 AM until 5:30 PM.',0,false,500,'Republique'),
('Walk Through Park','Rue du Gué', NULL, 'Metz','57000','France','A garden, park, and walking path share space with a landscape that changes from downtown Metz to farmland. One can do it any day, any time but our recommendation is during day time.',0,false,NULL,'Republique'),
('Montmartre Shops and Cathedral','35 Rue du Chevalier de la Barre', NULL, 'Paris','75018','France','An elegant cathedral sits upon a hill overlooking Paris. The surrounding shops complete the quaint albeit touristy experience. Open every day from 6:00 AM to 10:30 PM.',0,false,NULL,'Gare de l est'),
('Macaron Class','59 Rue du Cardinal Lemoine', NULL, 'Paris', '75005','France','An interactive cooking experience to train in the acclaimed art of French pastry baking. Class takes place Friday through Monday, from 3:00 PM to 6:00 PM.',95,true,15,'Gare de l est'),
('Palace de Versailles','Place d"Armes', NULL, 'Paris', '78000','France','Experience the gardens and palace of the 17th and 18th century French royalty. Open every day except Mondays from 10:15 AM to 5:15 PM',90,true,NULL,'Gare de l est'),
('Bungy Jumping','Hauptstr. 36', NULL,'Interlaken', '38000','Switzerland','Get an adrenaline rush with the highest water-touch bungy jumping in the world. Open Monday-Friday from 5:00 PM to 10:00 PM.',190,true,30,'Interlaken Zentralplatz'),
('Hang Gliding','Rugenparkstrasse 2', NULL, 'Interlaken', '38000','Switzerland','Climb, jump, and wade your way through a canyon formed from glacial runoff with the help of seasoned guides. Open Monday-Friday from 12:15 PM to 3:15 PM.',120,true,60,'Interlaken Zentralplatz'),
('Swiss Chocolate Making','Jungfraustrasse 35', NULL,'Interlaken', '38000','Switzerland','Learn to make chocolate from Swiss chocolatiering masters. Open Monday-Friday from 2:00 PM to 7:00 PM',70,true,60,'Interlaken Zentralplatz')

;

INSERT INTO open_times VALUES 
('Allez Les Bleus', 1, NULL,NULL),
('Allez Les Bleus', 2, NULL,NULL),
('Allez Les Bleus', 3, NULL,NULL),
('Allez Les Bleus', 4, NULL,NULL),
('Allez Les Bleus', 5, NULL,NULL),
('Allez Les Bleus', 6, '20:00:00','23:59:00'),
('Allez Les Bleus', 7, '20:00:00','23:59:00'),
('Cathedral', 1, '09:30:00','17:30:00'),
('Cathedral', 2, '09:30:00','17:30:00'),
('Cathedral', 3, '09:30:00','17:30:00'),
('Cathedral', 4, '09:30:00','17:30:00'),
('Cathedral', 5, '09:30:00','17:30:00'),
('Cathedral', 6, '09:30:00','17:30:00'),
('Cathedral', 7, '09:30:00','17:30:00'),
('Walk Through Park', 1, '00:00:00','23:59:00'),
('Walk Through Park', 2, '00:00:00','23:59:00'),
('Walk Through Park', 3, '00:00:00','23:59:00'),
('Walk Through Park', 4, '00:00:00','23:59:00'),
('Walk Through Park', 5, '00:00:00','23:59:00'),
('Walk Through Park', 6, '00:00:00','23:59:00'),
('Walk Through Park', 7, '00:00:00','23:59:00'),
('Montmartre Shops and Cathedral', 1, '06:00:00','22:30:00'),
('Montmartre Shops and Cathedral', 2, '06:00:00','22:30:00'),
('Montmartre Shops and Cathedral', 3, '06:00:00','22:30:00'),
('Montmartre Shops and Cathedral', 4, '06:00:00','22:30:00'),
('Montmartre Shops and Cathedral', 5, '06:00:00','22:30:00'),
('Montmartre Shops and Cathedral', 6, '06:00:00','22:30:00'),
('Montmartre Shops and Cathedral', 7, '06:00:00','22:30:00'),
('Macaron Class', 1, '15:00:00','18:00:00'),
('Macaron Class', 2, '15:00:00','18:00:00'),
('Macaron Class', 3, NULL,NULL),
('Macaron Class', 4, NULL,NULL),
('Macaron Class', 5, NULL,NULL),
('Macaron Class', 6, '15:00:00','18:00:00'),
('Macaron Class', 7, '15:00:00','18:00:00'),
('Palace de Versailles', 1, '10:15:00','17:15:00'),
('Palace de Versailles', 2, NULL,NULL),
('Palace de Versailles', 3, '10:15:00','17:15:00'),
('Palace de Versailles', 4, '10:15:00','17:15:00'),
('Palace de Versailles', 5, '10:15:00','17:15:00'),
('Palace de Versailles', 6, '10:15:00','17:15:00'),
('Palace de Versailles', 7, '10:15:00','17:15:00'),
('Bungy Jumping', 1, NULL, NULL),
('Bungy Jumping', 2, '17:00:00','22:00:00'),
('Bungy Jumping', 3, '17:00:00','22:00:00'),
('Bungy Jumping', 4, '17:00:00','22:00:00'),
('Bungy Jumping', 5, '17:00:00','22:00:00'),
('Bungy Jumping', 6, '17:00:00','22:00:00'),
('Bungy Jumping', 7, NULL,NULL),
('Hang Gliding', 1, NULL, NULL),
('Hang Gliding', 2, '12:30:00','15:30:00'),
('Hang Gliding', 3, '12:30:00','15:30:00'),
('Hang Gliding', 4, '12:30:00','15:30:00'),
('Hang Gliding', 5, '12:30:00','15:30:00'),
('Hang Gliding', 6, '12:30:00','15:30:00'),
('Hang Gliding', 7, NULL,NULL),
('Swiss Chocolate Making', 1, NULL, NULL),
('Swiss Chocolate Making', 2, '14:00:00','19:00:00'),
('Swiss Chocolate Making', 3, '14:00:00','19:00:00'),
('Swiss Chocolate Making', 4, '14:00:00','19:00:00'),
('Swiss Chocolate Making', 5, '14:00:00','19:00:00'),
('Swiss Chocolate Making', 6, '14:00:00','19:00:00'),
('Swiss Chocolate Making', 7, NULL,NULL)
;

INSERT INTO credit_card VALUES (314159265358,'Ryan','Peck','1800 American Way',NULL,'Marietta','30062','USA','ryanpeck239@gmail.com','12-2020')

;

INSERT INTO trip VALUES (1,'ryanpeck239@gmail.com','Paris',true,314159265358)

;

INSERT INTO activity VALUES ('Montmartre Shops and Cathedral','2018-07-07 18:00:00','2018-07-07 22:00:00',1,NULL),
('Macaron Class','2018-07-06 15:00:00','2018-07-06 18:00:00',1,1),
('Palace de Versailles','2018-07-07 10:15:00','2018-07-07 17:15:00',1,2)

;

INSERT INTO	review VALUES(1,'Macaron Class','ryanpeck239@gmail.com','2016-07-04 12:00:00','The macaron class was very good but it was too expensive','Delicious but Expensive')

;

-- user, reservation, credit_card, trip, public_trans,
-- attraction, review, activity inserted.









