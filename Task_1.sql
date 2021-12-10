use Publishing;

-- 1.Создайте кластеризованный индекс по имени автора для таблицы Authors.
create index FName on author(FirstName);

-- 2.Создайте кластеризованный составной индекс, содержащий цену и название каждой книги.
create index priceName on book(NameBook, PriceOfBook); 

-- 3.Создайте представление, в котором выберите из таблицы продажи все книг, стоимостью больше 55 грн. 
create view sales55 
As select book_id, Quantity, Price from sales where Price > 55;
drop view if exists sales55;

-- 4.Для таблицы «Авторы» отключить кластеризированный индекс. Проверить возможность выбора данных из таблицы. Подключить обратно индекс.
Drop INDEX FName ON author;
select * from author;
create index FName on author(FirstName);

-- 5.Написать представление, которое будет отображать информацию о книгах, которые имели тираж более 10 экземпляров.
create view Books
as select * from book where DrawingOfBook > 10;
select * from books;
drop view if exists Books;

-- 6. Написать представление, которое содержит информацию о суммах, на которые были проданы книги каждым магазином за последний месяц.
create view SalesShop
as Select NameShop, sum(sales.price*sales.quantity) as Sales from shop
join sales on sales.shop_id = shop.id
group by nameShop;
select * from SalesShop;
drop view if exists SalesShop;

-- 7. Показать на экран среднее количество страниц по каждой из тематик, при этом показать только тематики, в которых среднее количество более 400.
create view AvgPages
as select NameTheme, avg(pages) as Average from book
join themes on themes.id = book.theme_id
group by NameTheme
having Average > 400;
select * from AvgPages;
drop view if exists AvgPages;