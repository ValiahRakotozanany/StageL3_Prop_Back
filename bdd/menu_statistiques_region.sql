INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES
('MEN0033','Analyse','fa fa-home',null,9,1,null);
INSERT INTO MENUDYNAMIQUE (ID,LIBELLE,ICONE,HREF,RANG,NIVEAU,ID_PERE) VALUES
('MEN0034','Analyse effectif district','fa fa-list','/tiatanindrazana/pages/module.jsp?but=analyse/statistiques-region.jsp',1,2,'MEN0033');

INSERT INTO USERMENU(ID, REFUSER, IDMENU, IDROLE, CODESERVICE, CODEDIR, INTERDIT) VALUES
('USRMEN00025',null,'MEN0033','dg',null,null,0);