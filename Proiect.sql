/*CREAREA TABELEI ADRESA*/
create table ADRESA (id_adresa number(2) 
constraint PKey_adresa primary key,
tara varchar2(20) not null, 
localitate varchar2(20), strada varchar2(30),
numar number(2));

/*CREAREA TABELEI ANGAJAT*/
create table ANGAJAT 
(idAng number(4)constraint PKey_angajat primary key,
nume varchar2(30), prenume varchar2(30), 
salariu number(5), nivel_pregatire varchar2(30),
numar_telefon varchar2(15), email varchar2(30), 
data_angajare date,
id_adresa number(2),
id_superior number(4),
constraint FKey_adresa foreign key(id_adresa) references adresa(id_adresa));


/*CREAREA TABELEI MEDIC*/
create table MEDIC
(idMedic number(4)constraint PKey_idMedic primary key,
idAng number(4),
specializare varchar2(30),
nr_cabinet number(2),
constraint FKey_medic foreign key(idAng) references angajat(idAng)
);

/*CREAREA TABELEI ASISTENT*/
create table ASISTENT
(idAsistent number(4)constraint PKey_idAsistent primary key,
idAng number(4),
orePregatireLunara number(3),
nrCursuriSuplimentare number(2),
constraint FKey_asistent foreign key(idAng) references angajat(idAng)
);
drop table consultatie;
drop table pacient;

/*CREAREA TABELEI PACIENT*/
create table PACIENT
(idPacient number(4) constraint PKey_idPacient primary key,
nume varchar2(30),
prenume varchar2(30),
varsta number(3),
email varchar2(30),
telefon varchar2(30),
id_adresa number(2),
data_nasterii date default sysdate,
constraint FKey_idAdresaPacient foreign key(id_adresa)
references adresa(id_adresa)
);

/*CREAREA TABELEI CONSULTATIE*/
create table CONSULTATIE
(idConsultatie number(4) 
constraint PKey_idConsultatie primary key,
idPacient number(4), 
idMedic number(4), idAsistent number(4),
data_consultatie date default sysdate,
pret number(3), servicii varchar2(30),
constraint FKey_idPacient foreign key(idPacient)
references PACIENT(idPacient),
constraint FKey_idMedic foreign key(idMedic) 
references MEDIC(idMedic),
constraint FKey_idAsistent foreign key(idAsistent) 
references ASISTENT(idAsistent)
);
/* SA SE ADAUGE RESTRICTIA CA EMAIL-UL SA CONTINA "@" SI MAI APOI "gmail.com" sau "yahoo.com"*/

alter table pacient add constraint CK_EMAIL check (EMAIL like '%@gmail.com' or EMAIL like '%yahoo.com');

/*SA SE VERIFICE CA FIECARE NUMAR DE TELEFON ESTE UNIC, ATAT PENTRU PACIENTI CAT SI PENTRU ANGAJATI*/

alter table pacient add constraint UK_TELEFON_Pacient unique(telefon);
alter table angajat add constraint UK_TELEFON_Angajat unique(numar_telefon);

/*SA SE ADAUGE RESTRICTIA ASTFEL INCAT SALARIUL ANGAJATULUI SA NU FIE NULL*/
alter table angajat modify salariu not null;

/*SA SE ADAUGE O RESTRICTIE CARE SA VERIFICE CA TIPUL DE SERVICII PENTRU O CONSULTATIE SA FIE IN URMATOAREA LISTA: {CONSULTATIE, ANALIZE, OPERATIE}*/

alter table CONSULTATIE add constraint CH_SERVICII check ( SERVICII IN ('analize','operatie', 'consultatie'));

/*SA SE ADAUGE O RESTRICTIE CARE SA VERIFICE CA NIVELUL DE STUDII PENTRU UN ANGAJAT FIE IN URMATOAREA LISTA: {LICENTA, MASTER, DOCTORAT}*/
alter table ANGAJAT add constraint CH_NivelStudii check ( NIVEL_PREGATIRE IN ('Licenta','Masterat', 'Doctorat'));

/*SA SE ADAUGE O RESTRICTIE CARE SA VERIFICE CA SPECIALIZAREA MEDICULUI ESTE IN URMATOAREA LISTA: {PEDIATRU, OCOLOG, ORTOPED, MEDIC GENERALIST, UROLOG, DERMATOLOG, NEUROLOG, NEFROLOG, GASTROENTEROLOG, RADIOLOG, CARDIOLOG, CHIRURG, REUMATOLOG}*/
alter table MEDIC add constraint CH_Specializare check ( 
SPECIALIZARE IN ('oncolog', 'pediatru', 'ortoped',
'medic generalist', 'urolog', 'dermatolog', 'neurolog',
'nefrolog', 'gastroenterolog', 'radiolog', 'cardiolog',
'chirurg', 'reumatolog', 'oftalmolog'));

alter table MEDIC drop constraint CH_Specializare;
/*SA SE ACTIVEZE SI SA SE DEZACTIVEZE CONSTRANGEREA CA SPECIALIZAREA MEDICULUI SA SE REGASEASCA IN LISTA*/
alter table MEDIC disable constraint CH_Specializare;
alter table MEDIC enable constraint CH_Specializare;

/*SA SE ELIMINE SI SA SE ADAUGE LA LOC EMAIL-UL PENTRU FIECARE PACIENT*/
alter table PACIENT drop constraint CK_EMAIL;
alter table PACIENT drop column EMAIL;
alter table PACIENT add EMAIL VARCHAR2(30);
alter table PACIENT add constraint CK_EMAIL check (EMAIL like '%@gmail.com' or EMAIL like '%yahoo.com');

/*SA SE ADAUGE CAMPUL DE BLOC, ETAJ SI APARTAMENT PENTRU TABELA ADRESA*/
alter table ADRESA add numar_bloc number(4);
alter table ADRESA add apartament number(4);
alter table ADRESA add etaj number(4);
/*ADAUGAREA COLONEI DE ORA IN TABELA CONSULTATIE*/
alter table consultatie add ora number(3);

/*ADAUGAREA RESTRICTIEI DE INTERVAL ORAR PENTRU PROGRAMAREA CONSULTATIILOR IN PROGRAMUL DE MUNCA (ORA 8 PANA LA 21)*/
alter table consultatie add constraint CK_ORA check(ora >= 8 and ora <= 21);


