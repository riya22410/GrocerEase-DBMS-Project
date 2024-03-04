-- listing all products from the store in a customer's city
Select * from Inventory 
where StoreID in (
	Select storeID 
	from Offline_Stores 
    Inner Join Customers On Offline_Stores.city in (
		Select Customers.City 
        where Customers.CustomerID=1)
	);

-- cart order count

-- checking for balance in a customer's wallet
Select Balance from Wallet where CustomerID = 1;

-- Finding the stores closest to the customer
SELECT CustomerID, storeID, MIN(ABS(customers.pin_code - offline_stores.zip_code)) AS min_difference
FROM customers, offline_stores
WHERE customers.City = offline_stores.city
GROUP BY customers.CustomerID, offline_stores.storeID
ORDER BY customers.CustomerID, min_difference;

-- average rating for all orders
SELECT AVG(reviews.stars) AS Average_rating
FROM reviews;

-- Select and display items below Rs. 99
SELECT itemID, ItemName, price
FROM Inventory
WHERE price < 99;

-- item being ordered the most
SELECT Orders.itemID, Inventory.ItemName as Item, inventory.category, SUM(quantity) AS total_quantity
FROM orders
JOIN inventory ON Orders.itemID = inventory.itemID
GROUP BY Orders.itemID, inventory.category, Inventory.ItemName
ORDER BY total_quantity DESC
LIMIT 1;

-- update address
UPDATE Customers
SET AddressLine1 = '456 Park Avenue', AddressLine2 = 'Flat 22',
City = 'Delhi', State = 'Delhi', pin_code = '110001'
WHERE CustomerID = 1;

-- total cart cost
SELECT c.Customer_ID, SUM(c.Quantity * i.price) AS total_bill_price
FROM cart c
JOIN inventory i ON c.Item_ID = i.itemID
GROUP BY c.Customer_ID
;

-- delete from inventory

-- group by categories + most sold product
SELECT inventory.category, inventory.ItemName
FROM inventory
GROUP BY category, ItemName;

-- user's most frequent orders bought
SELECT itemID , COUNT(itemID) AS Frequency
FROM Orders
WHERE CustomerID = 11
GROUP BY itemID
ORDER BY Frequency DESC
LIMIT 1;
