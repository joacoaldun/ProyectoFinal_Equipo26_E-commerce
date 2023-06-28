--CREACION BD TP FINAL PROGRAMACION 3--
create DATABASE P3_ECOMMERCE_DB

use P3_ECOMMERCE_DB
GO
create table Marcas(
    Id int not null primary key identity (1,1),
    Descripcion varchar(50) null,
    ImagenUrl varchar(1000) not null

);
GO
create table Categorias(
    Id int not null primary key identity (1,1),
    Descripcion varchar(50) null

);

go
create table Articulos(
    Id int not null primary key identity (1,1),
    Codigo varchar(50) not null,
    Nombre varchar(50) not null,
    Descripcion varchar (150) null,
    IdMarca int null,
    IdCategoria int null,
    Precio money null,
    Estado bit null default 1
)
---JOACO! Para dropear la de articulos hay que dropear las de stock y fav por la FK...
drop table stock
drop table ListaFavoritos
drop table Articulos

go
create table Imagenes(
    Id int not null primary key identity (1,1),
    IdArticulo int not null,
    ImagenUrl varchar(1000) not null
)

go
insert into MARCAS values 
('Sony','https://historia-biografia.com/wp-content/uploads/2019/10/sony.jpg'), 
('Microsoft', 'https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RWCZER?ver=1433&q=90&m=6&h=195&w=348&b=%23FFFFFFFF&l=f&o=t&aim=true'), 
('Nintendo','https://1000marcas.net/wp-content/uploads/2019/12/Nintendo-Logo-PNG-1.png'), 
('HP','https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/HP_New_Logo_2D.svg/2048px-HP_New_Logo_2D.svg.png'), 
('Razer','https://hardwareviews.com/wp-content/uploads/2019/03/razer-logo.jpg'),
('Noganet','https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/092019/noga.jpg?bhemwa3OZZKNvMmuKZeromyOdQMY1i2o&itok=C9fALjj4'),
('Edifier','https://events.channelpronetwork.com/sites/default/files/Edifier_logo_2016.jpg'),
('Cooler Master','https://cdn.worldvectorlogo.com/logos/cooler-master-logo.svg'),
('Logitech','https://logodownload.org/wp-content/uploads/2018/03/logitech-logo.png'), 
('Redragon','https://cdn.worldvectorlogo.com/logos/redragon.svg')

insert into CATEGORIAS values 
('Consolas'),
('Computadoras escritorio'),
('Notebook'),
('Accesorios'),
('Videojuegos')

insert into ARTICULOS values 
('S01', 'Playstation 4', 'Con tu consola PlayStation 4 tendrás entretenimiento asegurado todos los días.', 1, 1, 200000,1),
('S02', 'Playstation 5', 'Con tu consola PlayStation 5 tendrás entretenimiento asegurado todos los días.', 1, 1, 300000,1),
('C03', 'Resident Evil 4 Remake', 'Salvando a Ashley por 10° vez.', 1, 5, 30000,1),
('D04', 'Teclado Redragon Yama K550', 'Gracias al rgb podrás ser mas habilidoso en los juegos', 10, 4, 30000,1),
('F05', 'Notebook', null, 4, 3, 300000, 1)


insert into Imagenes values 
(1,'https://http2.mlstatic.com/D_NQ_NP_885600-MLA51045269675_082022-O.webp'),
(2,'https://images.fravega.com/f300/af1a88e0d12772f769e6f824a3cb236e.jpg.webp'),
(3,'https://http2.mlstatic.com/D_NQ_NP_880036-MLA53990748326_022023-O.webp'),
(3,'https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/media/image/2023/01/resident-evil-4-2942734.jpg'),
(4,'https://http2.mlstatic.com/D_NQ_NP_935185-MLA46504064329_062021-O.webp')



--SP LISTAR CON STOCK--
go
alter procedure storedListar as
SELECT a.Id, Codigo, Nombre, a.Descripcion 
as DescripcionArticulo, a.Estado as Estado, 
Precio,m.Id as IdMarca, 
m.Descripcion as NombreMarca,
c.Id as IdCategoria, 
c.Descripcion as NombreCategoria, 
i.ImagenUrl as imagen,i.Id as IdImagen ,i.IdArticulo as idArticuloImagen , s.cantidad as Stock from ARTICULOS a 
left join MARCAS m on a.IdMarca=m.Id 
left join CATEGORIAS c on a.IdCategoria=c.Id 
left join IMAGENES i on a.Id=i.IdArticulo
left join stock s on a.Id=s.IdArticulo

--JUEGOS DE LA MARCA SONY
select A.nombre, M.Descripcion from Articulos A
inner join Marcas M on M.Id=A.IdMarca
inner join Categorias C on C.Id=A.IdCategoria
where M.Id=1 and C.Id=5

--CANTIDAD CATEGORIAS DE UNA MARCA--
select  count (distinct c.Id) from Categorias C 
inner join Articulos A on A.IdCategoria=C.Id
inner join Marcas M on M.Id=A.IdMarca
where M.Id=1


