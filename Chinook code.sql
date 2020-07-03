/* 1) Find the city with the highest revenue that will host a promotional music festival.*/
SELECT BillingCity, SUM("Total") FROM Invoice GROUP BY BillingCity ORDER BY SUM("Total") DESC LIMIT 1;

/* 2) Country with the most invoices*/
SELECT BillingCountry, COUNT("InvoiceId") FROM Invoice GROUP BY BillingCountry ORDER BY COUNT(InvoiceId) DESC;

/* 3) Customer that spends the most money*/
SELECT CustomerId, SUM("Total") FROM Invoice GROUP BY CustomerId ORDER BY SUM("Total") DESC LIMIT 1;

/* 4) Contacts of customers that listen to rock music*/
SELECT DISTINCT FirstName, LastName, Email FROM Customer
INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
INNER JOIN InvoiceLine ON Invoice.InvoiceId = InvoiceLine.InvoiceId
INNER JOIN Track ON Track.TrackId = InvoiceLine.TrackId
INNER JOIN Genre ON Genre.GenreId = Track.GenreId
WHERE Genre.Name = "Rock";

/* 5) Most popular genre in each country*/
SELECT *, MAX(SumTot) as MostPopGen FROM
(SELECT Invoice.BillingCountry as Country, Genre.Name as Type, SUM(InvoiceLine.UnitPrice) AS SumTot
FROM InvoiceLine INNER JOIN Invoice on Invoice.InvoiceId = InvoiceLine.InvoiceId
INNER JOIN Track ON Track.TrackId = InvoiceLine.TrackId
INNER JOIN Genre ON Genre.GenreId = Track.GenreId
GROUP BY Invoice.BillingCountry, Genre.GenreId) sub
GROUP BY Country