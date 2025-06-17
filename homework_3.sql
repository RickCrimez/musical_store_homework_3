-- Создание таблиц со связями
CREATE TABLE artist_genres (
    artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    genre_id INTEGER NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE album_artists (
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE,
    artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE compilation_tracks (
    compilation_id INTEGER NOT NULL REFERENCES compilations(id) ON DELETE CASCADE,
    track_id INTEGER NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
    PRIMARY KEY (compilation_id, track_id)
);

-- Добавление жанров в БД
INSERT INTO genres (name) VALUES
('Рок'), ('Поп'), ('Хип-хоп'), ('Электроника'), ('Джаз');

-- Добавление исполнителей в БД
INSERT INTO artists (name) VALUES
('Король и Шут'), ('Lady Gaga'), ('Eminem'), ('The Prodigy'), ('Louis Armstrong');

-- Связываем исполнителей с жанрами
INSERT INTO artist_genres (artist_id, genre_id) VALUES
(1, 1), -- Король и Шут - Рок
(2, 2), (2, 4), -- Lady Gaga - Поп и Электроника
(3, 3), -- Eminem - Хип-хоп
(4, 4), -- The Prodigy - Электроника
(5, 5); -- Louis Armstrong - Джаз

-- Добавление альбомов в БД
INSERT INTO albums (title, release_year) VALUES
('Акустический альбом', 1999),
('The Fame', 2008),
('Music to Be Murdered By', 2020),
('Invaders Must Die', 2019),
('What a Wonderful World', 1967);

-- Связываем альбомы с исполнителями
INSERT INTO album_artists (album_id, artist_id) VALUES
(1, 1), -- Король и Шут - Акустический альбом
(2, 2), -- Lady Gaga - The Fame
(3, 3), -- Eminem - Music to Be Murdered By
(4, 4), -- The Prodigy - Invaders Must Die
(5, 5); -- Louis Armstrong - What a Wonderful World

-- Добавление треков в БД
INSERT INTO tracks (title, duration, album_id) VALUES
('Лесник', 210, 1),
('Проклятый старый дом', 185, 1),
('Poker Face', 237, 2),
('Just Dance', 200, 2),
('Godzilla', 211, 3),
('Darkness', 337, 3),
('Omen', 194, 4),
('Invaders Must Die', 245, 4),
('What a Wonderful World', 141, 5),
('Hello Brother', 178, 3),
('Bad Romance', 295, 2),
('Take My Breath Away', 220, 4);

-- Добавляем сборники
INSERT INTO compilations (title, release_year) VALUES
('Лучшие рок-хиты', 2018),
('Поп-музыка 2000-х', 2019),
('Хип-хоп 2020', 2020),
('Электронная энергия', 2018),
('Золотая классика', 2021);

-- Связываем сборники с треками
INSERT INTO compilation_tracks (compilation_id, track_id) VALUES
(1, 1), (1, 2), -- Лучшие рок-хиты
(2, 3), (2, 4), (2, 11), -- Поп-музыка 2000-х
(3, 5), (3, 6), (3, 10), -- Хип-хоп 2020
(4, 7), (4, 8), (4, 12), -- Электронная энергия
(5, 9); -- Золотая классика

-- 1. Название и продолжительность самого длительного трека
SELECT title, duration 
FROM tracks 
ORDER BY duration DESC 
LIMIT 1;

-- 2. Название треков, продолжительность которых не менее 3,5 минут
SELECT title 
FROM tracks 
WHERE duration >= 210;

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title 
FROM compilations 
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова
SELECT name 
FROM artists 
WHERE name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my»
SELECT title 
FROM tracks 
WHERE LOWER(title) LIKE '%мой%' OR LOWER(title) LIKE '%my%';

-- 1. Количество исполнителей в каждом жанре
SELECT g.name, COUNT(ag.artist_id) AS artist_count
FROM genres g
LEFT JOIN artist_genres ag ON g.id = ag.genre_id
GROUP BY g.name
ORDER BY artist_count DESC;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.id) AS track_count
FROM tracks t
JOIN albums a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому
SELECT a.title, AVG(t.duration) AS avg_duration
FROM albums a
JOIN tracks t ON a.id = t.album_id
GROUP BY a.title
ORDER BY avg_duration DESC;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT DISTINCT ar.name
FROM artists ar
WHERE ar.id NOT IN (
    SELECT aa.artist_id
    FROM album_artists aa
    JOIN albums al ON aa.album_id = al.id
    WHERE al.release_year = 2020
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (например, Eminem)
SELECT DISTINCT c.title
FROM compilations c
JOIN compilation_tracks ct ON c.id = ct.compilation_id
JOIN tracks t ON ct.track_id = t.id
JOIN albums a ON t.album_id = a.id
JOIN album_artists aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE ar.name = 'Eminem';