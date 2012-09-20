<?xml version="1.0" encoding="UTF-8"?>

<analysis name="GestSEA" version="0.0.0" 
  xmlns:typens="urn:gestsea"
  xmlns="http://www.pygmalion.org/analysis/">

  <!-- Liens, Cotisations, Subdivisions géographique, Responsabilités -->
  <classes>

    <!-- Cotisations (multi-sociétés) -->
    <class name="gestsea_cotisation_parametrage" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true" meaning="major"/>
      <property uid="1001" name="avec_defaut_produit"  type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="defaut_produit_code"  type="code"/>
      <property uid="1001" name="lot_dernier_numero"   type="integer" notnull="true" default="0"/>
      <property uid="1001" name="facture_objet"        type="text" notnull="true"/>
      <constraint type="check" expr="NOT avec_defaut_produit OR (avec_defaut_produit AND defaut_produit_code IS NOT NULL)"/>
    </class>

    <class name="gestsea_cotisation_lot" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1001" name="numero"               type="integer" notnull="true" meaning="major"/>
      <property uid="1001" name="cotisation_id"        type="id" notnull="true" unique="true"/>
      <property uid="1001" name="facturable"           type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="en_facture"           type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="erreur_message"       type="text" notnull="true" default="false"/>
      <property uid="1001" name="commande_id"          type="id" index="default"/>
      <property uid="1001" name="facture_id"           type="id" index="default"/>
      <constraint type="foreign-key" column="cotisation_id" references="gestsea_cotisation(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestsea_cotisation" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true" meaning="major"/>
      <property uid="1001" name="partenaire_id"        type="id" notnull="true" index="default" meaning="significant"/>
      <property uid="1001" name="date"                 type="date" notnull="true" meaning="significant"/>
      <property uid="1001" name="reglement_autre"      type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="reglement_id"         type="id" index="default"/>
      <property uid="1001" name="reglement_libelle"    type="text" />
      <property uid="1001" name="reglement_mode_id"    type="id" notnull="true" index="default"/>
      <property uid="1001" name="reglement_date"       type="date"/>
      <property uid="1002" name="reglement_banque"     type="name"/>
      <property uid="1002" name="reglement_numcompte"  type="name"/>
      <property uid="1002" name="reglement_reference"  type="name"/>
      <property uid="1001" name="montant_ttc"          type="money" notnull="true"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true"/>
      <constraint type="check" expr="(NOT reglement_autre AND reglement_date IS NOT NULL AND reglement_banque IS NOT NULL AND reglement_numcompte IS NOT NULL AND reglement_reference IS NOT NULL) OR (reglement_autre AND reglement_id IS NOT NULL)"/>
    </class>

    <class name="gestsea_cotisation_ligne" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1001" name="cotisation_id"        type="id" notnull="true"/>
      <property uid="1001" name="produit_id"           type="id" notnull="true"/>
      <property uid="1001" name="produit_code"         type="code" notnull="true" meaning="major"/>
      <property uid="1001" name="quantite"             type="quantity" notnull="true" default="1" meaning="significant"/>
      <property uid="1001" name="montant_ttc"          type="money" notnull="true" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true"/>
      <constraint type="check" expr="quantite>0"/>
      <constraint type="check" expr="montant_ttc>=0 AND montant_ht>=0"/>
      <constraint type="foreign-key" column="cotisation_id" references="gestsea_cotisation(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="produit_id" references="gestsea_cotisation_produit(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestsea_cotisation_produit" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1001" name="nom"                  type="name" notnull="true" unique="true" meaning="major"/>
      <property uid="1001" name="code"                 type="code" notnull="true" meaning="significant"/>
      <property uid="1001" name="societe_id"           type="id" notnull="true"/>
      <property uid="1001" name="montant_ttc"          type="money" notnull="true" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true"/>
      <constraint type="check" expr="montant_ttc>=0 AND montant_ht>=0"/>
      <constraint type="foreign-key" column="societe_id" references="base_societe(id)" ondelete="restrict" onupdate="cascade"/>
    </class>



    <!-- Groupes de cantons -->
    <class name="gestsea_canton_groupe" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1001" name="nom"                  type="name" unique="true" meaning="major"/>
      <property uid="1001" name="description"          type="text"/>
    </class>


    <class name="gestsea_canton_groupe_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1001" name="canton_id"            type="id" notnull="true"/>
      <property uid="1001" name="groupe_id"            type="id" notnull="true"/>
      <constraint type="foreign-key" column="canton_id" references="base_canton(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="groupe_id" references="gestsea_canton_groupe(id)" ondelete="cascade" onupdate="cascade"/>
    </class>


    <!-- (Geo-)Structures -->
    <class name="gestsea_structure" schema="societe" primary-key="id">
      <property uid="1001" name="id"                  type="serial"  notnull="true"/>
      <property uid="1003" name="code"                type="code"    notnull="true" unique="true"/>
      <property uid="1003" name="code_etendu"         type="text"    notnull="true" unique="true" mode="auto" meaning="significant"/>
      <property uid="1003" name="nom"                 type="name"    notnull="true" meaning="major"/>
      <property uid="1003" name="externe"             type="boolean" notnull="true" default="false"/>
      <property uid="1013" name="parent_structure_id" type="id"/>
      <property uid="1013" name="partenaire_id"       type="id"      notnull="true"/>
      <constraint type="foreign-key" column="parent_structure_id"  references="gestsea_structure(id)" ondelete="restrict" onupdate="cascade"/>      
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="restrict" onupdate="cascade"/>
    </class>
    
    <class name="gestsea_structure_commune_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"                  type="serial"  notnull="true" meaning="major"/>
      <property uid="1013" name="structure_id"        type="id"      notnull="true"/>
      <property uid="1013" name="commune_id"          type="id"      notnull="true"/>
      <constraint type="foreign-key" column="structure_id" references="gestsea_structure(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="commune_id"   references="base_commune(id)" ondelete="restrict" onupdate="cascade"/>
    </class>
    
    <!-- Juridique -->
    <class name="gestsea_juridique_procedure_commande_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"                type="serial"  notnull="true" meaning="major"/>
      <property uid="1001" name="commande_id"       type="id"      notnull="true"/>
      <property uid="1001" name="procedure_id"      type="id"      notnull="true"/>
      <property uid="1003" name="ordre"             type="integer" notnull="true" default="0"/>
      <property uid="1003" name="complement"        type="text"/>
      <constraint type="foreign-key" column="commande_id"     references="gestion_ventes_commande(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="procedure_id" references="gestsea_juridique_procedure(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestsea_juridique_procedure" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1003" name="code"             type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="description"      type="text"/>
    </class>

    <class name="gestsea_juridique_tache" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"   notnull="true" meaning="major"/>
      <property uid="1003" name="nom"              type="name"     notnull="true" meaning="significant"/>
      <property uid="1003" name="date"             type="date"     notnull="true" meaning="significant"/>
      <property uid="1003" name="duree"            type="quantity" notnull="true" default="1" meaning="significant"/>
      <property uid="1003" name="partenaire_id"    type="id"       notnull="true" meaning="significant"/>
      <property uid="1001" name="type_id"          type="id"       notnull="true"/>
      <property uid="1001" name="employe_id"       type="id"       notnull="true" meaning="significant"/>
      <property uid="1003" name="dossier_id"       type="id"/>
      <property uid="1003" name="description"      type="text"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id" references="gestsea_juridique_tache_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="dossier_id" references="gestsea_juridique_dossier(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="employe_id" references="base_societe_employe(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestsea_juridique_tache_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1003" name="code"             type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"              type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="description"      type="text"/>
    </class>


    <class name="gestsea_juridique_dossier" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1003" name="nom"              type="name"    notnull="true" meaning="major"/>
      <property uid="1003" name="complement"       type="name"    notnull="true"/>
      <property uid="1003" name="employe_id"       type="id"      notnull="true" meaning="significant"/>
      <property uid="1003" name="etat_id"          type="id"      notnull="true" meaning="significant"/>
      <property uid="1003" name="type_id"          type="id"      notnull="true"/>
      <property uid="1003" name="date_ouverture"   type="date"/>
      <property uid="1003" name="date_cloture"     type="date"/>
      <property uid="1003" name="description"      type="text"/>
      <constraint type="foreign-key" column="employe_id" references="base_societe_employe(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="etat_id" references="gestsea_juridique_dossier_etat(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id" references="gestsea_juridique_dossier_type(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestsea_juridique_dossier_commande" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true" meaning="major"/>
      <property uid="1003" name="ordre"            type="integer" notnull="true" default="1"/>
      <property uid="1003" name="dossier_id"       type="id"      notnull="true"/>
      <property uid="1003" name="commande_id"      type="id"      notnull="true"/>
      <property uid="1003" name="note"             type="text"/>
      <constraint type="foreign-key" column="dossier_id" references="gestsea_juridique_dossier(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="commande_id" references="gestion_ventes_commande(id)" ondelete="cascade" onupdate="cascade"/>      
    </class>


    <class name="gestsea_juridique_dossier_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1003" name="nom"              type="name"    notnull="true" meaning="major"/>
      <property uid="1003" name="service_id"       type="id"      notnull="true"/>
      <property uid="1003" name="note"             type="text"/>
      <constraint type="foreign-key" column="service_id" references="base_societe_service(id)" ondelete="restrict" onupdate="cascade"/>      
    </class>

    <class name="gestsea_juridique_dossier_etat" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1003" name="nom"              type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="note"             type="text"/>
      <record>
        <field>1</field>
        <field>Ouvert</field>
        <field></field>
      </record>
      <record>
        <field>2</field>
        <field>Cloturé</field>
        <field></field>
      </record>
      <record>
        <field>3</field>
        <field>Abandonné</field>
        <field></field>
      </record>
    </class>

    <!-- Publication -->
    <class name="gestsea_publication" schema="societe" primary-key="id">
      <property uid="1001" name="id"              type="serial"  notnull="true"/>
      <property uid="1003" name="code"            type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"             type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="nb_prerelances"  type="integer" notnull="true"/>
      <property uid="1003" name="nb_postrelances" type="integer" notnull="true"/>
      <property uid="1003" name="numero_prochain" type="integer" notnull="true"/>
      <property uid="1003" name="contact_type_id" type="id"      notnull="true"/>      
      <constraint type="foreign-key" column="contact_type_id" references="base_partenaire_contact_type(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestsea_publication_parution" schema="societe" primary-key="id">
      <property uid="1001" name="id"              type="serial"  notnull="true"/>
      <property uid="1003" name="publication_id"  type="id"      notnull="true"/>
      <property uid="1003" name="code"            type="name"    notnull="true" unique="true" meaning="significant"/>
      <property uid="1003" name="numero"          type="integer" notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="date"            type="date"    notnull="true"/>
      <property uid="1003" name="titre"           type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="description"     type="text"/>
      <constraint type="foreign-key" column="publication_id" references="gestsea_publication(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestsea_publication_abonnement" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"              type="serial"  notnull="true" meaning="major"/>
      <property uid="1003" name="publication_id"  type="id"      notnull="true"/>
      <property uid="1003" name="produit_id"      type="id"      notnull="true" unique="true"/>
      <property uid="1003" name="nb_numeros"      type="integer" notnull="true" default="1" meaning="significant"/>
      <property uid="1003" name="differe"         type="integer" notnull="true" default="0" meaning="significant"/>
      <constraint type="foreign-key" column="publication_id" references="gestsea_publication(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="produit_id" references="gestion_produit(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestsea_publication_abonnement_commande" schema="societe" primary-key="id">
      <property uid="1001" name="id"                type="serial"  notnull="true" meaning="major"/>
      <property uid="1003" name="commande_ligne_id" type="id" notnull="true"/>
      <property uid="1003" name="abonnement_id"     type="id" notnull="true"/>
      <property uid="1003" name="publication_id"    type="id" notnull="true" mode="auto"/>
      <property uid="1003" name="partenaire_id"     type="id" notnull="true" meaning="significant"/>
      <property uid="1003" name="contact_id"        type="id" notnull="true" nevernull="true"/>
      <property uid="1003" name="nb_exemplaires"    type="integer" notnull="true" default="1"/>
      <constraint type="foreign-key" column="commande_ligne_id" references="gestion_ventes_commande_ligne(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="publication_id" references="gestsea_publication(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="abonnement_id" references="gestsea_publication_abonnement(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="contact_id" references="base_partenaire_contact(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestsea_publication_abonnement_routage" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true" meaning="major"/>
      <property uid="1003" name="commande_id"      type="id" notnull="true"/>
      <property uid="1003" name="facture_ligne_id" type="id" notnull="true"/>
      <property uid="1003" name="facture_id"       type="id" notnull="true" mode="auto"/>
      <property uid="1003" name="partenaire_id"    type="id" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1003" name="contact_id"       type="id" notnull="true" mode="auto"/>
      <property uid="1003" name="abonnement_id"    type="id" notnull="true" mode="auto"/>
      <property uid="1003" name="publication_id"   type="id" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1003" name="nb_exemplaires"   type="integer" notnull="true" default="1" mode="auto" meaning="significant"/>
      <property uid="1003" name="numero_debut"     type="integer" notnull="true" default="1" mode="auto" meaning="significant"/>
      <property uid="1003" name="numero_fin"       type="integer" notnull="true" default="1" mode="auto" meaning="significant"/>
      <property uid="1003" name="suspendu"         type="boolean" notnull="true" default="false" nevernull="true"/>
      <constraint type="foreign-key" column="commande_id" references="gestsea_publication_abonnement_commande(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="contact_id" references="base_partenaire_contact(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_id" references="gestion_ventes_facture(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_ligne_id" references="gestion_ventes_facture_ligne(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="abonnement_id" references="gestsea_publication_abonnement(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="publication_id" references="gestsea_publication(id)" ondelete="cascade" onupdate="cascade"/>
    </class>


  </classes>

  <functions>

    <function name="fc_traite_lot" schema="societe">
      <parameters>
        <parameter name="a_lot_numero" type="integer"/>
      </parameters>
      <return type="integer"/>
      <code>
  total integer;
  p_societe_id base_societe.id%TYPE;
  p_commande_id gestion_ventes_commande.id%TYPE;
  p_facture_id gestion_ventes_facture.id%TYPE;
  ok boolean;
  l record;
  cotis gestsea_cotisation%ROWTYPE;
  cotis_ligne gestsea_cotisation_ligne%ROWTYPE;
BEGIN
  /* Verifications  (du parametrage et des produits à faire!)*/
  SELECT count(*) FROM gestsea_cotisation_parametrage INTO total;
  IF total!=1 THEN
    RAISE EXCEPTION 'Le paramètrage des cotisations est incorrect (nb_enreg!=1).';
  END IF;
  SELECT count(*) FROM gestsea_cotisation_lot WHERE numero=a_lot_numero AND NOT en_facture INTO total;
  IF 0>=total THEN
    RETURN 0;
  END IF;
  FOR l IN SELECT lot.id AS lid, cot.* FROM gestsea_cotisation_lot AS lot JOIN gestsea_cotisation AS cot ON (cot.id=cotisation_id) WHERE lot.numero=a_lot_numero AND NOT en_facture LOOP
    ok:=TRUE;
    SELECT count(*) FROM base_partenaire WHERE id=l.partenaire_id INTO total;
    IF 0>=total THEN
      ok:=FALSE;
    END IF;
    IF NOT ok THEN
      UPDATE gestsea_cotisation_lot SET facturable=FALSE, erreur_message='Le partenaire n''existe pas.' WHERE id=l.lid;
    END IF;
  END LOOP;

  /* Facturation */
  total := 0;
  SELECT societe_id FROM base_societe_utilisateur_rel WHERE utilisateur_login=CURRENT_USER INTO p_societe_id;
  FOR l IN SELECT cotisation_id AS cid FROM gestsea_cotisation_lot WHERE lot.numero=a_lot_numero AND NOT en_facture AND facturable LOOP
    SELECT count(*) 
      FROM gestsea_cotisation_ligne AS lig JOIN gestsea_cotisation_produit AS prod ON (produit_id=prod.id)
      WHERE cotisation_id=l.cid AND societe_id=p_societe_id INTO total;
    SELECT avec_defaut_produit FROM gestsea_cotisation_parametrage INTO ok;
    IF ok OR total>0 THEN
      SELECT * FROM gestsea_cotisation WHERE id=l.cid INTO cotis;
      SELECT nextval('gestion_ventes_commande_id_seq') INTO p_commande_id;
      INSERT INTO gestion_ventes_commande(id,date,partenaire_id,objet)
        SELECT p_commande_id,CURRENT_DATE, cotis.partenaire_id, '['||to_char(cotis.id,'FM099999')||'] '||facture_objet||' ('||EXTRACT(YEAR FROM CURRENT_DATE)||')'
          FROM gestsea_cotisation_parametrage;
      IF total>0 THEN
        FOR cotis_ligne IN SELECT * FROM gestsea_cotisation_ligne WHERE cotisation_id=l.cid LOOP
          INSERT INTO gestion_ventes_commande_ligne(commande_id,produit_id,quantite)
            SELECT p_commande_id,produit.id,cotis_ligne.quantite
              FROM gestion_produit AS produit 
              WHERE produit.code=cotis_ligne.produit_code;
        END LOOP;
      ELSE
        INSERT INTO gestion_ventes_commande_ligne(commande_id,produit_id,quantite)
          SELECT p_commande_id,produit.id,cotis_ligne.quantite
            FROM gestsea_cotisation_parametrage JOIN gestion_produit AS produit ON (produit.code=defaut_produit_code);
      END IF;
      /* Passage en facturation */
      SELECT nextval('gestion_ventes_facture_id_seq') INTO p_facture_id;
      INSERT INTO gestion_ventes_facture (id,commande_id) VALUES (p_facture_id,p_commande_id);
      /* Reglement ??? */

      /* Cotisation enregistrée */      
      UPDATE gestsea_cotisation_lot SET commande_id=p_commande_id,facture_id=p_facture_id WHERE cotisation_id=l.cid;
    END IF;
    UPDATE gestsea_cotisation_lot SET en_facture=TRUE WHERE cotisation_id=l.cid;
    total := total+1;
  END LOOP;
  
  RETURN total;
END;
      </code>
    </function>


    <function name="tg_complete_cotisation" type="trigger" schema="base">
      <code>
  total integer;
BEGIN
  SELECT count(*) FROM gestsea_cotisation_parametrage INTO total;
  IF total!=1 THEN
    RAISE EXCEPTION 'Le paramètrage des cotisations est incorrect (nb_enreg!=1).';
  END IF;
  IF NEW.reglement_autre THEN
    SELECT count(*) FROM gestion_ventes_reglement WHERE id=NEW.reglement_id INTO total;
    IF 0>=total THEN
      RAISE EXCEPTION 'Le reglement que vous indiquez n''existe pas.';
    ELSE
      SELECT partenaire.nom||' '||reglement.montant||' € ('||reglement.date_reglement||')' 
        FROM gestion_ventes_reglement AS reg JOIN base_partenaire AS p ON (p.id=partenaire_id)
        WHERE reg.id=NEW.reglement_id INTO NEW.reglement_libelle;
    END IF;
  END IF;

  INSERT INTO gestsea_cotisation_lot (lot,cotisation_id,en_facture)
    SELECT lot_dernier_numero,NEW.cotisation_id,false FROM gestsea_cotisation_parametrage;
  RETURN NEW;  
END;
      </code>
    </function>


    <function name="tg_complete_cotisation_ligne" type="trigger" schema="base">
      <code>
  p_cotisation_id gestsea_cotisation.id%TYPE;
BEGIN
  IF TG_OP='INSERT' OR TG_OP='UPDATE' THEN
    SELECT NEW.quantite*montant_ttc,NEW.quantite*montant_ht,code 
      FROM gestsea_cotisation_produit
      WHERE id=NEW.produit_id INTO NEW.montant_ttc, NEW.montant_ht, NEW.produit_code;
    p_cotisation_id = NEW.cotisation_id;
  ELSE
    p_cotisation_id = OLD.cotisation_id;
  END IF;
  UPDATE gestsea_cotisation SET montant_ttc=COALESCE(sum(lig.montant_ttc),0), montant_ht=COALESCE(SUM(lig.montant_ht),0)
    FROM gestsea_cotisation_ligne AS lig WHERE cotisation_id=p_cotisation_id;
  RETURN NEW;  
END;
      </code>
    </function>


    <function name="tg_complete_cotisation_produit" type="trigger" schema="base">
      <code>
  query text;
  total integer;
BEGIN
  SELECT 'SELECT count(*) FROM '||schema||'.gestion_produit WHERE code='''||NEW.code||''''
    FROM base_societe WHERE id=NEW.societe_id INTO query;
  EXECUTE query INTO total;
  IF total!=1 THEN
    RAISE EXCEPTION 'Le produit que vous indiquez est invalide (nb!=1).';
  END IF;
  RETURN NEW;  
END;
      </code>
    </function>


    <function name="tg_complete_structure" type="trigger" schema="societe">
      <code>
  p_length integer;
BEGIN
  SELECT MAX(LENGTH(RTRIM(code,'#'))) FROM gestsea_structure WHERE parent_id=NEW.parent_id AND id!=NEW.id INTO p_length;
  NEW.code:=UPPER(RTRIM(NEW.code,'#'));  
  IF LENGTH(NEW.code)>p_length THEN
    p_length := LENGTH(NEW.code);
    UPDATE gestsea_structure SET code=RPAD(code,p_length,'#') WHERE id!=NEW.id AND parent_id=NEW.parent_id;
  ELSE
    NEW.code:=RPAD(NEW.code,p_length,'#');
  END IF;
  SELECT code_etendu||NEW.code FROM gestsea_structure WHERE id=NEW.parent_structure_id INTO NEW.code_etendu;
  IF OLD.code_etendu!=NEW.code_etendu THEN
    UPDATE gestsea_structure SET code_etendu=NEW.code_etendu||code WHERE parent_id=NEW.id;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>


    <function name="tg_manage_ventes_commande_ligne_2" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  IF TG_OP='INSERT' THEN
    INSERT INTO gestsea_publication_abonnement_commande (commande_ligne_id,abonnement_id,partenaire_id,nb_exemplaires)
      SELECT ligne.id, abonnement.id,commande.partenaire_id,ligne.quantite
        FROM gestion_ventes_commande_ligne AS ligne
             JOIN gestion_ventes_commande AS commande ON (commande.id=commande_id) 
             JOIN gestsea_publication_abonnement AS abonnement USING (produit_id)
        WHERE ligne.id=NEW.id;
  ELSIF TG_OP='UPDATE' THEN
    IF OLD.abonnement_id!=NEW.abonnement_id THEN
      SELECT count(*) FROM gestsea_publication_abonnement WHERE produit_id=NEW.produit_id INTO total;
      IF 0>=total THEN
        DELETE FROM gestsea_publication_abonnement_commande WHERE commande_ligne_id=NEW.id;
      ELSE
        UPDATE gestsea_publication_abonnement_commande SET abonnement_id=abonnement.id
          FROM gestsea_publication_abonnement AS abonnement WHERE produit_id=NEW.produit_id;
      END IF;
    END IF;
    IF OLD.quantite!=NEW.quantite THEN
      SELECT sum(nb_exemplaires) FROM gestsea_publication_abonnement_commande 
        WHERE commande_ligne_id=NEW.id INTO total;
      IF total>NEW.quantite THEN
        UPDATE gestion_ventes_commande_ligne SET quantite=total WHERE id=NEW.id;
      END IF;
    END IF;
  ELSIF TG_OP='DELETE' THEN
    DELETE FROM gestsea_publication_abonnement_commande WHERE commande_ligne_id=OLD.id;
  END IF;
  RETURN NULL;
END;
      </code>
    </function>


    <function name="tg_manage_ventes_facture_ligne_2" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='INSERT' THEN
    INSERT INTO gestsea_publication_abonnement_routage (commande_id, facture_ligne_id)
      SELECT id, NEW.id FROM gestsea_publication_abonnement_commande 
        WHERE commande_ligne_id=NEW.commande_ligne_id;
  ELSE
    RAISE EXCEPTION 'Depuis quand on supprime des lignes de facture ?!';
  END IF;
  RETURN NULL;
END;
      </code>
    </function>


    <function name="tg_complete_publication_abonnement_commande" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT fc_get_contact(NEW.partenaire_id,contact_type_id)
    FROM gestsea_publication WHERE id=NEW.publication_id INTO NEW.contact_id;
  IF NEW.contact_id IS NULL THEN
    RAISE EXCEPTION 'Il n''est pas possible d''ajouter cette personne à la liste des abonnés car elle ne possède pas une seule adresse active.';
  END IF;
  SELECT publication_id FROM gestsea_publication_abonnement 
    WHERE id=NEW.abonnement_id INTO NEW.publication_id;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_publication_abonnement_routage" type="trigger" schema="societe">
      <code>
  total integer;
  p_numero gestsea_publication_abonnement_routage.numero_debut%TYPE;
  ok boolean;
BEGIN
  SELECT com.quantite-fac.quantite, lig.facture_id, fac.facture_id=fac2.facture_id
    FROM gestion_ventes_facture_ligne AS fac, 
         gestsea_publication_abonnement_commande AS lig 
         JOIN gestion_ventes_commande_ligne AS com ON (com.id=lig.commande_ligne_id)
         JOIN gestion_ventes_facture_ligne AS fac2 ON (com.id=fac2.commande_ligne_id)
    WHERE fac.id=NEW.facture_ligne_id AND lig.id=NEW.id
    INTO total, NEW.facture_id, ok;
  IF total!=0 THEN
    RAISE EXCEPTION 'La totalité d''une ligne de commande comprenant un routage de publication doit être facturée en intégralité.';
  END IF;
  IF NOT ok THEN
    RAISE EXCEPTION 'Les numéros de facture ne correspondent pas lors de l''établissement du routage.';
  END IF;

  SELECT partenaire_id,contact_id,abonnement_id,publication_id,nb_exemplaires
    FROM gestsea_publication_abonnement_commande
    WHERE id=NEW.commande_id
    INTO NEW.partenaire_id, NEW.contact_id,NEW.abonnement_id,NEW.publication_id,NEW.nb_exemplaires;
  SELECT MAX(numero_fin)+1
    FROM gestsea_publication_abonnement_routage
    WHERE partenaire_id=NEW.partenaire_id INTO p_numero;
  SELECT CASE WHEN p_numero>numero_prochain THEN p_numero ELSE numero_prochain END 
    FROM gestsea_publication WHERE id=NEW.publication_id INTO p_numero;
  SELECT p_numero+differe, p_numero+differe+nb_numeros
    FROM gestsea_publication_abonnement 
    WHERE id=NEW.abonnement_id
    INTO NEW.numero_debut,NEW.numero_fin;
  RETURN NEW;
END;
      </code>
    </function>


<!--

    <function name="phonex" schema="systeme">
      <parameters>
        <parameter name="a_mot" type="text"/>
      </parameters>
      <return type="phonex"/>
      <code>
BEGIN

  RETURN 0;
END;
      </code>
    </function>
-->



  </functions>

  <triggers>
    <trigger name="tg_complete_cotisation" schema="base" function="tg_complete_cotisation">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="base" on-table="gestsea_cotisation"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="base" on-table="gestsea_cotisation"/>
    </trigger>

    <trigger name="tg_complete_cotisation_ligne" schema="base" function="tg_complete_cotisation_ligne">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="base" on-table="gestsea_cotisation_ligne"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="base" on-table="gestsea_cotisation_ligne"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="base" on-table="gestsea_cotisation_ligne"/>
    </trigger>

    <trigger name="tg_complete_cotisation_produit" schema="base" function="tg_complete_cotisation_produit">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="base" on-table="gestsea_cotisation_produit"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="base" on-table="gestsea_cotisation_produit"/>
    </trigger>

    <trigger name="tg_complete_structure" schema="societe" function="tg_complete_structure">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestsea_structure"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestsea_structure"/>
    </trigger>

    <trigger name="tg_manage_ventes_commande_ligne_2" schema="societe" function="tg_manage_ventes_commande_ligne_2">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
    </trigger>

    <trigger name="tg_manage_ventes_facture_ligne_2" schema="societe" function="tg_manage_ventes_facture_ligne_2">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_facture_ligne"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_facture_ligne"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="gestion_ventes_facture_ligne"/>
    </trigger>

    <trigger name="tg_complete_publication_abonnement_commande" schema="societe" function="tg_complete_publication_abonnement_commande">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestsea_publication_abonnement_commande"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestsea_publication_abonnement_commande"/>
    </trigger>

    <trigger name="tg_complete_publication_abonnement_routage" schema="societe" function="tg_complete_publication_abonnement_routage">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestsea_publication_abonnement_routage"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestsea_publication_abonnement_routage"/>
    </trigger>

  </triggers>


</analysis>
