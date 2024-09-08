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

-- (III) POPULATE SECTION
-- INSERT rows into the tables we made
INSERT INTO songs (song_title, artist, release_year, song_key, beats_per_minute) VALUES
('Dont Fence Me In', 'Gene Autry', 1944, 'F major', 140),
('Thats Amore', 'Dean Martin', 1953, 'G major', 96),
('All I Have to Do Is Dream', 'The Everly Brothers', 1958, 'E major', 68),
('All Shook Up', 'Elvis Presley', 1957, 'A major', 175),
('At the Hop', 'Danny & the Juniors', 1957, 'C major', 130),
('Day-O (The Banana Boat Song)', 'Harry Belafonte', 1956, 'F major', 92),
('Beyond the Sea', 'Bobby Darin', 1959, 'C major', 115),
('Blue Skies', 'Ella Fitzgerald', 1958, 'F major', 160),
('Blue Suede Shoes', 'Elvis Presley', 1956, 'E major', 156),
('Blueberry Hill', 'Fats Domino', 1956, 'F major', 84),
('Cheek to Cheek', 'Fred Astaire', 1935, 'F major', 112),
('Cold, Cold Heart', 'Hank Williams', 1951, 'C major', 80),
('Come Fly With Me', 'Frank Sinatra', 1958, 'C major', 132),
('Dream a Little Dream of Me', 'Ella Fitzgerald', 1950, 'C major', 72),
('Earth Angel', 'The Penguins', 1954, 'C major', 75),
('Everyday', 'Buddy Holly', 1957, 'A major', 140),
('Fever', 'Peggy Lee', 1958, 'A minor', 135),
('Folsom Prison Blues', 'Johnny Cash', 1955, 'E major', 92),
('Get A Job', 'The Silhouettes', 1957, 'C major', 110),
('Goodnight Irene', 'Lead Belly', 1949, 'C major', 80),
('Hey Good Lookin', 'Hank Williams', 1951, 'A major', 148),
('High Hopes', 'Frank Sinatra', 1959, 'C major', 104),
('I Walk the Line', 'Johnny Cash', 1956, 'E major', 72),
('Jailhouse Rock', 'Elvis Presley', 1957, 'E major', 160),
('Johnny B Goode', 'Chuck Berry', 1958, 'Bb major', 168),
('La Bamba', 'Ritchie Valens', 1958, 'C major', 144),
('Let Me Be Your Teddy Bear', 'Elvis Presley', 1957, 'C major', 128),
('Love is Here to Stay', 'Ella Fitzgerald', 1956, 'C major', 122),
('Love Me Tender', 'Elvis Presley', 1956, 'A major', 72),
('Love Potion No. 9', 'The Clovers', 1959, 'Eb major', 126),
('Mr. Sandman', 'The Chordettes', 1954, 'C major', 120),
('My Funny Valentine', 'Ella Fitzgerald', 1956, 'C major', 80),
('Peggy Sue', 'Buddy Holly', 1957, 'E major', 180),
('Que Sera, Sera (Whatever Will Be, Will Be)', 'Doris Day', 1956, 'C major', 80),
('Rock Around the Clock', 'Bill Haley & His Comets', 1954, 'A major', 168),
('Rockin Robin', 'Bobby Day', 1958, 'A major', 120),
('Sixteen Tons', 'Tennessee Ernie Ford', 1955, 'C major', 84),
('Your Cheatin Heart', 'Hank Williams', 1953, 'C major', 100);


INSERT INTO genres(genre_name) VALUES
('Big Band'),
('Blues'),
('Calypso'),
('Chicano Rock'),
('Country'),
('Doo-Wop'),
('Folk'),
('Honky Tonk'),
('Jazz'),
('Pop'),
('Rhythm and Blues'),
('Rock and Roll'),
('Rockabilly'),
('Standards'),
('Swing'),
('Western');

INSERT INTO themes (theme_name) VALUES
('Acceptance'),
('Adventure'),
('Ambition'),
('Anticipation'),
('Appreciation'),
('Betrayal'),
('Cultural Appreciation'),
('Confidence'),
('Dance'),
('Devotion'),
('Escapism'),
('Freedom'),
('Fun'),
('Goodbye'),
('Happiness'),
('Heartache'),
('Hope'),
('Independence'),
('Infatuation'),
('Isolation'),
('Longing'),
('Love'),
('Nature'),
('Nostalgia'),
('Pain'),
('Passion'),
('Redemption'),
('Regret'),
('Resilience'),
('Responsibility'),
('Romance'),
('Success'),
('Work');


