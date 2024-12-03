DROP TABLE Personne	CASCADE CONSTRAINTS;
DROP TABLE MereDe	CASCADE CONSTRAINTS;
DROP TABLE PereDe	CASCADE CONSTRAINTS;

-- ----------------------------------------------------------------------
-- TABLE : Personne
-- ----------------------------------------------------------------------
CREATE TABLE Personne ( 
	numPers			NUMBER(4)    	NOT NULL
	, nomPers		VARCHAR2(20)
	, prenomPers	VARCHAR2(20)
	, sexePers		VARCHAR2(1)	CHECK (sexePers IN ('F','M'))
	, CONSTRAINT PK_Personne PRIMARY KEY (numPers)  
);

-- ----------------------------------------------------------------------
-- TABLE : MereDe
-- ----------------------------------------------------------------------
CREATE TABLE MereDe ( 
	numPersEnfant	NUMBER(4)		NOT NULL
	, numPersMere	NUMBER(4)
	, CONSTRAINT PK_MereDe PRIMARY KEY (numPersEnfant)
) ;

-- ----------------------------------------------------------------------
-- TABLE : PereDe
-- ----------------------------------------------------------------------
CREATE TABLE PereDe ( 
	numPersEnfant	NUMBER(4)		NOT NULL
	, numPersPere	NUMBER(4)
	, CONSTRAINT PK_PereDe PRIMARY KEY (numPersEnfant)
) ;

-- ----------------------------------------------------------------------
-- CREATION DES REFERENCES DE TABLE
-- ----------------------------------------------------------------------
ALTER TABLE MereDe ADD (
	CONSTRAINT FK_MereDe_PersonneEnfant FOREIGN KEY (numPersEnfant)
		REFERENCES Personne (numPers)) ;

ALTER TABLE MereDe ADD (
	CONSTRAINT FK_MereDe_PersonneMere FOREIGN KEY (numPersMere)
		REFERENCES Personne (numPers)) ;

ALTER TABLE PereDe ADD (
	CONSTRAINT FK_PereDe_PersonneEnfant FOREIGN KEY (numPersEnfant)
		REFERENCES Personne (numPers)) ;

ALTER TABLE PereDe ADD (
	CONSTRAINT FK_PereDe_PersonnePere FOREIGN KEY (numPersPere)
		REFERENCES Personne (numPers)) ;

