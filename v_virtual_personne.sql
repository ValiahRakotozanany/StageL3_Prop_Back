-- ANTENNE.V_VIRTUAL_PERSONNE_INSERTION source

CREATE OR REPLACE FORCE VIEW "ANTENNE"."V_VIRTUAL_PERSONNE_INSERTION" ("ID", "NOM", "DISTRICT", "REGION", "COMMUNES", "PRENOM", "AGE", "SEXE", "DOMICILE", "JOB", "MAIL", "TELEPHONE", "COMPTEFB", "WHATSAPP", "CHAMPLIBRE", "IDATTENTE", "IDRESPONSABLE", "TRAITEMENT", "IDTYPETRAITEMENT", "DEMANDES", "IDPOSTE", "ETAT", "CIBLE", "CIBLELIB", "ATOUT", "ATTENTEDETAILLE") AS
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
    p.etat,
    p.cible,
    p.ciblelib,
    p.atout,
    p.attentedetaille
FROM
    v_personne_lib_complet p

;