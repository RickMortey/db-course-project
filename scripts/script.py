import psycopg2

try:
	conn = psycopg2.connect(
	   database="postgres",
	   user='mipt',
	   password='mipt',
	   host='localhost',
	   port= '5050'
	)
	print("Connection OK")
except:
	print("Connection failed")

conn.autocommit = True
cursor = conn.cursor()

cursor.execute('''
INSERT INTO bookstore.Customers(user_nm, user_last_n, user_birth_dt, mobile_phone_no, card_no, email_no)
VALUES  ('Андрей', 'Филин', '2002-11-10', '78005553535', '4556686386618595', 'andruha_krutoy@ya.ru'),
		('Андрей', 'Лукин', '2002-04-28', '79538245974', '4916029690550706','samiy_krutoy_andruha@yandex.ru'),
		('Ксения', 'Куринова', '1990-03-25', '79191189929', '4408114808062680' ,'kurlik@gmail.com'),
		('Марина', 'Чарная', '2003-03-08', '79535550419', '4916410551210152','i_love_beer@yandex.ru'),
		('Арман', 'Бркисян', '2022-02-04', '79211234567', '4556766356928206','ad.enjoyer@outlook.com'),
		('Дмитрий', 'Прохоров', '1974-08-03', '79007654321', '4485991438330603','ad.enjoyer2@gmail.com'),
		('Михаил', 'Бохонко', '1990-11-07', '79284206920', '4556812005316441','i-love-chillin@outlook.com'),
		('Олеся', 'Зайченко', '2005-11-23', '79352284200', '4532433727781231','reject-humanity@mail.ru'),
		('Юрий', 'Хованский', '1912-09-04', '79419411945', '5257190538302219', 'good_beer_enjoyer@outlook.com')
''')

print("Data inserted successfully")
print("All data from Customers")

cursor.execute('''SELECT * FROM bookstore.Customers;''')

fetch = cursor.fetchall()
print(fetch)

conn.commit()
cursor.close()
conn.close()

print("Connection closed")