/* POPULARE TABELA ADRESA*/
insert into adresa values(1, 'Romania', 'Bucuresti', 'Strada Sperantei', 3, 51, 14, 4);
insert into adresa values(2, 'Romania', 'Bucuresti', 'Aleea Gornesti', 1, 56, 9,5);
insert into adresa values(3, 'Romania', 'Ilfov', 'Strada Leordeni', 15, 34, 5, 7);
insert into adresa values(4, 'Romania', 'Bucuresti', 'Strada Lacramioarei', 4, 6, 7, 8);
insert into adresa values(5, 'Romania', 'Bucuresti', 'Aleea Ghioceilor', 13, 77, 66, 9);
insert into adresa values(6, 'Romania', 'Bucuresti', 'Strada Gheorghe Posu', 43, 85, 3, 10);
insert into adresa values(7, 'Romania', 'Bucuresti', 'Bulevardul Roman', 33, 56, 206, 4);
insert into adresa values(8, 'Romania', 'Bucuresti', 'Strada Tudor Arghezi', 23, 78, 5, 3);
insert into adresa values(9, 'Romania', 'Bucuresti', 'Aleea Bucuriei', 33, 30, 204, 2);
insert into adresa values(10, 'Romania', 'Bucuresti', 'Drumul Binelui', 49, 67, 709, 1);
insert into adresa values(11, 'Romania', 'Bucuresti', 'Strada Simfoniei', 1, 43,54, 9);
insert into adresa values(12, 'Romania', 'Bucuresti', 'Drumul Caprei', 11, 54, 54, 5);
insert into adresa values(13, 'Romania', 'Bucuresti', 'Bulevardul Magheru', 24, 53, 279, 3);
insert into adresa values(14, 'Romania', 'Bucuresti', 'Strada Artei', 98, 57, 87, 9);
insert into adresa values(15, 'Romania', 'Bucuresti', 'Bulevardul Iorga', 99, 109, 113, 7);
insert into adresa values(16, 'Romania', 'Bucuresti', 'Bulevardul Victoriei', 76, 57, 34, 8);
insert into adresa values(17, 'Romania', 'Bucuresti', 'Strada Basmului', 6, 43, 233, 6);
insert into adresa values(18, 'Romania', 'Bucuresti', 'Strada Carpe', 7, 43,3, 4);
insert into adresa values(19, 'Romania', 'Bucuresti', 'Aleea Brumei', 5, 232, 54, 7);
insert into adresa values(20, 'Romania', 'Bucuresti', 'Strada Sperantei', 2, 545,3, 9);
insert into adresa values(21, 'Romania', 'Bucuresti', 'Strada Muzeelor', 1, 54, 2, 10);
insert into adresa values(22, 'Romania', 'Bucuresti', 'Bulevardul Ghioceilor', 7, 67,54, 5);
insert into adresa values(23, 'Romania', 'Bucuresti', 'Strada Frima', 5, 76, 122, 2);
insert into adresa values(24, 'Romania', 'Bucuresti', 'Aleea Fermei', 8, 65, 90, 3);
insert into adresa values(25, 'Romania', 'Bucuresti', 'Strada Tarna', 46, 89, 306, 5);
insert into adresa values(26, 'Romania', 'Bucuresti', 'Drumul Jiului', 23, 67, 103, 6);
insert into adresa values(27, 'Romania', 'Bucuresti', 'Strada Carpati', 12, 78, 409, 8);
insert into adresa values(28, 'Romania', 'Bucuresti', 'Strada Frezilor', 70, 78, 23, 10);
insert into adresa values(29, 'Romania', 'Bucuresti', 'Bulevardul Vinului', 6, 90, 43, 3);
insert into adresa values(30, 'Romania', 'Bucuresti', 'Strada Soarelui', 3, 56, 7, 2);
insert into adresa values(31, 'Romania', 'Bucuresti', 'Strada Sarmei', 4, 34, 5, 1);
insert into adresa values(32, 'Romania', 'Bucuresti', 'Aleea Trandafirilor', 14, 32, 43, 6);
insert into adresa values(33, 'Romania', 'Bucuresti', 'Strada Castelului', 12, 89, 4, 7);
insert into adresa values(34, 'Romania', 'Bucuresti', 'Strada Pliului', 5, 37, 43, 8);
insert into adresa values(35, 'Romania', 'Bucuresti', 'Strada Viorilor', 4, 107, 78, 9);
insert into adresa values(36, 'Romania', 'Bucuresti', 'Bulevardul Martirilor', 7, 67,54, 10);
insert into adresa values(37, 'Romania', 'Bucuresti', 'Strada Gazelelor', 5, 76, 122, 4);
insert into adresa values(38, 'Romania', 'Bucuresti', 'Aleea Crivnitei', 8, 65, 90, 6);
insert into adresa values(39, 'Romania', 'Bucuresti', 'Strada Taranuluu', 46, 89, 306, 7);
insert into adresa values(40, 'Romania', 'Bucuresti', 'Drumul Carului', 23, 67, 103, 8);
insert into adresa values(41, 'Romania', 'Bucuresti', 'Strada Leonida', 12, 78, 409, 9);
insert into adresa values(42, 'Romania', 'Bucuresti', 'Strada Aparatorilor', 70, 78, 23, 10);
insert into adresa values(43, 'Romania', 'Bucuresti', 'Bulevardul Harghitei', 6, 90, 43, 6);
insert into adresa values(44, 'Romania', 'Bucuresti', 'Strada Marasesti', 3, 56, 7, 3);
insert into adresa values(45, 'Romania', 'Bucuresti', 'Strada Dardanele', 4, 34, 5, 2);
insert into adresa values(46, 'Romania', 'Bucuresti', 'Aleea Razboinicilor', 14, 32, 43, 1);
insert into adresa values(47, 'Romania', 'Bucuresti', 'Strada Bobocilor', 12, 89, 4, 6);
insert into adresa values(48, 'Romania', 'Bucuresti', 'Strada Tudor Vianu', 5, 37, 43, 8);
insert into adresa values(49, 'Romania', 'Bucuresti', 'Strada Mihai Eminescu', 4, 107, 78, 7);
insert into adresa values(50, 'Romania', 'Bucuresti', 'Bulevardul Bogdan Baleanu', 7, 67,54, 9);
insert into adresa values(51, 'Romania', 'Bucuresti', 'Strada Stefan Cel Mare', 5, 76, 122, 10);
insert into adresa values(52, 'Romania', 'Bucuresti', 'Aleea Gaitei', 8, 65, 90, 6);
insert into adresa values(56, 'Romania', 'Bucuresti', 'Strada Dragostei', 46, 89, 306, 7);
insert into adresa values(57, 'Romania', 'Bucuresti', 'Drumul Ion Miulescu', 23, 67, 103, 8);
insert into adresa values(58, 'Romania', 'Bucuresti', 'Strada Nora Iuga', 12, 78, 409, 4);
insert into adresa values(59, 'Romania', 'Bucuresti', 'Strada Dumbrava Constantin', 70, 78, 23, 10);
insert into adresa values(60, 'Romania', 'Bucuresti', 'Bulevardul Sampaniei', 6, 90, 43, 9);
insert into adresa values(61, 'Romania', 'Bucuresti', 'Strada Soarelui', 3, 56, 7, 8);
insert into adresa values(62, 'Romania', 'Bucuresti', 'Strada Tudor Vladimirescu', 4, 34, 5, 5);
insert into adresa values(63, 'Romania', 'Bucuresti', 'Aleea Gardienilor', 14, 32, 43, 3);
insert into adresa values(64, 'Romania', 'Bucuresti', 'Strada Hyperion', 12, 89, 4, 4);
insert into adresa values(65, 'Romania', 'Bucuresti', 'Strada Alexandrescu', 5, 37, 43, 8);
insert into adresa values(66, 'Romania', 'Bucuresti', 'Strada Radulescu', 4, 107, 78, 7);
insert into adresa values(67, 'Romania', 'Bucuresti', 'Bulevardul Mihai Ionescu', 7, 67,54, 2);
insert into adresa values(68, 'Romania', 'Bucuresti', 'Strada Matei Basarab', 5, 76, 122, 1);
insert into adresa values(69, 'Romania', 'Bucuresti', 'Aleea Victor Babes', 8, 65, 90, 3);
insert into adresa values(70, 'Romania', 'Bucuresti', 'Strada Durdulanda', 46, 89, 306, 6);
insert into adresa values(71, 'Romania', 'Bucuresti', 'Drumul Chirpes', 23, 67, 103, 5);
insert into adresa values(72, 'Romania', 'Bucuresti', 'Strada Tapului', 12, 78, 409, 2);
insert into adresa values(73, 'Romania', 'Bucuresti', 'Strada Ferdinand I', 70, 78, 23, 9);
insert into adresa values(74, 'Romania', 'Bucuresti', 'Bulevardul Ferdinand II', 6, 90, 43, 10);
insert into adresa values(75, 'Romania', 'Bucuresti', 'Strada Vlad Tepes', 3, 56, 7, 7);
insert into adresa values(76, 'Romania', 'Bucuresti', 'Strada Ferdinand III', 4, 34, 5, 5);
insert into adresa values(77, 'Romania', 'Bucuresti', 'Aleea Matei Barbu', 14, 32, 43, 8);
insert into adresa values(78, 'Romania', 'Bucuresti', 'Strada Bacovia', 12, 89, 4,9);
insert into adresa values(79, 'Romania', 'Bucuresti', 'Strada Cantecului', 5, 37, 43,4);
insert into adresa values(80, 'Romania', 'Bucuresti', 'Strada Verilor', 4, 107, 78, 3);
insert into adresa values(81, 'Romania', 'Bucuresti', 'Bulevardul Merilor', 7, 67,54, 8);
insert into adresa values(82, 'Romania', 'Bucuresti', 'Strada Fierului', 5, 76, 122, 9);
insert into adresa values(83, 'Romania', 'Bucuresti', 'Aleea Carpatina', 8, 65, 90, 10);
insert into adresa values(84, 'Romania', 'Bucuresti', 'Strada Turnului', 46, 89, 306, 10);
insert into adresa values(85, 'Romania', 'Bucuresti', 'Drumul Cernei', 23, 67, 103, 8);
insert into adresa values(86, 'Romania', 'Bucuresti', 'Strada Cornului', 12, 78, 409, 9);
insert into adresa values(87, 'Romania', 'Bucuresti', 'Strada Falnic', 70, 78, 23, 5);
insert into adresa values(88, 'Romania', 'Bucuresti', 'Bulevardul Vernil', 6, 90, 43,3);
insert into adresa values(89, 'Romania', 'Bucuresti', 'Strada Sorin Dobrescu', 3, 56, 7, 6);
insert into adresa values(90, 'Romania', 'Bucuresti', 'Strada Sinestras', 4, 34, 5, 7);
insert into adresa values(91, 'Romania', 'Bucuresti', 'Aleea Turtei', 14, 32, 43, 8);
insert into adresa values(92, 'Romania', 'Bucuresti', 'Strada Uliului', 12, 89, 4, 9);
insert into adresa values(93, 'Romania', 'Bucuresti', 'Strada Elnei', 5, 37, 43, 10);
insert into adresa values(94, 'Romania', 'Bucuresti', 'Strada Vireu', 4, 107, 78, 6);
insert into adresa values(95, 'Romania', 'Bucuresti', 'Strada Capricornului', 4, 34, 5, 7);
insert into adresa values(96, 'Romania', 'Bucuresti', 'Aleea Varsatorului', 14, 32, 43, 8);
insert into adresa values(97, 'Romania', 'Bucuresti', 'Strada Carpatinelor', 12, 89, 4, 3);
insert into adresa values(98, 'Romania', 'Bucuresti', 'Strada Pontelius', 5, 37, 43, 7);
insert into adresa values(99, 'Romania', 'Bucuresti', 'Strada Silvestru', 4, 107, 78, 9);



