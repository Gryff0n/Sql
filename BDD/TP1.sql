DROP TABLE FCP CASCADE CONSTRAINTS;
DROP TABLE Action CASCADE CONSTRAINTS;
DROP TABLE Client CASCADE CONSTRAINTS;
DROP TABLE Region CASCADE CONSTRAINTS;
DROP TABLE ComposeDe CASCADE CONSTRAINTS;
DROP TABLE PossedeAction CASCADE CONSTRAINTS;
DROP TABLE PossedeFCP CASCADE CONSTRAINTS;

-- TABLE : FCP
CREATE TABLE FCP
  ( codeFCP 	NUMBER(4)  		NOT NULL
  , nomFCP 		VARCHAR2(20)  
  , dateDebut 	DATE  
  , dateFin 	DATE  
  , CONSTRAINT PK_FCP PRIMARY KEY (codeFCP)  
  ) ;

-- TABLE : Action
CREATE TABLE Action
  ( codeAct 		NUMBER(4)  		NOT NULL
  , nomAct 			VARCHAR2(20)  
  , valeurCourante 	NUMBER(8,2)  
  , codeRegion 		NUMBER(4)  		NOT NULL
  , CONSTRAINT PK_Action PRIMARY KEY (codeAct)  
  ) ;

-- TABLE : Client
CREATE TABLE Client
  ( numCli 					NUMBER(4)  		NOT NULL
  , prenomCli 				VARCHAR2(20)  
  , nomCli 					VARCHAR2(20)  
  , dateOuvertureCompte 	DATE  
  , CONSTRAINT PK_Client PRIMARY KEY (numCli)  
  ) ;

-- TABLE : Region
CREATE TABLE Region
  ( codeRegion 	NUMBER(4)  	NOT NULL
  , nomRegion 	VARCHAR2(20)  
  , CONSTRAINT PK_Region PRIMARY KEY (codeRegion)  
  ) ;

-- TABLE : ComposeDe
CREATE TABLE ComposeDe
  ( codeFCP 	NUMBER(4)  NOT NULL
  , codeAct 	NUMBER(4)  NOT NULL
  , quantite 	NUMBER(6)  
  , prixAchat 	NUMBER(8,2)  
  , CONSTRAINT PK_ComposeDe PRIMARY KEY (codeFCP, codeAct)  
  ) ;

-- TABLE : PossedeAction
CREATE TABLE PossedeAction
  ( numCli 		NUMBER(4)  	NOT NULL
  , codeAct 	NUMBER(4)  	NOT NULL
  , quantite 	NUMBER(6)  
  , prixAchat 	NUMBER(8,2)  
  , CONSTRAINT PK_PossedeAction PRIMARY KEY (numCli, codeAct)  
  ) ;

-- TABLE : PossedeFCP
CREATE TABLE PossedeFCP
  ( numCli 			NUMBER(4)  	NOT NULL
  , codeFCP 		NUMBER(4)  	NOT NULL
  , quantiteFCP 	NUMBER(6)  
  , CONSTRAINT PK_PossedeFCP PRIMARY KEY (numCli, codeFCP)  
   ) ;

-- CREATION DES REFERENCES DE TABLE
ALTER TABLE Action ADD (
    CONSTRAINT FK_Action_Region FOREIGN KEY (codeRegion)
        REFERENCES Region (codeRegion)) ;

ALTER TABLE ComposeDe ADD (
    CONSTRAINT FK_ComposeDe_FCP FOREIGN KEY (codeFCP)
        REFERENCES FCP (codeFCP)) ;

ALTER TABLE ComposeDe ADD (
    CONSTRAINT FK_ComposeDe_Action FOREIGN KEY (codeAct)
        REFERENCES Action (codeAct)) ;

ALTER TABLE PossedeAction ADD (
    CONSTRAINT FK_PossedeAction_Client FOREIGN KEY (numCli)
        REFERENCES Client (numCli)) ;

