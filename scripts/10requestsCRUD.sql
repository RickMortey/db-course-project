--- 1 Обновляем цену на книгу
UPDATE bookstore.Books
SET price = Books.price * 2
WHERE book_id = 10;

--- 2 Добавляем книгу, её описание и количество
INSERT INTO bookstore.Books(author_id, genre_id, publisher_id, name, price, amount_left)
VALUES (3, 5, 8, 'Бойцовский Клуб', 75, 30);

--- 3 Удаляем пользователя
DELETE
FROM bookstore.Customers
WHERE customer_id = 10;

--- 4 Добавляем пользователя
INSERT INTO bookstore.customers(user_nm, user_last_n, user_birth_dt, mobile_phone_no, email_no)
VALUES ('Тимур', 'Утцаль', '2002-10-14', '89535098245', 'uttsal.ts@phystech.edu');

--- 5 Добавляем покупку книги клиентом
INSERT INTO bookstore.Purchases(customer_id, book_id, purchase_amount, purchase_dt)
VALUES (9, 2, 3, '2022-05-06');

--- 6 Выбираем всех работников на позиции менеджера и зарплатой больше 25000
SELECT salary, vacancy
FROM bookstore.Employees
WHERE salary > 25000 AND vacancy = 'Manager';

--- 7 Меняем номер телефона клиента
UPDATE bookstore.Customers
SET mobile_phone_no = '79198889955'
WHERE customer_id = (SELECT customer_id
                 FROM bookstore.Customers
                 WHERE mobile_phone_no = '89535098245');

--- 8 Получаем название жанра по его id
SELECT genre_id
FROM bookstore.genres
WHERE genre_id = 1;

--- 9 Найдём все названия книг, где встречается слово "клуб"
SELECT name
FROM bookstore.books
WHERE POSITION('Клуб' IN name) > 0;

--- 10 Добавим продажу менеджеру
INSERT INTO bookstore.Sales(employee_id, book_id, amount, date)
VALUES (1, 2, 3, '2022-05-06');


--- CRUD запросы - это Create(в SQL INSERT), Read (в SQL SELECT), Update, Delete запросы. Все эти запросы есть в SQL