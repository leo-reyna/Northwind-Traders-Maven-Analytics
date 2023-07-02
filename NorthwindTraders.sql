-- Maven Analytics Northwind Traders Challenge
-- Top Level Analysis

USE [Northwind Traders]

/* SALES 
Count of Orders
There a total of 830 Products
*/
SELECT 
    COUNT(OrderID) as [Order Count]
FROM dbo.orders;

/* YTD Total Revenue 
YTD Total Sales were $1.354,458.59 Million
*/
SELECT 
    FORMAT(sum(quantity * unitPrice),'C') AS [YTD Total Sales]
FROM dbo.order_details;

/* YTD Net Revenue  - includes discount
YTD Total Sales were $1,265,793.04 Million
*/
SELECT 
    FORMAT(sum(quantity * unitPrice *(1- discount)),'C') AS [YTD Net Sales]
FROM dbo.order_details;

/* TOP 5 PRODUCTS 
The number 1 product is Camember Pierrot with 1,577, 
2nd Place Raclette Couravault with 1,496  and 3rd place 
to Gorgonzola Telino with 1,397 pieces, 4th place goes 
to Gnocchi di nonna Alice at 1,263 and on 5th place is Pavlova with 1,158
*/
SELECT TOP 5
    prd.productName AS [Product Name],
    FORMAT(CAST(SUM(ord.quantity) AS decimal (10,1)), '0,0') AS [Qty Sold]
FROM dbo.order_details AS ord
INNER JOIN dbo.products AS prd
    ON ord.productID = prd.productID
GROUP BY prd.productName
ORDER BY SUM(ord.quantity) DESC;

/* TOP 5 Customer based on Net Sales:
CUSTOMER NAME | NetSales | OrderCount
QUICK-Stop	$110,277.31	86
Ernst Handel	$104,874.98	102
Save-a-lot Markets	$104,361.95	116
Rattlesnake Canyon Grocery	$51,097.80	71
Hungry Owl All-Night Grocers	$49,979.91	55
*/
SELECT TOP 5
    cus.companyName AS CustomerName,
    FORMAT(sum(ode.quantity * ode.unitPrice *(1 - ode.discount)),'C') AS NetSales,
    COUNT(ode.orderID) AS OrderCount
FROM dbo.customers AS cus 
INNER JOIN dbo.orders AS ord 
    ON cus.customerID = ord.customerID
INNER JOIN dbo.order_details AS ode 
    ON ord.OrderID = ode.orderID
GROUP BY cus.companyName  
ORDER BY sum(ode.quantity * ode.unitPrice *(1 - ode.discount)) DESC;