select id, descripcion, ImagenUrl from marcas



--------------------------------------------------
--TIPO 1= ADMIN, TIPO 2=CLIENTE
go
create table Usuarios(
    Id int not null primary key identity (1,1),
    Nombre varchar (30) not null,
    Apellido varchar(30) not null,
    Username varchar(30) not null,
    Pass varchar(20) not null,
    TipoAcceso int not null check(TipoAcceso=1 or TipoAcceso=2),
    Email varchar(30) not null,
    EstadoActivo bit default 1
)

go
CREATE TABLE Provincias(
    IDProvincia int not null primary key identity (1, 1),
    NombreProvincia varchar(50) not null
)
go
CREATE TABLE Localidades(
    IDLocalidad int not null primary key identity (1, 1),
    NombreLocalidad varchar(150) not null,
    IDProvincia int not null foreign key references Provincias(IDProvincia)
)

go
create table Domicilio(
    Id int not null primary key identity (1,1),
    IdLocalidad int not null foreign key references Localidades(IdLocalidad),
    CodigoPostal int not null, 
    Direccion varchar(30) not null,
    Vivienda varchar(20) not null,
    NumeroDepartamento varchar(10) null
)
go
create table Cliente(
    Id int not null foreign key references Usuarios(Id),
    Dni varchar(20) not null,
    FechaNacimiento DATE not null,
    IDDomicilio int null foreign key references Domicilio (Id),
    PRIMARY KEY (Id)
)
go
CREATE TABLE ListaFavoritos (
    IdCliente INT,
    IdArticulo INT,
    PRIMARY KEY (IdCliente, IdArticulo),
    FOREIGN KEY (IdCliente) REFERENCES Cliente(Id),
    FOREIGN KEY (IdArticulo) REFERENCES Articulos(Id)
)
GO
create table Stock(
    IdArticulo int foreign key references Articulos (Id),
    Cantidad int default 0,
    Primary key (IdArticulo)
)

drop table stock


---------------SP ARTICULOS-----------------
go
alter PROCEDURE SpAgregarArticulo
@Nombre varchar(50),
@Codigo VARCHAR(50),
@Descripcion varchar(150),
@IdMarca int,
@IdCategoria int,
@Precio money,
@Estado bit
as
insert into Articulos values (@Nombre,@Codigo,@Descripcion,@IdMarca,@IdCategoria,@Precio,@Estado)


select * from Articulos
select * from Imagenes
select max(id) from Articulos


go
alter Procedure SpModificarArticulo
@Nombre varchar(50),
@Codigo VARCHAR(50),
@Descripcion varchar(150),
@IdMarca int,
@IdCategoria int,
@Precio money,
@Id int,
@Estado bit
as
Update Articulos set Nombre = @Nombre, Codigo = @Codigo, Descripcion = @Descripcion, IdMarca = @IdMarca, IdCategoria = @IdCategoria, Precio = @Precio, Estado=@Estado
where Id = @Id



select * from Articulos
select * from Imagenes
select max(id) from Articulos

-----------------SP STOCK-----------------
go 
create Procedure SPagregarStock
@Cantidad int,
@IdArticulo int
AS
INSERT INTO Stock (Cantidad, IdArticulo) VALUES (@Cantidad, @IdArticulo)

go
Create Procedure SPmodificarStock
@Cantidad int,
@IdArticulo int
as
Update Stock set Cantidad = @Cantidad
where IdArticulo = @IdArticulo

select * from articulos a 
left join stock s on s.IdArticulo= a.Id

insert into Stock values 
(1,0),
(2,0),
(3,0),
(4,0),
(5,0),
(10,0)

------BAJA FÍSICA-----
--HACER EL ALTER PARA BORRAS IMAGENES DE ARTICULO TAMBIEN.
go
alter Procedure SPeliminarArticulo (
    @id int
)
As begin
    delete from Stock where idArticulo=@id
    delete from Articulos where id = @id
    delete from Imagenes where IdArticulo = @id
    END
go


--Modificamos la tabla Cliente para que no alla problema si no hay Domicilio vinculado
ALTER TABLE Cliente
ALTER COLUMN IDDomicilio int NULL;

ALTER TABLE Cliente
ADD CONSTRAINT FK_Cliente_Domicilio FOREIGN KEY (IDDomicilio) REFERENCES Domicilio(Id);




--INSERT PARA PROBAR LOS CLIENTES
INSERT INTO Usuarios (Nombre, Apellido, Username, Pass, TipoAcceso, Email)
VALUES ('John', 'Doe', 'johndoe', 'password123', 2, 'johndoe@example.com');

INSERT INTO Cliente (Id, Dni, FechaNacimiento, IDDomicilio)
VALUES (1, '123456789', '1990-01-01', null);



--LISTAR LOS CLIENTES CON SP
Create PROCEDURE SPListarClientes
AS 
BEGIN
select U.id, Nombre, Apellido, Username, TipoAcceso, Email, Dni, FechaNacimiento, EstadoActivo from Usuarios u
inner join Cliente c on U.Id = c.id
END

