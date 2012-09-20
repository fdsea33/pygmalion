-- Suppressions
DELETE FROM compta_exercice;
DELETE FROM compta_compteperm;
DELETE FROM base_acces;
DELETE FROM base_partenaire_type;






-- Etablissement
INSERT INTO base_societe_etablissement (societe_id,code,nom,nic)
  SELECT cursoc(),'ETAB0001','Siège','00000';

-- Services
INSERT INTO base_societe_service (code,nom,etablissement_id)
  SELECT se_numero::varchar,se_nom,1
    FROM table_service WHERE se_societe=cursoc();

-- Droits et acces ???
INSERT INTO base_droits_profil (code, nom)
  SELECT to_char(dp_numero,'FM099'),dp_libelle
    FROM table_droitprofil;

INSERT INTO base_acces(code,nom,valeur)
  SELECT 'AC'||to_char(ac_niveau,'FM0999999'),ac_libelle,ac_niveau
    FROM table_acces;

-- Employes
INSERT INTO base_societe_employe(service_id,utilisateur_id,profil_id,acces_id,nom,prenom,initiales,actif,role,telephone,mobile,email,note)
  SELECT ser.id, u.id, p.id, a.id, ag_nom, ag_prenom,ag_initiales,ag_actif,ag_role,ag_telephone,ag_mobile,ag_email,ag_commentaire
    FROM table_employe
         JOIN table_agent ON (em_agent=ag_numero)
         JOIN table_service ON (em_service=se_numero)
         JOIN base_societe_service AS ser ON (se_numero=code)
         JOIN systeme_utilisateur AS u ON (u.login=em_login)
         JOIN base_droits_profil AS p ON (p.code::integer=dp_numero)
         JOIN table_acces AS ac ON (em_acces=ac_numero)
         JOIN base_acces AS a ON (ac.ac_niveau=a.valeur)
    WHERE se_societe=cursoc();

-- Type de personnes
INSERT INTO base_partenaire_type (nom,titre,actif) 
  SELECT distinct pe_titre||' ', pe_titre, count(pe_numero)>1 AS total 
    FROM table_personne group by 1,2;

-- Personnes
INSERT INTO base_partenaire (id,nom,prenom,type_id,actif,naissance_date) 
  SELECT pe_numero-1000000, pe_nom, pe_prenom, id, COALESCE(ep_numero=500000002,true), pe_naissance 
    FROM table_personne left join base_partenaire_type on (pe_titre=titre);
SELECT setval('base_partenaire_id_seq',COALESCE(MAX(id),0)+1,false) FROM base_partenaire;

-- Adresses
\a
\o adresses-reduites.csv
SELECT * 
  FROM table_adresse 
       JOIN table_personne USING (pe_numero) 
  WHERE length(pe_complement)>38 OR length(ad_addr1)>38 OR length(ad_addr2)>32 OR length(ad_addr3)>38;
\o
\a

INSERT INTO base_partenaire_contact (actif,date_fin,partenaire_id,type_id,complement,ligne3,voie,ligne5,codepostal_commune_id,telephone,fax,mobile,email)
  SELECT DISTINCT ad_active, ad_datestop, pe.pe_numero-1000000, 1, SUBSTR(pe_complement,1,38), SUBSTR(ad_addr1,1,38), SUBSTR(ad_addr2,1,32), SUBSTR(ad_addr3,1,38), cpcom.id, 