/* POPULARE TABELA ANGAJAT*/
insert into angajat values(1, 'Constantin', 'Andreea', 5000, 'Masterat', '0727590226', 'costareebsbwa@gmail.com', to_date('28/01/2003','dd/mm/yyyy'), 1, 56);
insert into angajat values(2, 'Carasel', 'Valeriu', 3000, 'Licenta', '0727390246', 'ce45e4tea@gmail.com', to_date('24/01/2021','dd/mm/yyyy'), 35, 1);
insert into angajat values(3, 'Caravan', 'Elena', 2000, 'Licenta', '0727520246', 'cost4e5ee545wa@gmail.com', to_date('23/04/2021','dd/mm/yyyy'), 2, 10);
insert into angajat values(4, 'Chiriac', 'Madalina', 8000, 'Masterat', '0747590326', 'cose45e45a@gmail.com', to_date('26/12/2004','dd/mm/yyyy'), 2, 55);
insert into angajat values(5, 'Tudor', 'Oana', 9000, 'Masterat', '0727390426', 'c4e5e45bwa@gmail.com', to_date('20/02/2013','dd/mm/yyyy'), 3, 54);
insert into angajat values(6, 'Constantin', 'Daniel', 4000, 'Licenta', '0327540226', 'ertw4tsbwa@gmail.com', to_date('18/11/2013','dd/mm/yyyy'), 4, 53);
insert into angajat values(7, 'Diaconescu', 'Maria', 4000, 'Masterat', '0724590426', 'te44te4tbwa@gmail.com', to_date('30/01/2007','dd/mm/yyyy'), 5, 52);
insert into angajat values(8, 'Deaconu', 'Alina', 5000, 'Masterat', '0727490426', 'ct4ee4ta@gmail.com', to_date('18/12/2015','dd/mm/yyyy'), 6, 51);
insert into angajat values(9, 'Stanescu', 'Adela', 5000, 'Masterat', '0727555226', 'tetetwa@gmail.com', to_date('28/08/2019','dd/mm/yyyy'), 7, 50);
insert into angajat values(10, 'Stoenescu', 'Ana', 6000, 'Masterat', '0727596264', 'certerta@gmail.com', to_date('02/10/2003','dd/mm/yyyy'), 8, 49);
insert into angajat values(11, 'Grigore', 'Diana', 6000, 'Masterat', '0724590256', 'rtags@gmail.com', to_date('01/01/2003','dd/mm/yyyy'), 9, 48);
insert into angajat values(12, 'Safaru', 'Cosmin', 5000, 'Masterat', '0727550526', 'bwadrgdr@gmail.com', to_date('16/03/2019','dd/mm/yyyy'), 11, 47);
insert into angajat values(13, 'Popescu', 'Simona', 5000, 'Masterat', '0707595226', 'crd564ge5w5a@gmail.com', to_date('21/04/2013','dd/mm/yyyy'), 12, 46);
insert into angajat values(14, 'Dumitrescu', 'Vlad', 8000, 'Masterat', '0720590126', '54erdggdra@gmail.com', to_date('18/07/2018','dd/mm/yyyy'), 13, 45);
insert into angajat values(15, 'Sfetcu', 'Grigoras', 5000, 'Masterat', '0727191216', 'drrdgsbwa@gmail.com', to_date('09/11/2017','dd/mm/yyyy'), 14, 44);
insert into angajat values(16, 'Scafaru', 'Antonia', 6000, 'Masterat', '0727190345', 'stadgdreebsbwa@gmail.com', to_date('11/02/2022','dd/mm/yyyy'), 15, 43);
insert into angajat values(17, 'Elen', 'Paula', 3000, 'Licenta', '0725590123', 'cdgdra@gmail.com', to_date('21/01/2016','dd/mm/yyyy'), 16, 42);
insert into angajat values(18, 'Symeonidis', 'Oana', 2000, 'Licenta', '0727577726', 'drgdrbsfthbwa@gmail.com', to_date('17/11/2019','dd/mm/yyyy'), 17, 41);
insert into angajat values(19, 'Telespan', 'Laura', 2000, 'Licenta', '0727550626', 'agsgdhfa@gmail.com', to_date('30/09/2009','dd/mm/yyyy'), 18, 40);
insert into angajat values(20, 'Telespan', 'Claudia', 4000, 'Masterat', '0777895226', 'fdhftsbwa@gmail.com', to_date('12/01/2013','dd/mm/yyyy'), 19, 39);
insert into angajat values(21, 'Sandulescu', 'Daria', 6000, 'Masterat', '0727590626', 'cgfheebsbwa@gmail.com', to_date('15/04/2019','dd/mm/yyyy'), 20, 38);
insert into angajat values(22, 'Dobrincu', 'Sebastian', 3000, 'Licenta', '0727560226', 'costargfhfheebsbwa@gmail.com', to_date('05/08/2006','dd/mm/yyyy'), 21, 37);
insert into angajat values(23, 'Georgian', 'Alexandru', 4000, 'Masterat', '0724590226', 'costareebwa@gmail.com', to_date('09/03/2004','dd/mm/yyyy'), 22, 36);
insert into angajat values(24, 'Visan', 'Rares', 7000, 'Masterat', '0727590676', 'costafghfghfreebsbwa@gmail.com', to_date('12/03/2019','dd/mm/yyyy'), 23, 35);
insert into angajat values(25, 'Semanti', 'Bogdan', 9000, 'Masterat', '0727590126', 'costareebsbwa@gmail.com', to_date('19/06/2022','dd/mm/yyyy'), 24, 34);
insert into angajat values(26, 'Pandone', 'Claudiu', 5000, 'Masterat', '0727590006', 'costareebgfhfsbwa@gmail.com', to_date('19/07/2020','dd/mm/yyyy'), 25, 22);
insert into angajat values(27, 'Margineanu', 'Matei', 4000, 'Masterat', '07270000000', 'costareebsbfghfgwa@gmail.com', to_date('08/05/2015','dd/mm/yyyy'), 26, 32);
insert into angajat values(28, 'Munteanu', 'Cristian', 6000, 'Masterat', '0757550255', 'costaredhdfebsbwa@gmail.com', to_date('02/02/2017','dd/mm/yyyy'), 27, 31);
insert into angajat values(29, 'Molnar', 'Alexandra', 4000, 'Masterat', '0727901314', 'fdhdcostareebsbwa@gmail.com', to_date('12/05/2016','dd/mm/yyyy'), 28, 30);
insert into angajat values(30, 'Stanica', 'Alexandru', 3000, 'Masterat', '0729092949', 'cosdfhdhtareebsbwa@gmail.com', to_date('18/12/2005','dd/mm/yyyy'), 29, null);
insert into angajat values(31, 'Lazar', 'Tiberiu', 8000, 'Masterat', '0727533326', 'costafhdhreebsbwa@gmail.com', to_date('27/11/2000','dd/mm/yyyy'), 30, null);
insert into angajat values(32, 'Nistor', 'Cosmin', 3000, 'Masterat', '0727590666', 'costareebsbwa@gmail.com', to_date('21/03/2013','dd/mm/yyyy'), 31, null);
insert into angajat values(33, 'Stanciu', 'Andrei', 6000, 'Masterat', '0727590999', 'costareebsbwhdfa@gmail.com', to_date('05/07/2003','dd/mm/yyyy'), 32, null);
insert into angajat values(34, 'Vrincut', 'Paul', 2000, 'Licenta', '0727590000', 'costareebsbhfdfdwa@gmail.com', to_date('09/06/2022','dd/mm/yyyy'), 33, null);
insert into angajat values(35, 'Antonescu', 'Gabriela', 9000, 'Masterat', '0727980226', 'costareebsbwa@gmail.com', to_date('22/02/2022','dd/mm/yyyy'), 34, null);
insert into angajat values(36, 'Stangaciu', 'Loredana', 9000, 'Masterat', '0736390226', 'costareebsbwa@gmail.com', to_date('07/07/2007','dd/mm/yyyy'), 35, null);
insert into angajat values(37, 'Hingan', 'Iulia', 3000, 'Masterat', '0727590333', 'cofdhfebsbwa@gmail.com', to_date('25/01/2007','dd/mm/yyyy'), 14, null);
insert into angajat values(38, 'Ivan', 'Maria', 4000, 'Masterat', '0727556326', 'costafdhfbwa@gmail.com', to_date('28/04/2003','dd/mm/yyyy'), 15, null);
insert into angajat values(39, 'Gont', 'Vlad', 5000, 'Masterat', '0727595636', 'costebsbwa@gmail.com', to_date('23/08/2003','dd/mm/yyyy'), 16, null);
insert into angajat values(40, 'Baltac', 'Cristian', 5000, 'Masterat', '0727770226', 'cosfhdtsbwa@gmail.com', to_date('10/01/2022','dd/mm/yyyy'), 17, null);
insert into angajat values(41, 'Crudu', 'Cristian', 5000, 'Masterat', '0727575426', 'efhbsbwa@gmail.com', to_date('27/03/2021','dd/mm/yyyy'), 18, null);
insert into angajat values(42, 'Horatiu', 'Valentin', 7000, 'Masterat', '0727588226', 'fdhdfebsbwa@gmail.com', to_date('21/05/2021','dd/mm/yyyy'), 19, null);
insert into angajat values(43, 'Chetran', 'Erika', 8000, 'Masterat', '0727590288', 'costdfhwa@gmail.com', to_date('20/03/2013','dd/mm/yyyy'), 20, null);
insert into angajat values(44, 'Ciausecu', 'Mircea', 9000, 'Masterat', '0727690296', 'costahdfhwa@gmail.com', to_date('19/01/2016','dd/mm/yyyy'), 33, null);
insert into angajat values(45, 'Danila', 'Daniel', 8000, 'Masterat', '0727590326', 'cosdfha@gmail.com', to_date('18/09/2017','dd/mm/yyyy'), 5, null);
insert into angajat values(46, 'Mazilu', 'Mircea', 7000, 'Masterat', '0727591226', 'codfwa@gmail.com', to_date('08/03/2000','dd/mm/yyyy'), 5, null);
insert into angajat values(47, 'Gologan', 'Alexandra', 5000, 'Masterat', '0727111111', 'fdhcfdhsbwa@gmail.com', to_date('10/11/2012','dd/mm/yyyy'), 2, null);
insert into angajat values(48, 'Cristescu', 'Eduard', 8000, 'Masterat', '0727101216', 'fdhfdhdf@gmail.com', to_date('02/07/2022','dd/mm/yyyy'), 1, null);
insert into angajat values(49, 'Popoiu', 'Raluca', 7000, 'Masterat', '0721510121', 'rdgdrwa@gmail.com', to_date('09/04/2021','dd/mm/yyyy'), 18, null);
insert into angajat values(50, 'Popoiu', 'Diana', 8000, 'Masterat', '0721591126', 'rdhdfuu5wa@gmail.com', to_date('23/09/2013','dd/mm/yyyy'), 19, null);
insert into angajat values(51, 'Olaru', 'George', 9000, 'Masterat', '0727530223', '54rdgdrg@gmail.com', to_date('12/12/2012','dd/mm/yyyy'), 30, null);
insert into angajat values(52, 'Paloiu', 'Cristiana', 8000, 'Masterat', '0777590226', 'rdhht5bwa@gmail.com', to_date('13/03/2013','dd/mm/yyyy'), 20, null);
insert into angajat values(53, 'Cirstian', 'Diana', 7000, 'Masterat', '0727575226', '5yergd5ysbwa@gmail.com', to_date('08/08/2008','dd/mm/yyyy'), 20, null);
insert into angajat values(54, 'Badea', 'Mircea', 4000, 'Masterat', '0727590799', 'tfhfthfsbwa@gmail.com', to_date('05/05/2005','dd/mm/yyyy'), 30, null);
insert into angajat values(55, 'Foriu', 'Tristian', 3000, 'Licenta', '0727587826', 'tfhftthwa@gmail.com', to_date('03/03/2003','dd/mm/yyyy'), 16, null);
insert into angajat values(56, 'Verni', 'Stoi', 3000, 'Licenta', '0727590001', 'fhttfhftbwa@gmail.com', to_date('22/01/2013','dd/mm/yyyy'), 19, null);


