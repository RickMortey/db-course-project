/*
 Индекс по выражению lower(name) (name - атрибут отношения books)
 Это позволит эффективно искать книги по названию, не задумываясь о регистре
 Пример: в 10requestsCRUD.sql в 9 запросе я искал книги, где есть слово "Клуб".
 Однако оно могло быть написано в нижнем регистре и тогда мне поиск ничего не дал бы.
 Эта проблема решается данным индексом.
 */
CREATE INDEX IF NOT EXISTS searchByName ON bookstore.Books(lower(name));

/*
 Индекс по выражению с сортировкой имён клиентов в алфавитном порядке.
 Это позволит эффективнее искать клиентов по фамилии и имени
 */
CREATE INDEX IF NOT EXISTS sortByCustomers ON bookstore.Customers(user_nm, user_last_n DESC);

/*
Индекс по выражению с сортировкой имён работников в алфавитном порядке.
Это позволит эффективнее искать работников по фамилии и имени
 */
CREATE INDEX IF NOT EXISTS sortByEmployees ON bookstore.Employee_data(name, surname DESC);
