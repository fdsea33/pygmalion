<?xml version="1.0" encoding="UTF-8"?>

<analysis name="Gestion" version="0.0.0" 
  xmlns:typens="urn:gestion"
  xmlns="http://www.pygmalion.org/analysis/">

  <!-- Devis/Commande, Facturation, Stock, RH, CRM,... -->
  <classes>
    <!-- Sequence -->
    <class name="gestion_sequence" schema="societe" primary-key="id">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1003" name="immuable"       type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="code"           type="code"    notnull="true" unique="true" meaning="major" mode="auto-update"/>
      <property uid="1003" name="sequence"       type="word"    notnull="true" unique="true" meaning="significant" mode="auto"/>
      <property uid="1003" name="nom"            type="name"    notnull="true"/>
      <property uid="1003" name="quotidienne"    type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="mensuelle"      type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="annuelle"       type="boolean" notnull="true" default="true"/>
      <property uid="1003" name="prefixe"        type="word"    default="YYYY"/>
      <property uid="1003" name="corps"          type="word"    notnull="true" default="FM099999"/>
      <property uid="1003" name="suffixe"        type="word"/>
      <property uid="1003" name="start"          type="integer" notnull="true" default="1"/>
      <property uid="1003" name="dernier_numero" type="word"    mode="auto"/>
      <property uid="1003" name="jour"           type="integer" mode="auto"/>
      <property uid="1003" name="mois"           type="integer" mode="auto"/>
      <property uid="1003" name="annee"          type="integer" mode="auto"/>
      <property uid="1018" name="note"           type="text"/>
      <record with-triggers="true" type="partial">
        <field property="immuable">true</field>
        <field property="code">COMMANDE</field>
        <field property="nom">Séquence des commande</field>
        <field property="mensuelle">true</field>
        <field property="prefixe">YYYYMM</field>
        <field property="corps">FM0999</field>
      </record>
      <record with-triggers="true" type="partial">
        <field property="immuable">true</field>
        <field property="code">FACTURE</field>
        <field property="nom">Séquence des factures</field>
      </record>
      <record with-triggers="true" type="partial">
        <field property="immuable">true</field>
        <field property="code">AVOIR</field>
        <field property="nom">Séquence des avoirs</field>
      </record>
    </class>

    <!-- Produits -->
    <class name="gestion_produit_compteperm_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1003" name="produit_id"     type="id"      notnull="true" meaning="major"/>
      <property uid="1003" name="compteperm_id"  type="id"      notnull="true" meaning="major"/>
      <property uid="1003" name="date_debut"     type="date"    notnull="true"/>
      <property uid="1003" name="date_fin"       type="date"/>
      <constraint type="foreign-key" column="produit_id" references="gestion_produit(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="compteperm_id"  references="compta_compteperm(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_produit" schema="societe" primary-key="id">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1003" name="code"           type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"            type="name"    notnull="true" unique="true" meaning="significant"/>
      <property uid="1003" name="date_debut"     type="date"    notnull="true"/>
      <property uid="1003" name="date_fin"       type="date"    notnull="true"/>
      <property uid="1003" name="actif"          type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="reduction"      type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="inquantifiable" type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="sans_stock"     type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="service"        type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="type_id"        type="id"      notnull="true" default="1"/>
      <property uid="1003" name="ean13"          type="ean13"/>
      <property uid="1003" name="categorie_id"   type="id"      notnull="true"/>
      <property uid="1018" name="note"           type="text"/>
      <constraint type="check" expr="date_fin IS NULL OR (date_fin IS NOT NULL AND date_fin>=date_debut)"/>
      <constraint type="foreign-key" references="gestion_produit_categorie(id)" column="categorie_id" ondelete="set null" onupdate="cascade"/>
    </class>

    <class name="gestion_produit_categorie" schema="societe" primary-key="id">
      <property uid="1001" name="id"                  type="serial"  notnull="true"/>
      <property uid="1003" name="code"                type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"                 type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="parent_categorie_id" type="id"/>
      <property uid="1018" name="note"      type="text"/>
      <record type="partial">
        <field property="code">GENERAL</field>
        <field property="nom">Tous les produits</field>
      </record>
      <constraint type="foreign-key" column="parent_categorie_id" references="gestion_produit_categorie(id)" ondelete="set null" onupdate="cascade"/>
    </class>

    <class name="gestion_produit_service_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"         type="serial"  notnull="true"/>
      <property uid="1003" name="produit_id" type="id"     notnull="true" meaning="major"/>
      <property uid="1003" name="service_id" type="id"     notnull="true" meaning="major"/>
      <constraint type="unique" column="produit_id,service_id"/>
      <constraint type="foreign-key" references="gestion_produit(id)" column="produit_id" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_societe_service(id)" column="service_id" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_produit_taxe" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1002" name="code"          type="code"    notnull="true" unique="true" meaning="significant"/>
      <property uid="1002" name="nom"           type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="taux"          type="rate"    notnull="true" default="0" mode="auto-update"/>
      <property uid="1002" name="montant"       type="money"   notnull="true" default="0" mode="auto-update"/>
      <property uid="1002" name="actif"         type="boolean" notnull="true" default="true"/>
      <property uid="1005" name="compteperm_id" type="id"      notnull="true" mode="auto-update"/>
      <property uid="1018" name="note"          type="text"/>
      <constraint type="check" expr="taux>=0"/>
      <constraint type="foreign-key" references="compta_compteperm(id)" column="compteperm_id" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_produit_prix_taxe_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1003" name="prix_id"        type="id"      notnull="true" meaning="major"/>
      <property uid="1003" name="taxe_id"        type="id"      notnull="true" meaning="major"/>
      <property uid="1002" name="base_montant"   type="money"   notnull="true" default="0"/>
      <constraint type="foreign-key" column="prix_id" references="gestion_produit_prix(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="taxe_id" references="gestion_produit_taxe(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_produit_prix" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1003" name="libelle"       type="label"   notnull="true" mode="auto" meaning="major" index="default"/>
      <property uid="1003" name="produit_id"    type="id"      notnull="true" meaning="significant" index="default" mode="auto-update"/>
      <property uid="1003" name="achat"         type="boolean" notnull="true" default="false" meaning="significant" mode="auto-update"/>
      <property uid="1003" name="actif"         type="boolean" notnull="true" default="true" meaning="significant"/>
      <property uid="1003" name="partenaire_id" type="id" mode="auto-update"/>
      <property uid="1003" name="date_debut"    type="date"    notnull="true" meaning="significant" index="default" mode="auto-update"/>
      <property uid="1003" name="date_fin"      type="date"    notnull="true" meaning="significant" index="default"/>
      <property uid="1003" name="montant_ttc"   type="money"   notnull="true" mode="auto"/>
      <property uid="1003" name="montant_ht"    type="money"   notnull="true"/>
      <property uid="1018" name="note"          type="text"/>
      <constraint type="check" expr="date_fin>=date_debut"/>
      <constraint type="check" expr="NOT achat OR (achat AND partenaire_id IS NOT NULL)"/>
      <constraint type="foreign-key" references="base_partenaire(id)" column="partenaire_id" ondelete="set null" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_produit(id)" column="produit_id" ondelete="cascade" onupdate="cascade"/>
    </class>

    <!-- Liens entre partenaires -->
    <class name="gestion_lien" schema="societe" primary-key="id">
      <property uid="1001" name="id"                type="serial"  notnull="true"/>
      <property uid="1003" name="libelle"           type="phrase" notnull="true" mode="auto" meaning="major"/>
      <property uid="1013" name="partenaire1_id"    type="id" notnull="true"/>
      <property uid="1013" name="partenaire2_id"    type="id" notnull="true"/>
      <property uid="1013" name="type_id"           type="id" notnull="true"/>
      <property uid="1013" name="role_id"           type="id" notnull="true"/>
      <property uid="1003" name="date_debut"        type="date"/>
      <property uid="1003" name="date_fin"          type="date"/>
      <property uid="1018" name="note"              type="text"/>
      <constraint type="foreign-key" column="partenaire1_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire2_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id" references="gestion_lien_type(id)" ondelete="restrict" onupdate="cascade"/>      
      <constraint type="foreign-key" column="role_id" references="gestion_lien_role(id)" ondelete="restrict" onupdate="cascade"/>      
    </class>
 
    <class name="gestion_lien_role" schema="societe" primary-key="id">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1002" name="code"           type="code"    notnull="true" unique="true" meaning="significant"/>
      <property uid="1003" name="prefixe"        type="phrase"  notnull="true" default=" en tant que "/>
      <property uid="1003" name="suffixe"        type="phrase"  notnull="true" default="."/>
      <property uid="1003" name="nom"            type="name"    notnull="true"/>
      <property uid="1003" name="nom_etendu"     type="name"    notnull="true" mode="auto" meaning="major"/>
      <property uid="1013" name="type_id"        type="id"      notnull="true"/>
      <constraint type="foreign-key" column="type_id" references="gestion_lien_type(id)" ondelete="restrict" onupdate="cascade"/>      
    </class>
 
    <class name="gestion_lien_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1002" name="code"           type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"            type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="phrase_directe" type="name"    notnull="true">ACTIF : partenaire 1 ... partenaire 2</property>
      <property uid="1003" name="phrase_inverse" type="name"    notnull="true">PASSIF : partenaire 2 ... partenaire 1</property>
      <record>
        <field>1</field>
        <field>ADHESION</field>
        <field>Transmission d'adhésion</field>
        <field>adhère pour</field>
        <field>a pour adhérent</field>
      </record>
      <record>
        <field>2</field>
        <field>MEMBRE</field>
        <field>Membre</field>
        <field>est membre de</field>
        <field>a pour membre</field>
      </record>
      <record>
        <field>3</field>
        <field>EMPLOI</field>
        <field>Relations professionnelles</field>
        <field>travaille pour</field>
        <field>a pour employé</field>
      </record>
    </class>
 

    <!-- Réductions-->
    <class name="gestion_reduction" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1003" name="code"                 type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"                  type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="taux"                 type="rate"    notnull="true" default="0"/>
    </class>

    <!-- Adhésions -->
    <class name="gestion_adhesion" schema="societe" primary-key="id">
      <property uid="1001" name="id"                 type="serial"  notnull="true" meaning="major"/>
      <property uid="1003" name="facture_ligne_id"   type="id"      notnull="true"/>
      <property uid="1003" name="facture_id"         type="id"      notnull="true" mode="auto"/>
      <property uid="1002" name="partenaire_id"      type="id"      notnull="true" nevernull="true" meaning="significant"/>
      <property uid="1003" name="periode_id"         type="id"      notnull="true"/>
      <property uid="1013" name="type_id"            type="id"      notnull="true"/>
      <property uid="1003" name="reduction_id"       type="id"/>
      <property uid="1003" name="periode_date_debut" type="date"    notnull="true" mode="auto"/>
      <property uid="1003" name="periode_date_fin"   type="date"    notnull="true" mode="auto"/>
      <property uid="1003" name="type_nom"           type="name"    notnull="true" mode="auto" meaning="significant"/>
      <property uid="1003" name="produit_nom"        type="name"    notnull="true" mode="auto" meaning="significant"/>
      <constraint type="unique" column="type_id,partenaire_id,periode_id"/>
      <constraint type="foreign-key" column="type_id" references="gestion_adhesion_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="periode_id" references="gestion_adhesion_periode(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="reduction_id" references="gestion_adhesion_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_id" references="gestion_ventes_facture(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_ligne_id" references="gestion_ventes_facture_ligne(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_adhesion_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1003" name="code"           type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"            type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="reduction_id"   type="id"      notnull="true"/>
      <property uid="1018" name="note"           type="text"/>
      <constraint type="foreign-key" column="reduction_id" references="gestion_reduction(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_adhesion_type_produit_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1001" name="adhesion_type_id" type="id"      notnull="true" meaning="major"/>
      <property uid="1001" name="produit_id"       type="id"      notnull="true" meaning="major"/>
      <constraint type="foreign-key" column="adhesion_type_id" references="gestion_adhesion_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="produit_id" references="gestion_produit(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_adhesion_periode" schema="societe" primary-key="id">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1003" name="code"           type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="date_debut"     type="date"    notnull="true" meaning="significant"/>
      <property uid="1003" name="date_fin"       type="date"    notnull="true" meaning="significant"/>
    </class>

    <class name="gestion_adhesion_type_periode_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"             type="serial"  notnull="true"/>
      <property uid="1001" name="type_id"        type="id"      notnull="true" meaning="major"/>
      <property uid="1001" name="periode_id"     type="id"      notnull="true" meaning="major"/>
      <constraint type="unique" column="type_id,periode_id"/>
      <constraint type="foreign-key" column="type_id"    references="gestion_adhesion_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="periode_id" references="gestion_adhesion_periode(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_adhesion_transmission" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"               type="serial"  notnull="true" meaning="major"/>
      <property uid="1001" name="adhesion_type_id" type="id"      notnull="true"/>
      <property uid="1001" name="lien_type_id"     type="id"      notnull="true"/>
      <property uid="1002" name="sens_inverse"     type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="actif"            type="boolean" notnull="true" default="false"/>
      <constraint type="foreign-key" column="adhesion_type_id" references="gestion_adhesion_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="lien_type_id" references="gestion_lien_type(id)" ondelete="cascade" onupdate="cascade"/>
    </class>



    <!-- Ventes -->
    <class name="gestion_ventes_commande_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1002" name="nom"                  type="name" notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1002" name="defaut"               type="boolean" notnull="true" default="true"/>
      <property uid="1002" name="avec_signature"       type="boolean" notnull="true" default="true"/>
      <property uid="1003" name="validite_delai_id"    type="id" notnull="true" meaning="significant"/>
      <property uid="1003" name="paiement_delai_id"    type="id" notnull="true" meaning="significant"/>
      <constraint type="foreign-key" column="validite_delai_id" references="base_delai(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="paiement_delai_id" references="base_delai(id)" ondelete="restrict" onupdate="cascade"/>
      <record type="partial">
        <field property="nom">Standard</field>
        <field property="validite_delai_id">2</field>
        <field property="paiement_delai_id">1</field>
      </record>
    </class>


    <class name="gestion_ventes_commande" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1002" name="numero"               type="sequence" notnull="true" mode="auto" meaning="major"/>
      <property uid="1003" name="date"                 type="date" notnull="true" meaning="significant"/>
      <property uid="1003" name="type_id"              type="id" notnull="true" nevernull="true"/>
      <property uid="1003" name="validite_delai_id"    type="id" notnull="true" mode="auto"/>
      <property uid="1003" name="validite_date"        type="date" notnull="true" mode="auto"/>
      <property uid="1004" name="avec_signature"       type="boolean" notnull="true" mode="auto"/>
      <property uid="1004" name="signature_client"     type="boolean" notnull="true" default="false"/>
      <property uid="1004" name="immodifiable"         type="boolean" notnull="true" default="false"/>
      <property uid="1015" name="avec_bons_livraison"  type="boolean" notnull="true" default="false"/>
      <property uid="1005" name="employe_id"           type="id" notnull="true" nevernull="true"/>
      <property uid="1006" name="partenaire_id"        type="id" notnull="true" meaning="significant"/>
      <property uid="1007" name="commande_contact_id"  type="id" nevernull="true"/>
      <property uid="1007" name="commande_version_id"  type="id" mode="auto"/>
      <property uid="1008" name="facture_contact_id"   type="id" nevernull="true"/>
      <property uid="1009" name="livraison_contact_id" type="id" nevernull="true"/>
      <property uid="1010" name="impression_id"        type="id" notnull="true" nevernull="true"/>
      <property uid="1011" name="modele_id"            type="id" notnull="true" mode="auto"/>
      <property uid="1012" name="reduction_taux"       type="rate" notnull="true" mode="auto"/>
      <property uid="1013" name="montant_ttc"          type="money" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1014" name="montant_ht"           type="money" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1015" name="acompte"              type="boolean" notnull="true" default="false"/>
      <property uid="1016" name="objet"                type="phrase"/>
      <property uid="1017" name="civilites"            type="phrase"/>
      <property uid="1018" name="introduction"         type="text"/>
      <property uid="1019" name="conclusion"           type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="type_id" references="gestion_ventes_commande_type(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="employe_id" references="base_societe_employe(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commande_contact_id" references="base_partenaire_contact(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commande_version_id" references="base_partenaire_contact_version(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_contact_id" references="base_partenaire_contact(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="livraison_contact_id" references="base_partenaire_contact(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="modele_id" references="base_impression_modele(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="impression_id" references="base_impression(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="validite_delai_id" references="base_delai(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_ventes_commande_ligne" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1002" name="nom"                  type="name" mode="auto" notnull="true" meaning="major"/>
      <property uid="1002" name="immodifiable"         type="boolean" notnull="true" default="false" meaning="significant" mode="auto"/>
      <property uid="1002" name="a_inclure"            type="boolean" notnull="true" default="true"/>
      <property uid="1002" name="inclus"               type="boolean" notnull="true" default="false" mode="auto"/>
      <property uid="1002" name="commande_id"          type="id" notnull="true" mode="auto-update"/>
      <property uid="1002" name="produit_id"           type="id" notnull="true" mode="auto"/>
      <property uid="1002" name="prix_id"              type="id" notnull="true"/>
      <property uid="1002" name="stock_id"             type="id"/>
      <property uid="1002" name="stock_mouvement_id"   type="id" mode="auto"/>
      <property uid="1003" name="reduction"            type="boolean"  notnull="true" default="false"/>
      <property uid="1002" name="montant_unitaire_ttc" type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_unitaire_ht"  type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="quantite"             type="quantity" notnull="true" default="1" meaning="significant"/>
      <property uid="1002" name="montant_brut_ttc"     type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_brut_ht"      type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_ttc"          type="money" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true" mode="auto"/>
      <property uid="1018" name="description"          type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="commande_id" references="gestion_ventes_commande(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="produit_id" references="gestion_produit(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="prix_id" references="gestion_produit_prix(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="stock_id" references="gestion_stock(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="stock_mouvement_id" references="gestion_stock_mouvement(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_ventes_facture" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="commande_id"          type="id" notnull="true" mode="auto-update"/>
      <property uid="1002" name="piece_id"             type="id" notnull="true" mode="auto"/>
      <property uid="1002" name="numero"               type="sequence" notnull="true" mode="auto" meaning="major"/>
      <property uid="1002" name="date"                 type="date" notnull="true"/>
      <property uid="1003" name="paiement_delai_id"    type="id" notnull="true" nevernull="true"/>
      <property uid="1003" name="paiement_date"        type="date" notnull="true"/>
      <property uid="1002" name="immodifiable"         type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="employe_id"           type="id" notnull="true"/>
      <property uid="1007" name="facture_version_id"   type="id" mode="auto"/>
      <property uid="1007" name="livraison_version_id" type="id" mode="auto"/>
      <property uid="1002" name="partenaire_id"        type="id" notnull="true" meaning="significant"/>
      <property uid="1002" name="impression_id"        type="id"/>
      <property uid="1002" name="modele_id"            type="id" mode="auto"/>
      <property uid="1002" name="reduction_taux"       type="rate" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_ttc"          type="money" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="objet"                type="phrase"/>
      <property uid="1002" name="civilites"            type="phrase"/>
      <property uid="1002" name="message"              type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="paiement_delai_id" references="base_delai(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commande_id" references="gestion_ventes_commande(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="piece_id" references="compta_piece(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="employe_id" references="base_societe_employe(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_version_id" references="base_partenaire_contact_version(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="livraison_version_id" references="base_partenaire_contact_version(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="impression_id" references="base_impression(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="modele_id" references="base_impression_modele(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_ventes_facture_ligne" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="facture_id"           type="id"      notnull="true"/>
      <property uid="1002" name="commande_ligne_id"    type="id"      notnull="true"/>
      <property uid="1002" name="ecriture_id"          type="id"      notnull="true" mode="auto"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true" mode="auto" meaning="major"/>
      <property uid="1002" name="immodifiable"         type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="a_inclure"            type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="inclus"               type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="produit_id"           type="id" notnull="true" mode="auto"/>
      <property uid="1002" name="prix_id"              type="id" mode="auto"/>
      <property uid="1002" name="stock_mouvement_id"   type="id" mode="auto"/>
      <property uid="1003" name="reduction"            type="boolean"  notnull="true" default="false" mode="auto"/>
      <property uid="1002" name="montant_unitaire_ttc" type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_unitaire_ht"  type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="quantite"             type="quantity" notnull="true" meaning="significant"/>
      <property uid="1002" name="montant_brut_ttc"     type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_brut_ht"      type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_ttc"          type="money" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true" mode="auto"/>
      <property uid="1018" name="description"          type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="facture_id" references="gestion_ventes_facture(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commande_ligne_id" references="gestion_ventes_commande_ligne(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="ecriture_id" references="compta_ecriture(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="produit_id" references="gestion_produit(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="prix_id" references="gestion_produit_prix(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="stock_mouvement_id" references="gestion_stock_mouvement(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_ventes_avoir" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="numero"               type="sequence" notnull="true" meaning="major"/>
      <property uid="1002" name="immodifiable"         type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="commande_id"          type="id"/>
      <property uid="1002" name="facture_id"           type="id"/>
      <property uid="1002" name="employe_id"           type="id" notnull="true"/>
      <property uid="1002" name="partenaire_id"        type="id" meaning="significant"/>
      <property uid="1002" name="date"                 type="date"/>
      <property uid="1002" name="impression_id"        type="id"/>
      <property uid="1002" name="modele_id"            type="id"/>
      <property uid="1002" name="reduction_taux"       type="rate" notnull="true"/>
      <property uid="1002" name="montant_ttc"          type="money" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money"/>
      <property uid="1002" name="objet"                type="phrase"/>
      <property uid="1002" name="civilites"            type="phrase"/>
      <property uid="1002" name="message"              type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" references="gestion_ventes_commande(id)" column="commande_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_ventes_facture(id)" column="facture_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="employe_id" references="base_societe_employe(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_partenaire(id)" column="partenaire_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_impression(id)" column="impression_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="modele_id" references="base_impression_modele(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_ventes_avoir_ligne" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1002" name="nom"                  type="name" mode="auto" notnull="true" meaning="major"/>
      <property uid="1002" name="immodifiable"         type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="facture_ligne_id"     type="id" notnull="true"/>
      <property uid="1002" name="avoir_id"             type="id" notnull="true" mode="auto"/>
      <property uid="1002" name="produit_id"           type="id" notnull="true" mode="auto"/>
      <property uid="1002" name="prix_id"              type="id" mode="auto"/>
      <property uid="1002" name="stock_mouvement_id"   type="id" mode="auto"/>
      <property uid="1002" name="montant_unitaire_ttc" type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_unitaire_ht"  type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="quantite"             type="quantity" notnull="true" meaning="significant" mode="auto"/>
      <property uid="1002" name="montant_brut_ttc"     type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_brut_ht"      type="money" notnull="true" mode="auto"/>
      <property uid="1002" name="montant_ttc"          type="money" notnull="true" meaning="significant" mode="auto"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true" mode="auto"/>
      <property uid="1018" name="description"          type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="avoir_id" references="gestion_ventes_avoir(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="facture_ligne_id" references="gestion_ventes_facture_ligne(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="produit_id" references="gestion_produit(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="prix_id" references="gestion_produit_prix(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="stock_mouvement_id" references="gestion_stock_mouvement(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <!-- Reglements et relances Ventes -->
    <class name="gestion_ventes_relance" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"   notnull="true"/>
      <property uid="1002" name="nom"                  type="name"     notnull="true" meaning="major"/>
      <property uid="1002" name="datetime"             type="datetime" notnull="true" unique="true" meaning="significant"/>
    </class>

    <class name="gestion_ventes_relance_lettre" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="relance_id"           type="id"      notnull="true"/>
      <property uid="1002" name="etape_id"             type="id"      notnull="true"/>
      <property uid="1002" name="echeance_id"          type="id"      notnull="true"/>
      <property uid="1002" name="partenaire_id"        type="id"      notnull="true"/>
      <constraint type="foreign-key" column="relance_id" references="gestion_ventes_relance(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="etape_id" references="gestion_ventes_relance_mode_etape(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="echeance_id" references="gestion_ventes_facture_reglement_echeance(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="gestion_ventes_relance_mode" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="code"                 type="code" notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="nom"                  type="name" notnull="true" unique="true" meaning="significant"/>
      <property uid="1002" name="defaut"               type="boolean" notnull="true" default="false"/>
      <record>
        <field>1</field>
        <field>0</field>
        <field>Pas de relances</field>
        <field>false</field>
      </record>
      <record>
        <field>2</field>
        <field>30-50-65</field>
        <field>Relances à 30, 50 et 65 jours</field>
        <field>true</field>
      </record>
    </class>

    <class name="gestion_ventes_relance_mode_etape" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="relance_mode_id"      type="id"      notnull="true"/>
      <property uid="1002" name="nb_jours"             type="integer" notnull="true" meaning="major"/>
      <property uid="1002" name="message"              type="text"    notnull="true"/>
      <constraint type="foreign-key" column="relance_mode_id" references="gestion_ventes_relance_mode(id)" ondelete="cascade" onupdate="cascade"/>
      <record>
        <field>1</field>
        <field>1</field>
        <field>30</field>
        <field>Message (30 jours)</field>
      </record>
      <record>
        <field>2</field>
        <field>1</field>
        <field>50</field>
        <field>Message (50 jours)</field>
      </record>
      <record>
        <field>3</field>
        <field>1</field>
        <field>65</field>
        <field>Message (65 jours)</field>
      </record>
    </class>


    <class name="gestion_ventes_facture_reglement_echeance" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="facture_id"           type="id" notnull="true"/>
      <property uid="1002" name="partenaire_id"        type="id" notnull="true"/>
      <property uid="1002" name="relance_mode_id"      type="id" notnull="true"/>
      <property uid="1002" name="prevision_montant"    type="money" meaning="significant"/>
      <property uid="1002" name="date"                 type="date" meaning="significant"/>
      <property uid="1002" name="part_montant"         type="money" notnull="true" meaning="significant"/>
      <property uid="1002" name="partiel"              type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="reglement_id"         type="id"/>
      <constraint type="foreign-key" column="facture_id" references="gestion_ventes_facture(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="relance_mode_id" references="gestion_ventes_relance_mode(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="reglement_id" references="gestion_ventes_reglement(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

   
    <class name="gestion_ventes_reglement" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="partenaire_id"        type="id" notnull="true"/>
      <property uid="1002" name="mode_id"              type="id" notnull="true"/>
      <property uid="1002" name="banque"               type="name" notnull="true"/>
      <property uid="1002" name="numero_compte"        type="name" notnull="true"/>
      <property uid="1002" name="reference"            type="name" notnull="true"/>
      <property uid="1002" name="date_reglement"       type="date" notnull="true" meaning="significant"/>
      <property uid="1002" name="date_saisie"          type="date" notnull="true"/>
      <property uid="1002" name="montant"              type="money" notnull="true" meaning="significant"/>
      <constraint type="foreign-key" references="base_partenaire(id)" column="partenaire_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_ventes_reglement_mode(id)" column="mode_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_ventes_reglement_mode" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="nom"                  type="name" notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="banque_compte_id"     type="id" notnull="true"/>
      <property uid="1018" name="compteperm_id"        type="id" notnull="true"/>
      <property uid="1002" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" references="compta_compteperm(id)" column="compteperm_id" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_banque_compte(id)" column="banque_compte_id" ondelete="cascade" onupdate="cascade"/>
    </class>


    <class name="gestion_ventes_reversement" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="reglement_id"         type="id"      notnull="true"/>
      <property uid="1002" name="mode_id"              type="id"      notnull="true"/>
      <property uid="1002" name="montant"              type="money"   notnull="true" meaning="significant"/>
      <constraint type="foreign-key" references="gestion_ventes_reglement(id)" column="reglement_id" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_ventes_reversement_mode(id)" column="mode_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_ventes_reversement_mode" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="code"                 type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true" meaning="significant"/>
      <property uid="1018" name="compteperm_id"        type="id"      notnull="true"/>
      <property uid="1002" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1018" name="societe_id"           type="id"/>
      <constraint type="foreign-key" references="compta_compteperm(id)" column="compteperm_id" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_societe(id)" column="societe_id" ondelete="cascade" onupdate="cascade"/>
    </class>

    


    <!-- Achats -->
    <class name="gestion_achats_facture" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="numero"               type="phrase" notnull="true" meaning="major"/>
      <property uid="1002" name="nom"                  type="name" notnull="true"/>
      <property uid="1002" name="date"                 type="date" notnull="true" meaning="significant"/>
      <property uid="1002" name="partenaire_id"        type="id" notnull="true"/>
      <property uid="1002" name="impression_id"        type="id" notnull="true"/>
      <property uid="1002" name="modele_id"            type="id" notnull="true"/>
      <property uid="1002" name="montant_ttc"          type="money" notnull="true" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" references="base_partenaire(id)" column="partenaire_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_impression(id)" column="impression_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_impression_modele(id)" column="modele_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_achats_facture_ligne" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="nom"                  type="name" notnull="true" meaning="major"/>
      <property uid="1002" name="facture_id"           type="id" notnull="true"/>
      <property uid="1002" name="produit_id"           type="id" notnull="true"/>
      <property uid="1002" name="prix_id"              type="id"/>
      <property uid="1002" name="stock_mouvement_id"   type="id"/>
      <property uid="1002" name="quantite"             type="quantity" notnull="true" meaning="significant"/>
      <property uid="1002" name="montant_brut_ttc"     type="money" notnull="true"/>
      <property uid="1002" name="montant_brut_ht"      type="money" notnull="true"/>
      <property uid="1002" name="montant_ttc"          type="money" notnull="true" meaning="significant"/>
      <property uid="1002" name="montant_ht"           type="money" notnull="true"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" references="gestion_achats_facture(id)" column="facture_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_produit(id)" column="produit_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_produit_prix(id)" column="prix_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_stock_mouvement(id)" column="stock_mouvement_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_achats_facture_reglement_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="facture_id"           type="id" notnull="true"/>
      <property uid="1002" name="reglement_id"         type="id" notnull="true"/>
      <property uid="1002" name="partiel"              type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="montant"              type="money" notnull="true"/>
      <constraint type="foreign-key" references="gestion_achats_facture(id)" column="facture_id" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_achats_reglement(id)" column="reglement_id" ondelete="cascade" onupdate="cascade"/>
    </class>

   
    <class name="gestion_achats_reglement" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="partenaire_id"        type="id" notnull="true"/>
      <property uid="1002" name="mode_id"              type="id" notnull="true"/>
      <property uid="1002" name="reference"            type="name" notnull="true"/>
      <property uid="1002" name="date_reglement"       type="date" notnull="true" meaning="significant"/>
      <property uid="1002" name="date_saisie"          type="date" notnull="true"/>
      <property uid="1002" name="montant"              type="money" notnull="true" meaning="significant"/>
      <constraint type="foreign-key" references="base_partenaire(id)" column="partenaire_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_achats_reglement_mode(id)" column="mode_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="gestion_achats_reglement_mode" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="nom"                  type="name" notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="banque_compte_id"     type="id" notnull="true"/>
      <property uid="1018" name="compteperm_id"        type="id" notnull="true"/>
      <property uid="1002" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" references="compta_compteperm(id)" column="compteperm_id" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_banque_compte(id)" column="banque_compte_id" ondelete="cascade" onupdate="cascade"/>
    </class>

    
    <!-- Stock -->
    <class name="gestion_stock_lieu" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1002" name="nom"           type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="actif"         type="boolean" notnull="true" default="true"/>
      <property uid="1018" name="note"          type="text"/>
      <property uid="1001" name="lieu_id"       type="id"/>
      <constraint type="foreign-key" references="gestion_stock_lieu(id)" column="lieu_id" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_stock" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1002" name="nom"           type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1001" name="stock_lieu_id" type="id"      notnull="true"/>
      <property uid="1001" name="produit_id"    type="id"      notnull="true" meaning="significant"/>
      <property uid="1002" name="actif"         type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="defaut"        type="boolean" notnull="true" default="false"/>
      <property uid="1002" name="quantite_init" type="quantity" notnull="true" default="0"/>
      <property uid="1002" name="quantite"      type="quantity" notnull="true" default="0"/>
      <property uid="1002" name="quantite_max"  type="quantity" notnull="true" default="0"/>
      <property uid="1018" name="note"          type="text"/>
      <constraint type="foreign-key" references="gestion_stock_lieu(id)" column="stock_lieu_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="gestion_produit(id)" column="produit_id" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="gestion_stock_mouvement" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"   notnull="true" meaning="major"/>
      <property uid="1001" name="stock_id"      type="id"       notnull="true" meaning="significant"/>
      <property uid="1002" name="quantite"      type="quantity" notnull="true" default="0" meaning="significant"/>
      <property uid="1002" name="virtuel"       type="boolean"  notnull="true" default="true"/>
      <property uid="1002" name="date"          type="date" meaning="significant"/>
      <property uid="1018" name="note"          type="text"/>
      <constraint type="foreign-key" references="gestion_stock(id)" column="stock_id" ondelete="restrict" onupdate="cascade"/>
    </class>

  </classes>


  <functions>
  
    <function name="fc_nextval" schema="societe">
      <parameters>
        <parameter name="a_sequence_code" type="code"/>
      </parameters>
      <return type="integer"/>
      <code>
  number gestion_sequence.dernier_numero%TYPE;
  cle integer;
  indice_jour integer;
  indice_mois integer;
  indice_annee integer;
  datetime timestamp;
  seq gestion_sequence%ROWTYPE;
BEGIN
  SELECT CURRENT_TIMESTAMP INTO datetime;
  SELECT * FROM gestion_sequence WHERE code=a_sequence_code FOR UPDATE INTO seq;
  SELECT EXTRACT(YEAR FROM datetime) INTO indice_jour, indice_mois, indice_annee;
  UPDATE gestion_sequence SET jour=seq.jour,mois=seq.mois,annee=seq.annee WHERE code=seq.code;
  SELECT nextval(seq.sequence) INTO cle;
  SELECT COALESCE(TO_CHAR(CURRENT_TIMESTAMP, seq.prefixe),'')||COALESCE(TO_CHAR(cle, seq.corps),'')||COALESCE(TO_CHAR(CURRENT_TIMESTAMP, seq.suffixe),'') INTO number;
  RETURN number;
END;
      </code>
    </function>


    <function name="tg_complete_sequence" type="trigger" schema="societe">
      <code>
  query text;
BEGIN
  IF TG_OP='INSERT' OR TG_OP='UPDATE' THEN
    SELECT TO_CHAR(CURRENT_TIMESTAMP,NEW.prefixe) INTO query;
    SELECT TO_CHAR(4,NEW.corps) INTO query;
    SELECT TO_CHAR(CURRENT_TIMESTAMP,NEW.suffixe) INTO query;
  END IF;
  IF TG_OP='INSERT' THEN
    NEW.sequence:=LOWER('gestion_sequences_'||NEW.code||round(99*random())||'_seq');
    query:='CREATE SEQUENCE '||NEW.sequence||' INCREMENT BY 1 START WITH '||NEW.start;
    EXECUTE query;
    return NEW;
  ELSIF TG_OP='UPDATE' THEN
    IF OLD.immuable THEN
      NEW.immuable := true;
      NEW.code     := OLD.code;
      NEW.sequence := OLD.sequence;
    END IF;
    IF NEW.start!=OLD.start THEN
      query:='ALTER SEQUENCE '||NEW.sequence||' RESTART WITH '||NEW.start;
      EXECUTE query;
    ELSIF (NEW.quotidienne AND OLD.jour!=NEW.jour) OR (NEW.mensuelle AND OLD.mois!=NEW.mois) OR (NEW.annuelle AND OLD.annee!=NEW.annee) THEN
      query:='ALTER SEQUENCE '||NEW.sequence||' RESTART WITH 0';
      EXECUTE query;
    END IF;
    RETURN NEW;
  ELSIF TG_OP='DELETE' THEN
    query:='DROP SEQUENCE '||NEW.sequence;
    EXECUTE query;
    return OLD;
  END IF;
END;
      </code>
    </function>



    <function name="tg_complete_produit_taxe" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='UPDATE' THEN
    NEW.code:=OLD.code;
    IF OLD.taux!=NEW.taux OR OLD.montant!=NEW.montant OR OLD.compteperm_id!=NEW.compteperm_id THEN
      RAISE EXCEPTION 'Une taxe ne peut pas être mise à jour. Il est seulement possible d''en ajouter ou d''en supprimer.';
    END IF;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_produit_prix_taxe_rel" type="trigger" schema="societe">
      <code>
  p_prix_id gestion_produit_prix.id%TYPE;
  p_montant_ht gestion_produit_prix.montant_ht%TYPE;
  p_montant_taxes gestion_produit_prix.montant_ht%TYPE;
BEGIN
  IF TG_OP='INSERT' OR TG_OP='UPDATE' THEN
    p_prix_id := NEW.prix_id;
  ELSE
    p_prix_id := OLD.prix_id;
  END IF;
  SELECT montant_ht FROM gestion_produit_prix WHERE id=p_prix_id INTO p_montant_ht;
  SELECT ROUND(COALESCE(SUM(rel.base_montant+taxe.taux*p_montant_ht+taxe.montant),0),2)
    FROM gestion_produit_prix_taxe_rel AS rel 
         JOIN gestion_produit_taxe AS taxe ON (taxe_id=taxe.id)
    WHERE rel.prix_id=p_prix_id INTO p_montant_taxes;
  UPDATE gestion_produit_prix SET montant_ttc=p_montant_ht+p_montant_taxes WHERE id=p_prix_id;
  RETURN NEW;
END;
      </code>
    </function>




    <function name="tg_complete_produit_prix" type="trigger" schema="societe">
      <code>
  p_prix_id gestion_produit_prix.id%TYPE;
BEGIN
  IF TG_OP='INSERT' THEN
    NEW.montant_ttc := NEW.montant_ht;
    SELECT id FROM gestion_produit_prix 
      WHERE date_fin IN (SELECT max(date_fin) FROM gestion_produit_prix WHERE produit_id=NEW.produit_id)
      INTO p_prix_id;
    INSERT INTO gestion_produit_prix_taxe_rel (prix_id, taxe_id, base_montant)
      SELECT prix_id, taxe_id, base_montant
        FROM gestion_produit_prix_taxe_rel WHERE prix_id=p_prix_id;
  ELSIF TG_OP='UPDATE' THEN
    NEW.produit_id    := OLD.produit_id;
    NEW.achat         := OLD.achat;
    NEW.partenaire_id := OLD.partenaire_id;
    NEW.montant_ht    := OLD.montant_ht;
    NEW.date_debut    := OLD.date_debut;
    IF OLD.date_fin>NEW.date_fin THEN
      NEW.date_fin := OLD.date_fin;
    END IF;
    IF NEW.date_debut>OLD.date_debut THEN
      NEW.date_debut := OLD.date_debut;
    END IF;
  END IF;
  SELECT code||' '||TRIM(nom)||' / '||NEW.montant_ttc||' TTC / '||NEW.montant_ht||' HT'
    FROM gestion_produit
    WHERE id=NEW.produit_id
    INTO NEW.libelle;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="fc_get_reduction_rate" schema="societe">
      <parameters>
        <parameter name="a_partenaire_id" type="id"/>
        <parameter name="a_date" type="date"/>
      </parameters>
      <return type="rate"/>
      <code>
  p_periode_id gestion_adhesion_periode.id%TYPE;
  p_ret gestion_reduction.taux%TYPE;
BEGIN
  SELECT id
    FROM gestion_adhesion 
    WHERE periode_date_fin>=a_date AND a_date>=periode_date_debut AND partenaire_id=a_partenaire_id
    ORDER BY periode_date_fin DESC
  INTO p_periode_id;

  SELECT COALESCE(MAX(reduc.taux),0.00)
    FROM gestion_adhesion AS adhesion 
         JOIN gestion_reduction AS reduc ON (reduc.id=reduction_id)
    WHERE periode_id=p_periode_id AND partenaire_id=a_partenaire_id
  INTO p_ret;

  IF p_ret IS NULL THEN
    p_ret := 0;
  END IF;

  RETURN p_ret;
END;
      </code>
    </function>




    <function name="tg_complete_lien" type="trigger" schema="societe">
      <code>
  p_role_type_id gestion_lien_type.id%TYPE;
BEGIN
  SELECT type_id FROM gestion_lien_role WHERE id=NEW.role_id INTO p_role_type_id;
  IF NEW.type_id!=p_role_type_id THEN
    RAISE EXCEPTION 'Le rôle et le type de lien doivent être en adéquation.';
  END IF;
  SELECT p1.libelle||' '||t.phrase_directe||' '||p2.libelle||r.prefixe||r.nom||r.suffixe
    FROM base_partenaire AS p1,
         base_partenaire AS p2,
	 gestion_lien_type AS t,
	 gestion_lien_role AS r
    WHERE p1.id=NEW.partenaire1_id AND p2.id=NEW.partenaire2_id AND t.id=NEW.type_id AND r.id=NEW.role_id
    INTO NEW.libelle;
  RETURN NEW;
END;
      </code>
    </function>


    <function name="tg_complete_lien_role" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT '['||type.code||'] '||NEW.nom FROM gestion_lien_type AS type WHERE id=NEW.type_id INTO NEW.nom_etendu;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_adhesion" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  SELECT nom, facture_id, COALESCE(NEW.partenaire_id,partenaire_id)
    FROM gestion_ventes_facture_ligne JOIN gestion_ventes_facture AS facture ON (facture_id=facture.id)
    WHERE id=NEW.facture_ligne_id
    INTO NEW.produit_nom, NEW.facture_id, NEW.partenaire_id;
  SELECT date_debut, date_fin 
    FROM gestion_adhesion_periode 
    WHERE id=NEW.periode_id 
    INTO NEW.periode_date_debut, NEW.periode_date_fin;
  SELECT type_nom
    FROM gestion_adhesion_type
    WHERE id=NEW.type_id 
    INTO NEW.type_nom;
  SELECT count(*) FROM gestion_adhesion_transmission WHERE adhesion_type_id=NEW.type_id INTO total;
  IF total>0 THEN
    INSERT INTO gestion_adhesion (partenaire_id,facture_ligne_id,periode_id,type_id,reduction_id) 
      SELECT lien.pid,NEW.facture_ligne_id,NEW.periode_id,NEW.type_id,NEW.reduction_id
        FROM (SELECT CASE WHEN sens_inverse THEN partenaire1_id ELSE partenaire2_id END AS pid
                FROM gestion_lien JOIN gestion_adhesion_transmission ON (type_id=lien_type_id)
                WHERE adhesion_type_id=NEW.type_id AND (CASE WHEN sens_inverse THEN partenaire2_id ELSE partenaire1_id END)=NEW.partenaire_id) AS lien;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_ventes_commande" type="trigger" schema="societe">
      <code><![CDATA[
  total integer;
  ok boolean;
  default_contact_id base_partenaire_contact.id%TYPE;
  contact_id base_partenaire_contact.id%TYPE;
  p_commande_montant_ttc gestion_ventes_commande.montant_ttc%TYPE;
  p_commande_montant_ht  gestion_ventes_commande.montant_ht%TYPE;
BEGIN
  IF TG_OP='UPDATE' OR TG_OP='DELETE' THEN
    IF OLD.immodifiable THEN
      RAISE EXCEPTION 'Une commande passée en facture est verrouillée et ne peut être modifiée.';
    END IF;
  END IF;

  IF NEW.partenaire_id IS NULL THEN
    RAISE EXCEPTION 'Une commande doit être faite pour une personne/société donnée.';
  END IF;

  IF NEW.employe_id IS NULL THEN
    SELECT id FROM base_societe_employe WHERE utilisateur_login=CURRENT_USER INTO NEW.employe_id;
  END IF;

  IF NEW.type_id IS NULL THEN
    SELECT count(*) FROM gestion_ventes_commande_type WHERE defaut AND actif INTO total;
    IF total=1 THEN
      SELECT id FROM gestion_ventes_commande_type WHERE defaut AND actif INTO NEW.type_id;
    ELSE
      RAISE EXCEPTION 'Aucun type n''a été spécifié.';
    END IF;
  END IF;

  SELECT COALESCE(SUM(lig.montant_ttc),0), COALESCE(SUM(lig.montant_ht),0) FROM gestion_ventes_commande_ligne AS lig WHERE lig.commande_id=NEW.id INTO NEW.montant_ttc, NEW.montant_ht;

  SELECT rolsuper FROM pg_authid WHERE rolname=current_user INTO ok;

  IF (NEW.commande_contact_id IS NULL OR NEW.facture_contact_id IS NULL OR NEW.livraison_contact_id IS NULL) THEN
    SELECT count(*) FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id INTO total;
    default_contact_id := NULL;
    IF 0>=total THEN
      IF NOT ok THEN
        RAISE EXCEPTION 'Pour réaliser une commande le client doit avoir au moins une adresse.';
      END IF;
    ELSIF total=1 THEN
      SELECT id FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id INTO default_contact_id;
      NEW.commande_contact_id  := default_contact_id;
      NEW.facture_contact_id   := default_contact_id;
      NEW.livraison_contact_id := default_contact_id;
    ELSE
    SELECT id FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id ORDER BY type_id INTO default_contact_id;

      IF NEW.commande_contact_id IS NULL THEN
        SELECT count(*) FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id AND type_id=2 INTO total;
        IF 0>=total THEN
          NEW.commande_contact_id := default_contact_id;
        ELSE
          SELECT id FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id AND type_id=2 INTO NEW.commande_contact_id;  
        END IF;
      END IF;  

      IF NEW.facture_contact_id IS NULL THEN
        SELECT count(*) FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id AND type_id=3 INTO total;
        IF 0>=total THEN
          NEW.facture_contact_id := default_contact_id;
        ELSE
          SELECT id FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id AND type_id=3 INTO NEW.facture_contact_id;  
        END IF;
      END IF;  

      IF NEW.livraison_contact_id IS NULL THEN
        SELECT count(*) FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id AND type_id=4 INTO total;
        IF 0>=total THEN
          NEW.livraison_contact_id := default_contact_id;
        ELSE
          SELECT id FROM base_partenaire_contact WHERE partenaire_id=NEW.partenaire_id AND type_id=4 INTO NEW.livraison_contact_id;  
        END IF;
      END IF;

    END IF;
  END IF;

  SELECT fc_get_current_contact_version(NEW.commande_contact_id) INTO NEW.commande_version_id;
  SELECT fc_get_impression_id(NEW.impression_id,1) INTO NEW.impression_id;
  SELECT fc_get_impression_modele_id(NEW.impression_id, NEW.modele_id) INTO NEW.modele_id;
  SELECT validite_delai_id, avec_signature, fc_get_delai_date(validite_delai_id,NEW.date)
    FROM gestion_ventes_commande_type
    WHERE id=NEW.type_id
    INTO NEW.validite_delai_id, NEW.avec_signature, NEW.validite_date;
  SELECT fc_get_reduction_rate(NEW.partenaire_id, NEW.date) INTO NEW.reduction_taux;
  IF TG_OP='INSERT' THEN
    IF NEW.numero IS NULL OR NOT ok THEN
      SELECT fc_nextval('COMMANDE') INTO NEW.numero;
    END IF;
  END IF;
  RETURN NEW;
END;
]]>    </code>
    </function>



    <function name="tg_complete_ventes_commande_ligne" type="trigger" schema="societe">
      <code><![CDATA[
  commande_date gestion_ventes_commande.date%TYPE;
  commande_reduction gestion_ventes_commande.reduction_taux%TYPE;
  total integer;
  sans_stock boolean;
BEGIN
  IF TG_OP='UPDATE' OR TG_OP='DELETE' THEN
    IF OLD.immodifiable THEN
      IF TG_OP='DELETE' THEN
        RAISE EXCEPTION 'Une ligne d''une commande passée en facture est immodifiable et ineffaçable.';
      END IF;
      NEW.immodifiable     := true;
      NEW.nom               := OLD.nom;
      NEW.commande_id        := OLD.commande_id;
      NEW.produit_id         := OLD.produit_id;
      NEW.prix_id             := OLD.prix_id;
      NEW.stock_id            := OLD.stock_id;
      NEW.stock_mouvement_id   := OLD.stock_mouvement_id;
      NEW.reduction            := OLD.reduction;
      NEW.montant_unitaire_ttc := OLD.montant_unitaire_ttc;
      NEW.montant_unitaire_ht  := OLD.montant_unitaire_ht;
      NEW.quantite            := OLD.quantite;
      NEW.montant_brut_ttc    := OLD.montant_brut_ttc;
      NEW.montant_brut_ht    := OLD.montant_brut_ht;
      NEW.montant_ttc        := OLD.montant_ttc;
      NEW.montant_ht        := OLD.montant_ht;
      NEW.description      := OLD.description;
    END IF;
  END IF;
  IF TG_OP='INSERT' THEN
    NEW.inclus    := FALSE;
  ELSIF TG_OP='UPDATE' THEN
    IF NEW.inclus AND NOT NEW.a_inclure THEN
      NEW.inclus  := FALSE;
    END IF;
  END IF;
  IF TG_OP='INSERT' OR TG_OP='UPDATE' THEN
    IF NEW.prix_id IS NULL THEN
      RAISE EXCEPTION 'Il faut spécifier quel produit/prix vous voulez utiliser.';
    END IF;
    SELECT montant_ht, montant_ttc, produit_id 
      FROM gestion_produit_prix 
      WHERE id=NEW.prix_id 
      INTO NEW.montant_unitaire_ht, NEW.montant_unitaire_ttc, NEW.produit_id;

    SELECT date, reduction FROM gestion_ventes_commande WHERE id=NEW.commande_id INTO commande_date, commande_reduction;
    SELECT nom, reduction, sans_stock FROM gestion_produit WHERE id=NEW.produit_id INTO NEW.nom, NEW.reduction, sans_stock;
    SELECT count(*) FROM gestion_produit WHERE id=NEW.produit_id  AND COALESCE(date_fin,'31/12/9999')>=commande_date AND commande_date>=date_debut INTO total;
    IF total!=1 THEN
      RAISE EXCEPTION 'Le produit ''%'' n''est pas en service au moment de l''établissement du commande.',NEW.nom;
    END IF;
    IF sans_stock THEN
      NEW.stock_id := NULL;
      NEW.stock_mouvement_id := NULL;
    ELSE
      SELECT count(*) FROM gestion_stock WHERE id=NEW.stock_id AND produit_id=NEW.produit_id INTO total;
      IF 0>=total THEN
        NEW.stock_id := NULL;
      END IF;
      IF NEW.stock_id IS NULL THEN
        SELECT count(*) FROM gestion_stock WHERE produit_id=NEW.produit_id AND actif INTO total;
        IF 0>=total THEN
          RAISE EXCEPTION 'Le produit ''%'' qui est déclaré comme possédant un stock, n''en possède pas en réalité.',NEW.nom;
        ELSE
          SELECT id FROM gestion_stock WHERE produit_id=NEW.produit_id AND actif ORDER BY defaut DESC INTO NEW.stock_id;
        END IF;
      END IF;
    END IF;

    IF 0>=NEW.quantite THEN
      RAISE EXCEPTION 'La quantité du produit doit être supérieure ou égale à 1.';
    END IF;
    NEW.montant_brut_ht  := NEW.quantite*NEW.montant_unitaire_ht;
    NEW.montant_brut_ttc := NEW.quantite*NEW.montant_unitaire_ttc;
    IF NOT NEW.reduction THEN
      commande_reduction := 0;
    END IF;
    NEW.montant_ht  := NEW.montant_brut_ht*(1-commande_reduction);
    NEW.montant_ttc := NEW.montant_brut_ttc*(1-commande_reduction);
    RETURN NEW;
  ELSE
    RETURN OLD;
  END IF;
END;]]>
      </code>
    </function>



    <function name="tg_manage_ventes_commande_ligne" type="trigger" schema="societe">
      <code>
  p_commande_id gestion_ventes_commande.date%TYPE;
BEGIN
  IF TG_OP='INSERT' THEN
    IF NEW.stock_id IS NOT NULL THEN
      SELECT nextval('gestion_stock_mouvement_id_seq') INTO NEW.stock_mouvement_id;
      INSERT INTO gestion_stock_mouvement (id,stock_id,quantite,virtuel,date) SELECT NEW.stock_mouvement_id, NEW.stock_id, -NEW.quantite, true, 'now'::date;
    END IF;
  ELSIF TG_OP='UPDATE' THEN
    IF NEW.stock_id IS NULL AND OLD.stock_id IS NOT NULL THEN
      DELETE FROM gestion_stock_mouvement WHERE id=NEW.stock_mouvement_id;
    ELSIF NEW.stock_id IS NOT NULL AND OLD.stock_id IS NOT NULL THEN
      UPDATE gestion_stock_mouvement SET stock_id=NEW.stock_id, quantite=-NEW.quantite, virtuel=true, date='now'::date WHERE id=NEW.stock_mouvement_id;
    ELSIF NEW.stock_id IS NOT NULL AND OLD.stock_id IS NULL THEN
      SELECT nextval('gestion_stock_mouvement_id_seq') INTO NEW.stock_mouvement_id;
      INSERT INTO gestion_stock_mouvement (id,stock_id,quantite,virtuel,date) SELECT NEW.stock_mouvement_id, NEW.stock_id, -NEW.quantite, true, 'now'::date;      
    END IF;  
  ELSIF TG_OP='DELETE' THEN
    IF NEW.stock_id IS NOT NULL THEN
      DELETE FROM gestion_stock_mouvement WHERE id=NEW.stock_mouvement_id;
    END IF;    
  END IF;

  IF TG_OP='DELETE' THEN
    p_commande_id := OLD.commande_id;
  ELSE
    p_commande_id := NEW.commande_id;
  END IF;
  UPDATE gestion_ventes_commande SET montant_ttc=COALESCE(SUM(lig.montant_ttc),0), montant_ht=COALESCE(SUM(lig.montant_ht),0) FROM gestion_ventes_commande_ligne AS lig WHERE id=p_commande_id AND lig.commande_id=p_commande_id;
  RETURN NULL;
END;
      </code>
    </function>



    <function name="tg_complete_ventes_facture" type="trigger" schema="societe">
      <code>
  total integer;
  ok boolean;
  p_piece_id compta_piece.id%TYPE;
  p_piece_libelle compta_piece.libelle%TYPE;
  p_piece_journal_type_id compta_piece.journal_type_id%TYPE;
  p_abrev text;
BEGIN

  IF TG_OP='UPDATE' OR TG_OP='DELETE' THEN
    IF OLD.immodifiable THEN
      IF TG_OP='DELETE' THEN
        RAISE EXCEPTION 'Une facture ne peut pas être supprimée.';
      END IF;
      NEW.immodifiable   := true;
      NEW.commande_id    := OLD.commande_id;
      NEW.employe_id     := OLD.employe_id;
      NEW.partenaire_id  := OLD.partenaire_id;
      NEW.numero         := OLD.numero;
      NEW.date           := OLD.date;
      NEW.reduction_taux := OLD.reduction_taux;
      NEW.montant_ttc    := OLD.montant_ttc;
      NEW.montant_ht     := OLD.montant_ht;
    END IF;
  END IF;  

  IF TG_OP='INSERT' OR TG_OP='UPDATE' THEN
    IF NEW.commande_id IS NULL THEN
      RAISE EXCEPTION 'Vous devez obligatoirement utiliser une commande pour créer une facture.';
    END IF;
    SELECT avec_bons_livraison FROM gestion_ventes_commande WHERE id=NEW.commande_id INTO ok;
    IF ok THEN
      RAISE EXCEPTION 'La gestion des bons de livraison n''est pas encore implémentée.';
    END IF;
    SELECT fc_get_impression_id(NEW.impression_id,2) INTO NEW.impression_id;
    SELECT fc_get_impression_modele_id(NEW.impression_id, NEW.modele_id) INTO NEW.modele_id;
  END IF;

  IF TG_OP='INSERT' THEN
    IF NEW.date IS NULL OR NOT ok THEN
      NEW.date := 'now'::date;
    END IF;

    SELECT partenaire_id,employe_id,reduction_taux, objet, civilites, montant_ht, montant_ttc, fc_get_current_contact_version(facture_contact_id), fc_get_current_contact_version(livraison_contact_id),paiement_delai_id, fc_get_delai_date(paiement_delai_id,NEW.date)
      FROM gestion_ventes_commande AS com
           JOIN gestion_ventes_commande_type AS type ON (type_id=type.id)
      WHERE com.id=NEW.commande_id 
      INTO NEW.partenaire_id, NEW.employe_id, NEW.reduction_taux, NEW.objet, NEW.civilites, NEW.montant_ht, NEW.montant_ttc, NEW.facture_version_id, NEW.livraison_version_id,NEW.paiement_delai_id,NEW.paiement_date;

    /* Piece */
/*
    SELECT nextval('compta_piece_id_seq') INTO p_piece_id;
    SELECT id, abrev FROM compta_journal_type WHERE code='SALES' INTO p_piece_journal_type_id, p_abrev;
    IF p_piece_journal_type_id IS NULL THEN
      RAISE EXCEPTION 'Un seul et unique journal de ventes (SALES) doit exister pour faire des factures.';
    END IF;
    p_piece_libelle :='['||COALESCE(p_abrev,'')||']['||NEW.partenaire_id||'] '''||COALESCE(NEW.objet,'')||'''';
    INSERT INTO compta_piece(id,libelle,date,echeance,journal_type_id)
      VALUES (p_piece_id,p_piece_libelle,NEW.date,NEW.delai_date,p_piece_journal_type_id);
    NEW.piece_id  := p_piece_id;
*/
    SELECT rolsuper FROM pg_authid WHERE rolname=current_user INTO ok;
    IF NEW.numero IS NULL OR NOT ok THEN
      SELECT fc_nextval('FACTURE') INTO NEW.numero;
    END IF;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_manage_ventes_facture" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  /* Lignes (Ecritures, Adhesion...) */
  INSERT INTO gestion_ventes_facture_ligne (facture_id, commande_ligne_id)  
    SELECT NEW.id, ligne.id
      FROM gestion_ventes_commande_ligne AS ligne 
      WHERE ligne.a_inclure AND NOT ligne.inclus;
  /* Ligne TVA
  INSERT INTO compta_ecriture (libelle,debit_d,credit_d,compte_id,piece_id) 
    SELECT taxe.nom, 0, SUM(fc_get_taxe_montant(ligne.montant_ht,taxe.id)), fc_get_compte(taxe.compteperm_id), NEW.piece_id
      FROM gestion_ventes_facture_ligne AS ligne LEFT JOIN gestion_produit_taxe_rel AS rel USING (produit_id)
           LEFT JOIN gestion_produit_taxe AS taxe ON (taxe.id=taxe_id)
      WHERE taxe.actif GROUP BY taxe.nom;
  */
  /* Ligne Contrepartie
  INSERT INTO compta_ecriture (libelle,debit_d,credit_d,compte_id,piece_id) 
    SELECT partenaire.id||' '||partenaire.nom, NEW.montant_ttc, 0, fc_get_compte(partenaire.compteperm_id), NEW.piece_id
      FROM base_partenaire LEFT JOIN compta_compteperm_partenaire_rel ON (partenaire.id=partenaire_id)
      WHERE partenaire.id = NEW.partenaire_id;
  */
  RETURN NULL;
END;
      </code>
    </function>


    <function name="tg_complete_ventes_facture_ligne" type="trigger" schema="societe">
      <code>
  p_facture_reduction gestion_ventes_facture.reduction_taux%TYPE;
  p_piece_id compta_piece.id%TYPE;
  p_compteperm_id compta_compteperm.id%TYPE;
  p_facture_date gestion_ventes_facture.date%TYPE;
  total integer;
  sans_stock boolean;
  p_avec_bons_livraison boolean;
  p_commande_id integer;
BEGIN
  IF TG_OP='UPDATE' OR TG_OP='DELETE' THEN
    IF OLD.immodifiable THEN
      IF TG_OP='DELETE' THEN
        RAISE EXCEPTION 'Une ligne de facture ne peut pas être supprimée.';
      END IF;

      NEW.immodifiable         := true;
      NEW.nom                  := OLD.nom;
      NEW.ecriture_id          := OLD.ecriture_id;
      NEW.commande_ligne_id    := OLD.commande_ligne_id;
      NEW.facture_id           := OLD.facture_id;
      NEW.produit_id           := OLD.produit_id;
      NEW.prix_id              := OLD.prix_id;
      NEW.stock_id             := OLD.stock_id;
      NEW.stock_mouvement_id   := OLD.stock_mouvement_id;
      NEW.reduction            := OLD.reduction;
      NEW.montant_unitaire_ttc := OLD.montant_unitaire_ttc;
      NEW.montant_unitaire_ht  := OLD.montant_unitaire_ht;
      NEW.quantite             := OLD.quantite;
      NEW.montant_brut_ttc     := OLD.montant_brut_ttc;
      NEW.montant_brut_ht      := OLD.montant_brut_ht;
      NEW.montant_ttc          := OLD.montant_ttc;
      NEW.montant_ht           := OLD.montant_ht;
      NEW.description          := OLD.description;

    END IF;
  END IF;

  IF TG_OP='INSERT' THEN
    /* Affectation des principales valeurs */
    SELECT produit_id,prix_id,stock_mouvement_id,reduction, description, commande_id FROM gestion_ventes_commande_ligne WHERE id=NEW.commande_ligne_id INTO NEW.produit_id, NEW.prix_id, NEW.stock_mouvement_id, NEW.reduction, NEW.description, p_commande_id;
    SELECT avec_bons_livraison FROM gestion_ventes_commande WHERE id=p_commande_id INTO p_avec_bons_livraison;
    SELECT date, reduction, piece_id FROM gestion_ventes_facture WHERE id=NEW.facture_id INTO p_facture_date, p_facture_reduction, p_piece_id;
    IF p_avec_bons_livraison THEN
      RAISE EXCEPTION 'Les bons de livraisons ne sont pas encore gérés.';
    ELSE
      /* Recup des montants tel que (sans bons de livraisons) */
      SELECT quantite, montant_unitaire_ttc, montant_unitaire_ht, montant_brut_ttc, montant_brut_ht, montant_ttc, montant_ht 
        FROM gestion_ventes_commande_ligne 
        INTO NEW.quantite, NEW.montant_unitaire_ttc, NEW.montant_unitaire_ht, NEW.montant_brut_ttc, NEW.montant_brut_ht, NEW.montant_ttc, NEW.montant_ht;
    END IF;

    /* Ecriture */
    SELECT count(*) FROM gestion_produit_compteperm_rel WHERE produit_id=NEW.produit_id AND date_fin>=p_facture_date AND p_facture_date>=date_debut INTO total;
    IF total!=1 THEN
      RAISE EXCEPTION 'Le produit % n''est pas rattaché à un compte comptable au moment de l''établissmeent de la facture.',NEW.nom;
    END IF;
    SELECT compteperm_id FROM gestion_produit_compteperm_rel WHERE produit_id=NEW.produit_id AND date_fin>=p_facture_date AND p_facture_date>=date_debut INTO p_compteperm_id;
    INSERT INTO compta_ecriture(libelle,debit_d,credit_d,compte_id,piece_id) 
      VALUES (NEW.nom, 0, NEW.montant_ht, fc_get_compte(p_compteperm_id), p_piece_id);
    /* Adhesion */
    INSERT INTO gestion_adhesion (facture_ligne_id,periode_id,type_id,reduction_id)
      SELECT NEW.id, periode.id, atype.id, atype.reduction_id
        FROM gestion_type_produit_rel AS tprel
             JOIN gestion_adhesion_type AS atype ON (adhesion_type_id=atype.id)
             JOIN gestion_adhesion_periode_rel AS rel ON (atype.id=rel.type_id)
             JOIN gestion_adhesion_periode AS periode ON (periode.id=rel.periode_id)
        WHERE produit_id=NEW.produit_id AND periode.date_fin>=p_facture_date AND p_facture_date>=periode.date_debut;
    
  END IF;

  RETURN NEW;
END;
      </code>
    </function>


    <function name="tg_complete_ventes_relance" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='UPDATE' THEN
    NEW.dateheure:=OLD.dateheure;
  END IF;
  IF TG_OP='INSERT' THEN
    NEW.datetime := 'now'::timestamp;
    INSERT INTO gestion_ventes_relance_lettre (relance_id,etape_id,echeance_id,partenaire_id)
      SELECT NEW.id, etape.id, echeance.id, echeance.partenaire_id 
        FROM gestion_ventes_facture_reglement_echeance AS echeance
             JOIN gestion_ventes_relance_mode_etape AS etape USING (relance_mode_id)
        WHERE 'now'::date-echeance.date>=0 AND NOT echeance.id||'X'||etape.id IN (SELECT echeance_id||'X'||etape_id FROM gestion_ventes_relance_lettre);
  END IF;
END;
      </code>
    </function>


  </functions>
  
  <triggers>

    <trigger name="tg_complete_sequence" schema="societe" function="tg_complete_sequence">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_sequence"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_sequence"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="gestion_sequence"/>
    </trigger>

    <trigger name="tg_complete_produit_taxe" schema="societe" function="tg_complete_produit_taxe">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_produit_taxe"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_produit_taxe"/>
    </trigger>

    <trigger name="tg_manage_produit_prix_taxe_rel" schema="societe" function="tg_complete_produit_prix_taxe_rel">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="gestion_produit_prix_taxe_rel"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="gestion_produit_prix_taxe_rel"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="gestion_produit_prix_taxe_rel"/>
    </trigger>

    <trigger name="tg_complete_produit_prix" schema="societe" function="tg_complete_produit_prix">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_produit_prix"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_produit_prix"/>
    </trigger>

    <trigger name="tg_complete_lien" schema="societe" function="tg_complete_lien">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_lien"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_lien"/>
    </trigger>

    <trigger name="tg_complete_lien_role" schema="societe" function="tg_complete_lien_role">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_lien_role"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_lien_role"/>
    </trigger>

    <trigger name="tg_complete_adhesion" schema="societe" function="tg_complete_adhesion">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_adhesion"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_adhesion"/>
    </trigger>

    <trigger name="tg_complete_ventes_commande" schema="societe" function="tg_complete_ventes_commande">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_commande"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_commande"/>
    </trigger>

    <trigger name="tg_complete_ventes_commande_ligne" schema="societe" function="tg_complete_ventes_commande_ligne">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
    </trigger>

    <trigger name="tg_manage_ventes_commande_ligne" schema="societe" function="tg_complete_ventes_commande_ligne">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="gestion_ventes_commande_ligne"/>
    </trigger>

    <trigger name="tg_complete_ventes_facture" schema="societe" function="tg_complete_ventes_facture">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_facture"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_facture"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="gestion_ventes_facture"/>
    </trigger>

    <trigger name="tg_manage_ventes_facture" schema="societe" function="tg_manage_ventes_facture">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_facture"/>
    </trigger>

    <trigger name="tg_complete_ventes_relance" schema="societe" function="tg_complete_ventes_relance">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="gestion_ventes_relance"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="gestion_ventes_relance"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="gestion_ventes_relance"/>
    </trigger>

  </triggers>

</analysis>
