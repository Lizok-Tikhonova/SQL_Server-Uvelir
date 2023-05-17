create database UvelirLiza;

use bd;


create table clients
(id_clients int primary key IDENTITY,
surname varchar(15) not null,
name_ varchar(15) not null,
telephone varchar(20) unique check(telephone LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
email varchar(30),
adres varchar(30)
);	


create table sotrudnics
(id_sotrudnica int primary key IDENTITY,
surname varchar(15) not null,
name_ varchar(15) not null,
patronimyc varchar(15),
birthday date not null check(DATEDIFF(day, birthday, CONVERT (date, GETDATE()) )>=18*360),
passport varchar(10) unique check(passport LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
telephone varchar(20) unique check(telephone LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
adres varchar(30),
email varchar(30),
inn varchar(15) unique check(inn LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')));



create table positions
(id_position int primary key IDENTITY,
name_pos varchar(20) not null unique)


create table uchet_sotrudnicov
(
id_uch int primary key identity,
data_priema date not null,
data_uvolneniya date default null,
status_working int check(status_working = 0 or status_working = 1), /* 0-работает, 1-уволен*/
id_sotrudnica int not null,
position int not null
);


alter table uchet_sotrudnicov
add foreign key (id_sotrudnica) references sotrudnics(id_sotrudnica);
alter table uchet_sotrudnicov
add foreign key (position) references positions(id_position);



create table metals
(id_matala int primary key IDENTITY,
name_metal varchar(20) not null,
cena_gramm Smallmoney not null);

create table tips
(id_tipa int primary key IDENTITY,
name_ varchar(30) not null);

create table stones
(id_stones int primary key IDENTITY,
name_ varchar(30) not null,
cena_gramm Smallmoney not null
);


create table ukrashenia
(id_ucrashenia int primary key IDENTITY,
tip int not null,
metal int not null,
stone int not null,
massa_stone float(10) check(massa_stone >= 0),
massa_metals float(10) check(massa_metals > 0),
dop_infa varchar(50),
cena_works Smallmoney not null check(cena_works > 0));


create table requests
(id_requests int primary key IDENTITY,
sotrudnic_prinim int not null,
sotrudnic_izg int not null,
client_ int not null,
predoplata Smallmoney check(predoplata > 0),
registration_date date check(registration_date<=CONVERT (date, GETDATE())),
date_vadachi date,
itog_cena money check(itog_cena >= 0),
status_oplat int check(status_oplat = 0 or status_oplat = 1)); /* 0-не оплачено*/



create table chek
(
id_requests int,
id_ukrasheia int unique,
Primary key (id_requests, id_ukrasheia)
)


alter table chek
add foreign key (id_requests) references requests(id_requests);

alter table chek
add foreign key (id_ukrasheia) references ukrashenia(id_ucrashenia);


alter table requests
add foreign key (client_) references clients(id_clients);

alter table requests
add foreign key (sotrudnic_prinim) references sotrudnics(id_sotrudnica);
alter table requests
add foreign key (sotrudnic_izg) references sotrudnics(id_sotrudnica);


alter table ukrashenia
add foreign key (tip) references tips(id_tipa);
alter table ukrashenia
add foreign key (metal) references metals(id_matala);
alter table ukrashenia
add foreign key (stone) references stones(id_stones);


alter table uchet_sotrudnicov
add foreign key (id_sotrudnica) references sotrudnics(id_sotrudnica);



insert into positions values
('master'),
('priemchica')



insert into sotrudnics values
('Terhova', 'Anna', 'Romanovna', '2004-05-08','2020260235','79105105001', 'Lenina20', 'anna@mail.com', '222222223222'),
('Kalinin', 'Oleg', 'Denisovich', '2000-10-12','6660267232', '79102563652', 'Kirova56', 'kal_ol@gmail.com', '333333333333'),
('Demidov', 'Ruslan', 'Ruslanovich', '1995-02-10','2020711351', '79256513254', 'Saltikova-Shedrina10', 'rus@mail.com', '444444444444'),
('Semenov', 'Dmitriy', 'Romanovich', '1990-05-08','2330723351', '79256512254', 'Barikad6', 'sem@mail.com', '555555555555'),
('Lebedev', 'Roman', 'Semenovich', '1992-04-11','2311723351', '79256500254', 'Barikad15', 'leb@mail.com', '555511115555');



insert into uchet_sotrudnicov values
--('2022-05-05', '2022-12-01', 1,1,1),
('2018-04-05', null, 0,2,2),
('2017-10-12', null, 0,3,1),
('2015-11-14', null, 0,4,2),
('2020-05-05', null, 0,1,1),
('2019-10-10', null, 0,5,2);




--update uchet_sotrudnicov
--set status_working = 1
--where status_working =0 and id_sotrudnica =2;




 insert into clients values
 ('Kachanov', 'Iliya', '79105155225','kach@mail.com','Lenina5'),
 ('Tiikhonova', 'Liza', '79533652351','liza@mail.com','Lenina5'),
 ('Dmitriev', 'Oleg', '79002506363','olegDm@mail.com','StepanaR25'),
 ('SOrokin', 'Nikita', '79206302514','sorok@mail.com','Kanichevskaya64'),
 ('Terehin', 'Fedor', '79804714545','tereh@mail.com','Semenovskaya150'),
 ('Arhipova', 'Sasha', '79502365145','arhip@mail.com','Kirova21'),
 ('Kalin', 'Oleg', '79502365124','kalin@mail.com','Zueva68');


 insert into metals values
 ('Platina', 1200),
 ('Zoloto', 3000),
 ('Serebro', 48),
 ('Paladiy', 2000);


 insert into tips values
 ('earrings'), --  серьги
 ('ring'), -- кольцо
 ('сhain'), -- цепочка
 ('pendant'),   --кулон
 ('bracelet'); --браслет

 insert into stones values
 ('Not_Stone', 0),
 ('Almas', 100000),
 ('Izumrud', 25000),
 ('Rubin', 17000),
 ('Sapfir', 10000),
 ('Yantar', 12000),
 ('Opal', 8000),
 ('Fianit', 10000);



 --update ukrashenia
 --set massa_stone=5
 --where id_ucrashenia =5


 insert into ukrashenia values
 (1, 2, 1,0,3,'Сделать серьги диаметром 0,7', 10000),
 (1, 3, 2, 1.1, 2.1,null, 15000),
 (2, 1, 3, 2.1, 3.1,'Размер кольца 16', 15000),
 (2, 2, 4, 2.4, 4.5,'Размер кольца 15', 11000),
 (2, 4, 5,1.7,4.2,'Р.15, камень побольше', 11000),
 (3, 1, 1,0,3.9,'цепочка размер 42', 19000),
 (3, 3, 1,0,3.7,'Диаметр звена 1,5мл', 17000),
 (4, 2, 8,2.1,4.1, null, 15000),
 (4, 3, 5,1.5,2.8, null, 11000),
 (5, 1, 1,0,3.5, null, 13000),
 (5, 2, 7,3.2,3.9,null, 12000),
 (5, 4, 5,3.3,3.7,'Маленький круглый опал спустя каждые 5 звеньев', 15000),
 (1, 1, 6,1.4,4.3,null, 13000),
 (2, 2, 2,2.2,4.5,null, 14000),
 (3, 3, 1,0,4.6,'цепочка размер44', 16000),
 (4, 4, 3,2.5,3.9,'кулон капелька', 12000),
 (5, 3, 4,3.2,4.1,null, 11000),
 (1, 2, 8,1.9,4.5,'висюльки', 10000),
 (2, 1, 7,2.3,1.6,'р.17', 16000);


 --расчет стоимости заявки
 --select requests.id_requests ,sum(stones.cena_gramm*ukrashenia.stone+metals.cena_gramm+ukrashenia.massa_metals+ukrashenia.cena_works) from requests, ukrashenia, chek, metals, stones
 --where ukrashenia.id_ucrashenia = chek.id_ukrasheia and chek.id_requests = requests.id_requests and ukrashenia.metal=metals.id_matala and ukrashenia.stone = stones.id_stones
 --group by requests.id_requests 


 insert into requests values
 ( 1, 2, 1, 3000, '2020-12-15','2020-12-19', 228053.22,1),
 ( 3, 4, 3, 3000, '2020-10-02','2020-10-02', 91203,1),
 ( 1, 5, 4, 3000, '2021-09-01', '2021-09-19', 82004,1),
 ( 3, 2, 5, 3000, '2021-12-02','2021-12-12', 83208,1),
  ( 1, 2, 5, 3000, '2021-12-02','2021-11-08', 17051,1),

  ( 3, 4, 2, 3000, '2020-12-15','2020-12-20', 98004,1),
 ( 1, 4, 3, 3000, '2020-10-02','2021-10-05', 75254,1),
 ( 1, 5, 4, 3000, '2021-09-01','2021-09-05', 71003,1),
 ( 1, 5, 5, 3000, '2021-12-02','2021-07-08', 67003,1),
  ( 3, 5, 6, 3000, '2021-12-02','2021-02-09', 86204,1),

  ( 3, 4, 7, 3000, '2022-10-15','2022-10-23', 217004,1),
 ( 3, 4, 2, 3000, '2022-11-02','2022-11-04', 16052,1),
 ( 1, 2, 4, 3000, '2021-09-01','2021-06-05', 168056,1),
 ( 3, 2, 7, 3000, '2021-12-02','2021-03-05', 93004,1),
  (1, 2, 6, 3000, '2021-12-02','2021-01-06', 73201,1);



  insert into chek values
 ( 1, 1),
 ( 1, 2),
 ( 2, 3),
 ( 3, 4),
 ( 4, 5),
 ( 4, 6),
 ( 5, 7),
 ( 6, 8),
 ( 7, 9),
 ( 7, 10),
 ( 8, 11),
 ( 9, 12),
 ( 10, 13),
 ( 11, 14),
 ( 12, 15),
 (13,16),
 (13,17),
 (14,18),
 (15,19);


 --триггер на внесение записи в украшения
go
create trigger addUkr
on ukrashenia
after insert
as
if(select massa_stone from inserted)is null and (select massa_metals from inserted)is null
print('Запись внесена')
else
throw 50000, 'Масса камня не может быть заполнена, так как украшение еще не изготовлено',16



--триггер на внесение записи в заявку
go
create trigger addReq
on requests
after insert
as
declare @id_prinim int = (select sotrudnic_prinim from inserted)
declare @id_izg int = (select sotrudnic_izg from inserted)


declare @st_work_prinnim int = (select sotrudnics.id_sotrudnica from  sotrudnics
where exists(select * from uchet_sotrudnicov, positions
where sotrudnics.id_sotrudnica = uchet_sotrudnicov.id_sotrudnica and uchet_sotrudnicov.position = positions.id_position and uchet_sotrudnicov.status_working=0 and uchet_sotrudnicov.id_sotrudnica=@id_prinim and uchet_sotrudnicov.position=1))

declare @st_work_izg int = (select sotrudnics.id_sotrudnica from  sotrudnics
where exists(select * from uchet_sotrudnicov, positions
where sotrudnics.id_sotrudnica = uchet_sotrudnicov.id_sotrudnica and uchet_sotrudnicov.position = positions.id_position and uchet_sotrudnicov.status_working=0 and uchet_sotrudnicov.id_sotrudnica=@id_izg and uchet_sotrudnicov.position=2))


if @st_work_prinnim is null
throw 50000, 'Принять заказ может только работающая приемщица',16
if @st_work_izg is null
throw 50000, 'Изготавливать заказ может только работающий мастер',16


if(select status_oplat from inserted)=0 and (select date_vadachi from inserted)is null and (select itog_cena from inserted)=0 and (select predoplata from inserted)is null
print('Запись внесена')
else
throw 50000, 'Не удалось внести запись, проверьте, что заявка не оплачена, дата выдачи не указана, итоговая цена уже посчитана или внесена предобплпата то определения с заказом',16




--добавление предоплаты / оплата заказа
create trigger updRequests
on requests
after update 
as

if (@@rowcount =1)
begin
	if(select predoplata from inserted)is not null and (select predoplata from deleted)is null
	begin 
	if(select predoplata from inserted) =3000
	begin
		declare @id_req int = (select id_requests from inserted)
		declare @predopl smallmoney= (select predoplata from inserted)
		declare @id_chek int = (select chek.id_requests from chek
		where (exists(select requests.id_requests from requests
		where chek.id_requests = requests.id_requests and requests.id_requests=@id_req ))group by chek.id_requests)

		if @id_chek is not null
		begin
		update requests
		set predoplata = @predopl
		where requests.id_requests=@id_req
		print('Предоплата внесена')
		end
		else
		throw 50000, 'Вы еще не выбрали украшение, на что предоплату вы хотите оставить?)',1 
    end
	else throw 50000, 'предоплата в мастерской фиксированная, 3000',1 
	end
	
	if(select status_oplat from inserted) != (select status_oplat from deleted)
	begin
		declare @id_req2 int = (select id_requests from inserted)
		declare @status_oplat int = (select status_oplat FROM inserted)
		declare @status_oplat_del int = (select status_oplat FROM deleted)

		declare @status_itog int = (select itog_cena FROM inserted)
		declare @status_itog_del int = (select itog_cena FROM deleted)

		declare @kolvo_not_izg int = (select COUNT(chek.id_ukrasheia) from chek, requests, ukrashenia
		where requests.id_requests = chek.id_requests and chek.id_requests =@id_req2 and chek.id_ukrasheia = ukrashenia.id_ucrashenia and (ukrashenia.massa_metals)is null)

		if @kolvo_not_izg = 0
		begin
		update requests
		set status_oplat = @status_oplat,
		date_vadachi = CONVERT(date, GETDATE())
		where requests.id_requests = @id_req2
		print('Заказ закрыт')
		end
		else
		throw 50000, 'Заказ еще не был полностью изготовлен',1
	end
		if(select date_vadachi from inserted)is not null and (select date_vadachi from deleted)is null and (select status_oplat from inserted) =0
		throw 50000, 'Заказ еще не был оплачен',1
end



update ukrashenia
set massa_metals=3.5,
massa_stone =2.1
where ukrashenia.id_ucrashenia=25


update requests
set predoplata =3000
where requests.id_requests=22



update requests
set status_oplat =1
where requests.id_requests=22



--вносим изготовленное украшение
go
create trigger updUkr
on ukrashenia
after update
as
declare @id_ukr int = (select id_ucrashenia from inserted)
declare @massa_metals int = (select massa_metals from inserted)
declare @massa_stone int = (select massa_stone from inserted) 

declare @cena_works Smallmoney = (select cena_works FROM inserted)

declare @predopl Smallmoney = (select requests.predoplata FROM requests, chek,ukrashenia
			where requests.id_requests = chek.id_requests and chek.id_ukrasheia = ukrashenia.id_ucrashenia and ukrashenia.id_ucrashenia =@id_ukr)

if(select requests.predoplata from requests, chek, ukrashenia
	where requests.id_requests = chek.id_requests and chek.id_ukrasheia =ukrashenia.id_ucrashenia AND ukrashenia.id_ucrashenia=@id_ukr)is not null and (select massa_stone FROM deleted)IS NULL and (select massa_metals FROM deleted)is null
begin 
declare @id int = (select id_ucrashenia FROM inserted)

update ukrashenia
set massa_metals = @massa_metals,
massa_stone=@massa_stone
where ukrashenia.id_ucrashenia=@id_ukr
print('запись внесена')

update requests
set itog_cena = requests.itog_cena + @massa_metals * metals.cena_gramm + @massa_stone * stones.cena_gramm + @cena_works from chek, ukrashenia, requests, stones,metals
where requests.id_requests = chek.id_requests and chek.id_ukrasheia = ukrashenia.id_ucrashenia and ukrashenia.id_ucrashenia=@id and ukrashenia.metal = metals.id_matala and ukrashenia.stone=stones.id_stones
print('цена внесена')
	end
else
throw 50000, 'Произошла ошибка, возможные причины: вы пытаетесь изготовить украшение на которое еще не внесена предоплата, либо украшение уже было добавлено',16



--составляем чек до внесения предоплаты
go
create trigger add_ukr_in_chek
on chek
after insert
as
declare @id_chek int = (select id_requests FROM inserted)
if (select requests.id_requests from requests, chek
where requests.id_requests = chek.id_requests and chek.id_requests=@id_chek and (requests.predoplata)is not null
group by requests.id_requests)IS NULL
print(1)

else
throw 50000, 'Нельзя внести новое украшение в заказ, если он был уже утвержден(внесена предоплата)',1




--при увольнении подставляется сегодняшняя дата, проверка чятобы нельзя было обратно вернуть в этой же записи
go
CREATE TRIGGER Uvolnenie_UchetSotr
ON uchet_sotrudnicov
AFTER UPDATE
AS
declare @status int = (select status_working from inserted)
IF @status = 1
begin
update uchet_sotrudnicov
set data_uvolneniya = CONVERT (date, GETDATE())
where id_sotrudnica = (select id_sotrudnica from inserted)
end
IF @status = 0
throw 50000, 'Вы не можете вернуть уволенного сотрудника, только заного нанять',16







-----------------------------------------------------------------------------------------------------------------------------




--итоговая цена украшений
select ukrashenia.id_ucrashenia, tips.name_, metals.name_metal, ukrashenia.massa_metals, stones.name_,  ukrashenia.massa_stone, (ukrashenia.cena_works+ukrashenia.massa_metals*metals.cena_gramm+ukrashenia.stone*stones.cena_gramm) as itog_cena_ukr
from ukrashenia, stones, metals, tips
where ukrashenia.stone = stones.id_stones and ukrashenia.metal = metals.id_matala and tips.id_tipa = ukrashenia.tip


--доход по месяцам за 2021 год, от максимального к минимальному
select convert(int, sum(ukrashenia.cena_works+ukrashenia.massa_metals*metals.cena_gramm+ukrashenia.stone*stones.cena_gramm)) as dohod, DATENAME(month,(requests.date_vadachi)) as month
from requests join chek on chek.id_requests = requests.id_requests join ukrashenia on chek.id_ukrasheia =ukrashenia.id_ucrashenia join stones on stones.id_stones=ukrashenia.stone join metals on metals.id_matala=ukrashenia.metal
where requests.date_vadachi between '2021-01-01' and '2021-12-31'
group by DATENAME(month,(requests.date_vadachi))
order by dohod desc


--доход по годам
select year(requests.date_vadachi) as год, convert(int, sum(ukrashenia.cena_works+ukrashenia.massa_metals*metals.cena_gramm+ukrashenia.stone*stones.cena_gramm)) as dohod
from ukrashenia, stones, requests,metals, chek
where ukrashenia.stone = stones.id_stones and requests.id_requests = chek.id_requests and chek.id_ukrasheia = ukrashenia.id_ucrashenia and ukrashenia.metal = metals.id_matala
group by  year(requests.date_vadachi)


--в каком году больше всего продали украшений
select year(requests.date_vadachi) as год, count(requests.date_vadachi) as количество
from requests
group by year(requests.date_vadachi)
having count(requests.date_vadachi)>=all(select count(requests.date_vadachi) from requests group by year(requests.date_vadachi))


--самое дорогое проданное серебряное украшение
select ukrashenia.id_ucrashenia, tips.name_, stones.name_, (ukrashenia.cena_works+ukrashenia.massa_metals*metals.cena_gramm+ukrashenia.stone*stones.cena_gramm) as summ from ukrashenia,stones,metals,tips
where stones.id_stones = ukrashenia.stone and tips.id_tipa = ukrashenia.tip and metals.id_matala = ukrashenia.metal and metals.name_metal='serebro' and (ukrashenia.cena_works+ukrashenia.massa_metals*metals.cena_gramm+ukrashenia.stone*stones.cena_gramm) >=
all(select (ukrashenia.cena_works+ukrashenia.massa_metals*metals.cena_gramm+ukrashenia.stone*stones.cena_gramm) as summ from ukrashenia,stones,metals
where stones.id_stones = ukrashenia.stone and metals.id_matala = ukrashenia.metal and metals.name_metal='serebro')



--фамилия, имя клиентов, которые купили хотябы одни серьги через join
select clients.surname +' '+ clients.name_ as Клиенты from clients
where exists(select clients.surname from requests join chek on requests.id_requests=chek.id_requests join ukrashenia on chek.id_ukrasheia = ukrashenia.id_ucrashenia join tips on tips.id_tipa = ukrashenia.tip
where requests.client_ = clients.id_clients and tips.id_tipa =1) 



--фамилия, имя клиентов и количество купленных сережек
select clients.surname +' '+ clients.name_ as Клиенты, count(ukrashenia.id_ucrashenia) as kolvo from clients, ukrashenia, requests,chek,tips
where  requests.client_ = clients.id_clients and requests.id_requests = chek.id_requests
and chek.id_ukrasheia=ukrashenia.id_ucrashenia and ukrashenia.tip=tips.id_tipa and tips.name_='earrings'
group by clients.surname, clients.name_






--По входным параметрам Фамилия и Имя сотрудника выводится количество изготовленных им украшений

create proc Sotr5
@surname varchar(15),
@name varchar(15),
@kolvo int output
as
select @kolvo =  count(requests.id_requests) from requests, sotrudnics
where requests.sotrudnic_izg = sotrudnics.id_sotrudnica and sotrudnics.surname=@surname and sotrudnics.name_ = @name and requests.status_oplat=1
print 'Сотрудник изготовил - ' + convert(varchar, @kolvo) + ' укр.'

if @kolvo =0
print 'Либо вы ввели приемщицу, либо сотрудник все еще ничего не изготовил'

declare @kolvo int
exec Sotr5 'Terhova', 'Anna' , @kolvo output




--По входному параметру id_украшения выводится количество проданных украшений

create proc Released
@name_tip varchar(10),
@kolvo_ukr int output
as
select @kolvo_ukr = COUNT(requests.date_vadachi) from requests,chek, ukrashenia,tips
where requests.id_requests =chek.id_requests and chek.id_ukrasheia = ukrashenia.id_ucrashenia and tips.id_tipa =ukrashenia.tip and tips.name_ = @name_tip
	print 'Было отпущено ' + convert(varchar,@kolvo_ukr) + ' укр.'


declare @kolvo_ukr int
exec Released 'pendant', @kolvo_ukr output