/* POPULARE TABELA MEDIC*/
insert into medic values(1, 56, 'pediatru', 30);
insert into medic values(2, 55, 'pediatru', 29);
insert into medic values(3, 54, 'oncolog', 28);
insert into medic values(4, 53, 'ortoped', 27);
insert into medic values(5, 52, 'medic generalist', 26);
insert into medic values(6, 51, 'medic generalist', 25);
insert into medic values(7, 50, 'urolog', 24);
insert into medic values(8, 49, 'neurolog', 23);
insert into medic values(9, 48, 'urolog', 22);
insert into medic values(10, 47, 'dermatolog', 21);
insert into medic values(11, 46, 'dermatolog', 20);
insert into medic values(12, 45, 'nefrolog', 19);
insert into medic values(13, 44, 'nefrolog', 18);
insert into medic values(14, 43, 'gastroenterolog', 17);
insert into medic values(15, 42, 'gastroenterolog', 16);
insert into medic values(16, 41, 'oftalmolog', 15);
insert into medic values(17, 40, 'oftalmolog', 14);
insert into medic values(18, 39, 'oftalmolog', 13);
insert into medic values(19, 38, 'radiolog', 12);
insert into medic values(20, 37, 'radiolog', 11);
insert into medic values(21, 36, 'cardiolog', 10);
insert into medic values(22, 35, 'cardiolog', 9);
insert into medic values(23, 34, 'chirurg', 8);
insert into medic values(24, 33, 'cardiolog', 7);
insert into medic values(25, 32, 'reumatolog', 6);
insert into medic values(26, 31, 'chirurg', 5);
insert into medic values(27, 30, 'chirurg', 4);

/* POPULARE TABELA ASISTENT*/
insert into asistent values(1, 29, 65, 4);
insert into asistent values(2, 28, 75, 4);
insert into asistent values(3, 27, 45, 3);
insert into asistent values(4, 26, 25, 3);
insert into asistent values(5, 25, 43, 2);
insert into asistent values(6, 24, 76, 2);
insert into asistent values(7, 23, 65, 1);
insert into asistent values(8, 22, 67, 1);
insert into asistent values(9, 21, 69, 5);
insert into asistent values(10, 20, 67, 5);
insert into asistent values(11, 19, 85, 6);
insert into asistent values(12, 18, 95, 6);
insert into asistent values(13, 17, 25, 7);
insert into asistent values(14, 16, 15, 7);
insert into asistent values(15, 15, 45, 8);
insert into asistent values(16, 14, 35, 8);
insert into asistent values(17, 13, 55, 9);
insert into asistent values(18, 12, 85, 9);
insert into asistent values(19, 11, 95, 10);
insert into asistent values(20, 10, 75, 10);
insert into asistent values(21, 9, 45, 11);
insert into asistent values(22, 8, 25, 11);
insert into asistent values(23, 7, 44, 12);
insert into asistent values(24, 6, 64, 12);
insert into asistent values(25, 5, 63, 13);
insert into asistent values(26, 4, 62, 13);
insert into asistent values(27, 3, 61, 14);
insert into asistent values(28, 2, 60, 14);
insert into asistent values(29, 1, 87, 14);



