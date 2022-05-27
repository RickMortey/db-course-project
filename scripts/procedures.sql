CREATE OR REPLACE PROCEDURE InsertCustomer (
    name         VARCHAR(20),
    surname      VARCHAR(20),
    birth_date   DATE,
    mobile_phone VARCHAR(20),
    email        VARCHAR(50),
    card_number  VARCHAR(40)
) LANGUAGE plpgsql AS
$$
BEGIN
    INSERT INTO bookstore.Customers(user_nm, user_last_n, user_birth_dt, mobile_phone_no, email_no, card_no) VALUES
    (name, surname, birth_date, mobile_phone, email, card_number) RETURNING customer_id;
end
$$;

CREATE OR REPLACE PROCEDURE UpdateCustomer (
    id           INTEGER,
    name         VARCHAR(20),
    surname      VARCHAR(20),
    birth_date   DATE,
    mobile_phone VARCHAR(20),
    email        VARCHAR(50),
    card_number  VARCHAR(40)
) LANGUAGE plpgsql AS
$$
BEGIN
    UPDATE bookstore.Customers SET
    user_nm = name,
    user_last_n = surname,
    user_birth_dt = birth_date,
    mobile_phone_no = mobile_phone,
    email_no = email,
    card_no = card_number
    WHERE customer_id = id;
end;
$$;