CREATE TABLE demande (
	id varchar(255) NOT NULL PRIMARY KEY,
	nom varchar(255) NOT NULL	
);

CREATE TABLE poste(
	id varchar(255) NOT NULL PRIMARY KEY,
	nom varchar(255) NOT NULL,
	idregion varchar(255) NOT NULL,
	iddistrict varchar(255),
	idcommune varchar(255),
	idpersonne varchar(255)
);

ALTER TABLE poste ADD CONSTRAINT fk_poste_personne FOREIGN KEY (idPersonne) REFERENCES personne(id)	;	


ALTER TABLE poste ADD CONSTRAINT fk_poste_region 
FOREIGN KEY (idregion) REFERENCES region(id);

ALTER TABLE poste ADD CONSTRAINT fk_poste_district 
FOREIGN KEY (iddistrict) REFERENCES district(id);

ALTER TABLE poste ADD CONSTRAINT fk_poste_commune 
FOREIGN KEY (idcommune) REFERENCES commune(id);


CREATE TABLE personne_demande(
	id varchar(255) NOT NULL PRIMARY KEY,
	idPersonne varchar(255) NOT NULL,
	idDemande varchar(255) NOT NULL
);

ALTER TABLE PERSONNE_DEMANDE ADD CONSTRAINT fk_personne_demande1
FOREIGN KEY (idPersonne) REFERENCES personne(id);

ALTER TABLE PERSONNE_DEMANDE ADD CONSTRAINT fk_personne_demande2
FOREIGN KEY (idDemande) REFERENCES demande(id);

CREATE SEQUENCE seqpersonnedemande
    START WITH 1
    INCREMENT BY 1;
CREATE OR REPLACE FUNCTION getseqpersonnedemande
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqpersonnedemande.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;

CREATE SEQUENCE seqposte
    START WITH 1
    INCREMENT BY 1;
CREATE OR REPLACE FUNCTION getseqposte
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqposte.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;


CREATE SEQUENCE seqdemande
    START WITH 1
    INCREMENT BY 1;
CREATE OR REPLACE FUNCTION getseqdemande
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqdemande.NEXTVAL INTO retour FROM DUAL;

   RETURN retour;
END;


CREATE OR REPLACE VIEW v_personne_demande AS
SELECT 
	pd.IDPERSONNE ,
	LISTAGG(d.id , ';') WITHIN GROUP (ORDER BY d.NOM) AS demandes,
	LISTAGG(d.NOM , ';') WITHIN GROUP (ORDER BY d.NOM) AS demandeslib
FROM 
	PERSONNE_DEMANDE pd ,
	DEMANDE d 
WHERE
	pd.IDDEMANDE = d.ID (+)
GROUP BY 
	pd.IDPERSONNE;  

CREATE OR REPLACE VIEW v_personne_poste AS 
SELECT 
	p.idPersonne,
	LISTAGG(p.id , ';') WITHIN GROUP (ORDER BY p.NOM) AS idposte,
	LISTAGG(p.NOM , ';') WITHIN GROUP (ORDER BY p.NOM) AS idpostelib
FROM 
	POSTE p	
GROUP BY 
	p.idPersonne;

CREATE OR REPLACE VIEW v_personne_lib_complet AS
SELECT
	p.*,
	CASE
	WHEN p.etat = 1 THEN
		'Créé(e)'
	WHEN p.ETAT = 11 THEN
		'Validé(e)'
	WHEN p.ETAT = 0 THEN
		'Annulé(e)'
	WHEN p.ETAT = 7 THEN
		'Interviewé(e)'
	END AS etatlib,
	a.val as idAttenteLib,
	vpc.idregion AS region,
	vpc.iddistrict AS district,
	r.VAL regionlib,
	d.NOM districtlib,
	vpc.communes,
	vpc.communeslib,
	r2.NOM AS IDRESPONSABLELIB,
	vpte.TYPE_ENTITES typeentites,
	tpt.nom idtypetraitementlib,
	de.DEMANDES,
	de.DEMANDESLIB,
	po.IDPOSTELIB,
	po.IDPOSTE