/*POPULAREA TABELEI PACIENT*/
insert into pacient values(1, 'Constantin', 'Andreea', 20, '0727590226',  35,to_date('28/01/2003','dd/mm/yyyy'), 'costareebsbwa@gmail.com');
insert into pacient values(2, 'Carasel', 'Valeriu', 20,'0727550436',34, to_date('08/08/2002','dd/mm/yyyy'),'variu13@gmail.com');
insert into pacient values(3, 'Cojocaru', 'Flavius', 21,'0727698265', 33,  to_date('24/01/2002','dd/mm/yyyy'),'flaviuscojocaru@gmail.com');
insert into pacient values(4, 'Caravan', 'Elena', 20, '0727390118', 32,to_date('12/04/2003','dd/mm/yyyy'),'hellen@gmail.com');
insert into pacient values(5, 'Nicolae', 'Diana', 20,  '0727777090', 31, to_date('17/09/2003','dd/mm/yyyy'),'diananico@gmail.com');
insert into pacient values(6, 'Visan', 'Rares', 20,  '0727540281', 30, to_date('02/11/2003','dd/mm/yyyy'),'raresvisan@gmail.com');
insert into pacient values(7, 'Tudor', 'Gabriel', 20,'0737888226', 29,to_date('23/10/2003','dd/mm/yyyy'),  'tudorgabriel@gmail.com');
insert into pacient values(8, 'Mihalache', 'Gabriela', 20,'0766690226',28, to_date('29/12/2003','dd/mm/yyyy'),'gabi3004@gmail.com');
insert into pacient values(9, 'Dumitrache', 'Mihaela', 20,  '0727577277',27, to_date('09/12/2003','dd/mm/yyyy'), 'miha3002@gmail.com');
insert into pacient values(10, 'Dumitrescu', 'Daniela', 20, '0727111333', 26, to_date('06/06/2003','dd/mm/yyyy'), 'danieladumi@gmail.com');
insert into pacient values(11, 'Condurache', 'Stefan', 21, '0727490123',25, to_date('03/11/2002','dd/mm/yyyy'), 'steftoma@gmail.com');
insert into pacient values(12, 'Toma', 'Adelina', 20,'0727594444', 24,  to_date('09/06/2003','dd/mm/yyyy'),'adetoma2002@gmail.com');
insert into pacient values(13, 'Nistor', 'Ana', 20,'0721591221', 23, to_date('23/08/2003','dd/mm/yyyy'),  'ananistor@gmail.com');
insert into pacient values(14,'Catana', 'Cosmin', 20,'0727510116', 22, to_date('05/05/2003','dd/mm/yyyy'),  'cosmin2003catana@gmail.com');
insert into pacient values(15, 'Bojan', 'Paul', 20,'0727599292',21, to_date('09/09/2003','dd/mm/yyyy'),  'paulboj@gmail.com');
insert into pacient values(16, 'Popescu', 'Vlad', 20, '0729990226', 20,to_date('10/01/2003','dd/mm/yyyy'),'vladpop@gmail.com' );
insert into pacient values(17, 'Munteanu', 'Matei', 20,'0727590336', 19, to_date('28/04/2003','dd/mm/yyyy'),'mateimunti@gmail.com');
insert into pacient values(18, 'Margineanu', 'Cristian', 20,'0727532226', 18,  to_date('17/10/2003','dd/mm/yyyy'),'margicris@gmail.com');
insert into pacient values(19, 'Boja', 'Victor', 20, '0727590243',17, to_date('16/11/2003','dd/mm/yyyy'), 'vic2003@gmail.com');
insert into pacient values(20, 'Onoiu', 'Bogdan', 20,'0727597776', 16, to_date('06/04/2003','dd/mm/yyyy'), 'bogdionoiu@gmail.com');
insert into pacient values(21, 'Luca', 'Robert', 20, '0727590271', 15,to_date('13/04/2003','dd/mm/yyyy'),  'lucrob@gmail.com');
insert into pacient values(22, 'Oana', 'Horia', 20,'0727520216', 14, to_date('19/03/2003','dd/mm/yyyy') ,'horia23@gmail.com' );
insert into pacient values(23, 'Chetran', 'Theodor', 22,  '0723590226', 13,to_date('18/06/2001','dd/mm/yyyy'), 'theochetran@gmail.com');
insert into pacient values(24, 'Bagarea', 'Erika', 20,  '0727590223', 12, to_date('19/11/2003','dd/mm/yyyy'),'erika.21@gmail.com');
insert into pacient values(25, 'Ciausescu', 'Mircea', 21,'0724590526', 11 ,to_date('07/04/2002','dd/mm/yyyy'), 'mirceaciasca@gmail.com' );
insert into pacient values(26, 'Mazilu', 'Mircea', 20,'0727890826',10, to_date('09/05/2003','dd/mm/yyyy'),'mazi@gmail.com');
insert into pacient values(27, 'Anton', 'Luana', 21,  '0787598228', 9, to_date('16/09/2002','dd/mm/yyyy'),'luana2003@gmail.com');
insert into pacient values(28, 'Antonescu', 'Gabriela', 21, '0727590018',8,to_date('20/09/2002','dd/mm/yyyy'),  'gabianto28@gmail.com');
insert into pacient values(29, 'Stangaciu', 'Loredana', 22,'0727590200', 7, to_date('30/03/2001','dd/mm/yyyy'),'loristangaciu@gmail.com' );
insert into pacient values(30, 'Sfetcu', 'Grigoras', 20,'0727590101',  6, to_date('28/02/2003','dd/mm/yyyy'), 'grigo@gmail.com');
insert into pacient values(31, 'Borta', 'Rares', 20, '0727510126', 5, to_date('12/02/2003','dd/mm/yyyy'), 'rarea0828@gmail.com');
insert into pacient values(32, 'Ionescu', 'Andrei', 23, '0727540254', 4,  to_date('13/03/2000','dd/mm/yyyy'),'andreiionescu@gmail.com');

insert into pacient values(33, 'Ionescu', 'Calin', 20, '0727595257', 3,  to_date('27/07/2003','dd/mm/yyyy'),'calin2003@gmail.com');
insert into pacient values(34, 'Vasilescu', 'Gigel', 21,'0727596241', 2, to_date('24/04/2002','dd/mm/yyyy'), 'gigel33@gmail.com');
insert into pacient values(35, 'Baciu', 'Vasile', 20,'0727591219', 1,to_date('18/10/2003','dd/mm/yyyy'),  'vasilebaciu@gmail.com');
insert into pacient values(36, 'Danila', 'Daniel', 22,  '0727510215', 2, to_date('31/01/2001','dd/mm/yyyy'),'danieldanila@gmail.com');
insert into pacient values(37, 'Paunescu', 'Gabriel', 20, '0727590006',3 ,  to_date('30/12/2003','dd/mm/yyyy'),'gabiPaunescu@gmail.com');
insert into pacient values(38,'Hristache', 'Alexandra', 21, '0727550626', 4, to_date('01/08/2002','dd/mm/yyyy'), 'hristacheade@gmail.com');
insert into pacient values(39, 'Boboia', 'Tiberiu', 20, '0727490286', 5, to_date('12/11/2003','dd/mm/yyyy'),'tibibob@gmail.com');
insert into pacient values(40, 'Lazar', 'Maria', 20,'0727540256', 6, to_date('26/08/2003','dd/mm/yyyy'),  'marilazar@gmail.com');
insert into pacient values(41, 'Ivan', 'Vlad', 22, '0727590566', 7, to_date('19/11/2001','dd/mm/yyyy'),'vladivan34@gmail.com');
insert into pacient values(42, 'Gont', 'Cezin', 20,  '0727530251', 8, to_date('14/07/2003','dd/mm/yyyy'),'cezin@gmail.com');
insert into pacient values(43, 'Cupii', 'Mihai', 20, '0727990523',9, to_date('08/09/2003','dd/mm/yyyy'),'cupiimihai@gmail.com');
insert into pacient values(44, 'Baltac', 'Alexandru', 21, '0729591222',10, to_date('12/07/2002','dd/mm/yyyy'),'baltacalex@gmail.com');
insert into pacient values(45, 'Stanica', 'Andreea', 22,'0727597227',11, to_date('04/07/2001','dd/mm/yyyy'),  'andreeastanica@gmail.com');


