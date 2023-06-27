-- Maven Analytics Northwind Traders Challenge
-- Top Level Analysis

USE [Northwind Traders]

/* SALES 
Count of Orders
There a total of 830 Products
*/

/* YTD Total Revenue 
YTD Total Sales were $1.354,458.59 Million
*/
SELECT FORMAT(sum(quantity * unitPrice),'C') AS [YTD Total Sales]
FROM dbo.order_details;

/* YTD Net Revenue 
YTD Total Sales were $1,265,793.04 Million
*/
SELECT FORMAT(sum(quantity * unitPrice *(1- discount)),'C') AS [YTD Net Sales]
FROM dbo.order_details;

/* TOP 5 PRODUCTS 
The number 1 product is Camember Pierrot with 1,577, 2nd Place Raclette Couravault with 1,496 and 3rd  place to Gorgonzola Telino with 1,397 pieces, 4th place goes to Gnocchi di nonna Alice at 1,263 and on 5th place is Pavlova with 1,158
*/
SELECT TOP 5
    prd.productName AS [Product Name], FORMAT(CAST(SUM(ord.quantity) AS decimal (10,1)), '0,0') AS [Qty Sold]
FROM dbo.order_details AS ord
INNER JOIN dbo.products AS prd
    ON ord.productID = prd.productID
GROUP BY prd.productName
ORDER BY SUM(ord.quantity) DESC;