ALTER TABLE PossedeAction ADD (
    CONSTRAINT FK_PossedeAction_Action FOREIGN KEY (codeAct)
        REFERENCES Action (codeAct)) ;

ALTER TABLE PossedeFCP ADD (
    CONSTRAINT FK_PossedeFCP_Client FOREIGN KEY (numCli)
        REFERENCES Client (numCli)) ;

ALTER TABLE PossedeFCP ADD (
    CONSTRAINT FK_PossedeFCP_FCP FOREIGN KEY (codeFCP)
        REFERENCES FCP (codeFCP)) ;


INSERT INTO Client VALUES(1, 'Pierre',  'Leloup', to_date('22/12/2000','DD/MM/YYYY'));
INSERT INTO Client VALUES(2, 'Paul',    'Durand', to_date('12/01/1998','DD/MM/YYYY'));
INSERT INTO Client VALUES(3, 'Louis',   'Dupont', to_date('15/03/2001','DD/MM/YYYY'));
INSERT INTO Client VALUES(4, 'Jacques', 'Martin', to_date('28/09/2001','DD/MM/YYYY'));
INSERT INTO Client VALUES(5, 'Pierre',  'Perrin', to_date('11/06/2000','DD/MM/YYYY'));
-- INSERT INTO Client VALUES(6, 'Aurélia',  'Dubois', to_date('13/01/2011','DD/MM/YYYY'));

INSERT INTO Region VALUES(1, 'Europe');
INSERT INTO Region VALUES(2, 'USA');

INSERT INTO Action VALUES(1, 'Alcatel',          5.1,  1);
INSERT INTO Action VALUES(2, 'Snecma',           19.3, 1);
INSERT INTO Action VALUES(3, 'General Electric', 95.6, 2);
INSERT INTO Action VALUES(4, 'BNP',              11.8, 1);
INSERT INTO Action VALUES(5, 'IBM',              21.3, 2);

INSERT INTO FCP 
	VALUES (1, 'MAXITUNE'	, to_date('15/01/2000','DD/MM/YYYY')
							, to_date('14/01/2016','DD/MM/YYYY'));
INSERT INTO FCP 
	VALUES (2, 'PEPERE'		, to_date('28/03/1999','DD/MM/YYYY')
							, to_date('27/03/2015','DD/MM/YYYY'));
INSERT INTO FCP 
	VALUES(3, 'DYNAMIQUE'	, to_date('01/04/2001','DD/MM/YYYY')
							, to_date('31/03/2015','DD/MM/YYYY'));

INSERT INTO PossedeAction VALUES(1, 1, 100,   10.1);
INSERT INTO PossedeAction VALUES(1, 2, 1000,  5.6);
INSERT INTO PossedeAction VALUES(1, 3, 220,   20.5);
INSERT INTO PossedeAction VALUES(2, 1, 134,   20);
INSERT INTO PossedeAction VALUES(2, 5, 213,   15.3);
INSERT INTO PossedeAction VALUES(3, 1, 24434, 18);
INSERT INTO PossedeAction VALUES(3, 2, 112,   13.6);
INSERT INTO PossedeAction VALUES(3, 4, 6000,  6.1);
INSERT INTO PossedeAction VALUES(4, 3, 1000,  80.6);
INSERT INTO PossedeAction VALUES(5, 3, 123,   75.1);
INSERT INTO PossedeAction VALUES(5, 5, 500,   14.9);
-- INSERT INTO PossedeAction VALUES(6, 2, 100000,   10.3);

INSERT INTO ComposeDe VALUES (1, 1, 10, 12.7);
INSERT INTO ComposeDe VALUES (1, 2, 15, 5.2);
INSERT INTO ComposeDe VALUES (1, 4, 12, 18.4);
INSERT INTO ComposeDe VALUES (2, 1, 3,  22.1);
INSERT INTO ComposeDe VALUES (2, 2, 5,  21);
INSERT INTO ComposeDe VALUES (2, 3, 1,  10);
INSERT INTO ComposeDe VALUES (2, 4, 20, 12.4);
INSERT INTO ComposeDe VALUES (3, 3, 12, 68.1);
INSERT INTO ComposeDe VALUES (3, 5, 5,  15.3);