/* POPULARE TABELA CONSULTATIE*/
insert into consultatie values(1, 45, 1, 1, to_date('12/02/2023','dd/mm/yyyy'),564, 'consultatie',14 );
insert into consultatie values(2, 44, 27, 29, to_date('12/02/2023','dd/mm/yyyy'), 900, 'operatie', 15);
insert into consultatie values(3, 43, 26, 28, to_date('12/02/2023','dd/mm/yyyy'),  900, 'operatie', 12);
insert into consultatie values(4, 42 ,25, 27, to_date('13/02/2023','dd/mm/yyyy'),300, 'analize',17);
insert into consultatie values(5, 41 ,24, 26, to_date('13/02/2023','dd/mm/yyyy'), 300, 'analize', 18);
insert into consultatie values(6, 40 ,23, 25, to_date('13/02/2023','dd/mm/yyyy'), 564, 'consultatie', 19);
insert into consultatie values(7, 39 ,22, 24, to_date('14/02/2023','dd/mm/yyyy'), 300, 'analize', 20);
insert into consultatie values(8, 38 ,21, 23, to_date('14/02/2023','dd/mm/yyyy'), 564, 'consultatie', 10);
insert into consultatie values(9, 37, 20, 22, to_date('14/02/2023','dd/mm/yyyy'), 300, 'analize', 11);
insert into consultatie values(10, 36, 19, 21, to_date('15/02/2023','dd/mm/yyyy'),564, 'consultatie', 15);
insert into consultatie values(11, 35, 18, 20, to_date('15/02/2023','dd/mm/yyyy'), 300, 'analize', 13);
insert into consultatie values(12, 34, 17, 19, to_date('15/02/2023','dd/mm/yyyy'), 564, 'consultatie', 14);
insert into consultatie values(13, 33, 16, 18, to_date('16/02/2023','dd/mm/yyyy'), 564, 'consultatie', 18);
insert into consultatie values(14, 32, 15, 17, to_date('16/02/2023','dd/mm/yyyy'), 300, 'analize', 10);
insert into consultatie values(15, 31, 14, 16, to_date('16/02/2023','dd/mm/yyyy'), 564, 'consultatie', 8);
insert into consultatie values(16, 30, 13, 15, to_date('17/02/2023','dd/mm/yyyy'), 564, 'consultatie', 9);
insert into consultatie values(17, 29 ,12, 14, to_date('17/02/2023','dd/mm/yyyy'), 300, 'analize', 8);
insert into consultatie values(18, 28, 11, 13, to_date('17/02/2023','dd/mm/yyyy'), 564, 'consultatie', 18);
insert into consultatie values(19, 27, 10, 12, to_date('18/02/2023','dd/mm/yyyy'), 564, 'consultatie', 19);
insert into consultatie values(20, 26, 9, 11, to_date('18/02/2023','dd/mm/yyyy'), 564, 'consultatie', 16);
insert into consultatie values(21, 25, 8, 10, to_date('18/02/2023','dd/mm/yyyy'), 300, 'analize', 15);
insert into consultatie values(22, 24, 7, 9, to_date('19/02/2023','dd/mm/yyyy'), 564, 'consultatie', 14);
insert into consultatie values(23, 23, 6, 8, to_date('19/02/2023','dd/mm/yyyy'), 564, 'consultatie', 13);
insert into consultatie values(24, 22, 5, 7, to_date('19/02/2023','dd/mm/yyyy'), 564, 'consultatie', 12);
insert into consultatie values(25, 21, 4, 6, to_date('20/02/2023','dd/mm/yyyy'), 300, 'analize', 11);
insert into consultatie values(26, 20, 3, 5, to_date('20/02/2023','dd/mm/yyyy'), 900, 'operatie', 10);
insert into consultatie values(27, 19, 2, 4, to_date('20/02/2023','dd/mm/yyyy'), 900, 'operatie', 8);
insert into consultatie values(28, 18, 1, 3, to_date('21/02/2023','dd/mm/yyyy'), 564, 'analize', 9);
insert into consultatie values(29, 17, 2, 2, to_date('21/02/2023','dd/mm/yyyy'), 564, 'consultatie', 10);
insert into consultatie values(30, 16, 1, 1,to_date('21/02/2023','dd/mm/yyyy'), 564, 'consultatie', 18);
insert into consultatie values(31, 15, 4, 2, to_date('22/02/2023','dd/mm/yyyy'), 300, 'analize', 19);
insert into consultatie values(32, 14, 5, 3, to_date('22/02/2023','dd/mm/yyyy'), 564, 'consultatie', 20);
insert into consultatie values(33, 13, 6, 4, to_date('22/02/2023','dd/mm/yyyy'), 564, 'consultatie', 18);
insert into consultatie values(34, 12, 7, 5, to_date('23/02/2023','dd/mm/yyyy'), 300, 'analize', 19);
insert into consultatie values(35, 11, 8, 6, to_date('23/02/2023','dd/mm/yyyy'), 564, 'consultatie', 18);
insert into consultatie values(36, 10, 9, 7, to_date('23/02/2023','dd/mm/yyyy'), 564, 'consultatie', 17);
insert into consultatie values(37, 9, 10, 8, to_date('24/02/2023','dd/mm/yyyy'), 564, 'consultatie', 16);
insert into consultatie values(38, 8, 11, 9, to_date('24/02/2023','dd/mm/yyyy'), 300, 'analize', 19);
insert into consultatie values(39, 7, 12, 10, to_date('24/02/2023','dd/mm/yyyy'), 564, 'consultatie', 18);
insert into consultatie values(40, 6, 13, 11, to_date('25/02/2023','dd/mm/yyyy'), 564, 'consultatie', 11);
insert into consultatie values(41, 5, 14, 12, to_date('25/02/2023','dd/mm/yyyy'), 300, 'analize', 10);
insert into consultatie values(42, 4, 15, 13, to_date('25/02/2023','dd/mm/yyyy'), 564, 'consultatie', 9);
insert into consultatie values(43, 3, 16, 14, to_date('26/02/2023','dd/mm/yyyy'), 300, 'analize', 8);
insert into consultatie values(44, 2, 17, 15, to_date('26/02/2023','dd/mm/yyyy'), 564, 'consultatie', 13);
insert into consultatie values(45, 1, 18, 16, to_date('26/02/2023','dd/mm/yyyy'), 300, 'analize', 14);

insert into consultatie values(46, 1, 5, 7, to_date('16/02/2023','dd/mm/yyyy'),  564, 'consultatie', 13);
insert into consultatie values(47, 2, 4, 6, to_date('23/02/2023','dd/mm/yyyy'), 300, 'analize', 12);
insert into consultatie values(48, 3, 3, 5, to_date('27/02/2023','dd/mm/yyyy'), 900, 'operatie', 11);
insert into consultatie values(49, 4, 2, 4, to_date('26/02/2023','dd/mm/yyyy'), 900, 'operatie', 10);
insert into consultatie values(50, 5, 1, 3, to_date('03/02/2023','dd/mm/yyyy'), 564, 'analize', 8);
insert into consultatie values(51, 6, 2, 2, to_date('02/02/2023','dd/mm/yyyy'), 564, 'consultatie', 17);
insert into consultatie values(52, 7, 3, 1, to_date('01/02/2023','dd/mm/yyyy'), 564, 'consultatie', 16);
insert into consultatie values(53, 8, 4, 2, to_date('12/02/2023','dd/mm/yyyy'), 300, 'analize', 15);
insert into consultatie values(54, 9, 5, 3, to_date('12/02/2023','dd/mm/yyyy'), 564, 'consultatie', 19);
insert into consultatie values(55, 10, 6, 4, to_date('08/02/2023','dd/mm/yyyy'), 564, 'consultatie', 20);
insert into consultatie values(56, 11, 7, 5, to_date('13/02/2023','dd/mm/yyyy'), 300, 'analize', 10);
insert into consultatie values(57, 10, 6, 4, to_date('08/02/2023','dd/mm/yyyy'), 564, 'consultatie', 8);
insert into consultatie values(58, 12, 7, 5, to_date('13/02/2023','dd/mm/yyyy'), 300, 'analize', 9);
insert into consultatie values(59, 13, 6, 4, to_date('08/02/2023','dd/mm/yyyy'), 564, 'consultatie', 13);
insert into consultatie values(60, 14, 7, 5, to_date('13/02/2023','dd/mm/yyyy'), 300, 'analize', 14);


insert into consultatie values(61, 1, 5, 7, to_date('16/04/2023','dd/mm/yyyy'), 564, 'consultatie', 13);
insert into consultatie values(62, 2, 4, 6, to_date('23/03/2023','dd/mm/yyyy'), 300, 'analize', 12);
insert into consultatie values(63, 3, 3, 5, to_date('27/02/2023','dd/mm/yyyy'),900, 'operatie',11);
insert into consultatie values(64, 4, 2, 4, to_date('26/10/2023','dd/mm/yyyy'), 900, 'operatie', 19);
insert into consultatie values(65, 5, 1, 3, to_date('03/09/2023','dd/mm/yyyy'), 564, 'analize', 10);
insert into consultatie values(66, 6, 2, 2, to_date('02/03/2023','dd/mm/yyyy'), 564, 'consultatie', 8);
insert into consultatie values(67, 7, 3, 1, to_date('01/10/2023','dd/mm/yyyy'), 564, 'consultatie', 9);
insert into consultatie values(68, 8, 4, 2, to_date('12/01/2023','dd/mm/yyyy'), 300, 'analize', 17);
insert into consultatie values(69, 9, 5, 3, to_date('12/02/2023','dd/mm/yyyy'), 564, 'consultatie', 16);
insert into consultatie values(70, 10, 6, 4, to_date('08/12/2023','dd/mm/yyyy'), 564, 'consultatie', 15);
insert into consultatie values(71, 11, 7, 5, to_date('13/12/2023','dd/mm/yyyy'), 300, 'analize', 14);
insert into consultatie values(72, 10, 6, 4, to_date('08/12/2023','dd/mm/yyyy'), 564, 'consultatie', 12);
insert into consultatie values(73, 12, 7, 5, to_date('13/12/2023','dd/mm/yyyy'), 300, 'analize', 13);
insert into consultatie values(74, 13, 6, 4, to_date('08/12/2023','dd/mm/yyyy'), 564, 'consultatie', 20);
insert into consultatie values(75, 14, 7, 5, to_date('13/12/2023','dd/mm/yyyy'), 300, 'analize', 16);