FROM 
	PERSONNE p,
	ATTENTE a,
	V_PERSONNE_COMMUNE vpc,
	DISTRICT d ,
	REGION r,
	RESPONSABLE r2,
	TYPE_TRAITEMENT tpt,
	v_personne_type_entite vpte,
	v_personne_demande de,
	v_personne_poste po
WHERE 
	p.IDATTENTE = a.id(+)
	AND p.ID = vpc.IDPERSONNE(+)
	AND vpc.idregion = r.ID (+)
	AND vpc.iddistrict = d.ID (+)
	AND p.IDRESPONSABLE = r2.ID (+)
	AND p.IDTYPETRAITEMENT = tpt.id(+)
	AND p.ID = vpte.IDPERSONNE(+)
	AND p.ID = de.IDPERSONNE(+)
	AND p.ID = po.IDPersonne(+) ;


	
-- v_personne_lib_complet_c
CREATE OR REPLACE VIEW v_personne_lib_complet_c as
   SELECT v.*
   FROM 
   		v_personne_lib_complet v
   WHERE 
   		v.etat = 1;
   
-- v_personne_lib_complet_v
   	
CREATE OR REPLACE VIEW v_personne_lib_complet_v as
   SELECT v.*
   FROM 
   		v_personne_lib_complet v
   WHERE 
   		v.etat = 11;
-- v_personne_lib_complet_a
   	
 CREATE OR REPLACE VIEW v_personne_lib_complet_a as
   SELECT v.*
   FROM 
   		v_personne_lib_complet v
   WHERE 
   		v.etat = 0;
   	
-- v_personne_lib_complet_i
   	
 CREATE OR REPLACE VIEW v_personne_lib_complet_i as
   SELECT v.*
   FROM 
   		v_personne_lib_complet v
   WHERE 
   		v.etat = 7;
   	
 -- v_virtual_personne_insertion
CREATE OR REPLACE VIEW v_virtual_personne_insertion as
SELECT 
	p.id,
	p.nom,  
	p.district,  
	p.region,  
	p.communes,  
	p.prenom, 
	p.age,  
	p.sexe,  
	p.domicile,  
	p.job,  
	p.mail,  
	p.telephone,  
	p.compteFB,  
	p.whatsapp,
	p.champlibre,
	p.idAttente,
	p.IDRESPONSABLE,
	p.TRAITEMENT,
	p.IDTYPETRAITEMENT ,
	p.DEMANDES ,
	p.IDPOSTE,
	p.etat
FROM 
	v_personne_lib_complet p;
	

CREATE OR REPLACE VIEW v_poste_lib_complet AS
SELECT 
	p.*,
	r.VAL AS IDREGIONLIB,
	d.NOM AS IDDISTRICTLIB,
	c.NOM AS IDCOMMUNELIB
FROM
	POSTE p,
	REGION r,
	DISTRICT d,
	COMMUNE c 
WHERE 
	p.IDREGION = r.id(+)
	AND p.IDDISTRICT = d.ID(+)
	AND p.IDCOMMUNE  = c.ID(+);

CREATE OR REPLACE VIEW PERSONNE_VALIDE_VIRTUEL AS 
SELECT 
	'' AS idPersonne,
	'' AS idResponsable,
	'' AS traitement,
	'' AS idTypeTraitement,
	'' AS idPoste
FROM dual;

ALTER TABLE PERSONNE MODIFY IDATTENTE VARCHAR2(255) NULL;
ALTER TABLE PERSONNE MODIFY JOB VARCHAR2(50) NULL;

CREATE OR REPLACE VIEW V_POSTE_LIB_COMPLET (ID, NOM, IDREGION, IDDISTRICT, IDCOMMUNE, IDREGIONLIB, IDDISTRICTLIB, IDCOMMUNELIB,IDPERSONNE,NOMPERSONNE,PRENOMPERSONNE) AS 
  SELECT 
	p.ID,p.NOM,p.IDREGION,p.IDDISTRICT,p.IDCOMMUNE,
	r.VAL AS IDREGIONLIB,
	d.NOM AS IDDISTRICTLIB,
	c.NOM AS IDCOMMUNELIB,
	p.IDPERSONNE,
	pers.nom AS NOMPERSONNE,
	pers.prenom AS PRENOMPERSONNE
