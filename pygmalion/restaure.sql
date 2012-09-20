\c gestsea
INSERT INTO base.base_societe(code,nom) VALUES ('sacea','SACEA');
INSERT INTO base.base_societe_utilisateur_rel(societe_id,utilisateur_login) VALUES (1,'brice');
SELECT systeme.set_search_path(false);
--INSERT INTO base_partenaire () VALUES ();