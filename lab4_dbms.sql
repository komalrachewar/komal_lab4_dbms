CREATE DATABASE e_commerce_db;

CREATE TABLE supplier(
    supp_id INT NOT NULL AUTO_INCREMENT,
    supp_name varchar(50) NOT NULL,
    supp_city varchar(50) NOT NULL,
    supp_phone varchar(50) NOT NULL,
    PRIMARY KEY (supp_id)
);

CREATE TABLE customer(
    cus_id INT NOT NULL AUTO_INCREMENT,
    cus_name varchar(20) NOT NULL,
    cus_phone varchar(10) NOT NULL,
    cus_city varchar(30) NOT NULL,
    cus_gender char,
    PRIMARY KEY (cus_id)
);

CREATE TABLE category(
    cat_id INT NOT NULL AUTO_INCREMENT,
    cat_name varchar(20) NOT NULL,
    PRIMARY KEY (cat_id)
);

CREATE TABLE product(
    pro_id INT NOT NULL AUTO_INCREMENT,
    pro_name varchar(20) NOT NULL DEFAULT "Dummy",
    pro_desc varchar(60),
    cat_id INT,
    PRIMARY KEY (pro_id),
    FOREIGN KEY (cat_id) REFERENCES category(cat_id)
);

CREATE TABLE supplier_pricing(
    pricing_id INT NOT NULL AUTO_INCREMENT,
    pro_id INT,
    supp_id INT,
    supp_price INT DEFAULT 0,
    PRIMARY KEY (pricing_id),
    FOREIGN KEY (pro_id) REFERENCES product(pro_id),
    FOREIGN KEY (supp_id) REFERENCES supplier(supp_id)
);