INSERT INTO PossedeFCP VALUES(1, 1, 50);
INSERT INTO PossedeFCP VALUES(1, 2, 75);
INSERT INTO PossedeFCP VALUES(2, 1, 50);
INSERT INTO PossedeFCP VALUES(4, 3, 100);

SELECT * FROM Client;

SELECT * FROM Region;

SELECT * FROM Action;

SELECT * FROM FCP;

SELECT * FROM PossedeAction;

SELECT * FROM ComposeDe;

SELECT * FROM PossedeFCP;

--Question 1

select nomCli as "Nom",prenomCli as "Prénom" from Client order by nomCli;

--Question 2

SELECT codeAct as "Code", nomAct as "Nom", valeurCourante as "Valeur" from Action;

--Question 3

Select * from Action where valeurCourante=(select min(valeurCourante) from Action) or valeurCourante=(select max(valeurCourante) from Action);

--Question 4

Select * from Action Natural Join (Select numCli, codeAct from PossedeAction Natural Join (Select numCli from Client where prenomCli='Pierre' and nomCli='Leloup'));

--Question 5

Select sum((valeurCourante-prixAchat)*quantite) as "Gain total potentiel" from Action Natural Join PossedeAction Natural Join (Select numCli from Client where prenomCli='Pierre' and nomCli='Leloup');

--Question 6

Select codeFCP,sum((valeurCourante-prixAchat)*quantite) as "Gain total potentiel" from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

--Question 7

Drop view GainsFCP;
Create view GainsFCP as 
Select codeFCP,sum((valeurCourante-prixAchat)*quantite) as "Gain total potentiel" from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

Select codeFCP as "FCP le plus performant","Gain total potentiel" as "Gains" from GainsFCP where "Gain total potentiel"=(select max("Gain total potentiel") from GainsFCP);
Select codeFCP as "FCP le moins performant","Gain total potentiel" as "Gains" from GainsFCP where "Gain total potentiel"=(select min("Gain total potentiel") from GainsFCP);

--Question 8


Create or replace view GainsFCP as 
Select codeFCP,sum((valeurCourante-prixAchat)*quantite) as "Gain total potentiel" from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

Select ROUND(AVG("Gain total potentiel"),2) as "Perf moyenne des FCP" from GainsFCP;

--Question 9

Create or replace view GainsFCP as 
Select codeFCP,sum((valeurCourante-prixAchat)*quantite) as "Gain total potentiel" from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

Create or replace view GainActionPL as
Select numCli, sum((valeurCourante-prixAchat)*quantite) as "GainActionPL" from Action Natural Join PossedeAction Natural Join (Select numCli from Client where prenomCli='Pierre' and nomCli='Leloup') group by numCli;

Create or replace view GainFCPPL as
Select numCli,SUM("Gain total potentiel"*quantiteFCP) as "GainPLFCP" from GainsFCP natural join possedeFCP natural join (Select numCli from Client where prenomCli='Pierre' and nomCli='Leloup') group by numCli;

select "GainActionPL"+"GainPLFCP" as "Gain total potentiel de PL" from GainFCPPL natural join GainActionPL;

--Question 11

Create or replace view GainsFCP(codeFCP,GainFCP) as 
Select codeFCP,sum((valeurCourante-prixAchat)*quantite) from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

Create or replace view GainActionPL(numCli,GainActionPL) as
Select numCli, sum((valeurCourante-prixAchat)*quantite)from Action Natural Join PossedeAction Natural Join (Select numCli from Client) group by numCli;

Create or replace view GainFCPPL(numCli,GainTotFCP) as
Select numCli,SUM(GainFCP*quantiteFCP) from GainsFCP natural join possedeFCP natural join (Select numCli from Client) group by numCli;