CASE WHEN STRPOS(contacts,'TEL:')>0 THEN SPLIT_PART(SUBSTRING(contacts FROM STRPOS(contacts,'TEL:')+4),'>',1) END,
CASE WHEN STRPOS(contacts,'FAX:')>0 THEN SPLIT_PART(SUBSTRING(contacts FROM STRPOS(contacts,'FAX:')+4),'>',1) END,
CASE WHEN STRPOS(contacts,'MOB:')>0 THEN SPLIT_PART(SUBSTRING(contacts FROM STRPOS(contacts,'MOB:')+4),'>',1) END,
CASE WHEN STRPOS(contacts,'EML:')>0 THEN SPLIT_PART(SUBSTRING(contacts FROM STRPOS(contacts,'EML:')+4),'>',1) END
    FROM table_adresse 
         JOIN table_personne AS pe USING (pe_numero)
         JOIN table_ville AS vi USING (vi_numero)
         JOIN table_codepostal AS cp USING (cp_numero)
         JOIN base_codepostal AS bcp ON (cp.cp_codepostal=bcp.numero)
         JOIN base_codepostal_commune_rel AS cpcom ON (vi.id=cpcom.commune_id AND bcp.id=codepostal_id);

/*         
  SELECT DISTINCT ad_active AND (COALESCE(ejtel.ej_actif,true) AND COALESCE(ejfax.ej_actif,true) AND COALESCE(ejmob.ej_actif,true) AND COALESCE(ejeml.ej_actif,true)), ad_datestop, pe.pe_numero-1000000, 1, pe_complement, ad_addr1, ad_addr2, ad_addr3, cpcom.id, ctel.cn_coordonnee, cfax.cn_coordonnee, cmob.cn_coordonnee, ceml.cn_coordonnee
    FROM table_adresse 
         JOIN table_personne AS pe USING (pe_numero)
         JOIN table_ville AS vi USING (vi_numero)
         JOIN table_codepostal AS cp USING (cp_numero)
         JOIN base_codepostal AS bcp ON (cp.cp_codepostal=bcp.numero)
         JOIN base_codepostal_commune_rel AS cpcom ON (vi.id=cpcom.commune_id AND bcp.id=codepostal_id)
         LEFT JOIN table_estjoignable AS ejtel USING (pe_numero) LEFT JOIN table_contact AS ctel ON (ejtel.cn_numero=ctel.cn_numero AND ctel.cn_type='TELEPHONE')
         LEFT JOIN table_estjoignable AS ejfax USING (pe_numero) LEFT JOIN table_contact AS cfax ON (ejfax.cn_numero=cfax.cn_numero AND cfax.cn_type='FAX')
         LEFT JOIN table_estjoignable AS ejmob USING (pe_numero) LEFT JOIN table_contact AS cmob ON (ejmob.cn_numero=cmob.cn_numero AND cmob.cn_type='PORTABLE')
         LEFT JOIN table_estjoignable AS ejeml USING (pe_numero) LEFT JOIN table_contact AS ceml ON (ejeml.cn_numero=ceml.cn_numero AND ceml.cn_type='E-MAIL');
  */            
 

-- Attributs
ALTER TABLE table_typeattribut ADD id INTEGER NOT NULL DEFAULT nextval('base_partenaire_attribut_type_id_seq');
INSERT INTO base_partenaire_attribut_type(id,code,nom)
  SELECT id,'TA'||id,ta_nom FROM table_typeattribut;
INSERT INTO base_partenaire_attribut_categorie (id,attribut_type_id,code,nom)
  SELECT cr_numero,id,'CR'||cr_numero,cr_libelle
    FROM table_categorie JOIN table_typeattribut USING (ta_numero);
SELECT setval('base_partenaire_attribut_categorie_id_seq',COALESCE(MAX(id))+1,false) FROM base_partenaire_attribut_categorie;

INSERT INTO base_partenaire_attribut (partenaire_id,type_id,categorie_id,note)
  SELECT pe_numero-1000000, id, cr_numero, at_valeur
    FROM table_attribut JOIN table_typeattribut using (ta_numero);

-- Observations
INSERT INTO base_partenaire_observation(partenaire_id,niveau,contenu)
  SELECT pe_numero-1000000,COALESCE(ob_niveau,1),ob_observation
    FROM table_observation;

