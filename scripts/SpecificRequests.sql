/* GROUP BY + HAVING
Хочу получить клиентов, которые купили больше 3 книг за все время. */
SELECT customer_id, sum(purchase_amount)
FROM bookstore.Purchases
GROUP BY customer_id
HAVING SUM(purchase_amount) > 3;

/* ORDER BY
Хочу получить продажи для каждого продавца по дате продажи
Может быть полезно чтобы оценить эффективность данного продавца
 */
SELECT employee_id, sale_id, amount
FROM bookstore.Sales
GROUP BY employee_id, sale_id, date
ORDER BY employee_id, sale_id DESC;

/* OVER + PARTITION BY
Вывожу названия книг, цену, а также среднюю цену по их автору.
Может быть полезно чтобы оценить, какая книга стоит слишком дорого или слишком мало для того или иного автора
*/
SELECT book_id,
       author,
       name,
       price,
       ROUND(AVG(price) OVER (PARTITION BY bookstore.books.author_id)) AS avg_price
FROM bookstore.books
         JOIN bookstore.authors ON bookstore.books.author_id = bookstore.Authors.author_id
ORDER BY bookstore.books.author_id;

/* OVER + ORDER BY
Вывожу, на каком месте в базе данных клиент
Может быть полезно в случае мы хотим понять, удалялись ли пользователи из базы данных или нет
*/
SELECT customer_id, ROW_NUMBER() OVER (ORDER BY customer_id)
FROM bookstore.customers;

/*
 Вывожу зарплату работников, а также их средннюю зп при разбиении на количество отработанных смен
*/
SELECT bookstore.employees.employee_id, name, surname, shifts_worked_amt, salary, AVG(salary) OVER (PARTITION BY shifts_worked_amt ORDER BY salary)
FROM bookstore.Employees JOIN bookstore.employee_data ON employees.employee_id = employee_data.employee_id;

/* 3 вида функций
    Показывает клиента,
    среднее количество купленных им книг,
    какой по счёту идёт дата покупки,
    самую низкую цену по жанру книги
*/
SELECT customer_id,
       genre_id,
       AVG(purchase_amount) OVER (PARTITION BY customer_id)                as bought_books_mean,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY purchase_dt)   as datetime_no,
       FIRST_VALUE(price) OVER (PARTITION BY genre_id ORDER BY price)      as min_price
FROM bookstore.purchases
         JOIN bookstore.books ON bookstore.Purchases.book_id = bookstore.Books.book_id;