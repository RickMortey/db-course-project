--Customers

DO
$do$
    BEGIN
        FOR i IN 1..25
            LOOP
                INSERT INTO bookstore.Customers (user_nm, user_last_n, user_birth_dt, mobile_phone_no, email_no, card_no)
                VALUES ('Иван',
                        'Иванов',
                        '2001-09-28',
                        800080 + i,
                        concat(i, 'test@mail.ru'),
                        987000 + i)
                ON CONFLICT DO NOTHING;
            END LOOP;
    END
$do$;


--Genres
INSERT INTO bookstore.Genres(genre_id, genre)
VALUES (1, 'Фантастика'),
       (2, 'Детектив'),
       (3, 'Приключения'),
       (4, 'Роман'),
       (5, 'Научная литература'),
       (6, 'Фольклор'),
       (7, 'Юмор'),
       (8, 'Справочник'),
       (9, 'Беллектристика'),
       (10, 'Самоучитель');

--Authors
INSERT INTO bookstore.Authors(author_id, author)
VALUES (1, 'Лев Толстой'),
       (2, 'Федор Достоевский'),
       (3, 'Антон Чехов'),
       (4, 'Владимир Набоков'),
       (5, 'Александр Пушкин'),
       (6, 'Эрнест Хемингуэй'),
       (7, 'Николай Гоголь'),
       (8, 'Джоан Роулинг'),
       (9, 'Михаил Булгаков'),
       (10, 'Айн Рэнд');

--Publishers
DO
$do$
    BEGIN
        FOR i IN 1..25
            LOOP
                INSERT INTO bookstore.Publishers(publisher_id, publisher_name, license_no, account_code, contract_no)
                VALUES (i,
                        concat('Издатель ', i),
                        CAST(100500 + i as varchar(30)),
                        CAST(420228 + i AS VARCHAR(30)),
                        CAST(800080 + i AS VARCHAR(30)))
                ON CONFLICT DO NOTHING;
            END LOOP;
    END
$do$;

--Books
DO
$do$
    BEGIN
        FOR i IN 1..50
            LOOP
                INSERT INTO bookstore.Books(author_id, genre_id, publisher_id, name, price, amount_left)
                VALUES (
                        floor(random() * (10 - 1)) + 1,
                        floor(random() * (10 - 1)) + 1,
                        floor(random() * (25 - 1)) + 1,
                        concat('Удивительная книга № ', i),
                        floor(random() * 100),
                        floor(random() * 100));
            END LOOP;
    END
$do$;

--Employees
INSERT INTO bookstore.Employees VALUES (1, 50000.0, 'Manager', 100, true);
INSERT INTO bookstore.Employees VALUES (2, 50000.0, 'Manager', 50, true);
INSERT INTO bookstore.Employees VALUES (3, 30000.0, 'Cashier', 40, true);
INSERT INTO bookstore.Employees VALUES (4, 30000.0, 'Cashier', 30, true);
INSERT INTO bookstore.Employees VALUES (5, 30000.0, 'Cashier', 40, true);
INSERT INTO bookstore.Employees VALUES (6, 0, 'Cashier', 10, false);
INSERT INTO bookstore.Employees VALUES (7, 15000.0, 'Cleaner', 20, true);
INSERT INTO bookstore.Employees VALUES (8, 0, 'Cleaner', 0, false);

--Employees Data
DO
$do$
    BEGIN
        FOR i IN 1..8
            LOOP
                INSERT INTO bookstore.employee_data(employee_id, name, surname, passport_no, passport_series, credit_card_no, contract_no)
                VALUES (i,
                        'Алексей',
                        'Смирнов',
                        '1916',
                        CAST(420228 + i AS VARCHAR(6)),
                        CAST(5555555555554444 + 15*i AS TEXT),
                        CAST(2281337420 + i AS TEXT));
            END LOOP;
    END
$do$;

--Purchases

DO
$do$
    BEGIN
        FOR i IN 1..50
            LOOP
                INSERT INTO bookstore.Purchases(customer_id, book_id, purchase_amount, purchase_dt)
                VALUES (
                        floor(random() * (25 - 1)) + 1,
                        floor(random() * (25 - 1)) + 1,
                        floor(random() * (5 - 1)) + 1,
                        '2022-05-09');
            END LOOP;
    END
$do$;

--Sales
DO
$do$
    BEGIN
        FOR i IN 1..50
            LOOP
                INSERT INTO bookstore.Sales(employee_id, book_id, amount, date)
                VALUES (
                        floor(random() * (6 - 1)) + 1,
                        floor(random() * (25 - 1)) + 1,
                        floor(random() * (5 - 1)) + 1,
                        '2022-05-09');
            END LOOP;
    END
$do$;

SELECT * FROM bookstore.Sales;