insert into Personne (numPers, nomPers, prenomPers, sexePers) values(1, 'Dubois','Anne','F');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(2, 'Durand','Alain','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(3, 'Dupont','Eric','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(4, 'Dunois','Marie','F');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(5, 'Durand','Pierre','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(6, 'Dupont','Daniel','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(7, 'Berthier','Aline','F');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(8, 'Durand','Paul','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(9, 'Durand','Odile','F');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(10, 'Dupont','Jeanne','F');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(11, 'Dupont','Nicolas','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(12, 'Dupont','Maxime','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(13, 'Durand','Luc','M');
insert into Personne (numPers, nomPers, prenomPers, sexePers) values(14, 'Durand','Monique','F');

insert into PereDe (numPersEnfant, numPersPere) values(5, 2);
insert into PereDe (numPersEnfant, numPersPere) values(8, 5);
insert into PereDe (numPersEnfant, numPersPere) values(9, 5);
insert into PereDe (numPersEnfant, numPersPere) values(13, 8);
insert into PereDe (numPersEnfant, numPersPere) values(6, 3);
insert into PereDe (numPersEnfant, numPersPere) values(10, 6);
insert into PereDe (numPersEnfant, numPersPere) values(11, 6);
insert into PereDe (numPersEnfant, numPersPere) values(12, 6);

insert into MereDe (numPersEnfant, numPersMere) values(5, 1);
insert into MereDe (numPersEnfant, numPersMere) values(8, 4);
insert into MereDe (numPersEnfant, numPersMere) values(9, 4);
insert into MereDe (numPersEnfant, numPersMere) values(10, 4);
insert into MereDe (numPersEnfant, numPersMere) values(11, 4);
insert into MereDe (numPersEnfant, numPersMere) values(12, 4);
insert into MereDe (numPersEnfant, numPersMere) values(13, 7);
insert into MereDe (numPersEnfant, numPersMere) values(14, 9);

--Exercice 1

select nomPers Nom, prenomPers Prenom from Personne where numPers in 
    (select numPersPere from PereDe group by numPersPere having count(numPersEnfant)>=2 
    UNION 
    select numPersMere from MereDe group by numPersMere having count(numPersEnfant)>=2);

--Exercice 2

select nomPers Nom, prenomPers Prenom from Personne where numPers in
	(select numPersPere from PereDe where numPersEnfant in (select numPersPere from PereDe Union select numPersMere from MereDe));

select nomPers Nom, prenomPers Prenom from Personne where numPers in
	(select numPersMere from MereDe where numPersEnfant in (select numPersPere from PereDe Union select numPersMere from MereDe));

--Exercice 3

Select nomPers Nom, prenomPers Prenom from Personne where numPers=(Select numPersPere from PereDe where numPersEnfant=(Select numPers from Personne where nomPers='Durand' and prenomPers='Paul'));

--Exercice 4


Select nomPers Nom, prenomPers Prenom from Personne where numPers in (
    Select numPersEnfant from MereDe where numPersMere=(select numPersMere from MereDe where numPersEnfant=(Select numPers from Personne where nomPers='Dupont' and prenomPers='Jeanne'))) 
    and 
    numPers<>(Select numPers from Personne where nomPers='Dupont' and prenomPers='Jeanne');


--Exercice 5

Select nomPers Nom, prenomPers Prenom from Personne where numPers=(select numPersMere from MereDe group by numPersMere 
    having count(numPersEnfant)=(select max(nbEnfants) from (select numPersMere, count(numPersEnfant) nbEnfants from MereDe group by numPersMere)));

--Exercice 6

Select nomPers Nom, prenomPers Prenom from Personne where numPers not in (select numPersPere from PereDe UNION select numPersMere from MereDe);

--Exercice 7

Create or replace view Couple(Mere,Pere) as 
    Select numPersMere,numPersPere from MereDe natural join PereDe;

Select nomPers Nom, prenomPers Prenom from Personne where numPers in (Select Mere from Couple Union Select Pere from Couple) and numPers not in(
    Select Mere from Couple group by Mere having count(distinct(Pere))>1
    Union
    Select Pere from Couple group by Pere having count(distinct(Mere))>1
);

--Exercice 8

Select nomPers Nom, prenomPers Prenom from Personne where numPers not in
(Select numPersEnfant from MereDe Union Select numPersEnfant from PereDe);

--Exercice 9

Select nomPers Nom, prenomPers Prenom from Personne where numPers not in (Select numPersEnfant from MereDe Natural join PereDe);

--Exercice 10

Select nomPers Nom, prenomPers Prenom from Personne where numPers in (
  select numPersEnfant from MereDe where numPersMere in (select numPersMere from MereDe group by numPersMere having count(numPersEnfant)=1)
    Union
  select numPersEnfant from PereDe where numPersPere in (select numPersPere from PereDe group by numPersPere having count(numPersEnfant)=1));

--Exercice 11

Create or replace view Parents(numMere,numPere) as
	Select numPersMere,numPersPere from (Select * from MereDe 
	Natural Join
	PereDe where numPersEnfant=(Select numPers from Personne where prenomPers='Luc' and nomPers='Durand'));

Create or replace view GrandParentsMere(numGrandMereMere, numGrandPereMere) as
	Select numPersMere,numPersPere from (Select * from MereDe 
	Natural Join
	PereDe where numPersEnfant=(Select numMere from Parents));

Create or replace view GrandParentsPere(numGrandMerePere, numGrandPerePere) as
	Select numPersMere,numPersPere from (Select * from MereDe 
	Natural Join
	PereDe where numPersEnfant=(Select numPere from Parents));

Create or replace view OnclesTantes(numOnclesTantes) as
    Select * from (
    Select numPersEnfant from MereDe where numPersMere=(Select numGrandMereMere from GrandParentsMere Union Select numGrandMerePere from GrandParentsPere)
	Union
	Select numPersEnfant from PereDe where numPersPere=(Select numGrandPereMere from GrandParentsMere Union Select numGrandPerePere from GrandParentsPere)) where numPersEnfant not in (Select numMere from Parents Union Select numPere from Parents);

Select nomPers Nom, prenomPers Prenom from Personne where numPers=(Select numPersEnfant from MereDe where numPersMere in (select numOnclesTantes from OnclesTantes))
    Union
Select nomPers Nom, prenomPers Prenom from Personne where numPers=(Select numPersEnfant from PereDe where numPersPere in (select numOnclesTantes from OnclesTantes));