-- Love, Cultural Appreciation, Happiness, Big Band for "That's Amore"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Thats Amore' AND artist = 'Dean Martin'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Thats Amore' AND artist = 'Dean Martin'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Cultural Appreciation')),
((SELECT song_id FROM songs WHERE song_title = 'Thats Amore' AND artist = 'Dean Martin'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Happiness'));

-- Love, Escapism for "All I Have to Do Is Dream"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'All I Have to Do Is Dream' AND artist = 'The Everly Brothers'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'All I Have to Do Is Dream' AND artist = 'The Everly Brothers'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Escapism'));

-- Infatuation, Love, Happiness for "All Shook Up"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'All Shook Up' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Infatuation')),
((SELECT song_id FROM songs WHERE song_title = 'All Shook Up' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'All Shook Up' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Happiness'));

-- Dance, Fun, Nostalgia for "At the Hop"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'At the Hop' AND artist = 'Danny & the Juniors'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Dance')),
((SELECT song_id FROM songs WHERE song_title = 'At the Hop' AND artist = 'Danny & the Juniors'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Fun')),
((SELECT song_id FROM songs WHERE song_title = 'At the Hop' AND artist = 'Danny & the Juniors'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nostalgia'));

-- Work, Cultural Appreciation, Anticipation for "Day-O (The Banana Boat Song)"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Day-O (The Banana Boat Song)' AND artist = 'Harry Belafonte'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Work')),
((SELECT song_id FROM songs WHERE song_title = 'Day-O (The Banana Boat Song)' AND artist = 'Harry Belafonte'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Cultural Appreciation')),
((SELECT song_id FROM songs WHERE song_title = 'Day-O (The Banana Boat Song)' AND artist = 'Harry Belafonte'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Anticipation'));

-- Love, Hope for "Beyond the Sea"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Beyond the Sea' AND artist = 'Bobby Darin'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Beyond the Sea' AND artist = 'Bobby Darin'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Hope'));

-- Hope, Love, Happiness for "Blue Skies"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Blue Skies' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Hope')),
((SELECT song_id FROM songs WHERE song_title = 'Blue Skies' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Blue Skies' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Happiness'));

-- Independence, Fun, Confidence for "Blue Suede Shoes"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Blue Suede Shoes' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Independence')),
((SELECT song_id FROM songs WHERE song_title = 'Blue Suede Shoes' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Fun')),
((SELECT song_id FROM songs WHERE song_title = 'Blue Suede Shoes' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Confidence'));

-- Nostalgia, Love, Heartache for "Blueberry Hill"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Blueberry Hill' AND artist = 'Fats Domino'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nostalgia')),
((SELECT song_id FROM songs WHERE song_title = 'Blueberry Hill' AND artist = 'Fats Domino'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Blueberry Hill' AND artist = 'Fats Domino'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Heartache'));

-- Romance for "Cheek to Cheek"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Cheek to Cheek' AND artist = 'Fred Astaire'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Romance'));

-- Heartache, Pain, Betrayal, Regret for "Cold, Cold Heart"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Cold, Cold Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Heartache')),
((SELECT song_id FROM songs WHERE song_title = 'Cold, Cold Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Pain')),
((SELECT song_id FROM songs WHERE song_title = 'Cold, Cold Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Betrayal')),
((SELECT song_id FROM songs WHERE song_title = 'Cold, Cold Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Regret'));

-- Adventure, Love, Escapism for "Come Fly With Me"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Come Fly With Me' AND artist = 'Frank Sinatra'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Adventure')),
((SELECT song_id FROM songs WHERE song_title = 'Come Fly With Me' AND artist = 'Frank Sinatra'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Come Fly With Me' AND artist = 'Frank Sinatra'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Escapism'));

-- Love, Longing, Nostalgia for "Dream a Little Dream of Me"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Dream a Little Dream of Me' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Dream a Little Dream of Me' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Longing')),
((SELECT song_id FROM songs WHERE song_title = 'Dream a Little Dream of Me' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nostalgia'));

-- Love, Devotion, Heartache for "Earth Angel"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Earth Angel' AND artist = 'The Penguins'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Earth Angel' AND artist = 'The Penguins'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Devotion')),
((SELECT song_id FROM songs WHERE song_title = 'Earth Angel' AND artist = 'The Penguins'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Heartache'));

-- Love, Happiness, Hope for "Everyday"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Everyday' AND artist = 'Buddy Holly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Everyday' AND artist = 'Buddy Holly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Happiness')),
((SELECT song_id FROM songs WHERE song_title = 'Everyday' AND artist = 'Buddy Holly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Hope'));

-- Passion, Infatuation for "Fever"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Fever' AND artist = 'Peggy Lee'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Passion')),
((SELECT song_id FROM songs WHERE song_title = 'Fever' AND artist = 'Peggy Lee'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Infatuation'));

-- Regret, Isolation, Redemption for "Folsom Prison Blues"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Folsom Prison Blues' AND artist = 'Johnny Cash'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Regret')),
((SELECT song_id FROM songs WHERE song_title = 'Folsom Prison Blues' AND artist = 'Johnny Cash'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Isolation')),
((SELECT song_id FROM songs WHERE song_title = 'Folsom Prison Blues' AND artist = 'Johnny Cash'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Redemption'));

-- Work, Responsibility for "Get A Job"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Get A Job' AND artist = 'The Silhouettes'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Work')),
((SELECT song_id FROM songs WHERE song_title = 'Get A Job' AND artist = 'The Silhouettes'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Responsibility'));

-- Longing, Goodbye, Pain for "Goodnight Irene"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Goodnight Irene' AND artist = 'Lead Belly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Longing')),
((SELECT song_id FROM songs WHERE song_title = 'Goodnight Irene' AND artist = 'Lead Belly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Goodbye')),
((SELECT song_id FROM songs WHERE song_title = 'Goodnight Irene' AND artist = 'Lead Belly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Pain'));

-- Love, Infatuation for "Hey Good Lookin'"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Hey Good Lookin' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Hey Good Lookin' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Infatuation'));

-- Hope for "High Hopes"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'High Hopes' AND artist = 'Frank Sinatra'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Hope'));

-- Love, Devotion for "I Walk the Line"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'I Walk the Line' AND artist = 'Johnny Cash'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'I Walk the Line' AND artist = 'Johnny Cash'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Devotion'));

-- Independence, Longing for "Jailhouse Rock"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Jailhouse Rock' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Independence')),
((SELECT song_id FROM songs WHERE song_title = 'Jailhouse Rock' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Longing'));

-- Ambition, Success for "Johnny B Goode"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Johnny B Goode' AND artist = 'Chuck Berry'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Ambition')),
((SELECT song_id FROM songs WHERE song_title = 'Johnny B Goode' AND artist = 'Chuck Berry'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Success'));

-- Happiness, Cultural Appreciation for "La Bamba"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'La Bamba' AND artist = 'Ritchie Valens'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Happiness')),
((SELECT song_id FROM songs WHERE song_title = 'La Bamba' AND artist = 'Ritchie Valens'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Cultural Appreciation'));

-- Love, Devotion for "Let Me Be Your Teddy Bear"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Let Me Be Your Teddy Bear' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Let Me Be Your Teddy Bear' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Devotion'));

-- Love, Devotion for "Love is Here to Stay"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Love is Here to Stay' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Love is Here to Stay' AND artist = 'Ella Fitzgerald'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Devotion'));

-- Love, Longing for "Love Me Tender"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Love Me Tender' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Love Me Tender' AND artist = 'Elvis Presley'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Longing'));

-- Love, Infatuation for "Love Potion No. 9"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Love Potion No. 9' AND artist = 'The Clovers'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Love Potion No. 9' AND artist = 'The Clovers'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Infatuation'));

-- Love, Longing, Nostalgia for "Mr. Sandman"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Mr. Sandman' AND artist = 'The Chordettes'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Mr. Sandman' AND artist = 'The Chordettes'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Longing')),
((SELECT song_id FROM songs WHERE song_title = 'Mr. Sandman' AND artist = 'The Chordettes'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nostalgia'));

-- Love, Nostalgia for "Peggy Sue"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Peggy Sue' AND artist = 'Buddy Holly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Love')),
((SELECT song_id FROM songs WHERE song_title = 'Peggy Sue' AND artist = 'Buddy Holly'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nostalgia'));

-- Acceptance, Resilience, Hope for "Que Sera, Sera (Whatever Will Be, Will Be)"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Que Sera, Sera (Whatever Will Be, Will Be)' AND artist = 'Doris Day'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Acceptance')),
((SELECT song_id FROM songs WHERE song_title = 'Que Sera, Sera (Whatever Will Be, Will Be)' AND artist = 'Doris Day'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Resilience')),
((SELECT song_id FROM songs WHERE song_title = 'Que Sera, Sera (Whatever Will Be, Will Be)' AND artist = 'Doris Day'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Hope'));

-- Freedom, Nostalgia, Fun for "Rock Around the Clock"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Rock Around the Clock' AND artist = 'Bill Haley & His Comets'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Freedom')),
((SELECT song_id FROM songs WHERE song_title = 'Rock Around the Clock' AND artist = 'Bill Haley & His Comets'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nostalgia')),
((SELECT song_id FROM songs WHERE song_title = 'Rock Around the Clock' AND artist = 'Bill Haley & His Comets'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Fun'));

-- Fun, Happiness, Nature for "Rockin' Robin"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Rockin Robin' AND artist = 'Bobby Day'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Fun')),
((SELECT song_id FROM songs WHERE song_title = 'Rockin Robin' AND artist = 'Bobby Day'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Happiness')),
((SELECT song_id FROM songs WHERE song_title = 'Rockin Robin' AND artist = 'Bobby Day'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Nature'));

-- Work for "Sixteen Tons"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Sixteen Tons' AND artist = 'Tennessee Ernie Ford'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Work'));

-- Heartache, Pain, Betrayal for "Your Cheatin' Heart"
INSERT INTO song_theme (song_id, theme_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Your Cheatin Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Heartache')),
((SELECT song_id FROM songs WHERE song_title = 'Your Cheatin Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Pain')),
((SELECT song_id FROM songs WHERE song_title = 'Your Cheatin Heart' AND artist = 'Hank Williams'),
 (SELECT theme_id FROM themes WHERE theme_name = 'Betrayal'));



INSERT INTO song_genre (song_id, genre_id) VALUES 
((SELECT song_id FROM songs WHERE song_title = 'Dont Fence Me In' AND artist = 'Gene Autry'),
    (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Dont Fence Me In' AND artist = 'Gene Autry'),
    (SELECT genre_id FROM genres WHERE genre_name = 'Western'));
	
-- Big Band for "That's Amore"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Thats Amore' AND artist = 'Dean Martin'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Big Band'));

-- Rock and Roll, Pop for "All I Have to Do Is Dream"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'All I Have to Do Is Dream' AND artist = 'The Everly Brothers'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'All I Have to Do Is Dream' AND artist = 'The Everly Brothers'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Pop'));

-- Rock and Roll, Pop for "All Shook Up"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'All Shook Up' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'All Shook Up' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Pop'));

-- Rock and Roll, Doo Wop for "At the Hop"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'At the Hop' AND artist = 'Danny & the Juniors'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'At the Hop' AND artist = 'Danny & the Juniors'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Doo-Wop'));

-- Calypso for "Day-O (The Banana Boat Song)"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Day-O (The Banana Boat Song)' AND artist = 'Harry Belafonte'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Calypso'));

-- Big Band, Swing for "Beyond the Sea"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Beyond the Sea' AND artist = 'Bobby Darin'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Big Band')),
((SELECT song_id FROM songs WHERE song_title = 'Beyond the Sea' AND artist = 'Bobby Darin'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Swing'));

-- Jazz, Standards for "Blue Skies"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Blue Skies' AND artist = 'Ella Fitzgerald'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
((SELECT song_id FROM songs WHERE song_title = 'Blue Skies' AND artist = 'Ella Fitzgerald'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Standards'));

-- Rock and Roll, Rockabilly for "Blue Suede Shoes"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Blue Suede Shoes' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'Blue Suede Shoes' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rockabilly'));

-- Rhythm and Blues, Rock and Roll for "Blueberry Hill"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Blueberry Hill' AND artist = 'Fats Domino'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rhythm and Blues')),
((SELECT song_id FROM songs WHERE song_title = 'Blueberry Hill' AND artist = 'Fats Domino'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll'));

-- Jazz, Standards for "Cheek to Cheek"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Cheek to Cheek' AND artist = 'Fred Astaire'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
((SELECT song_id FROM songs WHERE song_title = 'Cheek to Cheek' AND artist = 'Fred Astaire'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Standards'));

-- Country, Honky Tonk for "Cold, Cold Heart"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Cold, Cold Heart' AND artist = 'Hank Williams'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Cold, Cold Heart' AND artist = 'Hank Williams'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Honky Tonk'));

-- Jazz, Big Band for "Come Fly With Me"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Come Fly With Me' AND artist = 'Frank Sinatra'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
((SELECT song_id FROM songs WHERE song_title = 'Come Fly With Me' AND artist = 'Frank Sinatra'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Big Band'));

-- Jazz, Standards for "Dream a Little Dream of Me"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Dream a Little Dream of Me' AND artist = 'Ella Fitzgerald'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
((SELECT song_id FROM songs WHERE song_title = 'Dream a Little Dream of Me' AND artist = 'Ella Fitzgerald'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Standards'));

-- Doo-Wop, Rhythm and Blues for "Earth Angel"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Earth Angel' AND artist = 'The Penguins'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Doo-Wop')),
((SELECT song_id FROM songs WHERE song_title = 'Earth Angel' AND artist = 'The Penguins'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rhythm and Blues'));

-- Rock and Roll for "Everyday"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Everyday' AND artist = 'Buddy Holly'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll'));

-- Jazz, Pop for "Fever"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Fever' AND artist = 'Peggy Lee'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
((SELECT song_id FROM songs WHERE song_title = 'Fever' AND artist = 'Peggy Lee'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Pop'));

-- Country, Rockabilly for "Folsom Prison Blues"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Folsom Prison Blues' AND artist = 'Johnny Cash'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Folsom Prison Blues' AND artist = 'Johnny Cash'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rockabilly'));

-- Doo-Wop, Rhythm and Blues for "Get A Job"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Get A Job' AND artist = 'The Silhouettes'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Doo-Wop')),
((SELECT song_id FROM songs WHERE song_title = 'Get A Job' AND artist = 'The Silhouettes'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rhythm and Blues'));

-- Folk, Blues for "Goodnight Irene"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Goodnight Irene' AND artist = 'Lead Belly'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Folk')),
((SELECT song_id FROM songs WHERE song_title = 'Goodnight Irene' AND artist = 'Lead Belly'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Blues'));

-- Country, Honky Tonk for "Hey Good Lookin'"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Hey Good Lookin' AND artist = 'Hank Williams'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Hey Good Lookin' AND artist = 'Hank Williams'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Honky Tonk'));

-- Big Band for "High Hopes"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'High Hopes' AND artist = 'Frank Sinatra'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Big Band'));

-- Country, Rockabilly for "I Walk the Line"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'I Walk the Line' AND artist = 'Johnny Cash'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'I Walk the Line' AND artist = 'Johnny Cash'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rockabilly'));

-- Rock and Roll for "Jailhouse Rock"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Jailhouse Rock' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll'));

-- Rock and Roll for "Johnny B Goode"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Johnny B Goode' AND artist = 'Chuck Berry'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll'));

-- Rock and Roll, Chicano Rock for "La Bamba"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'La Bamba' AND artist = 'Ritchie Valens'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'La Bamba' AND artist = 'Ritchie Valens'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Chicano Rock'));

-- Rock and Roll, Pop for "Let Me Be Your Teddy Bear"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Let Me Be Your Teddy Bear' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'Let Me Be Your Teddy Bear' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Pop'));

-- Jazz, Standards for "Love is Here to Stay"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Love is Here to Stay' AND artist = 'Ella Fitzgerald'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
((SELECT song_id FROM songs WHERE song_title = 'Love is Here to Stay' AND artist = 'Ella Fitzgerald'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Standards'));

-- Country, Pop for "Love Me Tender"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Love Me Tender' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Love Me Tender' AND artist = 'Elvis Presley'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Pop'));

-- Rhythm and Blues, Doo-Wop for "Love Potion No. 9"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Love Potion No. 9' AND artist = 'The Clovers'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rhythm and Blues')),
((SELECT song_id FROM songs WHERE song_title = 'Love Potion No. 9' AND artist = 'The Clovers'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Doo-Wop'));

-- Rock and Roll for "Mr. Sandman"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Mr. Sandman' AND artist = 'The Chordettes'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Pop'));

-- Rock and Roll for "Peggy Sue"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Peggy Sue' AND artist = 'Buddy Holly'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll'));

-- Big Band for "Que Sera, Sera (Whatever Will Be, Will Be)"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Que Sera, Sera (Whatever Will Be, Will Be)' AND artist = 'Doris Day'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Big Band'));

-- Rock and Roll for "Rock Around the Clock"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Rock Around the Clock' AND artist = 'Bill Haley & His Comets'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll'));

-- Rock and Roll, Rhythm and Blues for "Rockin' Robin"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Rockin Robin' AND artist = 'Bobby Day'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rock and Roll')),
((SELECT song_id FROM songs WHERE song_title = 'Rockin Robin' AND artist = 'Bobby Day'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Rhythm and Blues'));

-- Country, Folk for "Sixteen Tons"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Sixteen Tons' AND artist = 'Tennessee Ernie Ford'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Sixteen Tons' AND artist = 'Tennessee Ernie Ford'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Folk'));

-- Country, Honky Tonk for "Your Cheatin Heart"
INSERT INTO song_genre (song_id, genre_id) VALUES
((SELECT song_id FROM songs WHERE song_title = 'Your Cheatin Heart' AND artist = 'Hank Williams'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
((SELECT song_id FROM songs WHERE song_title = 'Your Cheatin Heart' AND artist = 'Hank Williams'),
 (SELECT genre_id FROM genres WHERE genre_name = 'Honky Tonk'));


COMMIT;
