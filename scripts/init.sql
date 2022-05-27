DROP SCHEMA bookstore CASCADE;
CREATE SCHEMA bookstore;

CREATE TABLE IF NOT EXISTS bookstore.Customers
(
    customer_id     SERIAL      NOT NULL UNIQUE PRIMARY KEY,
    user_nm         VARCHAR(20) NOT NULL,
    user_last_n     VARCHAR(20) NOT NULL,
    user_birth_dt   DATE DEFAULT now()::date,
    mobile_phone_no VARCHAR(20) UNIQUE,
    email_no        VARCHAR(50) UNIQUE,
    card_no         VARCHAR(40) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS bookstore.Purchases
(
    purchase_id     SERIAL NOT NULL UNIQUE PRIMARY KEY,
    customer_id     SERIAL NOT NULL REFERENCES bookstore.Customers(customer_id) ON DELETE CASCADE,
    book_id         SERIAL NOT NULL,
    purchase_amount INTEGER,
    purchase_dt     DATE DEFAULT now()::date
);

CREATE TABLE IF NOT EXISTS bookstore.Genres
(
    genre_id        SERIAL NOT NULL UNIQUE PRIMARY KEY,
    genre           VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS bookstore.Authors
(
    author_id       SERIAL NOT NULL UNIQUE PRIMARY KEY,
    author          VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS bookstore.Publishers
(
    publisher_id     SERIAL NOT NULL UNIQUE PRIMARY KEY,
    publisher_name   VARCHAR(30),
    License_no       VARCHAR(10),
    Account_code     VARCHAR(10),
    Contract_no      VARCHAR(16)
);


CREATE TABLE IF NOT EXISTS bookstore.Books
(
    book_id         SERIAL NOT NULL UNIQUE PRIMARY KEY,
    author_id       SERIAL NOT NULL REFERENCES bookstore.Authors ON DELETE CASCADE,
    genre_id        SERIAL NOT NULL REFERENCES bookstore.Genres ON DELETE CASCADE,
    publisher_id    SERIAL NOT NULL REFERENCES bookstore.Publishers ON DELETE CASCADE,
    name            VARCHAR(30),
    price           INTEGER,
    amount_left     INTEGER
);

CREATE TABLE IF NOT EXISTS bookstore.Employees
(
    employee_id     SERIAL NOT NULL UNIQUE PRIMARY KEY,
    salary          INTEGER,
    vacancy         VARCHAR(30),
        CHECK (
            salary >= 0
            ),
    shifts_worked_amt INTEGER
        CHECK (
            shifts_worked_amt >= 0
            ),
    works_now_flg   BOOLEAN
);

CREATE TABLE IF NOT EXISTS bookstore.Employee_data
(
    id              SERIAL NOT NULL UNIQUE PRIMARY KEY,
    employee_id     SERIAL NOT NULL UNIQUE REFERENCES bookstore.Employees ON DELETE CASCADE,
    name            VARCHAR(30),
    surname         VARCHAR(30),
    Passport_no     VARCHAR(4)
        CHECK (
            length(Passport_no) = 4) NOT NULL,
    Passport_series VARCHAR(6)
        CHECK (
            length(Passport_series) = 6 ) NOT NULL,
    credit_card_no  TEXT,
    contract_no     TEXT
);



CREATE TABLE IF NOT EXISTS bookstore.Sales
(
    sale_id         SERIAL NOT NULL UNIQUE PRIMARY KEY,
    employee_id     SERIAL NOT NULL REFERENCES bookstore.Employees(employee_id) ON DELETE CASCADE,
    book_id         SERIAL NOT NULL,
    amount          INTEGER,
    date            DATE
);