Create or replace view AllMoney(numCli, totMoney) as
select numCli,NVL(GainActionPL,0)+NVL(GainTotFCP,0) from GainFCPPL natural full outer join GainActionPL;

Select numCli,prenomCli,nomCli,dateOuvertureCompte from Client natural join (select numCli from AllMoney where totMoney=(select max(totMoney) from AllMoney));

--Question 10

Create or replace view GainsFCP(codeFCP,GainFCP) as 
Select codeFCP,sum((valeurCourante)*quantite) from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

Create or replace view GainActionPL(numCli,GainActionPL) as
Select numCli, sum((valeurCourante)*quantite)from Action Natural Join PossedeAction Natural Join (Select numCli from Client) group by numCli;

Create or replace view GainFCPPL(numCli,GainTotFCP) as
Select numCli,SUM(GainFCP*quantiteFCP) from GainsFCP natural join possedeFCP natural join (Select numCli from Client) group by numCli;

Create or replace view AllMoney(numCli, totMoney) as
select numCli,NVL(GainActionPL,0)+NVL(GainTotFCP,0) from GainFCPPL natural full outer join GainActionPL;

Select numCli,prenomCli,nomCli,dateOuvertureCompte from Client natural join (select numCli from AllMoney where totMoney=(select max(totMoney) from AllMoney));

--Question 12

Create or replace view GainsFCP(codeFCP,GainFCP) as 
Select codeFCP,sum((valeurCourante-prixAchat)*quantite) from (Action Natural Join ComposeDe Natural Join (Select CodeFCP from FCP)) Group by codeFCP Order by codeFCP;

Create or replace view GainActionPL(numCli,GainActionPL) as
Select numCli, sum((valeurCourante-prixAchat)*quantite)from Action Natural Join PossedeAction Natural Join (Select numCli from Client) group by numCli;

Create or replace view GainFCPPL(numCli,GainTotFCP) as
Select numCli,SUM(GainFCP*quantiteFCP) from GainsFCP natural join possedeFCP natural join (Select numCli from Client) group by numCli;

Create or replace view AllMoney(numCli, totMoney) as
select numCli,NVL(GainActionPL,0)+NVL(GainTotFCP,0) from GainFCPPL natural full outer join GainActionPL;

Create or replace view years(numCli,years) as
select numCli,(to_number(to_char(SYSDATE,'YYYY'))-to_number(to_char(dateOuvertureCompte,'YYYY'))) from Client;

Create or replace view Rendement(numCli,rend) as
Select numCli,(totMoney / years) from years natural join AllMoney;

Select numCli,prenomCli,nomCli,dateOuvertureCompte from Client natural join (select numCli from Rendement where rend=(select max(rend) from Rendement));

--Question 13

Select * from FCP where to_char(dateDebut,'YYYY')='2000';

--Question 14

Select codeFCP, nomFCP from FCP where dateFin=(select MIN(dateFin) from FCP);

--Question 15

Select * from FCP
natural join
(Select distinct codeFCP from FCP
MINUS
Select distinct CodeFCP from FCP natural Join ComposeDe Natural Join Action where codeRegion<>(Select codeRegion from Region where nomRegion='Europe'));

--Question 16

create or replace view FCPEligible(codeFCP) as
Select distinct codeFCP from FCP
MINUS
Select distinct CodeFCP from FCP natural Join ComposeDe Natural Join Action where codeRegion<>(Select codeRegion from Region where nomRegion='Europe');

create or replace view ActEligible(codeAct) as
Select distinct codeAct from Action
MINUS
Select distinct CodeAct from Action where codeRegion<>(Select codeRegion from Region where nomRegion='Europe');

select * from client natural join
(select distinct numCli from Client
MINUS
(select distinct numCli from PossedeFCP where codeFCP not in (select codeFCP from FCPEligible)
UNION
select distinct numCli from PossedeAction where codeAct not in (select codeAct from ActEligible)));
