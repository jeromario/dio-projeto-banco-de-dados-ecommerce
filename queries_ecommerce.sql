use ecommerce;
insert into clients (Fname, Minit, Lname, CPF, Address) values 
	('Jefferson','J','Andrade',07957733409,'rua 19,curado 4 - jaboatao'),
	('Sandrade','R','Dias',12345678915,'rua brejo novo, curado - recife'),
	('Beatriz','R','Andrade',78945612302,'rua oliveira, barro - recife'),
	('Alan','L','Silva',15975325845,'rua de cima, alto - olinda'),
	('Gustavo','A','Almeida',74125896312,'rua da ladeira, ze - olinda'), 
	('Jonnas','N','Ferreira',95186224879,'rua seu luis, pixete - sao lourenco');
desc product;
insert into product (Fname, classification_kids, category, avaliacao, size, price) values
	('Celular',false,'Eletrônico',5,null,2000.00),
	('Boneca',true,'Brinquedos',3,null,150.00),
	('Calça',false,'Moda',4,'42',100.00),
	('Picanha',false,'Alimentos',2,null,80.00),
	('Sofá',false,'Móveis',1,'3x57x80',2500.00),
	('Play',false,'Eletrônico',5,null,1500.00),
	('Notbook',false,'Eletrônico',5,null,3000.00);
    
select * from product;
 desc orders;   
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
	(1,default,'compra via app',null,1),
	(2,default,'compra via app',50,0),
	(3,'Confirmado',null,null,1),
	(4,default,'compra via web',150,0);
select * from orders;

desc productOrder;

insert into productOrder (idProduct, idOrder, quantity, statusProduct) values 
	(1,1,2,default),
	(2,1,1,default),
	(3,2,1,default);
select * from productOrder;
desc productStorage;
insert into productStorage (storageLocation, quantity) values
	('Recife', 1000),
	('Recife', 500),
	('Maceio', 10),
	('Maceio', 100),
	('Maceio', 10),
	('Natal', 60);
select * from productStorage;

desc storageProduct;
insert into storageProduct (idProduct, idStorage, location) values
	(1,2,'RE'),
	(2,6,'RN');
select * from storageProduct;

desc supplier;
insert into supplier (SocialName, CNPJ, contact) values
	('SRStore', 123456789123456,81987653214),
	('Eletro mc', 856456789123456,81999985888),
	('Eletro CS', 561456789123456,82965783215);

desc seller;
insert into seller (SocialName, location, fantasyName, contact, CNPJ, CPF) values 
	('Tech eletro','Recife',null,81987876565,123456789456321,null),
	('Botique Durgas','Recife',null,81999317215,null,12345678321),
	('Kids World','Maceio',null,82995653223,987654321123456,null);
select * from seller;

desc productOrder;
insert into productSeller (idProduct, idPseller, prodQuantity) values
	(6,1,80),
	(7,2,10);
select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = o.idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
	(2,default,'compra via app',50,0);
 select * from productOrder;
 -- recuperacao de pedido com o produto associado e o cliente
select c.idClient, concat(Fname, ' ', Lname) as Client, count(*)as number_of_orders from clients c 
				inner join orders o on c.idClient = o.idOrderClient 
                inner join productOrder p on p.idOrder = o.idOrder
                group by idClient;
    