insert into consultatie values(76, 45, 5, 7, to_date('16/04/2023','dd/mm/yyyy'),  564, 'consultatie', 13);
insert into consultatie values(77, 44, 4, 6, to_date('23/03/2023','dd/mm/yyyy'),  300, 'analize', 15);
insert into consultatie values(78, 43, 3, 5, to_date('27/02/2023','dd/mm/yyyy'),  900, 'operatie', 14);
insert into consultatie values(79, 42, 2, 4, to_date('26/10/2023','dd/mm/yyyy'), 900, 'operatie', 17);
insert into consultatie values(80, 41, 1, 3, to_date('03/09/2023','dd/mm/yyyy'), 564, 'analize', 10);
insert into consultatie values(81, 40, 2, 2, to_date('02/03/2023','dd/mm/yyyy'), 564, 'consultatie', 8);
insert into consultatie values(82, 39, 3, 1, to_date('01/10/2023','dd/mm/yyyy'), 564, 'consultatie', 9);

/*ADAUGAREA UNEI CONSTRANGERI CARE SA FACA UNIC ID-UL ANGAJAT*/
alter table MEDIC add constraint CH_ANG_MEDIC unique(idAng);
alter table ASISTENT add constraint CH_ANG_ASISTENT unique(idAng);

/*ADAUGAREA UNEI CONSTRANGERI CARE SA FACA id-ul angajatului(tabela medic si tabela asistent), id-ul pacientului, id-ul medicului si id-ul asistentului(tabela consultatie), si id-ul adresei (tabela pacient si tabela angajat) DIFERIT DE NULL*/
alter table MEDIC modify (idAng not null);
alter table ASISTENT modify (idAng not null);
alter table ANGAJAT modify (id_adresa not null);
alter table PACIENT modify (id_adresa not null);
alter table CONSULTATIE modify (idPacient not null);
alter table CONSULTATIE modify (idMedic not null);
alter table CONSULTATIE modify (idAsistent not null);

/*SA SE SETEZE ETAJUL ASTFEL: 
ID-URILE IN INTERVALUL [1-10] -> ETAJUL 1
ID-URILE IN INTERVALUL (10-20] -> ETAJUL 2
ID-URILE IN INTERVALUL (20-30] -> ETAJUL 3
ID-URILE IN INTERVALUL (30-40] -> ETAJUL 4
ID-URILE IN INTERVALUL (40-50] -> ETAJUL 5
ID-URILE IN INTERVALUL (50-60] -> ETAJUL 6
ID-URILE IN INTERVALUL (60-70] -> ETAJUL 7
ID-URILE IN INTERVALUL (70-80] -> ETAJUL 8
ID-URILE IN INTERVALUL (80-90] -> ETAJUL 9
ID-URILE IN INTERVALUL (90-100] -> ETAJUL 10
*/
update adresa set etaj = 1 
where id_adresa>=1 and id_adresa<=10;
update adresa set etaj = 2 
where id_adresa>10 and id_adresa<=20;
update adresa set etaj = 3
where id_adresa>20 and id_adresa<=30;
update adresa set etaj = 4
where id_adresa>30 and id_adresa<=40;
update adresa set etaj = 5 
where id_adresa>40 and id_adresa<=50;
update adresa set etaj = 6 
where id_adresa>50 and id_adresa<=60;
update adresa set etaj = 7 
where id_adresa>60 and id_adresa<=70;
update adresa set etaj = 8 
where id_adresa>70 and id_adresa<=80;
update adresa set etaj = 9 
where id_adresa>80 and id_adresa<=90;
update adresa set etaj = 10 
where id_adresa>90 and id_adresa<=100;


/*SA SE MODIFICE TIPUL COLOANEI EMAIL, DE TIP VARCHAR2(50)*/
alter table pacient
modify (email VARCHAR2(50));

/*STERGETI TABELA PACIENT SI CONSTRAINT-URILE ACESTEIA, IAR MAI APOI RECUPERATILE*/
drop table PACIENT cascade constraints;
flashback table PACIENT to before drop;

/*SA SE STEARGA ADRESELE CARE NU SE INTALNESC LA NICIUN PACIENT SAU LA NICIUN ANGAJAT*/
delete from ADRESA
where id_adresa not in(select id_adresa from PACIENT) 
or id_adresa not in(select id_adresa from ANGAJAT);

/*SA SE AFISEZE INFORMATIILE DISPONIBILE PENTRU PACIENTUL CU ID-UL 3*/
select * from pacient 
where idPacient = 3;


/*SA SE AFISEZE NUMELE, PRENUMELE SI SALARIUL ANGAJATULUI CU SALARIUL CUPRINS INTRE 3000 SI 4000 DE RONI*/

select nume, prenume, salariu from angajat 
where salariu between 3000 and 4000;

/*SA SE AFISEZE NUMELE, PRENUMELE SI SPECIZLIZAREA MEDICULUI CU DATA ANGAJARII INAINTE DE 2008*/

select a.nume, a.prenume, m.specializare from medic m, angajat a
where  a.idAng = m.idAng and extract (year from a.data_angajare)<2008;

/*Sã se afi?eze toate informa?iile legate de toate consulta?iile mai pu?in cele 
cu tip de servicii “analize”, ordonate descrescãtor, în func?ie de pre?ul acestora. */

select * from consultatie where servicii<>'analize' order by pret desc;

/*Sã se afi?eze numele, prenumele ?i strada pe care acesta locuie?te, împreunã cu tipul serviciului solicitate în cadrul consulta?iei recent programate.*/
select nume || ' ' || prenume || ' locuieste pe strada ' || strada 
|| ', nr.' || numar || 
' si este programat in cadrul centrului medical pentru ' || servicii 
from pacient p, adresa a, consultatie c
where p.idConsultatie = c.idConsultatie and p.id_adresa = a.id_adresa;


/*
Sa se calculeze diferit discountul aferent fiecarei consultatii pentru pacientii clinicii astfel:
•	daca pacientul a fost programat la o singura consultatie atunci discountul este de 10% ;
•	daca pacientul a fost programat la doua consultatii atunci discountul este de 15%; 
•	daca pacientul a fost programat la trei consultatii atunci discountul este de 20%.
Din acestea sa se elimine inregistrarile incheiate de clientii care incep cu litera c. 
*/

select p.nume || ' ' || p.prenume, 
(case when count(c.idPacient)=1 then 0.1
when count(c.idPacient)=2 then 0.15
when count(c.idPacient)>=3 then 0.2
else 0 end) discount
from consultatie c, pacient p
where c.idPacient=p.idPacient
group by p.prenume, p.nume
minus
select p.nume || ' ' || p.prenume, 
(case when count(c.idPacient)=1 then 0.1
when count(c.idPacient)=2 then 0.15
when count(c.idPacient)>=3 then 0.2
else 0 end) discount
from consultatie c, pacient p
where c.idPacient=p.idPacient and nume like 'C%'
group by p.prenume, p.nume;

/*
3) Sa se calculeze distinct bonusul de salariu pentru asistentii centrului medical, dupa urmatoarea formula:
•	Daca este inregistrat la mai mult de 2 consultatii bonusul salarial va fi de 300 RON;
•	Daca este inregistrat la mai mult de 4 consultatii bonusul salarial va fi de 500 RON;
•	Daca este inregistrat la mai mult de 6 consultatii bonusul salarial va fi de 1000 RON;
*/

select ang.nume || ' ' || ang.prenume,
(case
when count(c.idAsistent)>=6 then 1000
when count(c.idAsistent)>=4 then 500
when count(c.idAsistent)>=2 then 300
else 0 end
) bonus_salarial
FROM asistent a, consultatie c, angajat ang
WHERE a.idAsistent = c.idAsistent
and a.idAng=ang.idAng
GROUP BY ang.nume, ang.prenume;


/*

Sã se calculeze salariul complet al asistentilor centrului medical, astfel încât 
fiecare prime?te la salariul normal un bonus. În func?ie de numãrul de 
consulta?ii ?inute, bonusul se calculeazã astfel:
- Dacã este înregistrat la mai mult de 2 consulta?ii bonusul 
salarial va fi de 300 RON;
- Dacã este înregistrat la mai mult de 4 consulta?ii bonusul 
salarial va fi de 500 RON;
- Dacã este înregistrat la mai mult de 6 consulta?ii bonusul 
salarial va fi de 1000 RON.
- Dacã nu se încadreazã în regulile de mai sus, bonusul va fi 0. 

*/

