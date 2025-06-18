-- Заполнение таблиц тестовыми данными
-- Жанры
INSERT INTO genres (name) VALUES
('Рок'), ('Поп'), ('Хип-хоп'), ('Электроника'), ('Джаз');

-- Исполнители
INSERT INTO artists (name) VALUES
('Король и Шут'), ('Lady Gaga'), ('Eminem'), ('The Prodigy'), ('Louis Armstrong');

-- Альбомы
INSERT INTO albums (title, release_year) VALUES
('Акустический альбом', 1999),
('The Fame', 2008),
('Music to Be Murdered By', 2020),
('Invaders Must Die', 2019),
('What a Wonderful World', 1967);

-- Связи исполнителей и жанров
INSERT INTO artist_genres (artist_id, genre_id) VALUES
(1, 1), (2, 2), (2, 4), (3, 3), (4, 4), (5, 5);

-- Связи альбомов и исполнителей
INSERT INTO album_artists (album_id, artist_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Треки
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


-- Сборники
INSERT INTO compilations (title, release_year) VALUES
('Лучшие рок-хиты', 2018),
('Поп-музыка 2000-х', 2019),
('Хип-хоп 2020', 2020),
('Электронная энергия', 2018),
('Золотая классика', 2021);

-- Связи сборников и треков
INSERT INTO compilation_tracks (compilation_id, track_id) VALUES
(1, 1), (1, 2),
(2, 3), (2, 4), (2, 11),
(3, 5), (3, 6), (3, 10),
(4, 7), (4, 8), (4, 12),
(5, 9);