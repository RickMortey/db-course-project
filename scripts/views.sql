-- персональные данные работников со скрытыми паспортными данными и номером кредитки
CREATE OR REPLACE VIEW employee_personal_data AS
    SELECT employee_id, name, surname,
           coalesce(substring(passport_no, 0, 2), '') || '**' || coalesce(substring(passport_no, 4, 5), '') AS passport_no,
           coalesce(substring(passport_series, 0, 2), '') || '***' || coalesce(substring(passport_series, 5, 6), '') AS passport_series,
           coalesce(substring(credit_card_no, 0, 4), '') || ' **** ****' || coalesce(substring(credit_card_no, 12, 16), '') AS credit_card,
           Contract_no
    FROM bookstore.Employee_data;


-- персональные данные издателей со скрытыми номром лицензии и номером счета
CREATE OR REPLACE VIEW publishers_personal_data AS
    SELECT publisher_id, publisher_name,
           coalesce(substring(license_no, 0, 2), '') || '****' || coalesce(substring(license_no, length(license_no) - 2, length(license_no)), '') AS license_no,
           coalesce(substring(account_code, 0, 2), '') || '*****' || coalesce(substring(account_code, length(account_code) - 2, length(account_code)), '') AS account_code,
           contract_no
    FROM bookstore.Publishers;

-- сводная таблица с полной развернутой информацией о книгах, которые остались в магазине
-- : с именем, стоимостью, автором, жарном, издателем,
CREATE OR REPLACE VIEW books_full_info AS
    SELECT name, price, A.author AS author, G.genre AS genre, P.publisher_name AS publisher
        FROM bookstore.books
            LEFT JOIN bookstore.authors A
                ON books.author_id = A.author_id
            LEFT JOIN bookstore.Genres G
                ON books.genre_id = G.genre_id
            LEFT JOIN bookstore.Publishers P
                ON books.publisher_id = P.publisher_id
    WHERE books.amount_left > 0
    ORDER BY name;

-- сводная таблица продаж и книг, которые были проданы
CREATE OR REPLACE VIEW books_sales AS
    SELECT sales.sale_id, B.name, B.price, sales.amount, sales.date
        FROM bookstore.sales
            LEFT JOIN bookstore.Books B
                ON sales.book_id = B.book_id
        ORDER BY sale_id;

-- сводная таблица работников и их продаж
CREATE OR REPLACE VIEW employees_sales AS
    SELECT employees.employee_id, vacancy, D.name, D.surname, s.sale_id, B.name AS title, amount, date
        FROM bookstore.employees
            RIGHT JOIN bookstore.sales s
                ON employees.employee_id = s.employee_id
            LEFT JOIN bookstore.employee_data D
                ON employees.employee_id = D.employee_id
            LEFT JOIN bookstore.books B
                        ON s.book_id = B.book_id
        ORDER BY (D.name, D.surname);

-- издатели, у которых скоро нужно будет заказывать новые книжки
CREATE OR REPLACE VIEW actual_providers AS
    SELECT P.publisher_name, B.name, B.price, B.amount_left
        FROM bookstore.Books B
            LEFT JOIN bookstore.Publishers P
                ON B.publisher_id = P.publisher_id
        WHERE B.amount_left  < 10
        ORDER BY (publisher_name);