FROM
	POSTE p,
	REGION r,
	DISTRICT d,
	COMMUNE c,
	PERSONNE pers
WHERE 
	p.IDREGION = r.id(+)
	AND p.IDDISTRICT = d.ID(+)
	AND p.IDCOMMUNE  = c.ID(+)
	AND p.IDPERSONNE = pers.ID(+);
	

CREATE OR REPLACE VIEW v_poste_disponible as
SELECT VPLC.*
FROM V_POSTE_LIB_COMPLET vplc 
WHERE vplc.IDPERSONNE IS NOT NULL;

CREATE OR REPLACE VIEW v_poste_non_disponible as
SELECT VPLC.*
FROM V_POSTE_LIB_COMPLET vplc 
WHERE vplc.IDPERSONNE IS NULL;

INSERT INTO ANTENNE.MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEN0030', 'Poste', 'fa fa-home', NULL, 8, 1, NULL);
INSERT INTO ANTENNE.MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEN0031', 'Liste poste', 'fa fa-list', '/tiatanindrazana/pages/module.jsp?but=poste/poste-liste.jsp', 1, 2, 'MEN0030');
INSERT INTO ANTENNE.MENUDYNAMIQUE (ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE) VALUES('MEN0032', 'Saisie poste', 'fa fa-plus', '/tiatanindrazana/pages/module.jsp?but=poste/poste-saisie.jsp', 2, 2, 'MEN0030');

CREATE OR REPLACE VIEW v_personne_type_entite  AS 
SELECT 
	aep.IDPERSONNE ,
	LISTAGG(t.VAL , ';') WITHIN GROUP (ORDER BY t.VAL) AS type_entites
FROM 
	ASSOCIATION_ENTITE_PERSONNE aep ,
	ENTITE e ,
	TYPEENTITE t 
WHERE 
	aep.IDENTITE = e.ID (+)
	AND e.IDTYPE = t.ID (+)
GROUP BY 
	aep.IDPERSONNE;

CREATE OR REPLACE VIEW v_personne_commune AS	  
SELECT
    idPersonne,
    r.ID idRegion,
    d.ID idDistrict,
    LISTAGG(pc.IDCOMMUNE , ';') WITHIN GROUP (ORDER BY IDCOMMUNE) AS communes,
    LISTAGG(c.NOM , ';') WITHIN GROUP (ORDER BY IDCOMMUNE) AS communeslib
FROM
    PERSONNE_COMMUNE pc,
    COMMUNE c,
    DISTRICT d ,
    REGION r 
WHERE 
	pc.IDCOMMUNE = c.ID (+)
	AND c.IDDISTRICT = d.id(+)
	AND d.IDREGION = r.ID 
GROUP BY
    pc.idPersonne,
   	r.id,
   	d.ID ;
   
   
   INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS000102', NULL, 'MEN0030', 'verificateur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS000100', NULL, 'MEN0007', 'redacteur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS00010', NULL, 'MEN0030', 'redacteur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS00006', NULL, 'MEN0020', 'redacteur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS00005', NULL, 'MEN0016', 'redacteur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS00004', NULL, 'MEN0013', 'redacteur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS000025', NULL, 'MEN0016', 'verificateur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS000022', NULL, 'MEN0007', 'verificateur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS00002', NULL, 'MEN0007', 'redacteur', NULL, NULL, 1); 
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS000019', NULL, 'MEN0003', 'verificateur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS000018', NULL, 'MEN0020', 'verificateur', NULL, NULL, 1);
INSERT INTO USERMENU
(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT)
VALUES('USRMENS00001', NULL, 'MEN0003', 'redacteur', NULL, NULL, 1);

