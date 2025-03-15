CREATE database SWIGGY;
USE SWIGGY;
CREATE TABLE users(
user_id INT PRIMARY KEY,
user_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE KEY NOT NULL,
phone VARCHAR(15) UNIQUE NOT NULL,
address TEXT,
created_at DATETIME NOT NULL
);
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2 , 1 ),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE menus (
    menu_id INT PRIMARY KEY,
    restaurant_id INT,
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants (restaurant_id),
    dish_name VARCHAR(100) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE orders (
order_id INT PRIMARY KEY,
order_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
total_amount DECIMAL(10,2) NOT NULL,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
delivery_date DATETIME,
user_id INT,
restaurant_id INT,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);
CREATE TABLE order_items (
order_item_id INT PRIMARY KEY,
order_id INT ,
FOREIGN KEY (order_id) REFERENCES orders (order_id),
menu_id INT,
FOREIGN KEY (menu_id) REFERENCES menus(menu_id),
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL
);
CREATE TABLE payments(
payment_id INT PRIMARY KEY,
order_id INT,
FOREIGN  KEY (order_id) REFERENCES orders(order_id),
payment_type VARCHAR(50) NOT NULL,
amount DECIMAL(10,2) NOT NULL,
payment_status VARCHAR(50) NOT NULL,
payment_date DATETIME DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE delivery_person(
delivery_personid INT PRIMARY KEY,
persons_name VARCHAR(50) NOT NULL,
contact_no VARCHAR(15) UNIQUE NOT NULL,
order_id INT,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
restaurant_id INT,
FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
user_id INT,
FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE feedback(
feedback_id INT PRIMARY KEY,
feedback_type VARCHAR(50) NOT NULL,
user_id INT,
FOREIGN KEY (user_id) REFERENCES users(user_id),
comments TEXT,
response TEXT
);
INSERT INTO users (user_id, user_name, email, phone, address, created_at) VALUES
(1, 'Aarav Sharma', 'aarav.sharma@gmail.com', '9876543210', '123 MG Road, Bengaluru, Karnataka', '2024-01-01 10:30:00'),
(2, 'Vivaan Gupta', 'vivaan.gupta@icloud.com', '9876543211', '456 Brigade Rd, Bengaluru, Karnataka', '2023-01-02 11:40:00'),
(3, 'Aditya Iyer', 'aditya.iyer@yahoo.com', '9876543212', '789 Church St, Mumbai, Maharashtra', '2023-07-06 12:10:00'),
(4, 'Anaya Patel', 'anaya.patel@yahoo.com', '9876543213', '321 Linking Rd, Mumbai, Maharashtra', '2022-07-04 13:20:00'),
(5, 'Sai Kumar', 'sai.kumar@gmail.com', '9876543214', '654 Jayanagar, Bengaluru, Karnataka', '2023-01-05 14:40:00'),
(6, 'Diya Singh', 'diya.singh@gmail.com', '9876543215', '987 Andheri West, Mumbai, Maharashtra', '2023-01-06 15:50:00'),
(7, 'Rohan Mehta', 'rohan.mehta@outlook.com', '9876543216', '135 HSR Layout, Bengaluru, Karnataka', '2024-10-07 16:23:00'),
(8, 'Tia Nair', 'tia.nair@icloud.com', '9876543217', '246 Bandra East, Mumbai, Maharashtra', '2023-01-08 17:41:00'),
(9, 'Krishna Rao', 'krishna.rao@icloud.com', '9876543218', '357 Koramangala, Bengaluru, Karnataka', '2023-01-09 18:25:00'),
(10, 'Pooja Joshi', 'pooja.joshi@outlook.com', '9876543219', '468 Powai, Mumbai, Maharashtra', '2024-05-10 19:15:00');

INSERT INTO restaurants (restaurant_id, restaurant_name, address, cuisine, rating, created_at) VALUES
(1, 'Spice Route', '123 Curry Lane, Bengaluru, Karnataka', 'Indian', 4.5, '2023-01-01 10:00:00'),
(2, 'Sushi Paradise', '456 Sushi Street, Mumbai, Maharashtra', 'Japanese', 3.7, '2023-01-02 11:00:00'),
(3, 'Pizza House', '789 Pizza Avenue, Delhi', 'Italian', 4.2, '2023-01-03 12:00:00'),
(4, 'Tandoori Nights', '321 Grill Road, Chennai, Tamil Nadu', 'Mexican', 4.6, '2023-01-04 13:00:00'),
(5, 'Burger Shack', '654 Burger Boulevard, Pune', 'American', 3.0, '2023-01-05 14:00:00'),
(6, 'Vegan Delight', '987 Green St, Hyderabad', 'Vegan', 3.8, '2023-01-06 15:00:00'),
(7, 'Mexican Fiesta', '135 Taco Lane, Jaipur', 'Italian', 4.3, '2023-01-07 16:00:00'),
(8, 'The Great Dine', '246 Dine Way, Kolkata', 'Continental', 4.1, '2023-01-08 17:00:00'),
(9, 'Barbeque Nation', '357 Grill St, Ahmedabad', 'Barbecue', 3.4, '2023-01-09 18:00:00'),
(10, 'Dim Sum House', '468 Dumpling Rd, Surat', 'Chinese', 4.0, '2023-01-10 19:00:00');

INSERT INTO menus (menu_id, restaurant_id, dish_name, price, availability) VALUES
(1, 1, 'Butter Chicken', 550.00, TRUE),
(2, 1, 'Paneer Tikka', 200.00, TRUE),
(3, 1, 'Biryani', 300.00, TRUE),
(4, 2, 'Dosa', 80.00, TRUE),
(5, 2, 'Idli', 60.00, TRUE),
(6, 2, 'Sambar', 50.00, TRUE),
(7, 3, 'Chaat', 350.00, TRUE),
(8, 3, 'Pav Bhaji', 120.00, TRUE),
(9, 3, 'Palak Paneer', 520.00, TRUE),
(10, 4, 'Vada Pav', 40.00, TRUE);

INSERT INTO orders (order_id, order_status, total_amount, order_date, delivery_date, user_id, restaurant_id) VALUES
(1, 'Pending', 1160.00, '2024-05-20 12:00:00', '2024-10-29 12:00:00', 1, 1),
(2, 'Completed', 320.00, '2024-04-20 12:15:00', '2024-02-18 12:45:00', 2, 1),
(3, 'Cancelled', 200.00, '2024-03-20 12:30:00', '2024-04-20 12:00:00', 4, 2),
(4, 'Pending', 450.00, '2024-12-20 12:45:00', '2024-09-26 12:00:00', 4, 3),
(5, 'Completed', 180.00, '2024-01-20 13:00:00', '2024-10-21 13:30:00', 5, 2),
(6, 'Pending', 1250.00, '2024-06-20 13:15:00', '2024-04-30 12:00:00', 4, 4),
(7, 'Completed', 670.00, '2024-07-20 13:30:00', '2024-08-10 14:00:00', 4, 9),
(8, 'Pending', 320.00, '2024-08-20 13:45:00', '2024-05-25 12:00:00', 8, 7),
(9, 'Pending', 550.00, '2024-09-20 12:45:00', '2024-06-10 12:00:00', 4, 3),
(10, 'Completed', 680.00, '2024-11-20 13:00:00', '2024-07-23 13:30:00', 5, 8);

INSERT INTO order_items (order_item_id, order_id, menu_id, quantity, price) VALUES
(1, 1, 1, 2, 1200.00),  
(2, 1, 2, 1, 200.00),  
(3, 2, 3, 3, 900.00),   
(4, 2, 1, 1, 550.00),  
(5, 3, 4, 2, 160.00),  
(6, 3, 5, 4, 240.00),   
(7, 4, 2, 1, 200.00),  
(8, 4, 6, 2, 100.00),   
(9, 5, 3, 1, 300.00),   
(10, 5, 7, 3, 150.00);   

INSERT INTO payments (payment_id, order_id, payment_type, amount, payment_status) VALUES
(1, 1, 'Credit Card', 1200.00, 'Completed'),
(2, 2, 'UPI', 200.00, 'Completed'),
(3, 3, 'Cash', 900.00, 'Pending'),
(4, 4, 'Debit Card', 550.00, 'Completed'),
(5, 5, 'Net Banking', 160.00, 'Failed'),
(6, 1, 'Paytm', 1200.00, 'Completed'),
(7, 2, 'Credit Card', 200.00, 'Completed'),
(8, 9, 'UPI', 150.00, 'Pending'),
(9, 7, 'Cash', 150.00, 'Completed'),
(10, 8, 'Debit Card', 130.00, 'Failed');
  
INSERT INTO delivery_person (delivery_personid, persons_name, contact_no, order_id, restaurant_id, user_id) VALUES
(1, 'Rahul Sharma', '9876543210', 1, 1, 1),
(2, 'Anita Singh', '9876543211', 2, 2, 2),
(3, 'Vikram Mehta', '9876543212', 3, 3, 3),
(4, 'Priya Joshi', '9876543213', 4, 1, 4),
(5, 'Suresh Patel', '9876543214', 5, 2, 5),
(6, 'Riya Verma', '9876543215', 7, 4, 6),  
(7, 'Karan Gupta', '9876543216', 1, 5, 7),
(8, 'Nisha Reddy', '9876543217', 2, 6, 8),
(9, 'Amit Bansal', '9876543218', 3, 7, 9),
(10, 'Neha Iyer', '9876543219', 4, 8, 10);

INSERT INTO feedback (feedback_id, feedback_type, user_id, comments, response) VALUES
(1, 'Positive', 1, 'The food was excellent and delivered on time!', NULL),
(2, 'Negative', 2, 'The order arrived late and was cold.', 'We apologize for the delay and are looking into it.'),
(3, 'Suggestion', 3, 'Add more vegetarian options to the menu.', NULL),
(4, 'Positive', 4,  'Great service and delicious food!', NULL),
(5, 'Negative', 5,  'Very disappointing experience.',  'We are sorry to hear that.'),
(6, 'Suggestion', 6,  'Consider a loyalty program for regular customers.',NULL),
(7, 'Positive', 7, 'Best biryani I have ever had!', NULL),
(8, 'Negative', 8, 'Not as spicy as I expected.', NULL),
(9, 'Positive', 9, 'Good quality food but a bit pricey.', NULL),
(10, 'Suggestion', 10, 'Add a feedback form in the app.', NULL);

SELECT * FROM restaurants;
SELECT * FROM menus;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM delivery_person;
SELECT * FROM feedback;

SELECT * FROM users;                       /*1st question*/

SELECT restaurant_name,address FROM restaurants;      /*2nd question*/

SELECT * FROM users                        /*3rd question*/
WHERE created_at>'2023-01-01';            
 
SELECT * FROM restaurants                  /*4th question*/
WHERE rating >=4.0;

SELECT * FROM orders                       /*5th question*/
WHERE order_date BETWEEN '2024-01-01' AND '2024-09-01';

SELECT * FROM users                                    /*6th question*/
WHERE email LIKE '%@gmail.com'
   OR email LIKE '%@yahoo.com';
   
SELECT * FROM restaurants                 /*7th question*/
WHERE cuisine="Italian";

SELECT orders.user_id,users.user_name,count(orders.order_id) AS total_orders FROM orders    /*8th question*/
INNER JOIN users ON orders.user_id=users.user_id
GROUP BY orders.user_id;

SELECT cuisine,avg(rating) AS average_rating FROM restaurants            /*9th question*/
GROUP BY cuisine;

SELECT users.user_name,restaurants.restaurant_name,orders.* FROM orders                   /*10th question*/
INNER JOIN users ON orders.user_id=users.user_id 
INNER JOIN restaurants ON orders.restaurant_id=restaurants.restaurant_id; 

SELECT order_item_id,menus.dish_name,menus.price FROM order_items         /*11th question*/
INNER JOIN menus ON menus.menu_id = order_items.menu_id;

SELECT menus.restaurant_id,menus.dish_name,restaurants.restaurant_name,menus.price FROM menus     /*12th question*/
INNER JOIN restaurants ON menus.restaurant_id=restaurants.restaurant_id
GROUP BY menus.restaurant_id;

SELECT orders.user_id,users.user_name,orders.order_id FROM orders                  /*13th question*/
INNER JOIN users ON users.user_id=orders.user_id
GROUP BY orders.user_id
HAVING COUNT(orders.user_id)>=5; 

SELECT user_name,SUBSTRING(user_name,1,5)AS short_name FROM users;                 /*14th question*/

SELECT restaurant_name,UPPER(restaurant_name) AS upper_names FROM restaurants;               /*15th question*/

SELECT NOW() AS `current time & date`;                                 /*16th question*/

SELECT order_date,delivery_date,HOUR(TIMEDIFF(order_date,delivery_date))AS time_diff FROM orders;    /*17th question*/

SELECT * FROM restaurants                                           /*18th question*/
WHERE rating >= 4
LIMIT 3;

SELECT restaurants.restaurant_name,menus.restaurant_id,menus.price FROM menus      /*19th question*/
INNER JOIN restaurants ON menus.restaurant_id=restaurants.restaurant_id
WHERE menus.price>500;

SELECT order_id,                                                       /*20th question*/
CASE 
WHEN order_status='Completed' THEN 'Delivered'
WHEN order_status='Pending' THEN 'In Progress'
ELSE 'Cancelled'
END AS `order status` FROM orders;

SELECT order_id,total_amount,                                           /*21th question*/
CASE 
WHEN total_amount>1000 THEN 'High'
ELSE 'Low'
END AS amount_type FROM orders;

SELECT delivery_person.delivery_personid,delivery_person.persons_name,orders.order_status,users.user_name FROM delivery_person         /*22th question*/
INNER JOIN orders ON delivery_person.order_id=orders.order_id
INNER JOIN users ON delivery_person.user_id=users.user_id
WHERE orders.order_status='Completed';

SELECT restaurants.restaurant_id,restaurants.restaurant_name,menus.dish_name,COUNT(menus.availability) AS currently_available FROM menus            /*23th question*/
INNER JOIN restaurants ON restaurants.restaurant_id=menus.menu_id
GROUP BY menus.restaurant_id;

SELECT user_id,user_name FROM users                                                            /*24th question*/
WHERE(SELECT count(user_id) FROM orders WHERE orders.user_id=users.user_id)>1;

SELECT users.user_id,users.user_name FROM users                                                  /*25th question*/
INNER JOIN feedback ON users.user_id=feedback.user_id
LEFT JOIN orders ON users.user_id=orders.user_id
WHERE orders.order_id IS NULL;

SELECT restaurants.restaurant_id,restaurants.restaurant_name,feedback.feedback_type FROM restaurants                       /*26th question*/
INNER JOIN orders ON orders.restaurant_id=restaurants.restaurant_id
INNER JOIN feedback ON feedback.user_id=orders.user_id
WHERE feedback_type="Positive";




