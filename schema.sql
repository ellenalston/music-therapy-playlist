START TRANSACTION;

-- (I) DROP SECTION
-- We drop tables with dependant data first
DROP TABLE IF EXISTS song_genre;
DROP TABLE IF EXISTS song_theme;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS themes;


-- (II) CREATE SECTION
-- Define the tables and columns

CREATE TABLE songs (
	song_id serial, 
	song_title varchar NOT NULL,
	artist varchar, 
	release_year int NOT NULL, 
	song_key varchar,
	beats_per_minute int,
	CONSTRAINT pk_songs PRIMARY KEY(song_id) 
);

CREATE TABLE genres(
	genre_id serial, 
	genre_name varchar,
	CONSTRAINT pk_genres PRIMARY KEY (genre_id)
);

CREATE TABLE themes(
	theme_id serial,
	theme_name varchar,
	CONSTRAINT pk_themes PRIMARY KEY (theme_id)
);

CREATE TABLE song_theme(
	song_id int,
	theme_id int,
	CONSTRAINT pk_song_theme PRIMARY KEY (song_id, theme_id),
	CONSTRAINT fk_song FOREIGN KEY (song_id) REFERENCES songs (song_id), 
	CONSTRAINT fk_theme FOREIGN KEY (theme_id) REFERENCES themes (theme_id)
);

CREATE TABLE song_genre(
	song_id int,
	genre_id int,
	CONSTRAINT pk_song_genre PRIMARY KEY (song_id, genre_id),
	CONSTRAINT fk_song FOREIGN KEY (song_id) REFERENCES songs (song_id), 
	CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres (genre_id));

COMMIT;