-- Impressions
INSERT INTO base_impression_type(code) VALUES ('BORDREGL');
INSERT INTO base_impression_type(code) VALUES ('DIVERS');

ALTER TABLE base_impression DISABLE TRIGGER t3_tg_build_printer0;

INSERT INTO base_impression(type_id,code,nom,defaut,actif,modele)
  SELECT CASE WHEN im_libelle ilike '%devis%' THEN 1
              WHEN im_libelle ilike '%facture%' THEN 2
              WHEN im_libelle ilike '%avoir%' THEN 3
              WHEN im_libelle ilike '%borde%' THEN 5 
              ELSE 6 END AS type_id, 'IM'||im_numero-500000000,im_libelle,im_defaut,im_defaut,im_modele
    FROM table_impression WHERE im_societe=cursoc();

ALTER TABLE base_impression ENABLE TRIGGER t3_tg_build_printer0;

-- Exercice
INSERT INTO compta_exercice (code,date_debut,date_fin,cloture, actif)
  SELECT 'EX'||EXTRACT(YEAR FROM ex_datedebut), ex_datedebut,ex_datefin,ex_cloture, ex_actif
    FROM table_exercice
    WHERE so_numero=cursoc();

-- Comptes généraux et auxiliaires
INSERT INTO compta_compteperm(nom,numero,acces_id,immuable,signe,general,accept_aux,utilisable,lettrable,groupable)
  SELECT cg_libelle,RTRIM(COALESCE(numero,'0'),'0'),acces.id,false,cg_debit,true,cg_accepteaux,cg_utilisable,cg_lettrable,cg_groupable
    FROM table_comptegen 
         JOIN table_acces USING (ac_numero) 
         JOIN base_acces AS acces ON (ac_niveau=acces.valeur) 
    WHERE so_numero=cursoc();

--  SELECT ca_libelle,CASE WHEN SUBSTR(ca_numcompte,1,1)!='0' THEN cg.numero||'y'||round(90000*random()) ELSE RTRIM(COALESCE(cg.numero,'0'),'0')||ca_numcompte END,acces.id,false,ca_debit,false,false,true,true,true,cp.id

ALTER TABLE compta_compteperm ADD pid integer default null references base_partenaire(id);

INSERT INTO compta_compteperm(nom,numero,acces_id,immuable,signe,general,accept_aux,utilisable,lettrable,groupable,parent_compteperm_id,pid)
  SELECT ca_libelle, CASE WHEN SUBSTR(ca_numcompte,1,1)!='0' THEN cg.numero ELSE RTRIM(COALESCE(cg.numero,'0'),'0')||'.'||ca_numcompte END||'_'||round(999*random()), acces.id, false, ca_debit, false, false, true, true, true, cp.id, p.id
    FROM table_compteaux AS ca
         JOIN table_comptegen AS cg USING (cg_numero) 
         JOIN compta_compteperm AS cp ON (cp.numero=RTRIM(COALESCE(cg.numero,'0'),'0')) 
         JOIN table_acces AS ac ON (ca.ac_numero=ac.ac_numero) 
         JOIN base_acces AS acces ON (ac_niveau=acces.valeur) 
         LEFT JOIN base_partenaire AS p ON (cp.numero ilike '411%' AND p.id=ca_numcompte::integer)
    WHERE so_numero=cursoc();

INSERT INTO compta_compteperm_partenaire_rel(compteperm_id,partenaire_id)
  SELECT id, pid
    FROM compta_compteperm 
    WHERE pid IS NOT NULL AND pid>0;


-- Produits
INSERT INTO gestion_produit(id,code,nom,date_debut,date_fin,actif,reduction,inquantifiable,sans_stock,service,categorie_id)
  SELECT pd_numero, 'PROD'||pd_numero,INITCAP(pd_libelle)||CASE WHEN NOT pd_actif THEN ' *'||round(999*random())||'*' ELSE '' END, '01/01/1970', '01/01/3000', pd_actif, pd_reduction, pd_sansquantite, true, false, 1
    FROM table_produit
    WHERE so_numero=cursoc();
