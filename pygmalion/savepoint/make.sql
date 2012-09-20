\c gestsea3

--BEGIN TRANSACTION;

-- Utilisateurs
INSERT INTO systeme.systeme_utilisateur (login,password,deja_present,superuser,createrole,can_login,maxconn,jusqua)
  SELECT rolname, '**********',true,rolsuper,rolcreaterole,rolcanlogin,rolconnlimit,rolvaliduntil
    FROM pg_authid WHERE rolname NOT IN (SELECT login FROM systeme.systeme_utilisateur);

-- Creation des schemas
\c gestsea3
INSERT INTO base.base_societe(id,code,nom,siren) VALUES (1,'sacea','SACEA','015002852');
\c gestsea3
INSERT INTO base.base_societe(id,code,nom,siren) VALUES (2,'fdsea','FDSEA','015052852');
/*
\c gestsea3
INSERT INTO base.base_societe(id,code,nom,siren) VALUES (3,'aava','AAVA','015789852');
\c gestsea3
INSERT INTO base.base_societe(id,code,nom,siren) VALUES (4,'sci','SCI','015045652');
*/
SET SEARCH_PATH TO public,base,systeme;
SELECT setval('base_societe_id_seq',COALESCE(MAX(id),0)+1,false) FROM base_societe;

-- Pretraitement
UPDATE table_personne SET pe_titre='---' WHERE pe_titre ILIKE ' ';
UPDATE table_personne SET pe_titre='---' WHERE pe_titre ILIKE '  ';
UPDATE table_personne SET pe_titre='---' WHERE pe_titre ILIKE '.';
UPDATE table_personne SET pe_titre='---' WHERE pe_titre IS NULL;
UPDATE table_personne SET pe_titre='Association' WHERE pe_titre ILIKE 'ASS%';
UPDATE table_personne SET pe_titre='EARL' WHERE pe_titre ILIKE 'EARL%';
UPDATE table_personne SET pe_titre='GAEC' WHERE pe_titre ILIKE 'GAEC%';
UPDATE table_personne SET pe_titre='Groupement d''employeur' WHERE pe_titre ILIKE 'GROUP%EMPL%';
UPDATE table_personne SET pe_titre='Indivision' WHERE pe_titre ILIKE 'INDIV%';
UPDATE table_personne SET pe_titre='M.' WHERE pe_titre ILIKE 'M';
UPDATE table_personne SET pe_titre='M.' WHERE pe_titre ILIKE 'M ';
UPDATE table_personne SET pe_titre='M.' WHERE pe_titre ILIKE 'monsieur';
UPDATE table_personne SET pe_titre='Mlle' WHERE pe_titre ILIKE 'M%LLE';
UPDATE table_personne SET pe_titre='Mme' WHERE pe_titre ILIKE 'madame';
UPDATE table_personne SET pe_titre='Mme' WHERE pe_titre ILIKE 'mme';
UPDATE table_personne SET pe_titre='Mme' WHERE pe_titre ILIKE 'mme ';
UPDATE table_personne SET pe_titre='Mmes' WHERE pe_titre ILIKE 'mmes';
UPDATE table_personne SET pe_titre='M. Mme' WHERE pe_titre ILIKE 'M%MME';
UPDATE table_personne SET pe_titre='SARL' WHERE pe_titre ILIKE 'SARL%';
UPDATE table_personne SET pe_titre='SCE' WHERE pe_titre ILIKE 'sce.';
UPDATE table_personne SET pe_titre='SCEA' WHERE pe_titre ILIKE 'scea ';
UPDATE table_personne SET pe_titre='SCEA' WHERE pe_titre ILIKE 'scea.';
UPDATE table_personne SET pe_titre='Societe' WHERE pe_titre ILIKE 'societe';

ALTER TABLE table_comptegen ADD numero VARCHAR;
UPDATE table_comptegen SET numero=CASE WHEN length(cg_numcompte)<5 THEN cg_numcompte||'X' ELSE cg_numcompte::varchar END;

CREATE OR REPLACE FUNCTION cursoc() RETURNS INTEGER AS
$$
DECLARE
  ret INTEGER;
  sp TEXT;
BEGIN
  SELECT setting from pg_settings where name='search_path' INTO sp;
  SELECT id FROM base.base_societe WHERE sp ILIKE '%'||"schema" INTO ret;
  IF ret IS NULL THEN
    RAISE EXCEPTION 'Pas de societe en cours.';
  END IF;
  RETURN ret;
END;
$$ LANGUAGE 'plpgsql' VOLATILE;

CREATE OR REPLACE FUNCTION concat2(text, text) RETURNS text AS 
$$
DECLARE
  ret text;
BEGIN
  SELECT COALESCE($1,'')||COALESCE($2,'') INTO ret;
  RETURN ret;
END; 
$$ LANGUAGE 'plpgsql';

CREATE AGGREGATE concatenate (
    sfunc = concat2,
    basetype = text,
    stype = text,
    initcond = ''
);

ALTER TABLE table_personne ADD contacts varchar;

CREATE VIEW personne_contacts AS 
  SELECT pe_numero AS personne, concatenate('<'||CASE WHEN cn_type='TELEPHONE' THEN 'TEL' WHEN cn_type='PORTABLE' THEN 'MOB' WHEN cn_type='E-MAIL' THEN 'EML' ELSE cn_type END||':'||cn_coordonnee||'>') AS valeur
    FROM table_estjoignable left join table_contact using (cn_numero) 
    WHERE length(cn_coordonnee)>5 and ej_actif 
    GROUP BY 1;
