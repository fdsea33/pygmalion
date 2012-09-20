<?xml version="1.0" encoding="UTF-8"?>

<analysis name="Base" version="0.0.0" 
  xmlns:typens="urn:Base"
  xmlns="http://www.pygmalion.org/analysis/">
  
  <schemas>
    <schema name="base"    type="static"  label="base" uuid="ce56e4a4-a7e0-4dd7-882e-185360a7d20e"/>
    <schema name="societe" type="dynamic" label="code" use="one-at-once" image-schema="base" image-class="base_societe" image-property="schema" image-name="nom" uuid="cca13bdc-26c1-42db-95f5-ef15b80c25a6">
      <from>
        <from-table name="base.base_societe_utilisateur_rel"/>
      </from>
      <where>
        <comparison value="utilisateur_login" is="equals-to" target="$1"/>
      </where>
    </schema>
  </schemas>

  <datatypes>
    <datatype name="code"           type="varchar" size="16"/>
    <datatype name="label"          type="varchar" size="128"/>
    <datatype name="money"          type="numeric" precision="16" scale="2"/>
    <datatype name="rate"           type="numeric" precision="16" scale="8"/>
    <datatype name="abbreviation"   type="varchar" size="4"/>
    <datatype name="name"           type="varchar" size="64"/>
    <datatype name="siren"          type="varchar" size="9"/>
    <datatype name="key"            type="varchar" size="2"/>
    <datatype name="address_line"   type="varchar" size="38"/>
    <datatype name="address_number" type="varchar" size="5"/>
    <datatype name="address_way"    type="varchar" size="32"/>
    <datatype name="ean13"          type="varchar" size="13"/>
    <datatype name="soundex2"       type="varchar" size="4"/>
    <datatype name="phonex"         type="float"   size="8"/>
  </datatypes>

  <classes>

    <!-- Internationalisation -->
    <class name="base_langue" schema="base" primary-key="id">
      <property uid="1001" name="id"           type="serial"  notnull="true"/>
      <property uid="1002" name="code"         type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"          type="name"    notnull="true" meaning="significant"/>
      <record>
        <field>1</field>
        <field>fr-FR</field>
        <field>Français (France)</field>
      </record>
      <record>
        <field>2</field>
        <field>en-US</field>
        <field>Anglais (U.S.A.)</field>
      </record>
      <record>
        <field>3</field>
        <field>en-GB</field>
        <field>Anglais (Royaume-Uni)</field>
      </record>
      <record>
        <field>4</field>
        <field>es-ES</field>
        <field>Espagnol (Espagne)</field>
      </record>
    </class>

    <class name="base_devise" schema="base" primary-key="id">
      <property uid="1001" name="id"       type="serial"       notnull="true"/>
      <property uid="1002" name="nom"      type="word"         notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="symbole"  type="abbreviation" notnull="true" unique="true" meaning="significant"/>
      <property uid="1004" name="abrev"    type="abbreviation" notnull="true" unique="true"/>
      <property uid="1005" name="taux"     type="rate"         notnull="true"/>
      <property uid="1002" name="defaut"   type="boolean"      notnull="true" default="false"/>
      <constraint type="check" expr="taux>0"/>
      <record>
        <field>1</field>
        <field>Euro</field>
        <field>€</field>
        <field>EUR</field>
        <field>1</field>
        <field>true</field>
      </record>
      <record>
        <field>2</field>
        <field>Dollar américain</field>
        <field>$</field>
        <field>USD</field>
        <field>0.77296461</field>
        <field>false</field>
      </record>
    </class>

    <!-- Société & Services -->
    <class name="base_societe" schema="base" primary-key="id">
      <property uid="1001" name="id"          type="serial" notnull="true"/>
      <property uid="1002" name="code"        type="code"   notnull="true" unique="true" meaning="significant"/>
      <property uid="1003" name="nom"         type="name"   notnull="true" unique="true" meaning="major"/>
      <property uid="1004" name="siren"       type="siren"  notnull="true" unique="true"/>
      <property uid="1004" name="rcs_ville"   type="word"/>
      <property uid="1004" name="rcs_type"    type="char" default="A"/>
      <property uid="1004" name="rm_numero"   type="word"/>
      <property uid="1004" name="nui"         type="word"  notnull="true" mode="auto" meaning="significant"/>
      <property uid="1004" name="naf"         type="word"/>
      <property uid="1004" name="code_pays"   type="key"/>
      <property uid="1004" name="tic_prefixe" type="key"/>
      <property uid="1004" name="tic"         type="word" index="default" mode="auto"/>
      <property uid="1005" name="adresse"     type="phrase"/>
      <property uid="1006" name="schema"      type="schema" mode="auto"/>
      <property uid="1018" name="note"        type="text"/>
    </class>

    <class name="base_societe_etablissement" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial" notnull="true"/>
      <property uid="1003" name="societe_id"       type="id"     notnull="true"/>
      <property uid="1002" name="code"             type="code"   notnull="true" index="default" unique="true" meaning="major"/>
      <property uid="1003" name="nom"              type="name"   notnull="true" meaning="significant"/>
      <property uid="1002" name="nic"              type="code"   notnull="true" unique="true"/>
      <property uid="1002" name="siret"            type="word"   notnull="true" unique="true" mode="auto"/>
      <property uid="1003" name="adresse"          type="phrase"/>
      <property uid="1018" name="note"             type="text"/>
      <constraint type="foreign-key" column="societe_id" references="base_societe(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="base_societe_utilisateur_rel" schema="base" primary-key="id" type="link">
      <property uid="1001" name="id"                type="serial" notnull="true"/>
      <property uid="1003" name="societe_id"        type="id"     notnull="true" meaning="major"/>
      <property uid="1003" name="utilisateur_login" type="word"   notnull="true" unique="true" meaning="major"/>
      <constraint type="foreign-key" column="societe_id" references="base_societe(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="utilisateur_login" references="systeme_utilisateur(login)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="base_societe_parametre" schema="societe" primary-key="id">
      <property uid="1001" name="id"                type="serial"  notnull="true"/>
      <property uid="1002" name="code"              type="code"    notnull="true" index="default" unique="true" meaning="major"/>
      <property uid="1002" name="nom"               type="name"    notnull="true" index="default" unique="true" meaning="significant"/>
      <property uid="1002" name="valeur"            type="text"/>
    </class>

    <class name="base_societe_service" schema="societe" primary-key="id">
      <property uid="1001" name="id"                type="serial"  notnull="true"/>
      <property uid="1002" name="code"              type="code"    notnull="true" index="default" unique="true" meaning="major"/>
      <property uid="1003" name="nom"               type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="parent_service_id" type="id"/>
      <property uid="1004" name="etablissement_id"  type="id" notnull="true"/>
      <property uid="1018" name="note"              type="text"/>
      <constraint type="foreign-key" column="parent_service_id" references="base_societe_service(id)" ondelete="set null" onupdate="cascade"/>
      <constraint type="foreign-key" column="etablissement_id" references="base_societe_etablissement(id)" ondelete="set null" onupdate="cascade"/>
    </class>

    <!-- Droits utilisateurs -->
    <class name="base_droits_profil" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="code"                 type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true" meaning="significant"/>
      <property uid="1018" name="note"                 type="text"/>
    </class>

    <class name="base_droits_profil_module" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1014" name="profil_id"            type="id" notnull="true" meaning="major"/>
      <property uid="1014" name="module_id"            type="id" notnull="true" meaning="major"/>
      <property uid="1003" name="selection"            type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="insertion"            type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="modification"         type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="suppression"          type="boolean" notnull="true" default="false"/>
      <constraint type="unique" column="profil_id,module_id"/>
      <constraint type="foreign-key" column="module_id" references="base_droits_module(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="profil_id" references="base_droits_profil(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="base_droits_module" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="code_interface"       type="code"    notnull="true" unique="true" meaning="significant"/>
      <property uid="1014" name="parent_module_id"     type="id"/>
      <property uid="1014" name="objets"               type="text"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="parent_module_id" references="base_droits_module(id)" ondelete="set null" onupdate="cascade"/>
    </class>


    <class name="base_acces" schema="societe" primary-key="id">
      <property uid="1001" name="id"      type="serial"  notnull="true"/>
      <property uid="1002" name="code"    type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="nom"     type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="valeur"  type="integer" notnull="true" unique="true"/>
      <constraint type="check" expr="valeur>=0"/>
      <record>
        <field>1</field>
        <field>INVITE</field>
        <field>Invité</field>
        <field>1000000</field>
      </record>
      <record>
        <field>2</field>
        <field>EXPERTCO</field>
        <field>Expert comptable</field>
        <field>0</field>
      </record>
    </class>


    <!-- Employés -->
    <class name="base_societe_employe" schema="societe" primary-key="id">
      <property uid="1001" name="id"                type="serial"  notnull="true"/>
      <property uid="1003" name="service_id"        type="id"      notnull="true"/>
      <property uid="1003" name="utilisateur_id"    type="id"      notnull="true" unique="true"/>
      <property uid="1003" name="utilisateur_login" type="word"    notnull="true" unique="true" mode="auto" meaning="significant"/>
      <property uid="1003" name="profil_id"         type="id"      notnull="true"/>
      <property uid="1003" name="acces_id"          type="id"      notnull="true"/>
      <property uid="1002" name="nom"               type="name"    notnull="true" meaning="major"/>
      <property uid="1002" name="prenom"            type="name"    notnull="true" meaning="significant"/>
      <property uid="1002" name="initiales"         type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="actif"             type="boolean" notnull="true" default="true"/>
      <property uid="1002" name="role"              type="word"/>
      <property uid="1002" name="telephone"         type="word"/>
      <property uid="1002" name="mobile"	    type="word"/>
      <property uid="1002" name="fax"               type="word"/>
      <property uid="1002" name="email"             type="phrase"/>
      <property uid="1002" name="bureau"            type="phrase"/>
      <property uid="1002" name="note"              type="word"/>
      <constraint type="foreign-key" column="service_id" references="base_societe_service(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="utilisateur_id" references="systeme_utilisateur(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="utilisateur_login" references="systeme_utilisateur(login)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="profil_id" references="base_droits_profil(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="acces_id" references="base_acces(id)" ondelete="restrict" onupdate="cascade"/>
    </class>



    <!-- Partenaires/Client/Fournisseur -->
    <class name="base_partenaire_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true" unique="true" index="default" meaning="major"/>
      <property uid="1003" name="morale"               type="boolean" notnull="true" default="true"/>
      <property uid="1003" name="masculin"             type="boolean" notnull="true" default="false"/>
      <property uid="1004" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1008" name="titre"                type="name"    notnull="true" index="default" meaning="significant"/>
      <property uid="1008" name="civilites"            type="name"    nevernull="true"/>
      <record type="partial" with-triggers="true">
        <field property="nom">Homme</field>
        <field property="morale">false</field>
        <field property="masculin">true</field>
        <field property="titre">Monsieur</field>
      </record>
      <record type="partial" with-triggers="true">
        <field property="nom">Femme</field>
        <field property="morale">false</field>
        <field property="masculin">false</field>
        <field property="titre">Madame</field>
      </record>
      <record type="partial" with-triggers="true">
        <field property="nom">SA</field>
        <field property="titre">S.A.</field>
      </record>
    </class>


    <class name="base_partenaire" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true" meaning="major"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true"   index="default"/>
      <property uid="1008" name="type_id"              type="id"      notnull="true" index="default"/>
      <property uid="1002" name="libelle"              type="address_line" notnull="true" index="default" mode="auto" meaning="significant"/>
      <property uid="1004" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1006" name="prenom"               type="name"    index="default"/>
      <property uid="1003" name="morale"               type="boolean" notnull="true" mode="auto"/>
      <property uid="1008" name="titre"                type="name"    index="default" mode="auto"/>
      <property uid="1009" name="debit_limite"         type="money"/>
      <property uid="1010" name="credit_limite"        type="money"/>
      <property uid="1011" name="langue_id"            type="id" index="default"/>
      <property uid="1012" name="site_web"             type="phrase"/>
      <property uid="1013" name="parent_id"            type="id"/>
      <property uid="1015" name="responsable_id"       type="id"/>
      <property uid="1016" name="naissance_date"       type="date"/>
      <property uid="1017" name="ean13"                type="ean13"/>
      <property uid="1017" name="nom_soundex2"         type="soundex2" notnull="true" index="default" mode="auto"/>
      <property uid="1017" name="nom_phonex"           type="phonex" index="default" mode="auto"/>
      <property uid="1018" name="note"                 type="text"/>
      <constraint type="foreign-key" column="parent_id" references="base_partenaire(id)" ondelete="set null" onupdate="cascade"/>
      <constraint type="foreign-key" column="responsable_id" references="base_societe_employe(id)" ondelete="set null" onupdate="cascade"/>
      <constraint type="foreign-key" column="langue_id" references="base_langue(id)" ondelete="set null" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id" references="base_partenaire_type(id)" ondelete="restrict" onupdate="cascade"/>
    </class>



    <!-- Contacts et adresses -->
    <class name="base_partenaire_contact" schema="societe" primary-key="id">
      <property uid="1001" name="id"                    type="serial"  notnull="true"/>
      <property uid="1002" name="actif"                 type="boolean" mode="auto-insert" notnull="true" default="true"/>
      <property uid="1002" name="date_fin"              type="date"    mode="auto"/>
      <property uid="1001" name="partenaire_id"         type="id"           notnull="true" meaning="major"/>
      <property uid="1001" name="type_id"               type="id"           notnull="true" default="1" meaning="major"/>
      <property uid="1001" name="complement"            type="address_line"/>
      <property uid="1001" name="ligne3"                type="address_line"/>
      <property uid="1001" name="numero"                type="address_number"/>
      <property uid="1001" name="voie"                  type="address_way"/>
      <property uid="1001" name="ligne5"                type="address_line"/>
      <property uid="1001" name="codepostal_commune_id" type="id"           notnull="true"/>
      <property uid="1001" name="codepostal_id"         type="id"           notnull="true" mode="auto"/>
      <property uid="1001" name="commune_id"            type="id"           notnull="true" mode="auto"/>
      <property uid="1001" name="codepostal"            type="address_number" index="default" mode="auto" meaning="significant"/>
      <property uid="1001" name="commune"               type="address_way" index="default" mode="auto" meaning="significant"/>
      <property uid="1001" name="telephone"             type="code" index="default" meaning="significant"/>
      <property uid="1001" name="mobile"                type="code" index="default"/>
      <property uid="1001" name="fax"                   type="code" index="default"/>
      <property uid="1001" name="email"                 type="phrase" index="default"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id" references="base_partenaire_contact_type(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="codepostal_commune_id" references="base_codepostal_commune_rel(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="codepostal_id" references="base_codepostal(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commune_id" references="base_commune(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="base_partenaire_contact_version" schema="societe" primary-key="id">
      <property uid="1001" name="id"                    type="serial"   notnull="true"/> 
      <property uid="1002" name="datetime_debut"        type="datetime" notnull="true" mode="auto"/>
      <property uid="1002" name="datetime_fin"          type="datetime" notnull="true" mode="auto"/>
      <property uid="1001" name="contact_id"            type="id"       notnull="true" default="1" meaning="major"/>
      <property uid="1001" name="complement"            type="address_line"   mode="auto"/>
      <property uid="1001" name="ligne3"                type="address_line"   mode="auto"/>
      <property uid="1001" name="numero"                type="address_number" mode="auto"/>
      <property uid="1001" name="voie"                  type="address_way"    mode="auto"/>
      <property uid="1001" name="ligne5"                type="address_line"   mode="auto"/>
      <property uid="1001" name="codepostal_commune_id" type="id"       notnull="true" mode="auto"/>
      <property uid="1001" name="codepostal_id"         type="id"       notnull="true" mode="auto"/>
      <property uid="1001" name="commune_id"            type="id"       notnull="true" mode="auto"/>
      <property uid="1001" name="codepostal"            type="address_number" index="default" mode="auto" meaning="significant"/>
      <property uid="1001" name="commune"               type="address_way" index="default" mode="auto" meaning="significant"/>
      <property uid="1001" name="telephone"             type="phrase" mode="auto" index="default" meaning="significant"/>
      <property uid="1001" name="mobile"                type="phrase" mode="auto" index="default"/>
      <property uid="1001" name="fax"                   type="phrase" mode="auto" index="default" meaning="significant"/>
      <property uid="1001" name="email"                 type="phrase" mode="auto" index="default"/>
      <constraint type="check" expr="datetime_fin>=datetime_debut"/>
      <constraint type="foreign-key" column="contact_id" references="base_partenaire_contact(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="codepostal_commune_id" references="base_codepostal_commune_rel(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="codepostal_id" references="base_codepostal(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commune_id" references="base_commune(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="base_partenaire_contact_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1002" name="code"                 type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="nom"                  type="name"    notnull="true" meaning="significant"/>
      <property uid="1002" name="actif"                type="boolean" notnull="true" default="true"/>
      <property uid="1002" name="immuable"             type="boolean" notnull="true" default="false"/>
      <property uid="1018" name="note"                 type="text"/>
      <record>
        <field>1</field>
        <field>DEFAUT</field>
        <field>Par défaut</field>
        <field>true</field>
        <field>true</field>
        <field></field>
      </record>
      <record>
        <field>2</field>
        <field>DEVIS</field>
        <field>Devis</field>
        <field>true</field>
        <field>true</field>
        <field></field>
      </record>
      <record>
        <field>3</field>
        <field>FACTURATION</field>
        <field>Facturation</field>
        <field>true</field>
        <field>true</field>
        <field></field>
      </record>
      <record>
        <field>4</field>
        <field>LIVRAISON</field>
        <field>Livraison</field>
        <field>true</field>
        <field>true</field>
        <field></field>
      </record>
      <record>
        <field>5</field>
        <field>CONTACT</field>
        <field>Contact</field>
        <field>true</field>
        <field>true</field>
        <field></field>
      </record>

    </class>


    <!-- Communes, Cantons, CP... -->
    <class name="base_codepostal_commune_rel" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial" notnull="true"/>
      <property uid="1001" name="nom"                  type="phrase" notnull="true" unique="true" mode="auto" meaning="major"/>
      <property uid="1001" name="codepostal_id"        type="id" notnull="true"/>
      <property uid="1001" name="commune_id"           type="id" notnull="true"/>
      <constraint type="foreign-key" column="codepostal_id" references="base_codepostal(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="commune_id" references="base_commune(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="base_codepostal" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1001" name="numero"               type="code"    index="default" unique="true" meaning="major"/>
      <property uid="1001" name="cedex"                type="boolean" notnull="true" default="false"/>
    </class>


    <class name="base_commune" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1001" name="nom"                  type="phrase"  notnull="true" meaning="major"/>
      <property uid="1001" name="cedex"                type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="canton_id"            type="id"/>
      <constraint type="foreign-key" column="canton_id" references="base_canton(id)" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="base_canton" schema="base" primary-key="id">
      <property uid="1001" name="id"                   type="serial"  notnull="true"/>
      <property uid="1001" name="nom"                  type="phrase"  notnull="true" meaning="major"/>
      <property uid="1001" name="arrondissement_id"    type="id"/>
    </class>

    
    <!-- Attributs et observations -->
    <class name="base_partenaire_observation" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1001" name="partenaire_id" type="id"      notnull="true" meaning="significant"/>
      <property uid="1001" name="importance_id" type="id"      notnull="true" meaning="significant"/>
      <property uid="1003" name="contenu"       type="phrase"  notnull="true" meaning="major"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="importance_id" references="base_partenaire_observation_importance(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="base_partenaire_observation_importance" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1001" name="niveau"        type="integer" notnull="true" default="1"/>
      <property uid="1003" name="code"          type="code"    notnull="true" unique="true" meaning="significant"/>
      <property uid="1003" name="nom"           type="phrase"  notnull="true" unique="true" meaning="major"/>
    </class>

    <class name="base_partenaire_attribut" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1001" name="partenaire_id" type="id"      notnull="true"/>
      <property uid="1001" name="type_id"       type="id"      notnull="true"/>
      <property uid="1001" name="type_nom"      type="name"    notnull="true" mode="auto" meaning="significant"/>
      <property uid="1001" name="categorie_id"  type="id"      notnull="true"/>
      <property uid="1001" name="categorie_nom" type="name"    notnull="true" mode="auto" meaning="major"/>
      <property uid="1003" name="note"          type="phrase"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id"       references="base_partenaire_attribut_type(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="categorie_id"  references="base_partenaire_attribut_categorie(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="base_partenaire_attribut_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"           type="serial"  notnull="true"/>
      <property uid="1002" name="code"         type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"          type="name"    notnull="true" meaning="significant"/>
      <property uid="1018" name="note"         type="text"/>
    </class>

    <class name="base_partenaire_attribut_categorie" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1001" name="attribut_type_id" type="id"      notnull="true"/>
      <property uid="1002" name="code"             type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"              type="name"    notnull="true" meaning="significant"/>
      <property uid="1018" name="note"             type="text"/>
      <constraint type="foreign-key" column="attribut_type_id" references="base_partenaire_attribut_type(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <!-- Délais -->
    <class name="base_delai" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1001" name="nom"           type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1001" name="defaut"        type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="nb_mois"       type="integer" notnull="true" default="0"/>
      <property uid="1001" name="nb_jours"      type="integer" notnull="true" default="0"/>
      <property uid="1001" name="fin_de_mois"   type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="prolongation"  type="boolean" notnull="true" default="false"/>
      <property uid="1001" name="jour_du_mois"  type="integer" notnull="true" default="1"/>
      <constraint type="check" expr="nb_mois>=0"/>
      <constraint type="check" expr="nb_jours>=0"/>
      <constraint type="check" expr="jour_du_mois BETWEEN 1 AND 31"/>
      <record type="partial">
        <field property="nom">Comptant à réception</field>
      </record>
      <record type="partial">
        <field property="nom">1 mois</field>
        <field property="nb_mois">1</field>
      </record>
      <record type="partial">
        <field property="nom">Fin de mois</field>
        <field property="fin_de_mois">true</field>
        <field property="defaut">true</field>
      </record>
      <record type="partial">
        <field property="nom">30 jours</field>
        <field property="nb_jours">30</field>
      </record>
      <record type="partial">
        <field property="nom">60 jours</field>
        <field property="nb_jours">60</field>
      </record>
      <record type="partial">
        <field property="nom">90 jours</field>
        <field property="nb_jours">90</field>
      </record>
      <record type="partial">
        <field property="nom">30 jours fin de mois</field>
        <field property="nb_jours">30</field>
        <field property="fin_de_mois">true</field>
      </record>
      <record type="partial">
        <field property="nom">30 jours fin de mois le 10</field>
        <field property="nb_jours">30</field>
        <field property="fin_de_mois">true</field>
        <field property="prolongation">true</field>
        <field property="jour_du_mois">10</field>
      </record>
    </class>


    <!-- Impressions -->
    <class name="base_impression_modele" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"   notnull="true" meaning="major"/>
      <property uid="1001" name="impression_id"    type="id"       notnull="true"/>
      <property uid="1003" name="datetime_debut"   type="datetime" notnull="true" auto="true"/>
      <property uid="1003" name="datetime_fin"     type="datetime" notnull="true" auto="true"/>
      <property uid="1018" name="modele"           type="text"     notnull="true"/>
      <constraint type="foreign-key" column="impression_id" references="base_impression(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="base_impression" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"   notnull="true"/>
      <property uid="1001" name="type_id"          type="id"       notnull="true"/>
      <property uid="1002" name="code"             type="code"     notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"              type="name"     notnull="true" meaning="significant"/>
      <property uid="1002" name="defaut"           type="boolean"  notnull="true" default="false"/>
      <property uid="1002" name="actif"            type="boolean"  notnull="true" default="false"/>
      <property uid="1018" name="modele"           type="text"     notnull="true" default="%% Saisissez votre modèle"/>
      <constraint type="foreign-key" column="type_id" references="base_impression_type(id)" ondelete="cascade" onupdate="cascade"/>
    </class>

    <class name="base_impression_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1002" name="code"             type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="immuable"         type="boolean" notnull="true" default="false"/>
      <record>
        <field>1</field>
        <field>DEVIS</field>
      </record>
      <record>
        <field>2</field>
        <field>FACTURE</field>
      </record>
      <record>
        <field>3</field>
        <field>AVOIR</field>
      </record>
      <record>
        <field>4</field>
        <field>BALANCE</field>
      </record>
    </class>

  </classes>

  <functions>


    <function name="tg_complete_societe" type="trigger" schema="base">
      <code><![CDATA[
BEGIN
  IF TG_OP='UPDATE' THEN
    IF OLD.code!=NEW.code THEN
      NEW.code:=OLD.code;
    END IF;
  END IF;
  IF NEW.siren IS NULL THEN
    NEW.siren:='000000000';
  END IF;
  NEW.tic := to_char(NEW.siren::integer,'FM009 009 009');
  IF LENGTH(COALESCE(NEW.rcs_ville,''))>1 THEN
    NEW.rm_numero := NULL;
    NEW.rcs_ville:=UPPER(NEW.rcs_ville);
    NEW.rcs_type:=UPPER(NEW.rcs_type);
    IF LENGTH(COALESCE(NEW.rcs_type,''))!=1 THEN
      NEW.rcs_type:='A';
    END IF;
    IF NEW.rcs_type!='A' THEN
      NEW.rcs_type:='B';
    END IF;
    NEW.nui := 'RCS '||NEW.rcs_ville||' '||NEW.rcs_type||' '||NEW.tic;
  ELSIF 1<=LENGTH(COALESCE(NEW.rm_numero,'')) AND LENGTH(COALESCE(NEW.rm_numero,''))<=3 THEN
    NEW.rcs_ville := NULL;
    NEW.rcs_type  := NULL;
    NEW.rm_numero := to_char(NEW.rm_numero::integer,'FM099');
    NEW.nui := NEW.tic||' RM '||NEW.rm_numero;
  ELSE
    NEW.rcs_ville := NULL;
    NEW.rcs_type  := NULL;
    NEW.rm_numero := NULL;
    NEW.nui := NEW.tic;
  END IF;
  IF LENGTH(COALESCE(NEW.code_pays,''))!=2 THEN
    NEW.code_pays := 'FR';
  END IF;
  IF LENGTH(COALESCE(NEW.tic_prefixe,''))!=2 THEN
    NEW.tic_prefixe := '--';
  END IF;
  NEW.tic := 'FR '||NEW.tic_prefixe||' '||NEW.tic;
  RETURN NEW;
END;]]>
      </code>
    </function>




    <function name="tg_manage_rights" type="trigger" schema="societe">
      <code>
  query     text;
  employe   base_societe_employe%ROWTYPE;
  module    base_droits_module%ROWTYPE;
  profil    base_droits_profil%ROWTYPE;
  droits    record;
  nb_priv   integer;
  tt_revoke integer;
  tt_grant  integer;
  reste_emp  integer;
BEGIN
  tt_revoke:=0;
  tt_grant :=0;

-- revoke all on all from all;
  FOR module IN SELECT * FROM base_droits_module LOOP
    query:='REVOKE ALL ON '||module.objets||' FROM ';
    reste_emp:=0;
    FOR employe IN SELECT * FROM base_societe_employe AS emp WHERE emp.utilisateur_login IN (SELECT usename FROM pg_user) LOOP
      IF reste_emp>0 THEN
        query:=query||',';
      END IF;
      query:=query||employe.utilisateur_login;
      reste_emp:=1;
    END LOOP;
    tt_revoke:=tt_revoke+1;	
    EXECUTE query;
  END LOOP;


-- grant pro on pro to pro;
  FOR profil IN SELECT * FROM base_droits_profil LOOP
    FOR droits IN SELECT objets, COALESCE(selection,false) AS sel, COALESCE(insertion,false) AS ins, COALESCE(modification,false) AS mod, COALESCE(suppression,false) AS sup 
                    FROM base_droits_profil_module LEFT JOIN base_droits_module ON (module_id=base_droits_module.id) 
                    WHERE base_droits_profil_module.profil_id=profil.id LOOP
      query:='';
      nb_priv:=0;
      IF droits.sel THEN 
        query:=query||'SELECT';
        nb_priv:=nb_priv+1;
      END IF;
      IF droits.ins THEN 
        IF nb_priv>0 THEN
          query:=query||',';
        END IF;
        query:=query||'INSERT';
        nb_priv:=nb_priv+1;
      END IF;
      IF droits.mod THEN 
        IF nb_priv>0 THEN
          query:=query||',';
        END IF;
        query:=query||'UPDATE';
        nb_priv:=nb_priv+1;
      END IF;
      IF droits.sup THEN 
        IF nb_priv>0 THEN
          query:=query||',';
        END IF;
        query:=query||'DELETE';
        nb_priv:=nb_priv+1;
      END IF;
      query:='GRANT '||query||' ON '||droits.objets||' TO ';
      IF nb_priv>0 AND query IS NOT NULL THEN
        reste_emp:=0;
        FOR employe IN SELECT * FROM base_societe_employe AS emp WHERE emp.profil_id=profil.id AND emp.utilisateur_login IN (SELECT usename FROM pg_user) LOOP
          IF reste_emp>0 THEN
            query:=query||',';
          END IF;
          query:=query||employe.utilisateur_login;
          reste_emp:=1;
        END LOOP;
        tt_grant :=tt_grant+1;
        EXECUTE query;
      END IF;
    END LOOP;
  END LOOP;
  RAISE NOTICE 'REVOKE %, GRANT %.',tt_revoke,tt_grant;
  RETURN New;
END;
      </code>
    </function>

   
    <function name="tg_complete_societe_etablissement" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT nui||' '||NEW.nic FROM base_societe WHERE id=NEW.societe_id INTO NEW.siret;
  RETURN NEW;
END;
      </code>
    </function>





    <function name="tg_complete_societe_employe" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT login FROM systeme_utilisateur WHERE id=NEW.utilisateur_id INTO NEW.utilisateur_login;
  RETURN NEW;
END;
      </code>
    </function>




    <function name="tg_complete_partenaire" type="trigger" schema="societe">
      <code>
BEGIN
  NEW.nom_soundex2 := soundex2(NEW.nom);
  NEW.nom_phonex   := phonex(NEW.nom);
  SELECT morale, titre FROM base_partenaire_type
    WHERE id=NEW.type_id INTO NEW.morale, NEW.titre;
  NEW.libelle := SUBSTR(COALESCE(NEW.titre||' ','')||NEW.nom||COALESCE(' '||NEW.prenom,''),1,38);
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_partenaire_type" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='UPDATE' THEN
    IF NEW.morale!=OLD.morale OR NEW.titre!=OLD.titre THEN
      UPDATE base_partenaire SET titre=NEW.titre, morale=NEW.morale WHERE type_id=NEW.id;
    END IF;
  END IF;
  IF NEW.civilites IS NULL THEN
    NEW.civilites := NEW.titre;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>





    <function name="tg_complete_contact" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT codepostal_id, commune_id 
    FROM base_codepostal_commune_rel 
    WHERE id=NEW.codepostal_commune_id
    INTO NEW.codepostal_id, NEW.commune_id;
  SELECT numero FROM base_codepostal WHERE id=NEW.codepostal_id INTO NEW.codepostal;
  SELECT nom FROM base_commune WHERE id=NEW.commune_id INTO NEW.commune;

  SELECT UPPER(NEW.numero), UPPER(NEW.voie), UPPER(NEW.ligne5)
    INTO NEW.numero,NEW.voie,NEW.ligne5;
  
  IF TG_OP='UPDATE' THEN
    IF NOT NEW.actif AND OLD.actif THEN
      NEW.date_fin := 'now'::DATE;
    END IF;
  ELSIF TG_OP='INSERT' THEN
    NEW.actif := true;
  END IF;

  RETURN NEW;
END;
      </code>
    </function>


    <function name="tg_manage_contact" type="trigger" schema="societe">
      <code>
BEGIN
  INSERT INTO base_partenaire_contact_version(contact_id) VALUES (NEW.id);
  RETURN NULL;
END;
      </code>
    </function>




    <function name="tg_complete_contact_version" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  IF TG_OP='DELETE' THEN
    RAISE EXCEPTION 'Cette opération est interdite. Une version ne peut être supprimée.';
  ELSIF TG_OP='UPDATE' THEN
    NEW.datetime_debut := OLD.datetime_debut;
    NEW.complement := OLD.complement;
    NEW.ligne3     := OLD.ligne3;
    NEW.numero     := OLD.numero;
    NEW.voie       := OLD.voie;
    NEW.ligne5     := OLD.ligne5;
    NEW.codepostal_commune_id := OLD.codepostal_commune_id;
    NEW.codepostal_id := OLD.codepostal_id;
    NEW.commune_id := OLD.commune_id;
    NEW.codepostal := OLD.codepostal;
    NEW.commune    := OLD.commune;
    NEW.telephone  := OLD.telephone;
    NEW.mobile     := OLD.mobile;
    NEW.fax        := OLD.fax;
    NEW.email      := OLD.email;
  ELSIF TG_OP='INSERT' THEN
    SELECT count(*) 
      FROM base_partenaire_contact_version
      WHERE contact_id=NEW.contact_id
      INTO total;
    IF total=0 THEN
      NEW.datetime_debut := '-infinity'::timestamp;
    ELSE
      NEW.datetime_debut := 'now'::timestamp;
    END IF;
    UPDATE base_partenaire_contact_version SET datetime_fin='now'
      WHERE datetime_fin>CURRENT_TIMESTAMP AND contact_id=NEW.contact_id;
    NEW.datetime_fin := 'infinity'::timestamp;
    SELECT complement,ligne3,numero,voie,ligne5,codepostal_commune_id,codepostal_id,commune_id,codepostal,commune
      FROM base_partenaire_contact
      WHERE id=NEW.contact_id
      INTO NEW.complement,NEW.ligne3,NEW.numero,NEW.voie,NEW.ligne5,NEW.codepostal_commune_id,NEW.codepostal_id, NEW.commune_id, NEW.codepostal, NEW.commune;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>


    <function name="fc_get_current_contact_version" schema="base">
      <parameters>
        <parameter name="a_contact_id" type="id"/>
      </parameters>
      <return type="id"/>
      <code>
  p_ret integer;
BEGIN
  IF a_contact_id IS NULL THEN
    RETURN NULL;
  END IF;
  SELECT id FROM base_partenaire_contact_version 
    WHERE contact_id=a_contact_id AND datetime_fin='infinity' 
    INTO p_ret;
  IF p_ret IS NULL THEN
    RAISE EXCEPTION 'Erreur système : Pas de version en cours pour le contact ''%''.',COALESCE(a_contact_id,'NULL');
  END IF;
  RETURN p_ret;
END;
      </code>
    </function>




    <function name="tg_complete_contact_type" type="trigger" schema="societe">
      <code>
BEGIN
  IF (TG_OP='DELETE') THEN
    IF OLD.immuable THEN
      RAISE EXCEPTION 'This type mustn''t be removed.';
    END IF;
    RETURN OLD;
  ELSE
    IF OLD.immuable THEN
      NEW.id := OLD.id;
      NEW.code := OLD.code;
      NEW.immuable := true;
    END IF;    
    RETURN NEW;
  END IF;
END;
      </code>
    </function>


    <function name="tg_complete_codepostal_commune_rel" type="trigger" schema="base">
      <code>
  cp varchar(5);
  ville varchar(32); 
BEGIN
  SELECT numero FROM base_codepostal WHERE id=NEW.codepostal_id INTO cp;
  SELECT nom FROM base_commune WHERE id=NEW.commune_id INTO ville;
  NEW.nom = cp||' '||ville;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_partenaire_attribut" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT nom FROM base_partenaire_attribut_type WHERE id=NEW.type_id INTO NEW.type_nom;
  SELECT nom FROM base_partenaire_attribut_categorie WHERE id=NEW.categorie_id INTO NEW.categorie_nom;
  RETURN NEW;
END;
      </code>
    </function>




    <function name="fc_get_nb_jours_dans_mois" schema="base">
      <parameters>
        <parameter name="a_date" type="date"/>
      </parameters>
      <return type="integer"/>
      <code>
  p_mois_nb_jours CONSTANT integer[12] = '{31,28,31,30,31,30,31,31,30,31,30,31}';
  p_annee integer;
  p_mois  integer;
  p_jours integer;
BEGIN
  p_annee:=EXTRACT(YEAR FROM a_date)::integer;
  p_mois:=EXTRACT(MONTH FROM a_date)::integer;
  p_jours:=p_mois_nb_jours[p_mois];
  IF (p_mois=2) AND (p_annee%4=0) AND ((p_annee%100!=0) OR (p_annee%400=0)) THEN
    p_jours := p_jours+1;
  END IF;    
  RETURN p_jours;
END;
      </code>
    </function>




    <function name="fc_get_delai_date" schema="societe">
      <parameters>
        <parameter name="a_delai_id" type="id"/>
        <parameter name="a_date" type="date"/>
      </parameters>
      <return type="date"/>
      <code>
  p_interval integer;
  p_delai base_delai%ROWTYPE;
  p_ret date;
BEGIN
  SELECT * FROM base_delai WHERE id=a_delai_id INTO p_delai;
  p_ret := a_date+(p_delai.nb_mois||' months')::interval;
  p_ret := a_date+p_delai.nb_jours;
  IF p_delai.fin_de_mois THEN
    SELECT fc_get_nb_jours_dans_mois(p_ret) INTO p_interval;
    p_ret := p_interval::text||'/'||EXTRACT(MONTH FROM p_ret)||'/'||EXTRACT(YEAR FROM p_ret)::text;
    IF p_delai.prolongation THEN
      SELECT fc_get_nb_jours_dans_mois(p_ret+1) INTO p_interval;
      p_ret := p_ret + CASE WHEN p_delai.jour_du_mois>p_interval THEN p_interval ELSE p_delai.jour_du_mois END;
    END IF;
  END IF;
  RETURN p_ret;
END;
      </code>
    </function>



    <function name="tg_complete_impression_modele" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  IF TG_OP='INSERT' THEN 
    UPDATE base_impression_modele SET datetime_fin='now' WHERE datetime_fin='infinity' AND impression_id=NEW.impression_id;
    NEW.datetime_debut := 'now';
    NEW.datetime_fin   := 'infinity';
  ELSIF TG_OP='UPDATE' THEN
    IF NEW.impression_id!=OLD.impression_id THEN
      NEW.impression_id:=OLD.impression_id;
    END IF;
    IF NEW.modele!=OLD.modele THEN
      INSERT INTO base_impression_modele (impression_id,modele) SELECT NEW.impression_id, NEW.modele;
      NEW.modele := OLD.modele;
    END IF;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_manage_impression" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  IF TG_OP='INSERT' THEN 
    INSERT INTO base_impression_modele (impression_id,modele) SELECT NEW.id, NEW.modele;
  ELSIF TG_OP='UPDATE' THEN
    IF NEW.modele!=OLD.modele THEN
      INSERT INTO base_impression_modele (impression_id,modele) SELECT NEW.id, NEW.modele;
    END IF;
  END IF;
  RETURN NULL;
END;
      </code>
    </function>




    <function name="tg_complete_impression_type" type="trigger" schema="societe">
      <code>
BEGIN
  IF OLD.immuable THEN
    RAISE EXCEPTION 'This type mustn''t be removed.';
  END IF;
END;
      </code>
    </function>



    <function name="fc_get_impression_modele_id" schema="societe">
      <parameters>
        <parameter name="a_impression_id" type="id"/>
        <parameter name="a_modele_id" type="id"/>
      </parameters>
      <return type="id"/>
      <code>
  ret base_impression_modele.id%TYPE;
  p_modele_id base_impression_modele.id%TYPE;
  total integer;
BEGIN
  IF a_impression_id IS NULL THEN
    RAISE EXCEPTION 'La vérification du modèle de l''impression n''est pas possible car l''impression à vérifier est inconnue.';
  END IF;
  p_modele_id := a_modele_id;
  IF p_modele_id IS NOT NULL THEN
    SELECT count(*) FROM base_impression_modele WHERE id=p_modele_id AND impression_id=a_impression_id INTO total;
    IF 0>=total THEN
      p_modele_id := NULL;
    ELSE
      ret := p_modele_id;
    END IF;
  END IF;
  IF p_modele_id IS NULL THEN     
    SELECT count(*) FROM base_impression_modele WHERE impression_id=a_impression_id AND datetime_fin='infinity' INTO total;
    IF 0>=total THEN
      RAISE EXCEPTION 'Il n''y a pas de modèle d''impressions en service pour ce type de document.';
    ELSIF total>1 THEN
      RAISE EXCEPTION 'Erreur du système : Plusieurs modèles sont en service pour l''impression %',a_impression_id;
    END IF;
    SELECT id FROM base_impression_modele WHERE impression_id=a_impression_id AND datetime_fin='infinity' INTO ret;
  END IF;
  RETURN ret;
END;
      </code>
    </function>




    <function name="fc_get_impression_id" schema="societe">
      <parameters>
        <parameter name="a_impression_id" type="id"/>
        <parameter name="a_type_id" type="id"/>
      </parameters>
      <return type="id"/>
      <code>
  p_impression_id base_impression.id%TYPE;
  ret base_impression.id%TYPE;
  total integer;
BEGIN
  IF a_type_id IS NULL THEN
    RAISE EXCEPTION 'La vérification de l''impression n''est pas possible car le type d''impression est inconnu.';
  END IF;
  p_impression_id := a_impression_id;
  IF p_impression_id IS NOT NULL THEN
    SELECT count(*) FROM base_impression WHERE id=p_impression_id AND type_id=a_type_id AND actif INTO total;
    IF 0>=total THEN
      p_impression_id := NULL;
    ELSE
      ret := p_impression_id;
    END IF;
  END IF;
  IF p_impression_id IS NULL THEN     
    SELECT count(*) FROM base_impression WHERE type_id=a_type_id AND actif INTO total;
    IF 0>=total THEN
      RAISE EXCEPTION 'Il n''y a pas d''impressions en service pour ce type de document.';
    END IF;
    SELECT id FROM base_impression WHERE type_id=a_type_id AND actif ORDER BY defaut DESC INTO ret;
  END IF;
  RETURN ret;
END;
      </code>
    </function>



    <function name="print" schema="systeme">
      <parameters>
        <parameter name="print_code" type="phrase"/>
        <parameter name="print_id" type="id"/>
      </parameters>
      <return type="text"/>
      <code>
  ret text;
  query text;
  total integer;
BEGIN
  ret:='';
  SELECT count(*) FROM base_impression WHERE code=print_code INTO total;
  IF total=1 THEN
    query:='SELECT prPDF_'||print_code||'('||print_id||')';
    EXECUTE query INTO ret;
  END IF;
  RETURN ret;
END;
      </code>
    </function>



    <function name="tg_build_printer" type="trigger" schema="societe">
      <code>
  total integer;
  pfb_modele text;
  print_code text;
  query text;
BEGIN
  SELECT count(*) FROM information_schema.routines WHERE routine_schema=pfb_schema AND routine_name='prPDF_'||NEW.code INTO total;
  IF (total>=1) THEN
    query:='DROP FUNCTION '||pfb_schema||'.prPDF_'||print_code||'(integer);';
  END IF;
  IF (TG_OP!='DELETE') THEN
    SELECT fc_build_printer(pfb_schema,NEW.modele,'prPDF_'||NEW.code,'/tmp');
  END IF;
  RETURN NULL;
END;
      </code>
    </function>

    <function _load="print_builder.opf"/>



  </functions>



  <triggers>

    <trigger name="tg_complete_societe" schema="base" function="tg_complete_societe">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="base" on-table="base_societe"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="base" on-table="base_societe"/>
    </trigger>

    <trigger name="tg_complete_societe_etablissement" schema="societe" function="tg_complete_societe_etablissement">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="base" on-table="base_societe_etablissement"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="base" on-table="base_societe_etablissement"/>
    </trigger>

    <trigger name="tg_build_printer" schema="societe" function="tg_build_printer">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="base_impression"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="base_impression"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="base_impression"/>
      <trigger-param name="pfb_schema" value="current-schema"/>
    </trigger>

    <trigger name="tg_manage_rights" schema="societe" function="tg_manage_rights">
      <trigger-event moment="after" event="insert" for-each="statement" on-schema="societe" on-table="base_droits_module"/>
      <trigger-event moment="after" event="update" for-each="statement" on-schema="societe" on-table="base_droits_module"/>
      <trigger-event moment="after" event="delete" for-each="statement" on-schema="societe" on-table="base_droits_module"/>
      <trigger-event moment="after" event="insert" for-each="statement" on-schema="societe" on-table="base_droits_profil_module"/>
      <trigger-event moment="after" event="update" for-each="statement" on-schema="societe" on-table="base_droits_profil_module"/>
      <trigger-event moment="after" event="delete" for-each="statement" on-schema="societe" on-table="base_droits_profil_module"/>
      <trigger-event moment="after" event="insert" for-each="statement" on-schema="societe" on-table="base_societe_employe"/>
      <trigger-event moment="after" event="update" for-each="statement" on-schema="societe" on-table="base_societe_employe"/>
      <trigger-event moment="after" event="delete" for-each="statement" on-schema="societe" on-table="base_societe_employe"/>
    </trigger>

    <trigger name="tg_complete_societe_employe" schema="societe" function="tg_complete_societe_employe">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_societe_employe"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_societe_employe"/>
    </trigger>

    <trigger name="tg_complete_partenaire" schema="societe" function="tg_complete_partenaire">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_partenaire"/>
    </trigger>

    <trigger name="tg_complete_partenaire_type" schema="societe" function="tg_complete_partenaire_type">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire_type"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_partenaire_type"/>
    </trigger>

    <trigger name="tg_complete_contact" schema="societe" function="tg_complete_contact">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire_contact"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_partenaire_contact"/>
    </trigger>

    <trigger name="tg_manage_contact" schema="societe" function="tg_manage_contact">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire_contact"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="base_partenaire_contact"/>
    </trigger>

    <trigger name="tg_complete_contact_version" schema="societe" function="tg_complete_contact_version">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire_contact_version"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_partenaire_contact_version"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="base_partenaire_contact_version"/>
    </trigger>

    <trigger name="tg_complete_contact_type" schema="societe" function="tg_complete_contact_type">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire_contact_type"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_partenaire_contact_type"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="base_partenaire_contact_type"/>
    </trigger>

    <trigger name="tg_complete_codepostal_commune_rel" schema="base" function="tg_complete_codepostal_commune_rel">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="base" on-table="base_codepostal_commune_rel"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="base" on-table="base_codepostal_commune_rel"/>
    </trigger>
 
    <trigger name="tg_complete_partenaire_attribut" schema="societe" function="tg_complete_partenaire_attribut">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_partenaire_attribut"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_partenaire_attribut"/>
    </trigger>

    <trigger name="tg_complete_impression_modele" schema="societe" function="tg_complete_impression_modele">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="base_impression_modele"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_impression_modele"/>
    </trigger>

    <trigger name="tg_manage_impression" schema="societe" function="tg_manage_impression">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="base_impression"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="base_impression"/>
    </trigger>

    <trigger name="tg_complete_impression_type" schema="societe" function="tg_complete_impression_type">
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="base_impression_type"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="societe" on-table="base_impression_type"/>
    </trigger>




  </triggers>


</analysis>
