CREATE DATABASE zomoto_pro;
USE zomoto_pro;


CREATE TABLE restaurants (
 restaurant_id INT PRIMARY KEY,
 restaurant_name VARCHAR(100),
 city VARCHAR(50),
 cuisine VARCHAR(50),
 rating DECIMAL(2,1),
 delivery_time int);
 


 CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    restaurant_id INT,
    customer_name VARCHAR(100),
    order_time TIMESTAMP,
    amount DECIMAL(10,2),

    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id)
);


INSERT INTO restaurants VALUES
(1,'Spice Hub','Delhi','Indian',4.7,30),
(2,'Pizza World','Mumbai','Italian',4.5,25),
(3,'Burger Town','Delhi','Fast Food',4.2,20),
(4,'South Express','Bangalore','South Indian',4.8,35),
(5,'Dragon House','Mumbai','Chinese',4.6,28),
(6,'Food Palace','Delhi','Indian',4.1,40);


INSERT INTO orders VALUES
(101,1,'Rahul','2025-08-01 10:15:00',450),
(102,2,'Aman','2025-08-01 11:30:00',700),
(103,1,'Priya','2025-08-01 12:10:00',300),
(104,3,'Neha','2025-08-01 19:00:00',250),
(105,4,'Rohit','2025-08-01 20:20:00',500),
(106,5,'Anjali','2025-08-01 21:00:00',650),
(107,1,'Karan','2025-08-01 20:45:00',350),
(108,2,'Simran','2025-08-01 18:30:00',800);

SELECT * FROM restaurants;

SELECT * FROM orders;


SELECT restaurant_name,
       city,
       cuisine,
       rating
FROM restaurants
ORDER BY rating DESC;


SELECT city,
       restaurant_name,
       rating
FROM restaurants
ORDER BY city, rating DESC;

SELECT cuisine,
       AVG(delivery_time) AS avg_delivery_time
FROM restaurants
GROUP BY cuisine;


SELECT restaurant_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY restaurant_id;


SELECT HOUR(order_time) AS order_hour,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY total_orders DESC;



SELECT HOUR(order_time) AS order_hour,
       COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
HAVING COUNT(*) >= 2;
SELECT restaurant_name,
       rating
FROM restaurants
WHERE rating >
(
    SELECT AVG(rating)
    FROM restaurants
);


SELECT r.restaurant_name,
       o.customer_name,
       o.amount
FROM restaurants r
JOIN orders o
ON r.restaurant_id = o.restaurant_id;


SELECT r.restaurant_name,
       SUM(o.amount) AS total_revenue
FROM restaurants r
JOIN orders o
ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC;


SELECT customer_name,
       SUM(amount) AS total_spent
FROM orders
GROUP BY customer_name
ORDER BY total_spent DESC;
SELECT restaurant_name,
       city,
       rating,

       RANK() OVER(
           PARTITION BY city
           ORDER BY rating DESC
       ) AS ranking

FROM restaurants;
SELECT restaurant_name,
       city,
       rating,

       DENSE_RANK() OVER(
           PARTITION BY city
           ORDER BY rating DESC
       ) AS dense_ranking

FROM restaurants;
 SELECT restaurant_name,
       city,
       rating,

       ROW_NUMBER() OVER(
           PARTITION BY city
           ORDER BY rating DESC
       ) AS row_num


FROM restaurants;
 SELECT *
FROM
(
    SELECT restaurant_name,
           city,
           rating,

           RANK() OVER(
               PARTITION BY city
               ORDER BY rating DESC
           ) AS ranking

    FROM restaurants
) x


WHERE ranking = 1;
 SELECT *
FROM orders
WHERE amount >
(
    SELECT AVG(amount)
    FROM orders
);


 SELECT cuisine,
       COUNT(*) AS total_restaurants
FROM restaurants
GROUP BY cuisine;


 SELECT city,
       AVG(rating) AS avg_rating
FROM restaurants
GROUP BY city;


 SELECT cuisine,
       COUNT(*) AS total
FROM restaurants
GROUP BY cuisine
ORDER BY total DESC;


SELECT restaurant_name,
       delivery_time
FROM restaurants
WHERE delivery_time < 30;
 SELECT SUM(amount) AS total_revenue
FROM orders;


SELECT restaurant_name,
       rating
FROM restaurants
ORDER BY rating DESC
LIMIT 1 OFFSET 1;

CREATE VIEW restaurant_summary AS


SELECT r.restaurant_name,
       r.city,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS revenue


FROM restaurants r
JOIN orders o
ON r.restaurant_id = o.restaurant_id

GROUP BY r.restaurant_name, r.city;


SELECT * FROM restaurant_summary;



