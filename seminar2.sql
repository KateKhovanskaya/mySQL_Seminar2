-- Задача 1. Создать сущность с подборкой фильмов (movies). 
-- В таблице имеются следующие атрибуты:
-- id -- уникальный идентификатор фильма,
-- title -- название фильма
-- title_eng -- название фильма на английском языке
-- year_movie  --  год выхода
-- count_min -- длительность фильма в минутах
-- storyline -- сюжетная линия, небольшое описание фильма
-- Все поля (кроме title_eng, count_min и storyline) обязательны для заполнения. 
-- Поле id : первичный ключ, который заполняется автоматически.

CREATE TABLE movies(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title VARCHAR(100) NOT NULL,
title_eng VARCHAR(100),
year_movie INT NOT NULL,
count_min INT,
storyline TEXT
);

INSEmoviesRT INTO movies (title, title_eng, year_movie, count_min, storyline)
VALUES("Форест Гамп", "Forest Gump", 1995, 130, "Сюжетная линия 1"),
("Игры разума", "A Beautiful Mind", 2001, 135, "От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. "),
("Игра престолов", "Game of Thrones", 2011, 300, "К концу подходит время благоденствия, и лето, длившееся почти десятилетие, угасает."),
("Назад в будущее", "Back to the Future", 1985, 116, "Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном"),
("Переподсик", "The Covenant", 2022, 123, "Афганистан, март 2018 года. Во время спецоперации по поиску оружия талибов отряд сержанта армии США ");

-- Переименовать сущность movies в cinema.
-- Добавить сущности cinema новый атрибут status_active (тип BIT) и атрибут genre_id после атрибута title_eng.
-- Удалить атрибут status_active сущности cinema. 
-- Удалить сущность actors из базы данных
-- Добавить внешний ключ на атрибут genre_id сущности cinema и направить его на атрибут id сущности genres.
-- Очистить сущность genres от данных и обнулить автоинкрементное  поле.

RENAME TABLE movies TO cinema;

ALTER TABLE cinema
ADD COLUMN status_active BIT,
ADD COLUMN genre_id INT unsigned after title_eng;

ALTER TABLE cinema
DROP COLUMN status_active;

CREATE TABLE actors(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
title VARCHAR(100) NOT NULL,
title_eng VARCHAR(100),
year_movie INT NOT NULL,
count_min INT,
storyline TEXT
);

DROP TABLE actors;

CREATE TABLE genres(
id INT auto_increment primary key,
name varchar(50) not null
);

ALTER TABLE cinema
ADD foreign key(genre_id) references genres(id);

-- Очистить таблицу
TRUNCATE TABLE generes;

SELECT id, title,
CASE
WHEN year_movie < 1990 THEN "80-e"
WHEN year_movie between 1990 and 1999 THEN "90-e"
WHEN year_movie between 2000 and 2009 THEN "2000-e"
ELSE "others"
END AS Category
FROM cinema;

SELECT id, title, count_min,
IF (count_min<50, "Короткометражный", 
	IF (count_min between 50 and 100, "Среднеметражный",
		IF(count_min>100, "Полнометражный", "Не определено"))) AS type_film
FROM cinema;
