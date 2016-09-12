drop table if exists review;
drop table if exists activity;
drop table if exists trip;
drop table if exists credit_card;
drop table if exists open_times;
drop table if exists attraction;
drop table if exists public_trans;
drop table if exists reservation;
drop table if exists user;

CREATE TABLE user (
  email VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  is_admin BOOLEAN Not NULL,
  is_suspended BOOLEAN Not NULL,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  city VARCHAR(50) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  country VARCHAR(50) NOT NULL,
  PRIMARY KEY  (email)
);

CREATE TABLE reservation (
  reservation_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) Not NULL,
  start_date_time DATETIME Not NULL, 
  end_date_time DATETIME Not NULL,
  total_cost DECIMAL(7,2) NOT NULL,
  number_in_party SMALLINT NOT NULL,
  PRIMARY KEY  (reservation_id)
);

CREATE TABLE public_trans (
  name VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  city VARCHAR(50) NOT NULL,
  PRIMARY KEY  (name)
  
);

create table attraction (
  name varchar(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  city VARCHAR(50) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  country VARCHAR(50) NOT NULL,
  description TEXT DEFAULT NULL,
  price decimal(10,2) NOT NULL,
  requires_reservation boolean NOT NULL,
  capacity SMALLINT, 
  nearest_public_trans varchar(50) default NULL,
  PRIMARY KEY (name),
  FOREIGN KEY (nearest_public_trans) REFERENCES public_trans(name)
);

CREATE TABLE open_times (
  name VARCHAR(50) NOT NULL,
  day_of_week int NOT NULL,
  open_time time,
  close_time time,
  PRIMARY KEY (name, day_of_week),
  FOREIGN KEY (name) REFERENCES attraction(name)
);

CREATE TABLE credit_card (
  cc_number VARCHAR(16) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  address2 VARCHAR(50) DEFAULT NULL,
  city VARCHAR(50) NOT NULL,
  zip VARCHAR(5) NOT NULL,
  country VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  expiry VARCHAR(50) NOT NULL,
  PRIMARY KEY  (cc_number),
  FOREIGN KEY (email) REFERENCES user(email) ON DELETE CASCADE
);

CREATE TABLE trip (
  trip_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  trip_user VARCHAR(50) NOT NULL,
  city VARCHAR(50) Not NULL,
  booked BOOLEAN Not NULL,
  cc_number VARCHAR(16) DEFAULT NULL,
  PRIMARY KEY  (trip_id),
  FOREIGN KEY (trip_user) REFERENCES user(email) ON DELETE CASCADE,
  FOREIGN KEY (cc_number) REFERENCES credit_card(cc_number) ON DELETE CASCADE
  
);

CREATE TABLE activity (
  attraction_name VARCHAR(50) NOT NULL,
  start_date_time DATETIME Not NULL,
  end_date_time DATETIME Not NULL,
  trip_id SMALLINT UNSIGNED NOT NULL,
  reservation_id SMALLINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY  (attraction_name,start_date_time,trip_id), 
  FOREIGN KEY (attraction_name) REFERENCES attraction(name),
  FOREIGN KEY (trip_id) REFERENCES trip(trip_id) ON DELETE CASCADE,
  FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id) ON DELETE SET NULL

  );

CREATE TABLE review (
  review_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  attraction VARCHAR(50) Not NULL,
  email VARCHAR(50) Not NULL,
  date_reviewed DATETIME Not NULL, 
  body TEXT Not NULL,
  title VARCHAR(50) Not NULL,
  PRIMARY KEY  (review_id),
  FOREIGN KEY (attraction) REFERENCES attraction(name),
  FOREIGN KEY (email) REFERENCES user(email) ON DELETE CASCADE
  
);
