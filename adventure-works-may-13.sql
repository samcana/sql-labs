## 1. 	Write a SELECT statement that lists the customerid along with their account number,
##type, the city the customer lives in and their postalcode.

SELECT * FROM adventureworks.customeraddress;

select c.CustomerID, c.AccountNumber, c.CustomerType,
a.City, a.PostalCode

from customer c
join customeraddress ca on c.CustomerID = ca.CustomerID #Using(CustomerID
join address a on ca.AddressID=a.AddressID;


SELECT c.CustomerID, c.AccountNumber, c.CustomerType, a.City, a.PostalCode
FROM adventureworks.customer c
JOIN adventureworks.customeraddress ca
ON c.CustomerID = ca.CustomerID
JOIN adventureworks.address a
ON ca.AddressID = a.AddressID;

# 2. 	Write a SELECT statement that lists the 20 most recently launched products, their name and colour

SELECT p.Name, p.ProductID, p.Color, p.SellStartDate
FROM adventureworks.product p
ORDER BY SellStartDate DESC
LIMIT 20;

# 3. 	Write a SELECT statement that shows how many products are on each shelf in 2/5/98,
# broken down by product category and subcategory

SELECT count(i.ProductID), i.Shelf, p.ProductSubcategoryID

FROM adventureworks.productinventory i

join product p on i.ProductID=p.ProductID
 
where i.ModifiedDate = '1998-05-02 00:00:00'

Group by Shelf, p.ProductSubcategoryID, i.ModifiedDate;

# 4. 	I am trying to track down a vendor email address 
# his name is Stuart and he works at G&K Bicycle Corp. Can you help?

SELECT * FROM vendor;

SELECT * FROM contact;

SELECT v.VendorID, v.AccountNumber, vc.ContactID, c.EmailAddress, c.FirstName
FROM adventureworks.vendor v
JOIN adventureworks.vendorcontact vc
ON v.vendorID = vc.vendorID
JOIN adventureworks.contact c
ON vc.ContactID = c.ContactID
where v.AccountNumber = 'G&KBI0001' ;

#5. 	What’s the total sales tax amount for sales to Germany? What’s the top region in Germany by sales tax? Germany is TerritoryID8...but....where to find the tax rate, hmmm

SELECT * FROM adventureworks.salestaxrate;

select * from countryregion;

select * from salesterritory;

#6 	Summarise the distinct # transactions by month

select TransactionID from transactionhistory;

SELECT count(TransactionID), EXTRACT(YEAR_MONTH FROM TransactionDate)

FROM adventureworks.transactionhistory

GROUP BY EXTRACT(YEAR_MONTH FROM TransactionDate);

#7.  Which ( if any) of the sales people exceeded their sales quota this year and last year? salespersonquotahistory has monthly quotas...do we need to add them up?

SELECT * FROM salesperson sa
#join salesperson sa
#ON hi.SalesPersonID = sa.SalesPersonID

WHERE sa.SalesYTD > sa.SalesQuota AND sa.SalesLastYear > sa.SalesQuota;


SELECT sum(SalesQuota), SalesPersonID FROM salespersonquotahistory hi
join salesperson sa
ON hi.SalesPersonID = sa.SalesPersonID

Group By SalesPersonID;

#8.  Do all products in the inventory have photos in the database and a text product description? 

select * from productproductphoto;

select * from productinventory pi
join productproductphoto pp
on pi.ProductID = pp.ProductID;

select * from productmodel;

# 9.  What's the average unit price of each product name on purchase orders which were not fully, but at least partially rejected?


SELECT po.PurchaseOrderID, pr.Name, po.OrderQty, po.UnitPrice, po.ReceivedQty, po.RejectedQty from purchaseorderdetail po
join product pr
on po.ProductID = pr.ProductID
WHERE RejectedQty <> ReceivedQty
AND RejectedQty > 0

ORDER BY pr.Name ASC;

select * from purchaseorderdetail;

#10. How many engineers are on the employee list? Have they taken any sickleave? (yes all of them have)

select * from employee;

select count(*) from employee
WHERE SickLeaveHours > 0;

#11 How many days difference on average between the planned and actual end date of workorders in the painting stages? Can't figure out which 'OperationSequence' is the painting stage aaahhhhh

select * from workorderrouting;

SELECT WorkOrderID,
  ROUND(AVG(DATEDIFF(ActualEndDate,ScheduledEndDate)),2) as AvgLag
  FROM workorderrouting
  GROUP BY WorkOrderID
  ORDER BY WorkOrderID ASC;