CREATE TABLE `order`(
    ord_id INT NOT NULL AUTO_INCREMENT,
    ord_ammount INT NOT NULL,
    ord_date DATE NOT NULL,
    cus_id INT,
    pricing_id INT,
    PRIMARY KEY (ord_id),
    FOREIGN KEY (cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY (pricing_id) REFERENCES supplier_pricing(pricing_id)
);

CREATE TABLE rating(
    rat_id INT NOT NULL AUTO_INCREMENT,
    ord_id INT,
    rat_ratStars INT NOT NULL,
    PRIMARY KEY (rat_id),
    FOREIGN KEY (ord_id) REFERENCES `order`(ord_id)
);

INSERT IGNORE INTO `supplier`(supp_name, supp_city, supp_phone)
VALUES
('Rajesh Retails', 'Delhi', '1234567890'),
('Appario Ltd.', 'Mumbai', '2589631470'),
('Knome products', 'Banglore', '9785462315'),
('Bansal Retails', 'Kochi', '8975463285'),
('Mittal Ltd.', 'Lucknow', '7898456532');

INSERT IGNORE INTO `customer`(cus_name, cus_phone, cus_city, cus_gender)
VALUES
('AAKASH', '9999999999', 'DELHI', 'M'),
('AMAN', '9785463215', 'NOIDA', 'M'),
('NEHA', '9999999999', 'MUMBAI', 'F'),
('MEGHA', '9994562399', 'KOLKATA', 'F'),
('PULKIT', '7895999999', 'LUCKNOW', 'M');


INSERT IGNORE INTO `category`(cat_name)
VALUES
('BOOKS'),
('GAMES'),
('GROCERIES'),
('ELECTRONICS'),
('CLOTHES');

INSERT IGNORE INTO `product`(pro_name, pro_desc, cat_id)
VALUES
('GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
('TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
('ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
('OATS', 'Highly Nutritious from Nestle', 3),
('HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
('MILK', '1L Toned MIlk', 3),
('Boat Earphones', '1.5Meter long Dolby Atmos', 4),
('Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
('Project IGI', 'compatible with windows 7 and above', 2),
('Hoodie', 'Black GUCCI for 13 yrs and above', 5),
('Rich Dad Poor Dad', 'Written by RObert Kiyosaki', 1),
('Train Your Brain', 'By Shireen Stephen', 1);

INSERT IGNORE INTO `supplier_pricing`(pro_id, supp_id, supp_price)
VALUES
(1, 2, 1500),
(3, 5, 30000),
(5, 1, 3000),
(2, 3, 2500),
(4, 1, 1000),
(12, 2, 780),
(12, 4, 789),
(3, 1, 31000),
(1, 5, 1450),
(4, 2, 999),
(7, 3, 549),
(7, 4, 529),
(6, 2, 105),
(6, 1, 99),
(2, 5, 2999),
(5, 2, 2999);

INSERT IGNORE INTO `order`(ord_ammount, ord_date, cus_id, pricing_id)
VALUES
(1500, '2021-10-06', 2, 1),
(1000, '2021-10-12', 3, 5),
(30000, '2021-09-16', 5, 2),
(1500, '2021-10-05', 1, 1),
(3000, '2021-08-16', 4, 3),
(1450, '2021-08-18', 1, 9),
(789, '2021-09-01', 3, 7),
(780, '2021-09-07', 5, 6),
(3000, '2021-00-10', 5, 3),
(2500, '2021-00-10', 2, 4),
(1000, '2021-09-15', 4, 5),
(789, '2021-09-16', 4, 7),
(31000, '2021-09-16', 1, 8),
(1000, '2021-09-16', 3, 5),
(3000, '2021-09-16', 5, 3),
(99, '2021-09-17', 2, 14);

INSERT IGNORE INTO `rating`(ord_id, rat_ratStars)
VALUES
(1, 4),
(2, 3),
(3, 1),
(4, 2),
(5, 4),
(6, 3),
(7, 4),
(8, 4),
(9, 3),
(10, 5),
(11, 3),
(12, 4),
(13, 2),
(14, 1),
(15, 1),
(16, 0);

select count(`customer`.cus_id) as cusNumber, `customer`.cus_gender from `customer` join `order` on `order`.cus_id = `customer`.cus_id where `order`.ord_ammount = 3000 group by `customer`.cus_id, `customer`.cus_gender;

select `order`.*, pro.pro_name from `order` 
join `supplier_pricing` sp on sp.pricing_id = `order`.pricing_id 
join `product` pro on pro.pro_id = sp.pro_id
where `order`.cus_id = 2  
order by `order`.cus_id;

SELECT supplier.*, sup.supp_id
FROM supplier
JOIN supplier_pricing sup ON sup.supp_id = supplier.supp_id
GROUP BY sup.supp_id
HAVING COUNT(sup.pro_id) > 1;

select min(sup.supp_price) as suppp, `product`.cat_id, `category`.cat_name from `product` 
join supplier_pricing sup on sup.pro_id = `product`.pro_id
join `category` on `category`.cat_id = `product`.cat_id
group by `product`.cat_id, `category`.cat_name;

select `product`.pro_id, `product`.pro_name from `product` 
join `supplier_pricing` sup on sup.pro_id = `product`.pro_id
join `order` on `order`.pricing_id = sup.pricing_id
where `order`.ord_date > '2021-10-05';

select cus_name, cus_gender from customer where cus_name LIKE "%A" OR cus_name LIKE "A%";

CREATE DEFINER=`root`@`localhost` PROCEDURE `getratingData`()
BEGIN
    SELECT `supplier`.supp_id, `supplier`.supp_name, AVG(`rating`.rat_ratStars) as avgrating,
    CASE
        WHEN AVG(`rating`.rat_ratStars) = 5 THEN 'Excellent'
        WHEN AVG(`rating`.rat_ratStars) > 4 THEN 'Good Service'
        WHEN AVG(`rating`.rat_ratStars) > 2 THEN 'Average'
        ELSE 'Poor Service'
    END AS type_of_Service
    FROM `rating`
    JOIN `order` ON `order`.ord_id = `rating`.ord_id
    JOIN `supplier_pricing` sup ON sup.pricing_id = `order`.pricing_id
    JOIN `supplier` ON `supplier`.supp_id = sup.supp_id
    GROUP BY `supplier`.supp_id, `supplier`.supp_name;
END
CALL getratingData();