UPDATE table_personne SET contacts=valeur FROM personne_contacts WHERE pe_numero=personne;
DROP VIEW personne_contacts;


-- Migration generale
UPDATE table_adresse SET cp_numero=9000 where cp_numero=500000025;
DELETE FROM table_villecp where cp_numero=500000025;
DELETE FROM table_codepostal WHERE cp_numero=500000025;
DELETE FROM table_villecp where vi_numero in (14624,80756,63900,67941,38446,97414,97390);
DELETE FROM table_ville where vi_numero in (14624,80756,63900,67941,38446,97414,97390);

-- Cantons
INSERT INTO base_canton (id,nom) SELECT ct_numero, ct_nom FROM table_canton WHERE ct_numero<500000000;
SELECT setval('base_canton_id_seq',COALESCE(MAX(id),0)+1,false) FROM base_canton;
-- CP
INSERT INTO base_codepostal(numero) SELECT DISTINCT cp_numero FROM table_codepostal;
-- Communes
ALTER TABLE table_ville ADD id INTEGER DEFAULT nextval('base_commune_id_seq');
INSERT INTO base_commune(id,nom,cedex,canton_id) 
  SELECT id,vi_nom,vi_nom ilike '%cedex%',ct_numero 
    FROM table_ville WHERE vi_nom IS NOT NULL;
-- Communes-CP
INSERT INTO base_codepostal_commune_rel(commune_id,codepostal_id,nom) 
  SELECT DISTINCT com.id, cp.id, cp.numero||' '||com.nom 
    FROM table_villecp JOIN table_ville using (vi_numero) 
         left join table_codepostal using (cp_numero) 
         left join base_commune as com using (id) 
         left join base_codepostal as cp on (cp_codepostal=numero) 
    WHERE com.id is not null and cp.id is not null;
-- Droits
INSERT INTO table_droitprofil SELECT 500,'Administrateur';
UPDATE table_employe SET dp_numero=500 WHERE dp_numero IS NULL;


--- Passage d'anciennes factures sans commandes en commande pour la normalisation.
ALTER TABLE table_devis ADD fa_numero integer references public.table_facture(fa_numero);
ALTER TABLE table_devis DISABLE TRIGGER ALL;
ALTER TABLE table_ligne DISABLE TRIGGER ALL;
ALTER TABLE table_facture DISABLE TRIGGER ALL;

DELETE FROM table_lignefacture WHERE fa_numero IN (SELECT fa_numero FROM table_facture WHERE fa_numfact=0);
DELETE FROM table_facture WHERE fa_numfact=0;

UPDATE table_lignefacture SET px_numero=px.px_numero, pd_numero=pdp.pd_numero
  FROM table_lignefacture as lf 
       join table_facture using (fa_numero) 
       join table_prix as px on (lf_montantttc/lf_quantite=px_tarifttc and px.pd_numero!=1400002) 
       join table_produit as pdp on (px.pd_numero=pdp.pd_numero) 
  where lf.pd_numero is null and lf.px_numero is null and pdp.so_numero=3 and px_datedebut<'01/09/2005' AND lf.fa_numero=table_lignefacture.fa_numero;

-- Attribution arbitraire pour les restants
\a
\o facture_a_voir.csv
SELECT * from table_lignefacture join table_facture using (fa_numero) where pd_numero is null or px_numero is null;
\o
\a
UPDATE table_lignefacture SET px_numero=1400038, pd_numero=1400005 WHERE pd_numero is null and px_numero is null;

INSERT INTO table_devis (de_numero,pe_numero,de_date,de_libelle,de_reduction,em_numero,fa_numero, de_montantttc, de_montantht)
  SELECT nextval('seq_devis'), pe_numero,fa_date,fa_libelle,fa_reduction,50, fa_numero, fa_montantttc, fa_montantht
    FROM table_facture WHERE de_numero IS NULL;

UPDATE table_facture SET de_numero=d.de_numero 
  FROM table_devis AS d 
  WHERE d.fa_numero IS NOT NULL AND table_facture.fa_numero=d.fa_numero;

INSERT INTO table_ligne(l_numero,de_numero,pd_numero,l_quantite,l_montantht,l_montantttc,px_numero)
  SELECT nextval('seq_ligne'),de_numero,lf.pd_numero,lf_quantite,lf_montantht,lf_montantttc, px_numero
    FROM table_lignefacture as lf 
         JOIN table_facture USING (fa_numero)
         JOIN table_devis as de USING (de_numero)
    WHERE de.fa_numero IS NOT NULL;
 
UPDATE table_devis SET em_numero=emp.em_numero 
  FROM table_employe AS emp 
  WHERE em_login=table_devis.update_user AND (table_devis.em_numero IS NULL);

-- Migration par societe generique
SET SEARCH_PATH TO public,systeme,base,sacea;
\i migrate.sql
/*
SET SEARCH_PATH TO public,systeme,base,fdsea;
\i migrate.sql
SET SEARCH_PATH TO public,systeme,base,aava;
\i migrate.sql
SET SEARCH_PATH TO public,systeme,base,sci;
\i migrate.sql
*/
-- Post Mises a jour specifiques

--COMMIT TRANSACTION;
