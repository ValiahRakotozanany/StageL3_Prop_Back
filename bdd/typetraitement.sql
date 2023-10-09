ALTER TABLE personne ADD idTypeTraitement varchar(255) ;

ALTER TABLE PERSONNE ADD 
CONSTRAINT fk_personne_type_traitement
FOREIGN KEY (idTypeTraitement) REFERENCES TYPE_traitement(id);

CREATE OR REPLACE VIEW v_personne_type_entite  AS 
SELECT 
	aep.IDPERSONNE ,
	LISTAGG(t.VAL , ', ') WITHIN GROUP (ORDER BY t.VAL) AS type_entites
FROM 
	ASSOCIATION_ENTITE_PERSONNE aep ,
	ENTITE e ,
	TYPEENTITE t 
WHERE 
	aep.IDENTITE = e.ID (+)
	AND e.IDTYPE = t.ID (+)
GROUP BY 
	aep.IDPERSONNE;


CREATE SEQUENCE seqtypetraitement
    START WITH 1
    INCREMENT BY 1;
CREATE OR REPLACE FUNCTION getseqtypetraitement
   RETURN NUMBER
IS
   retour   NUMBER;
BEGIN
   SELECT seqtypetraitement.NEXTVAL INTO retour FROM DUAL;
   RETURN retour;
END;


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
	tpt.nom idtypetraitementlib
FROM 
	PERSONNE p,
	ATTENTE a,
	V_PERSONNE_COMMUNE vpc,
	DISTRICT d ,
	REGION r,
	RESPONSABLE r2,
	TYPE_TRAITEMENT tpt,
	v_personne_type_entite vpte
WHERE 
	p.IDATTENTE = a.id(+)
	AND p.ID = vpc.IDPERSONNE(+)
	AND vpc.idregion = r.ID (+)
	AND vpc.iddistrict = d.ID (+)
	AND p.IDRESPONSABLE = r2.ID (+)
	AND p.IDTYPETRAITEMENT = tpt.id(+)
	AND p.ID = vpte.IDPERSONNE(+);


   
CREATE OR REPLACE VIEW v_personne_commune AS	  
SELECT
    idPersonne,
    r.ID idRegion,
    d.ID idDistrict,
    LISTAGG(pc.IDCOMMUNE , ', ') WITHIN GROUP (ORDER BY IDCOMMUNE) AS communes,
    LISTAGG(c.NOM , ', ') WITHIN GROUP (ORDER BY IDCOMMUNE) AS communeslib
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
   	
-- vue personne_valide_virtuel
   		
CREATE OR REPLACE VIEW PERSONNE_VALIDE_VIRTUEL AS 
SELECT 
	'' AS idPersonne,
	'' AS idResponsable,
	'' AS traitement,
	'' AS idTypeTraitement
FROM dual;

-- vue commnune lib complet

CREATE OR REPLACE VIEW v_commune_lib_complet AS	
SELECT 
	c.*,
	d.NOM IDDISTRICTLIB,
	d.IDREGION,
	r.VAL IDREGIONLIB
FROM 
	COMMUNE c,
	DISTRICT d,
	REGION r 
WHERE 
	c.IDDISTRICT = d.ID (+)
	AND d.IDREGION = r.ID (+);

-- vue commnune sans responsable
CREATE OR REPLACE VIEW V_COMMUNE_SANS_RESPONSABLE AS
SELECT 
	c.*
FROM 
	v_commune_lib_complet c 
WHERE 
	NOT EXISTS (
		SELECT v.id
		FROM v_commune_avec_responsable v
		WHERE v.ID = 
		c.ID 
	);

-- vue commnune avec responsable
CREATE OR REPLACE VIEW v_commune_avec_responsable as
SELECT 
	c.* 
FROM
	COMMUNE c, 
	PERSONNE_COMMUNE pc,
	PERSONNE p 
WHERE 
	c.id = pc.IDCOMMUNE (+)
	AND pc.IDPERSONNE = p.ID (+)
	AND p.IDTYPETRAITEMENT = 'TPTRESP001';

INSERT INTO TYPE_TRAITEMENT(ID, NOM) VALUES('TPTRESP001', 'Responsable');
INSERT INTO TYPE_TRAITEMENT (ID,NOM) VALUES ('TPT01','Animateur');

INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0020', 'Gestion des types de roles', 'fa fa-home', NULL, 7, 1, NULL);
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0021', 'Saisie types de roles', 'fa fa-plus', '/tiatanindrazana/pages/module.jsp?but=traitement/type-traitement.jsp', 1, 2, 'MEN0020');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0022', 'Liste types de roles', 'fa fa-list', '/tiatanindrazana/pages/module.jsp?but=traitement/liste-traitement.jsp', 2, 2, 'MEN0020');
INSERT INTO MENUDYNAMIQUE
(ID, LIBELLE, ICONE, HREF, RANG, NIVEAU, ID_PERE)
VALUES('MEN0023', 'Liste des communes sans responsable', 'fa fa-list', '/tiatanindrazana/pages/module.jsp?but=commune/liste-sans-responsable.jsp', 2, 2, 'MEN0007');
