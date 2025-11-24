CREATE DATABASE OnlineBookStore;
USE OnlineBookStore;

DROP TABLE IF EXISTS BOOKS;

CREATE TABLE Books(
Book_Id SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genere VARCHAR(50),
Published_Year INT ,
Price NUMERIC(10,2),
Stock int);

DROP TABLE IF EXISTS CUSTOMERS;

CREATE TABLE Customers(
Customer_id SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City varchar(50),
Country VARCHAR(100)
);

DROP TABLE IF EXISTS ORDERS;

CREATE TABLE Orders(
Order_ID SERIAL PRIMARY KEY,
Customer_id INT REFERENCES Customers(Customer_id),
Book_id INT REFERENCES Books(Book_id),
Order_Date DATE,
Quantity int,
Total_Amount NUMERIC(10,2)
);

SELECT * FROM CUSTOMERS;
SELECT * FROM BOOKS;
SELECT * FROM ORDERS;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books 
WHERE Genere = "Fiction";


-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_Year >= 1950;


-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE Country="Canada";


-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN "2023-11-01" AND "2023-11-29";


-- 5) Retrieve the total stock of books available:
SELECT sum(Stock) AS total_stock
FROM Books;

-- 6) Find the details of the most expensive book:

SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders
WHERE Quantity > 1;


-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders
WHERE Total_Amount > 20;

-- 9) List all genres available in the Books table:

SELECT DISTINCT Genere  FROM Books;

-- 10) Find the book with the lowest stock:

SELECT * FROM Books ORDER BY Stock ASC
LIMIT 5;

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(Total_Amount)
AS Revenue
FROM Orders;

-- Advance Questions :

-- 1) Retrieve the total number of books sold for each genre:

SELECT B.Genere, SUM(Quantity) AS Total_Book_SOLD
FROM Orders o
JOIN Books b ON o.Book_id = b.book_id
GROUP BY b.genere;

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price) AS AVRAGE_PRICE
FROM Books
WHERE GENERE = "Fantasy";

-- 3) List customers who have placed at least 2 orders:

SELECT Customer_id, COUNT(Order_id) AS ORDER_COUNT
FROM Orders 
GROUP BY Customer_id
HAVING COUNT(Order_id) >= 2;

-- 4) Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT * FROM Books
WHERE Genere = "Fantasy"
ORDER BY Price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;