SELECT setval('gestion_produit_id_seq',COALESCE(MAX(id),0)+1,true) FROM gestion_produit;

-- Prix & Taxes
ALTER TABLE gestion_produit_taxe ADD tv_numero integer not null references public.table_tva(tv_numero);
INSERT INTO gestion_produit_taxe (code,nom,taux,montant,actif,compteperm_id, tv_numero)
  SELECT tv_code,'TVA '||tv_taux||'%',tv_taux/100,0,tv_actif,cp.id, tv_numero
    FROM table_tva as tva
         JOIN table_comptegen AS cg USING (cg_numero)
         JOIN compta_compteperm AS cp ON (cp.numero=RTRIM(COALESCE(cg.numero,'0'),'0'))
    WHERE tva.so_numero=cursoc();

ALTER TABLE gestion_produit_prix ADD px_numero integer not null references public.table_prix(px_numero);

INSERT INTO gestion_produit_prix (produit_id, achat, date_debut, date_fin, montant_ht, px_numero)
  SELECT pd_numero,false,CASE WHEN px_datedebut IS NULL THEN '01/01/1970' ELSE px_datedebut END, CASE WHEN px_actif THEN '01/01/3000' ELSE px.update_time END::date, px_tarifht, px_numero
    FROM table_prix as px JOIN table_produit USING (pd_numero) 
    WHERE so_numero=cursoc();

INSERT INTO gestion_produit_prix_taxe_rel(prix_id,taxe_id,base_montant)
  SELECT px.id,tx.id, 0
    FROM gestion_produit_prix AS px
         JOIN table_prix USING (px_numero)
         JOIN gestion_produit_taxe AS tx USING (tv_numero);

-- Reduction
INSERT INTO gestion_reduction (code,nom,taux) VALUES ('R-','Pas de réductions',0);
INSERT INTO gestion_reduction (code,nom,taux) VALUES ('RA','Adhérent',0.15);
INSERT INTO gestion_reduction (code,nom,taux) VALUES ('RA+','Adhérent SACEA',0.25);

-- Adhesion
ALTER TABLE gestion_adhesion_type ADD ah_numero integer not null references public.table_adherence(ah_numero);
INSERT INTO gestion_adhesion_type (code,nom,reduction_id,ah_numero)
  SELECT 'ADH'||to_char(ah_numero-500000000,'FM0999'),ah_libelle,rd.id, ah_numero
    FROM table_adherence 
         JOIN table_produit USING (pd_numero)
         JOIN gestion_reduction AS rd ON (taux=ah_reduction/100)
    WHERE so_numero=cursoc();

INSERT INTO gestion_adhesion_type_produit_rel (adhesion_type_id,produit_id)
  SELECT t.id, pd_numero
    FROM table_adherence
         JOIN gestion_adhesion_type AS t USING (ah_numero)
         JOIN table_produit USING (pd_numero)
    WHERE so_numero=cursoc();

ALTER TABLE gestion_adhesion_periode ADD po_numero integer not null references public.table_periode(po_numero);
INSERT INTO gestion_adhesion_periode (code,date_debut,date_fin, po_numero)
  SELECT 'PER'||EXTRACT(YEAR FROM po_debut),po_debut,po_fin, po_numero
    FROM table_periode ORDER BY 1;

INSERT INTO gestion_adhesion_type_periode_rel(type_id,periode_id)
  SELECT t.id, p.id
    FROM table_periodeadherence 
         JOIN gestion_adhesion_type AS t USING (ah_numero)
         JOIN gestion_adhesion_periode AS p USING (po_numero);