select ang.nume || ' ' ||ang.prenume, count(c.idAsistent) numar_consultatii, 
(1000 + ang.salariu) as salariu_complet
from angajat ang, consultatie c, asistent a
where ang.idAng = a.idAng
and c.idAsistent = a.idAsistent
group by ang.nume, ang.prenume, ang.salariu
having count(c.idAsistent)>=6
UNION 
select ang.nume || ' ' ||ang.prenume, count(c.idAsistent) numar_consultatii, 
(500+ ang.salariu) as salariu_complet
from angajat ang, consultatie c, asistent a
where ang.idAng = a.idAng
and c.idAsistent = a.idAsistent
group by ang.nume, ang.prenume, ang.salariu
having count(c.idAsistent) in (4, 5) 
UNION
select ang.nume || ' ' ||ang.prenume, count(c.idAsistent) numar_consultatii, 
(300 + ang.salariu) as salariu_complet
from angajat ang, consultatie c, asistent a
where ang.idAng = a.idAng
and c.idAsistent = a.idAsistent
group by ang.nume, ang.prenume, ang.salariu
having count(c.idAsistent) in (2,3)
UNION
select ang.nume || ' ' ||ang.prenume, count(c.idAsistent) numar_consultatii, 
ang.salariu as salariu_complet
from angajat ang, consultatie c, asistent a
where ang.idAng = a.idAng
and c.idAsistent = a.idAsistent
group by ang.nume, ang.prenume, ang.salariu
having count(c.idAsistent) <2;

/* Sa se afi?eze asistentii ce vor primi primã pe sãrbãtori. Condi?iile pentru ob?inerea primei, sunt urmãtoarele:
    - nrOrePregatire>45
    - nrCursuriSuplimentare>5
*/

select ang.nume || ' ' || ang.prenume, 
count(c.idAsistent) as nrConsultatii, 
a.orePregatireLunara, a.nrCursuriSuplimentare 
from asistent a, angajat ang, consultatie c 
where orePregatireLunara > 45
and ang.idAng = a.idAng
and a.idAsistent = c.idAsistent
group by ang.nume, ang.prenume, 
a.orePregatireLunara, a.nrCursuriSuplimentare
INTERSECT
select ang.nume || ' ' || ang.prenume, 
count(c.idAsistent) as nrConsultatii, 
a.orePregatireLunara, a.nrCursuriSuplimentare 
from asistent a, angajat ang, consultatie c 
where nrCursuriSuplimentare > 5
and ang.idAng = a.idAng
and a.idAsistent = c.idAsistent
group by ang.nume, ang.prenume, 
a.orePregatireLunara, a.nrCursuriSuplimentare;

/* plata totala pe care pacientul va trebui sa o faca catre centrul medical*/
/*
Se scrie un proiect de lege prin care se doreste cresterea salariilor angajatilor cu studii superioare astfel:
    - 0,2 * salariu pentru absolventii de licenta
    - 0,4 * salariu pentru absolventii de masterat
    - 0,6 * salariu pentru absolventii de doctorat
Sa se afiseze care ar fi salariile angajatilor in urma adoptarii acestei legi.
*/
SELECT nume, prenume, nivel_pregatire, 
DECODE(UPPER(nivel_pregatire), 'LICENTA' ,
0.2,'MASTERAT', 0.4, 'DOCTORAT' , 0.6, 0)
as marireSalariu,
(salariu * DECODE(UPPER(nivel_pregatire),
'LICENTA' , 0.2,'MASTERAT', 0.4, 'DOCTORAT',
0.6, 0) + salariu) as salariu_marit FROM angajat;

/*
Sa se afiseze numele, prenumele, id-ul si id-ul superiorului, pentru asistentii inferiori medicului cu id-ul de angajat 56.
*/

SELECT idAng, nume, prenume, id_superior, LEVEL FROM angajat
CONNECT BY PRIOR idAng= id_superior
START WITH idAng = 56;

/*
Sa se afiseze numele asistentilor inferiori medicului cu id-ul de angajat 56, sub forma de organigrama.
*/
SELECT LEVEL, LPAD(' ', LEVEL)|| nume FROM angajat
CONNECT BY PRIOR idAng = id_superior
START WITH idAng= 56;

/*Sa se afiseze toti subordonatii angajatului cu prenumele Stoi:*/

SELECT idAng, prenume, salariu, nume, id_superior, LEVEL FROM angajat
CONNECT BY PRIOR idAng = id_superior
START WITH prenume= 'Stoi'
ORDER BY LEVEL;


/*11. Sa se afiseze toti subordonatii lui 'Stoi' fara cei .*/

SELECT idAng, nume, id_superior, salariu, LEVEL FROM angajat
WHERE salariu < 4000
CONNECT BY PRIOR idAng = id_superior
START WITH prenume = 'Stoi' 
ORDER BY LEVEL;


/*	Sã se afiºeze adresele pacientilor, chiar acestea nu sunt asociate strict pacientilor, ci si angajatilor */

SELECT a.* FROM pacient p, adresa a WHERE a.id_adresa = p.id_adresa (+);

/*Sã se afi?eze superiorii direc?i ai angaja?ilor ce au superiori.*/
SELECT a.nume||' are ca superior direct pe: '||s.nume  
FROM angajat a, angajat s
WHERE a.id_superior=s.idAng;

 /*Sa se afiseze toti pacientii care au aceeasi data de nastere ca pacientul cu id-ul 25*/
insert into pacient values(46,'Stanescu', 'Cristiana', 21, 
'0798322343', 12, to_date('07/04/2002', 'dd/mm/yyyy'), 
'cristianastanescu@yahoo.com');

SELECT * FROM pacient
WHERE data_nasterii IN 
(SELECT data_nasterii FROM pacient WHERE idPacient = 25);


/*Sã se afiºeze datele referitoare la angajatii ce sunt angajati de la inceputul anului  2012. */
select * from ANGAJAT where data_angajare 
between to_date( '01/01/2012', 'DD/MM/YYYY') and sysdate; 

/* Sa se afiseze toate datele referitoare la medicii inregistrati intr-un an 
diferit de 2013, dar care au salariul mai mic decat
oricare dintre salariile medicilor inregistrati in anul 2013, ordonati 
descrescator, in functie de salariu. */

SELECT * FROM angajat a, medic m
WHERE a.salariu < ANY
(SELECT a.salariu FROM angajat a, medic m
WHERE a.idAng = m.idAng and 
extract(year from a.data_angajare)=2013) 
AND a.idAng = m.idAng and 
extract(year from a.data_angajare)<>2013
ORDER BY salariu DESC; 

/*Sã se afi?eze numele, id-ul medicului, prenumele ?i specializarea 
medicilor cu specializarea de cardiolog*/

select m.idMedic, a.nume, a.prenume, m.specializare
from ANGAJAT a, MEDIC m 
where upper(m.specializare) = 'CARDIOLOG'
and m.idAng = a.idAng;

/*
Sa se afiseze id-ul, numele si prenuele angajatilor, dar si id-ul superiorului. In cazul in care
angajatul nu are un superior, atunci este afisat -1 in locul id-ului. 
*/
select idAng, nume || ' ' ||prenume as nume_angajat, 
nvl(id_superior, -1) id_superior
from angajat;

/*  TABELE VIRTUALE HEHE    */
/*Sa realizeze o tabela virtuala cu toti medicii cu master*/

CREATE OR REPLACE VIEW v_angajati_master
AS SELECT * FROM angajat 
WHERE upper(nivel_pregatire)='MASTERAT';

/*
Sa se afiseze toate datele stocate in tabela virtuala.
*/
SELECT * FROM v_angajati_master;

/*
Sa se seteze id-ul superiorilor ca fiind -1 in cazul in care acesta este null
*/
UPDATE v_angajati_master
SET id_superior = decode(id_superior, null, -1, id_superior);

/*
Aduagarea conditiei ca anul in care angajatul s-a alaturat centrului medical sa fie 2019.
*/
select * from v_angajati_master where extract(year from data_angajare) = 2019;

/*
Sa se creeze o tabela virtuala care sa se actualizeze cu ajutorul declansatorilor, pentru marirea salariilor medicilor, in functie de nivelul de pregatire:
- doctorat -> 2000 RON
- masterat -> 1000 RON
- licenta -> 500 RON
*/

CREATE OR REPLACE TRIGGER t_date_utile_medici
INSTEAD OF UPDATE ON v_date_utile_medici
BEGIN
UPDATE v_date_utile_medici
SET salariu = salariu + 
(case
when nivel_pregatire = 'doctorat' then 2000
when nivel_pregatire = 'masterat' then 1000
when nivel_pregatire = 'licenta' then 500
else 0 end);
end;

/* Aplicati optiunea de read only pentru tabela virtuala v_angajati_master*/

CREATE OR REPLACE VIEW v_angajati_master
AS SELECT * FROM angajat 
WHERE upper(nivel_pregatire)='MASTERAT'
WITH READ ONLY;

/*Sa se stearga tabela virtuala v_angajati_master*/
drop view v_angajati_master;

