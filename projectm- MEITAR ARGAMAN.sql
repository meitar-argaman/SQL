-- Name:MEITAR ARGAMAN
-- Date:20/04/2023
-- Description: - PROJECT 1 MEITAR ARGAMAN

USE master
create database projectm
use projectm

-- create table SalesTerritory
create table SalesTerritory
(TerritoryID int not null,
[Name] nvarchar(50) not null,	-- column CONSTRAINT
CountryRegionCode nvarchar(3) not null,
[Group] nvarchar(50) not null,	
SalesYTD money not null,
SalesLastYear money not null,
CostYTD	money not null,
CostLastYear money not null,
ModifiedDate datetime not null, 

constraint SalesTerritory_TerritoryID_PK  primary key (TerritoryID),
constraint SalesTerritory_Name_cK check (len(name)>=2) -- table CONSTRAINT
)
מ
-- create table Address
create table [Address]
(AddressID int not null,
AddressLine1 nvarchar(60) not null,
AddressLine2 nvarchar(60) ,
City nvarchar(30) not null,
StateProvinceID	int not null,
PostalCode	nvarchar(15) not null,
ModifiedDate datetime not null,

CONSTRAINT Address_AddressID_pk  primary key (AddressID)
)

-- create table Ship Method
create table ShipMethod
(ShipMethodID int not null ,
[Name] nvarchar  (50)not null,	
ShipBase money not null, 
ShipRate money not null,		
ModifiedDate datetime not null,

CONSTRAINT ShipMethod_ShipMethodID_pk  primary key (ShipMethodID)
)

-- create table Currency Rate
create table CurrencyRate
(CurrencyRateID int not null ,
CurrencyRateDate datetime not null, 
FromCurrencyCode nchar(3) not null,
ToCurrencyCode	nchar(3) not null,
AverageRate money not null,
EndOfDayRate  money not null,	
ModifiedDate  datetime not null,

constraint CurrencyRate_CurrencyRateID_PK  primary key (CurrencyRateID)
)

-- create table SpeciaOfferProduct
create table SpecialOfferProduct 
(SpecialOfferID int not null,
ProductID int not null,
ModifiedDate datetime not null,

constraint SpecialOfferProduct_SpecialOfferID_ProductID_PK  primary key (SpecialOfferID,ProductID), --multy pk
)

-- create table CreditCard
create table CreditCard
(CreditCardID int not null,
CardType nvarchar(50)not null,
CardNumber nvarchar(25)not null,	
ExpMonth tinyint not null,
ExpYear	smallint not null,
ModifiedDate datetime not null

constraint CreditCard_CreditCardID_PK  primary key (CreditCardID),
constraint CreditCard_CreditCardID_uk unique (CreditCardID)
)

-- create table SalesPerson
create table SalesPerson
(BusinessEntityID int  ,
TerritoryID	int ,
SalesQuota money,
Bonus money not null,
CommissionPct smallmoney not null,
SalesYTD money not null,
SalesLastYear money not null,	
ModifiedDate datetime not null

constraint SalesPerson_BusinessEntityID_PK  primary key (BusinessEntityID),
constraint SalesPerson_TerritoryID_fk Foreign key (TerritoryID) references SalesTerritory (TerritoryID)
)

-- create table Customer
create table Customer
(CustomerID int not null,
PersonID int,
StoreID int , 
TerritoryID	int ,
ModifiedDate datetime not null,

constraint Customer_CustomerID_PK  primary key (CustomerID),
constraint Customer_TerritoryID_fk Foreign key (TerritoryID) references SalesTerritory (TerritoryID)
)

-- create table Sales Order Header 
create table SalesOrderHeader 
(SalesOrderID int not null,
RevisionNumber tinyint not null ,
Orderdate datetime not null,
DueDate datetime not null,
Shipdate datetime ,
[Status] tinyint not null,
OnlineOrderFlag bit not null,
SalesOrderNumber nvarchar(25) not null, 
PurchaseOrderNumber nvarchar(25) , 
AccountNumber nvarchar(15),
CustomerID int not null,
SalesPersonID int ,	
TerritoryID	int, 
BillToAddressID	int not null,
ShipToAddressID	int not null,
ShipMethodID int not null,
CreditCardID int ,	
CreditCardApprovalCode varchar(15),
CurrencyRateID int ,	
SubTotal money not null,
TaxAmt	money not null,
Freight	money not null,
TotalDue money not null,
Comment varchar(1) ,
ModifiedDate datetime not null ,

constraint SalesOrderHeader_selesorderID_PK  primary key(SalesOrderID),
constraint SalesOrderHeader_CurrencyRateID_fk Foreign key (CurrencyRateID) references [CurrencyRate](CurrencyRateID),
constraint SalesOrderHeader_SalesPersonID_fk Foreign key (SalesPersonID) references [SalesPerson](BusinessEntityID),
constraint SalesOrderHeader_shiptoaddressID_fk Foreign key (shiptoaddressID) references [Address](addressID),
constraint SalesOrderHeader_TerritoryID_fk Foreign key (TerritoryID) references [SalesTerritory](TerritoryID),
constraint SalesOrderHeader_CreditCardID_fk Foreign key (CreditCardID) references [CreditCard](CreditCardID),
constraint SalesOrderHeader_CustomerID_fk Foreign key (CustomerID) references [Customer](CustomerID),
constraint SalesOrderHeader_ShipMethodID_fk Foreign key (ShipMethodID) references [ShipMethod](ShipMethodID)
)

