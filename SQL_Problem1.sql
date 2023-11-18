create database supplyDemand;
use supplyDemand;

create table supplier (
supp_id int primary key, 
supp_name varchar(50) not null, 
supp_city varchar(50) not null,
supp_phone varchar(50) not null);
/*inserting values into supplier*/
INSERT INTO supplier (supp_id, supp_name, supp_city, supp_phone)
VALUES
    (1, 'Rajesh Retails', 'Delhi', '1234567890'),
    (2, 'Appario Ltd.', 'Mumbai', '2589631470'),
    (3, 'Knome products', 'Bangalore', '9785462315'),
    (4, 'Bansal Retails', 'Kochi', '8975463285'),
    (5, 'Mittal Ltd.', 'Lucknow', '7898456532');

create table customer(
cus_id int primary key, 
cus_name varchar(20) not null,
cus_city varchar(30) not null,
cus_phone varchar(10) not null,
cus_gender char(30)
);
/*inserting values into customer*/
INSERT INTO customer (cus_id, cus_name, cus_phone, cus_city, cus_gender)
VALUES
    (1, 'AAKASH', '9999999999', 'DELHI', 'M'),
    (2, 'AMAN', '9785463215', 'NOIDA', 'M'),
    (3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
    (4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
    (5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');
select * from customer;

create table category(cat_id int primary key, cat_name varchar(20) not null);
/* inserting values in category*/
INSERT INTO category (cat_id, cat_name)
VALUES
    (1, 'BOOKS'),
    (2, 'GAMES'),
    (3, 'GROCERIES'),
    (4, 'ELECTRONICS'),
    (5, 'CLOTHES');
select * from category;

CREATE TABLE product (
    pro_id int primary key,
    pro_name varchar(20) not null,
    pro_desc varchar(60),
    cat_id int,
    FOREIGN KEY (cat_id) REFERENCES category(cat_id)
);
 /*inserting values in product*/
 INSERT INTO product (pro_id, pro_name, pro_desc, cat_id)
VALUES
    (1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
    (2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
    (3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
    (4, 'OATS', 'Highly Nutritious from Nestle', 3),
    (5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
    (6, 'MILK', '1L Toned MIlk', 3),
    (7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
    (8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
    (9, 'Project IGI', 'compatible with windows 7 and above', 2),
    (10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
    (11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki', 1),
    (12, 'Train Your Brain', 'By Shireen Stephen', 1);
select * from product;

create table supplier_pricing(
pricing_id int primary key,
pro_id int,
supp_id int,
   supp_price INT DEFAULT 0,
    FOREIGN KEY (pro_id) REFERENCES product(pro_id),
    FOREIGN KEY (supp_id) REFERENCES supplier(Supp_id)  
);
/*inserting values in supplier_pricing*/
INSERT INTO supplier_pricing (pricing_id, pro_id, supp_id, supp_price)
VALUES
    (1, 1, 2, 1500),
    (2, 3, 5, 30000),
    (3, 5, 1, 3000),
    (4, 2, 3, 2500),
    (5, 4, 1, 1000);
    
create table orders (
    ord_id int primary key,
    ord_date date not null,
    ord_amount int default 0,
    cus_id int,
    pricing_id int,
    foreign key (cus_id) references customer(cus_id),
    foreign key (pricing_id) references supplier_pricing(pricing_id)
);
select * from orders;
/*inserting values in orders*/
INSERT INTO orders (ord_id, ord_amount, ord_date, cus_id, pricing_id)
VALUES
    (101, 0,'2021-10-06', 2, 1),
    (102, 0,'2021-10-12', 3, 5),
    (103, 0,'2021-09-16', 5, 2),
    (104, 0,'2021-10-05', 1, 1),
    (105, 0,'2021-08-16', 4, 3),
    (106,0,'2021-08-18', 1, 4),
    (107,0, '2021-09-01', 3, 5),
    (108, 0,'2021-09-07', 5, 5),
    (109,0, '2021-10-10', 5, 3),
    (110,0, '2021-09-10', 2, 4),
    (111,0,'2021-09-15', 4, 5),
    (112,0, '2021-09-16', 4, 4),
    (113,0, '2021-09-16', 1, 3),
    (114,0, '2021-09-16', 3, 5),
    (115,0,'2021-09-16', 5, 3),
    (116,0,'2021-09-17', 2, 1);

create table ratings(
rating_id int primary key,
ord_id int,
rat_ratstarts int,
foreign key (ord_id) references orders(ord_id)
);
/*inserting values in ratings*/
insert into ratings (rating_ID, ord_id,rat_ratstarts)
VALUES
    (1, 101, 4),
    (2, 102, 3),
    (3, 103, 1),
    (4, 104, 2),
    (5, 105, 4),
    (6, 106, 3),
    (7, 107, 4),
    (8, 108, 4),
    (9, 109, 3),
    (10, 110, 5),
    (11, 111, 3),
    (12, 112, 4);
  
 --- Q.N.3)
SELECT
    c.cus_gender,
    COUNT(DISTINCT c.cus_id) AS total_customers
FROM
    customer c
JOIN
    orders o ON c.cus_id = o.cus_id
WHERE
    o.ord_amount >= 3000
GROUP BY
    c.cus_gender;
   
 --- Q.N.4) 
SELECT o.ord_id, p.pro_name
FROM orders o
JOIN customer c ON o.cus_id = c.cus_id
JOIN supplier_pricing sp ON o.pricing_id = sp.pricing_id
JOIN product p ON sp.pro_id = p.pro_id
WHERE c.cus_id = 2;

  
 --- Q.N.5)  
    SELECT s.*
FROM supplier s
JOIN supplier_pricing sp ON s.supp_id = sp.supp_id
GROUP BY s.supp_id
HAVING COUNT(DISTINCT sp.pro_id) > 1;

--- Q.N.6)
SELECT c.cat_id, c.cat_name, p.pro_name, sp.supp_price
FROM category c
JOIN product p ON c.cat_id = p.cat_id
JOIN supplier_pricing sp ON p.pro_id = sp.pro_id
WHERE sp.supp_price = (
    SELECT MIN(supp_price)
    FROM supplier_pricing
    WHERE pro_id = p.pro_id
)
ORDER BY c.cat_id;


---  Q.N.7)
SELECT p.pro_id, p.pro_name
FROM product p
JOIN supplier_pricing sp ON p.pro_id = sp.pro_id
JOIN orders o ON sp.pricing_id = o.pricing_id
WHERE o.ord_date > '2021-10-05';

--- Q.N.8)
select cus_name, cus_gender 
from customer
where cus_name LIKE ('A%') and cus_name LIKE ('%A');

--- Q.N.9)
SELECT
    s.supp_id,
    s.supp_name,
    r.rat_ratstarts,
    CASE
        WHEN r.rat_ratstarts = 5 THEN 'Excellent Service'
        WHEN r.rat_ratstarts > 4 THEN 'Good Service'
        WHEN r.rat_ratstarts > 2 THEN 'Average Service'
        ELSE 'Poor Service'
    END AS Type_of_Service
FROM supplier s
JOIN supplier_pricing sp ON s.supp_id = sp.supp_id
JOIN product p ON sp.pro_id = p.pro_id
JOIN orders o ON sp.pricing_id = o.pricing_id
LEFT JOIN ratings r ON o.ord_id = r.ord_id;