-- Ventes::Commandes
UPDATE table_devis SET em_numero=1
  WHERE de_numero IN (SELECT de_numero FROM table_devis LEFT JOIN table_ligne USING (de_numero) JOIN table_produit USING (pd_numero) WHERE so_numero=cursoc())
    AND em_numero IN (SELECT em_numero FROM table_employe 
      WHERE em_login NOT IN (select utilisateur_login from table_devis LEFT JOIN table_ligne USING (de_numero) JOIN table_produit USING (pd_numero) JOIN table_employe USING (em_numero) JOIN base_societe_employe AS e ON (em_login=utilisateur_login) WHERE so_numero=cursoc()) 
        AND em_login IN (select em_login from table_devis LEFT JOIN table_ligne USING (de_numero) JOIN table_produit USING (pd_numero) JOIN table_employe USING (em_numero) WHERE so_numero=cursoc()));


INSERT INTO gestion_ventes_commande(numero, date, immodifiable, employe_id, partenaire_id, reduction_taux, montant_ttc, montant_ht, acompte, objet, civilites, introduction, commande_contact_id, facture_contact_id, livraison_contact_id)
  SELECT DISTINCT ON (de_numero) de_numero ,de_date,true, e.id, pe_numero-1000000, de_reduction/100, de_montantttc, de_montantht, de_acompte, de_libelle, de_civilites, de_introduction, c.id, c.id, c.id
    FROM table_devis 
         LEFT JOIN base_partenaire_contact AS c ON (pe_numero-1000000=partenaire_id and c.actif)
         LEFT JOIN table_ligne USING (de_numero)
         JOIN table_produit USING (pd_numero)
         JOIN table_employe USING (em_numero)
         JOIN base_societe_employe AS e ON (em_login=utilisateur_login)
    WHERE so_numero=cursoc();

ALTER TABLE gestion_ventes_commande DISABLE TRIGGER ALL;

UPDATE gestion_ventes_commande SET reduction_taux=COALESCE(de_reduction/100,0) FROM table_devis WHERE de_numero=numero::integer;


ALTER TABLE gestion_ventes_commande_ligne DISABLE TRIGGER ALL;

INSERT INTO gestion_ventes_commande_ligne (nom, immodifiable, a_inclure, inclus, commande_id, produit_id, prix_id, reduction, quantite, montant_unitaire_ht, montant_unitaire_ttc, montant_brut_ht, montant_brut_ttc, montant_ht, montant_ttc, description)
  SELECT p.nom, true,true,true,c.id,p.id, prix.id, p.reduction, l_quantite,prix.montant_ht, prix.montant_ttc, l_montantht, l_montantttc, l_montantht*(1-CASE WHEN p.reduction THEN c.reduction_taux ELSE 0 END), l_montantttc*(1-CASE WHEN p.reduction THEN c.reduction_taux ELSE 0 END ), l_notes
    FROM table_ligne
         JOIN gestion_produit AS p ON (pd_numero=p.id)
         JOIN gestion_produit_prix AS prix USING (px_numero)
         JOIN gestion_ventes_commande AS c ON (de_numero=c.numero);
/*
CREATE VIEW gvc_totaux AS 
  SELECT commande_id, COALESCE(SUM(lig.montant_ttc),0) AS ttc, COALESCE(SUM(lig.montant_ht),0) AS ht 
    FROM gestion_ventes_commande_ligne AS lig 
    GROUP BY 1;
*/
UPDATE gestion_ventes_commande SET montant_ttc=de_montantttc, montant_ht=de_montantht FROM table_devis WHERE numero=de_numero;

--DROP VIEW gvc_totaux;

-- Ventes::Factures