-- create table SalesOrderDetail
create table SalesOrderDetail
(SalesOrderID int  not null,
SalesOrderDetailID int not null,
CarrierTrackingNumber nvarchar (25),
OrderQty smallint not null,
ProductID int not null, 
SpecialOfferID int not null, 
UnitPrice money not null, 
UnitPriceDiscount money not null,
ModifiedDate datetime  not null,


constraint SalesOrderDetail_SalesOrderID_selesorderdetailID_PK  primary key  (SalesOrderID,SalesOrderDetailID),-- multy pk
constraint SalesOrderDetail_SpecialOfferID_fk Foreign key (SpecialOfferID, productID) references [SpecialOfferProduct](SpecialOfferID, productID),--multy fk,
constraint SalesOrderDetail_SalesOrderID_fk Foreign key (SalesOrderID) references [SalesOrderHeader](SalesOrderID)
)

--- insert into all ther tables!!!!!!!!!!


-- insert into  SalesTerritory
insert into SalesTerritory
(TerritoryID, [Name], CountryRegionCode, [Group],SalesYTD,SalesLastYear,CostYTD,CostLastYear,ModifiedDate)
select TerritoryID, [Name], CountryRegionCode, [Group],	SalesYTD,SalesLastYear,CostYTD, costLastYear,ModifiedDate
from [dbo].[tempSalesTerritory]


--insert  into Address
insert  into [Address]
(AddressID ,AddressLine1 ,AddressLine2 ,City ,StateProvinceID ,PostalCode ,ModifiedDate)
select AddressID ,AddressLine1 ,AddressLine2 ,City ,StateProvinceID ,PostalCode ,ModifiedDate
from [dbo].[tempAddress]

-- insert into ShipMethod
insert  into ShipMethod
(ShipMethodID,[Name],ShipBase,ShipRate,ModifiedDate)
select ShipMethodID,[Name],ShipBase,ShipRate,ModifiedDate
from [dbo].[tempShipMethod]

--insert  into CurrencyRate
insert  into CurrencyRate
(CurrencyRateID	,CurrencyRateDate,	FromCurrencyCode ,ToCurrencyCode, AverageRate, EndOfDayRate,ModifiedDate)
select CurrencyRateID	,CurrencyRateDate,	FromCurrencyCode ,ToCurrencyCode,
AverageRate, EndOfDayRate,ModifiedDate
from [dbo].[tempCurrencyRate]

-- insert into Special Offer Product 
insert into SpecialOfferProduct 
(SpecialOfferID	,ProductID,	ModifiedDate)
select SpecialOfferID	,ProductID,	ModifiedDate
from [dbo].[tempSpecialOfferProduct]

--insert  into CreditCard
insert  into CreditCard
(CreditCardID,CardType,CardNumber,ExpMonth,	ExpYear, ModifiedDate)
select CreditCardID,CardType,CardNumber,ExpMonth,	ExpYear, ModifiedDate
from [dbo].[tempCreditCard]

-- insert into SalesPerson
insert into SalesPerson
(BusinessEntityID,TerritoryID,SalesQuota, Bonus,CommissionPct,SalesYTD, SalesLastYear,	ModifiedDate)
select BusinessEntityID,TerritoryID,SalesQuota, Bonus,CommissionPct,SalesYTD, SalesLastYear, ModifiedDate
from [dbo].[tempSalesPerson]

 --insert  into  Customer
insert into  Customer  (CustomerID ,PersonID, StoreID, TerritoryID	,	ModifiedDate)
select CustomerID ,PersonID, StoreID, TerritoryID ,ModifiedDate
from [dbo].[tempCustomer]

--insert  into  SalesOrderHeader
insert  into SalesOrderHeader
(SalesOrderID,RevisionNumber, Orderdate, DueDate,	ShipDate, 
[Status] ,OnlineOrderFlag,SalesOrderNumber,PurchaseOrderNumber,AccountNumber ,CustomerID ,
SalesPersonID, TerritoryID ,BillToAddressID,ShipToAddressID,ShipMethodID,CreditCardID,
CreditCardApprovalCode, CurrencyRateID ,SubTotal,	TaxAmt,	Freight	,TotalDue, Comment, 
ModifiedDate)
select SalesOrderID,RevisionNumber ,Orderdate ,DueDate,	ShipDate, [Status] ,OnlineOrderFlag,SalesOrderNumber,PurchaseOrderNumber,
AccountNumber ,CustomerID	,SalesPersonID,	TerritoryID	,BillToAddressID,ShipToAddressID,ShipMethodID,
CreditCardID, CreditCardApprovalCode,CurrencyRateID	,SubTotal,	TaxAmt,	Freight	,TotalDue,	Comment,ModifiedDate
from [dbo].[tempSalesOrderHeader]

-- insert into SalesOrderDetail 
insert  into SalesOrderDetail
(SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID,UnitPrice, UnitPriceDiscount,ModifiedDate)
select SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID,UnitPrice, UnitPriceDiscount,ModifiedDate
from [dbo].[tempSalesOrderDetail]



--SELECT FOR EXEMPLE
select * from SalesOrderHeader
select * from SalesOrderDetail
select * from ShipMethod
select * from CurrencyRate
select * from CreditCard
select * from SalesPerson
select * from SalesTerritory
select * from Customer
select * from [Address]
select * from SpecialOfferProduct


