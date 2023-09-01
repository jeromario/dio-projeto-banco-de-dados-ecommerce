-- criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10) not null,
    Minit varchar(3),
    Lname varchar(20),
    CPF char(11) not null,
    constraint unique_cpf_client unique(CPF),
    Address varchar(45)
    
    
);
alter table clients auto_increment=1; 

-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
    Fname varchar(10) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Brinquedos','Moda','Alimentos','Móveis') not null,
    avaliacao float default 0,
    size varchar(10),
    price float not null,
    productDescription varchar(255)
    
    
);
alter table product auto_increment=1;

-- tabela de pagamento
create table payment(
	idClient int,
    idPayment int,
    typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable float,
    primary key(idclient, idPayment),
    constraint fk_client_id foreign key(idClient) references clients(idClient)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Processando', 'Confirmado', 'Entregue') default 'Processando',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    -- idPayment int,
    -- constraint fk_payment_id foreign key (idPayment) references payment(idPayment),
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
    
);
alter table orders auto_increment=1;

-- criar tabela de estoque
create table productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);
alter table productStorage auto_increment=1;
-- criar tabela de produto em estoque
create table storageProduct(
	idProduct int,
    idStorage int,
    location char(2),
    primary key (idProduct, idStorage),
    constraint fk_storageProduct_product foreign key (idProduct) references product(idProduct),
    constraint fk_storageProduct_storage foreign key (idStorage) references productStorage(idProductStorage)
);


-- criar tabela de fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);
alter table supplier auto_increment=1;
-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    location varchar(255),
    fantasyName varchar(255),
    contact char(11) not null,
    CNPJ char(15),
    CPF char(11),
    constraint unique_cnpj_seller unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
);
alter table seller auto_increment=1;
 -- criar tabela de produto_vendedor
create table productSeller(
	idProduct int,
    idPseller int,
    prodQuantity int default 1,
    primary key (idProduct, idPseller),
    constraint fk_product_product foreign key(idProduct) references product(idProduct),
    constraint fk_product_seller foreign key(idPseller) references seller(idSeller)
);

-- criar tabela de produto/pedido
create table productOrder(
	idProduct int,
    idOrder int,
    quantity int default 1,
    statusProduct enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key (idProduct, idOrder),
    constraint fk_productOrder_product foreign key (idProduct) references product(idProduct),
    constraint fk_productOrder_order foreign key (idOrder) references orders(idOrder)
    
);

-- criar tabela de produto_fornecedor
create table productSupplier(
	idPseller int,
    idSupplier int,
    quantity int not null,
    primary key(idPseller, idSupplier),
    constraint fk_productSupplier_seller foreign key (idPseller) references productSeller(idPseller),
    constraint fk_productSupplier_supplier foreign key (idSupplier) references supplier(idSupplier)
);

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce'; 