--ALTER TABLE gestion_ventes_facture ALTER commande_id DROP NOT NULL;
--ALTER TABLE gestion_ventes_facture DISABLE TRIGGER ALL;
ALTER TABLE gestion_ventes_facture ALTER piece_id DROP NOT NULL;
ALTER TABLE gestion_ventes_facture_ligne DISABLE TRIGGER ALL;
ALTER TABLE gestion_ventes_facture ENABLE TRIGGER t34_tg_manage_ventes_facture0;
--ALTER TABLE gestion_ventes_facture DISABLE TRIGGER t33_tg_complete_ventes_facture2;
ALTER TABLE compta_piece DISABLE TRIGGER t18_tg_manage_compta_piece0;
ALTER TABLE compta_piece DISABLE TRIGGER t18_tg_manage_compta_piece1;
ALTER TABLE compta_piece DISABLE TRIGGER t18_tg_manage_compta_piece2;

INSERT INTO gestion_ventes_facture(numero,commande_id,date)
  SELECT fa_numfact, c.id, fa_date
    FROM table_facture 
         JOIN gestion_ventes_commande AS c ON (de_numero=c.numero);



-- Ventes::Reglements
ALTER TABLE gestion_ventes_reglement_mode ALTER banque_compte_id DROP NOT NULL;
ALTER TABLE gestion_ventes_reglement_mode ADD mr_numero integer not null references public.table_modereglement(mr_numero);
INSERT INTO gestion_ventes_reglement_mode (nom,compteperm_id, actif, mr_numero)
  SELECT mr_libelle, cp.id, mr_actif, mr_numero
    FROM table_modereglement AS mr
         JOIN table_comptegen AS cg USING (cg_numero)
         JOIN compta_compteperm AS cp ON (cp.numero=RTRIM(COALESCE(cg.numero,'0'),'0'))
    WHERE mr.so_numero=cursoc();


INSERT INTO gestion_ventes_reglement(id,partenaire_id, mode_id, banque, numero_compte, reference, date_reglement, date_saisie, montant)
  SELECT rg_numero,pe_numero-1000000, m.id, COALESCE(rg_libellebanque,'<???>'), COALESCE(rg_numerocompte,'<???>'), COALESCE(rg_reference,'<???>'), rg_date, update_time::date, rg_montant
    FROM table_reglement
         JOIN gestion_ventes_reglement_mode AS m USING (mr_numero);
SELECT setval('gestion_ventes_reglement_id_seq', COALESCE(MAX(id),0)+1,false) FROM gestion_ventes_reglement;

-- Ventes::Reversements
ALTER TABLE gestion_ventes_reversement_mode ADD mp_numero integer not null references public.table_moderepartition(mp_numero);
INSERT INTO gestion_ventes_reversement_mode (nom,code,compteperm_id, actif, mp_numero, societe_id)
  SELECT mp_libelle, 'MP'||mp_numero, cp.id, mp_actif, mp_numero, mp_societe
    FROM table_moderepartition AS mp
         JOIN table_comptegen AS cg USING (cg_numero)
         JOIN compta_compteperm AS cp ON (cp.numero=RTRIM(COALESCE(cg.numero,'0'),'0'))
    WHERE mp.so_numero=cursoc();


INSERT INTO gestion_ventes_reversement(id,reglement_id, mode_id, montant)
  SELECT rp_numero,rg_numero,m.id,rp_montant
    FROM table_repartition
         JOIN gestion_ventes_reversement_mode AS m USING (mp_numero);
SELECT setval('gestion_ventes_reversement_id_seq', COALESCE(MAX(id),0)+1,false) FROM gestion_ventes_reversement;




-- Suppression des colonnes de migration
/*
ALTER TABLE compta_compteperm DROP pid;
ALTER TABLE gestion_adhesion_type DROP ah_numero;
ALTER TABLE gestion_adhesion_periode DROP po_numero;
ALTER TABLE gestion_produit_taxe DROP tv_numero;
ALTER TABLE gestion_produit_prix DROP px_numero;
*/
-- Réactivation des triggers
ALTER TABLE gestion_ventes_facture ENABLE TRIGGER ALL;
ALTER TABLE gestion_ventes_commande ENABLE TRIGGER ALL;
ALTER TABLE gestion_ventes_commande_ligne ENABLE TRIGGER ALL;

