<?xml version="1.0" encoding="UTF-8"?>

<analysis name="Comptabilite" version="0.0.0" 
  xmlns:typens="urn:Compta"
  xmlns="http://www.pygmalion.org/analysis/">

  <datatypes>
    <datatype name="account"  type="varchar" size="16"/>
    <datatype name="month"    type="integer" size="4"/>
    <datatype name="year"     type="integer" size="4"/>
    <datatype name="quantity" type="numeric" precision="12" scale="2"/>
    <datatype name="sequence" type="varchar" size="16"/>
  </datatypes>

  <classes>

    <class name="compta_ecriture" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1002" name="libelle"       type="phrase"  notnull="true" meaning="major"/>
      <property uid="1003" name="numero"        type="integer" notnull="true" mode="auto"/>
      <property uid="1004" name="debit"         type="money"   notnull="true" default="0" mode="auto" meaning="significant"/>
      <property uid="1005" name="credit"        type="money"   notnull="true" default="0" mode="auto" meaning="significant"/>
      <property uid="1006" name="solde"         type="money"   notnull="true" default="0" mode="auto"/>
      <property uid="1007" name="devise_id"     type="id"      notnull="true" nevernull="true"/>
      <property uid="1008" name="devise_taux"   type="rate"    notnull="true" default="1" mode="auto"/>
      <property uid="1009" name="debit_d"       type="money"   notnull="true" default="0"/>
      <property uid="1010" name="credit_d"      type="money"   notnull="true" default="0"/>
      <property uid="1011" name="solde_d"       type="money"   notnull="true" default="0" mode="auto"/>
      <property uid="1016" name="cumul_id"      type="id"      notnull="true" mode="auto"/>
      <property uid="1012" name="simulation"    type="boolean"/>
      <property uid="1012" name="lettrage"      type="code"/>
      <property uid="1013" name="compte_id"     type="id"      notnull="true" mode="auto"/>
      <property uid="1013" name="compte_numero" type="account" notnull="true" mode="auto" meaning="significant"/>
      <property uid="1014" name="compteperm_id" type="id"      notnull="true"/>
      <property uid="1015" name="piece_id"      type="id"      notnull="true"/>
      <property uid="1015" name="piece_date"    type="date"    notnull="true" mode="auto"/>
      <property uid="1015" name="journal_id"    type="id"      notnull="true" mode="auto"/>
      <property uid="1015" name="journal_code"  type="code"    notnull="true" mode="auto"/>
      <property uid="1016" name="pointage_id"   type="id"/>
      <constraint type="foreign-key" references="compta_compte(id)"       column="compte_id"     ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_compteperm(id)"   column="compteperm_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_piece(id)"        column="piece_id"      ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_pointage(id)"     column="pointage_id"   ondelete="set null" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_journal(id)"      column="journal_id"    ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_compte_cumul(id)" column="cumul_id"      ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="compta_piece" schema="societe" primary-key="id">
      <property uid="1001" name="id"              type="serial"   notnull="true"/>
      <property uid="1002" name="date"            type="date"     notnull="true" meaning="significant"/>
      <property uid="1003" name="echeance"        type="date"     notnull="true"/>
      <property uid="1004" name="libelle"         type="phrase"   notnull="true" meaning="major"/>
      <property uid="1005" name="debit"           type="money"    notnull="true" default="0" mode="auto" meaning="significant"/>
      <property uid="1006" name="credit"          type="money"    notnull="true" default="0" mode="auto" meaning="significant"/>
      <property uid="1005" name="solde"           type="money"    notnull="true" default="0" mode="auto"/>
      <property uid="1007" name="numero"          type="integer"  notnull="true"/>
      <property uid="1008" name="exercice_code"   type="code"     notnull="true" mode="auto"/>
      <property uid="1008" name="exercice_id"     type="integer"  notnull="true"/>
      <property uid="1009" name="journal_type_id" type="integer"  notnull="true"/>
      <property uid="1009" name="journal_id"      type="integer"  notnull="true" mode="auto"/>
      <constraint type="foreign-key" references="compta_exercice(id)" column="exercice_id" match="simple" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_exercice(code)" column="exercice_code" match="simple" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_journal(id)"  column="journal_id"  match="simple" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_journal_type(id)" column="journal_type_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="compta_exercice" schema="societe" primary-key="id">
      <property uid="1001" name="id"           type="serial"   notnull="true"/>
      <property uid="1008" name="code"         type="code"     notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="date_debut"   type="date"     notnull="true" meaning="significant"/>
      <property uid="1003" name="date_fin"     type="date"     notnull="true" meaning="significant"/>
      <property uid="1004" name="cloture"      type="boolean"  notnull="true" default="false"/>
      <property uid="1005" name="actif"        type="boolean"  notnull="true" default="false"/>
      <property uid="1006" name="debit"        type="money"    notnull="true" default="0" mode="auto"/>
      <property uid="1007" name="credit"       type="money"    notnull="true" default="0" mode="auto"/>
      <property uid="1007" name="solde"        type="money"    notnull="true" default="0" mode="auto"/>
      <property uid="1010" name="nb_ecritures" type="integer"  notnull="true" default="0" mode="auto"/>
      <property uid="1007" name="note"         type="text"/>
      <record type="partial">
        <field property="code">EX200607</field>
        <field property="date_debut">01/09/2006</field>
        <field property="date_fin">31/08/2007</field>
      </record>
    </class>


    <class name="compta_journal" schema="societe" primary-key="id">
      <property uid="1001" name="id"                  type="serial"    notnull="true"/>
      <property uid="1002" name="type_id"             type="id"        notnull="true"/>
      <property uid="1002" name="debit_compteperm_id" type="id"        mode="auto-insert"/>
      <property uid="1003" name="mois"                type="integer"   notnull="true" meaning="significant"/>
      <property uid="1004" name="annee"               type="integer"   notnull="true" meaning="significant"/>
      <property uid="1005" name="code"                type="code"      notnull="true" unique="true" mode="auto-insert"/>
      <property uid="1006" name="nom"                 type="name"      notnull="true" mode="auto-insert" meaning="major"/>
      <property uid="1007" name="provisoire"          type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1009" name="contrepartie"        type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1011" name="debit"               type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1012" name="credit"              type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1012" name="solde"               type="money"     notnull="true" default="0" mode="auto"/>
      <constraint type="unique" column="type_id,annee,mois"/>
      <constraint type="foreign-key" column="type_id" references="compta_journal_type(id)" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" column="debit_compteperm_id" references="compta_compteperm(id)" ondelete="cascade" onupdate="cascade"/>
    </class>


    <class name="compta_journal_type" schema="societe" primary-key="id">
      <property uid="1001" name="id"                  type="serial"       notnull="true"/>
      <property uid="1002" name="code"                type="code"         notnull="true" unique="true"/>
      <property uid="1003" name="abrev"               type="abbreviation" notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"                 type="name"         notnull="true" meaning="significant"/>
      <property uid="1007" name="provisoire"          type="boolean"      notnull="true" default="false"/>
      <property uid="1009" name="contrepartie"        type="boolean"      notnull="true" default="false"/>
      <property uid="1002" name="debit_compteperm_id" type="id"/>
      <property uid="1018" name="note"                type="text"/>
      <constraint type="foreign-key" column="debit_compteperm_id" references="compta_compteperm(id)" ondelete="cascade" onupdate="cascade"/>
      <record>
        <field>1</field>
        <field>PURCHASES</field>
        <field>AC</field>
        <field>Journal des achats</field>
        <field>false</field>
        <field>false</field>
        <field null="true"/>
        <field null="true"/>
      </record>
      <record>
        <field>2</field>
        <field>SALES</field>
        <field>VT</field>
        <field>Journal des ventes</field>
        <field>false</field>
        <field>false</field>
        <field null="true"/>
        <field null="true"/>
      </record>
    </class>


    <class name="compta_pointage" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1005" name="banque_compte_id" type="id"      notnull="true"/>
      <property uid="1002" name="code"             type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="date"             type="integer" notnull="true" meaning="significant"/>
      <property uid="1004" name="debit"            type="money"   notnull="true" default="0" mode="auto" meaning="significant"/>
      <property uid="1005" name="credit"           type="money"   notnull="true" default="0" mode="auto" meaning="significant"/>
      <property uid="1005" name="solde"            type="money"   notnull="true" default="0" mode="auto"/>
      <property uid="1010" name="nb_ecritures"     type="integer" notnull="true" default="0" mode="auto"/>
      <constraint type="foreign-key" references="compta_banque_compte(id)" column="banque_compte_id" ondelete="set null" onupdate="cascade"/>
    </class>


    <class name="compta_compteperm_partenaire_rel" schema="societe" primary-key="id" type="link">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1005" name="partenaire_id" type="id"      notnull="true" meaning="major"/>
      <property uid="1005" name="compteperm_id" type="id"      notnull="true" meaning="major"/>
      <constraint type="unique" column="partenaire_id,compteperm_id"/>
      <constraint type="foreign-key" column="partenaire_id" references="base_partenaire(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="compteperm_id" references="compta_compteperm(id)" ondelete="restrict" onupdate="cascade"/>
    </class>
    

    <class name="compta_banque_compte" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1002" name="numero"        type="word"    notnull="true" meaning="significant"/>
      <property uid="1002" name="nom"           type="name"    notnull="true" unique="true" meaning="major"/>
      <property uid="1005" name="banque_id"     type="id"      notnull="true"/>
      <property uid="1005" name="compteperm_id" type="id"      notnull="true"/>
      <property uid="1018" name="note"          type="text"/>
      <constraint type="unique" column="numero,banque_id"/>
      <constraint type="foreign-key" references="compta_banque(id)" column="banque_id" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_compteperm(id)" column="compteperm_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="compta_banque" schema="societe" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1002" name="code"          type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1002" name="nom"           type="name"    notnull="true" meaning="significant"/>
      <property uid="1005" name="partenaire_id" type="id"      notnull="true" unique="true"/>
      <property uid="1018" name="note"          type="text"/>
      <constraint type="foreign-key" references="base_partenaire(id)" column="partenaire_id" ondelete="restrict" onupdate="cascade"/>
    </class>


    <class name="compta_compteperm" schema="societe" primary-key="id">
      <property uid="1001" name="id"                       type="serial"    notnull="true"/>
      <property uid="1002" name="nom"                      type="phrase"    notnull="true" meaning="significant"/>
      <property uid="1003" name="numero"                   type="account"   notnull="true" unique="true" meaning="major"/>
      <property uid="1004" name="acces_id"                 type="id"        notnull="true"/>
      <property uid="1012" name="parent_compteperm_id"     type="id" index="default"/>
      <property uid="1007" name="immuable"                 type="boolean" notnull="true" default="true"/>
      <property uid="1006" name="signe"                    type="boolean" notnull="true" default="false"/>
      <property uid="1013" name="general"                  type="boolean" notnull="true" default="false"/>
      <property uid="1014" name="accept_aux"               type="boolean" notnull="true" default="false"/>
      <property uid="1015" name="utilisable"               type="boolean" notnull="true" default="false"/>
      <property uid="1016" name="lettrable"                type="boolean" notnull="true" default="false"/>
      <property uid="1017" name="pointable"                type="boolean" notnull="true" default="false"/>
      <property uid="1018" name="groupable"                type="boolean" notnull="true" default="false"/>
      <property uid="1006" name="echeance"                 type="integer" default="-1"/>
      <property uid="1007" name="note"                     type="text"/>
      <constraint type="foreign-key" references="base_acces(id)"  column="acces_id" match="simple" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_compteperm(id)" column="parent_compteperm_id" match="simple" ondelete="cascade" onupdate="cascade"/>
      <_load file="plan_comptable.opr"/>
    </class>



    <class name="compta_compte" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"    notnull="true"/>
      <property uid="1001" name="compteperm_id"    type="id"        notnull="true" unique="true" meaning="significant"/>
      <property uid="1002" name="nom"              type="phrase"    notnull="true" mode="auto-insert" meaning="major"/>
      <property uid="1003" name="numero"           type="account"   notnull="true" unique="true" mode="auto"/>
      <property uid="1004" name="acces_id"         type="id"        notnull="true" mode="auto"/>
      <property uid="1012" name="parent_compte_id" type="id" mode="auto"/>
      <property uid="1005" name="exercice_id"      type="id"        notnull="true"/>
      <property uid="1008" name="debit"            type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1009" name="credit"           type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1009" name="solde"            type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1010" name="nb_ecritures"     type="integer"   notnull="true" default="0" mode="auto"/>
      <property uid="1011" name="derniere_lettre"  type="code" index="default"/>
      <property uid="1007" name="immuable"         type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1006" name="signe"            type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1013" name="general"          type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1014" name="accept_aux"       type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1015" name="utilisable"       type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1016" name="lettrable"        type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1017" name="pointable"        type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1018" name="groupable"        type="boolean"   notnull="true" default="false" mode="auto-insert"/>
      <property uid="1006" name="echeance"         type="integer" default="-1"/>
      <property uid="1007" name="note"             type="text"/>
      <constraint type="foreign-key" references="compta_compteperm(id)"  column="compteperm_id" match="simple" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_compte(id)"  column="parent_compte_id" match="simple" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="base_acces(id)"  column="acces_id" match="simple" ondelete="cascade" onupdate="cascade"/>
      <constraint type="foreign-key" references="compta_exercice(id)"  column="exercice_id" match="simple" ondelete="cascade" onupdate="cascade"/>
    </class>


    <class name="compta_compte_cumul" schema="societe" primary-key="id">
      <property uid="1001" name="id"               type="serial"    notnull="true"/>
      <property uid="1001" name="compteperm_id"    type="id"        notnull="true"/>
      <property uid="1003" name="numero"           type="account"   notnull="true" mode="auto" meaning="significant"/>
      <property uid="1002" name="nom"              type="phrase"    notnull="true" mode="auto" meaning="major"/>
      <property uid="1008" name="mois"             type="month"     notnull="true"/>
      <property uid="1008" name="annee"            type="year"      notnull="true"/>
      <property uid="1008" name="debit"            type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1009" name="credit"           type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1009" name="solde"            type="money"     notnull="true" default="0" mode="auto"/>
      <property uid="1010" name="nb_ecritures"     type="integer"   notnull="true" default="0" mode="auto"/>
      <constraint name="est le compte"  type="foreign-key" references="compta_compteperm(id)"  column="compteperm_id" match="simple" ondelete="cascade" onupdate="cascade"/>
    </class>

  </classes>

  <functions>


    <function name="tg_complete_compta_ecriture" type="trigger" schema="societe">
      <code>
  total integer;
BEGIN
  IF (NEW.debit_d>0 AND NEW.credit_d>0) THEN
    RAISE EXCEPTION 'Le débit ou le crédit doit être à 0.';
  END IF;
  IF (NEW.compteperm IS NULL) THEN
    RAISE EXCEPTION 'Le compte (permanent) de l''écriture doit être renseigné.';
  END IF;
  IF NEW.devis_id IS NULL THEN
    SELECT count(*) FROM base_devise WHERE defaut INTO total;
    IF total!=1 THEN
      RAISE EXCEPTION 'Une seule et unique devise doit être définie par défaut.';
    END IF;
    SELECT id FROM base_devise WHERE defaut INTO NEW.devise_id;
  END IF;
  SELECT taux FROM base_devise WHERE id=NEW.devise_id INTO NEW.devise_taux;
  SELECT NEW.debit_d-NEW.credit_d INTO NEW.solde_d;
  SELECT NEW.debit_d*NEW.devise_taux INTO NEW.debit;
  SELECT NEW.credit_d*NEW.devise_taux INTO NEW.credit;
  SELECT NEW.debit-NEW.credit INTO NEW.solde;
  SELECT numero, compteperm_id, fc_get_compte(compteperm_id) FROM compta_compteperm WHERE id=NEW.compteperm_id INTO NEW.compte_numero, NEW.compteperm_id, NEW.compte_id;
  SELECT date, journal_id FROM compta_piece WHERE id=NEW.piece_id INTO NEW.piece_date, NEW.journal_id;
  SELECT code FROM compta_journal WHERE id=NEW.journal_id INTO NEW.journal_code;
  IF TG_OP='INSERT' THEN
    SELECT count(*) FROM compta_compte_cumul WHERE mois=EXTRACT(MONTH FROM NEW.piece_date)::integer AND annee=EXTRACT(YEAR FROM NEW.piece_date)::integer AND compteperm_id=NEW.compteperm_id INTO total;
    IF 0>=total THEN
      INSERT INTO compta_compte_cumul(compteperm_id,mois,annee) SELECT NEW.compteperm_id, EXTRACT(MONTH FROM NEW.piece_date)::integer, EXTRACT(YEAR FROM NEW.piece_date)::integer;
    ELSIF total>1 THEN
      RAISE EXCEPTION 'Un seul cumul par mois et par compte peut être créé.';
    END IF;
    SELECT id FROM compta_compte_cumul WHERE mois=EXTRACT(MONTH FROM NEW.piece_date)::integer AND annee=EXTRACT(YEAR FROM NEW.piece_date)::integer AND compteperm_id=NEW.compteperm_id INTO NEW.cumul_id;
  END IF;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_manage_compta_ecriture" type="trigger" schema="societe">
      <code>
BEGIN
  UPDATE compta_piece SET debit=sum(ecr.debit), credit=sum(ecr.credit) FROM compta_ecriture as ecr WHERE compta_piece.id=piece_id;
  UPDATE compta_pointage SET debit=sum(ecr.debit), credit=sum(ecr.credit), nb_ecritures=count(ecr.id) FROM compta_ecriture as ecr WHERE compta_pointage.id=pointage_id;
  UPDATE compta_compte SET debit=sum(ecr.debit), credit=sum(ecr.credit), nb_ecritures=count(ecr.id) FROM compta_ecriture as ecr WHERE compta_compte.id=compte_id;
  UPDATE compta_compte_cumul SET debit=sum(ecr.debit), credit=sum(ecr.credit), nb_ecritures=count(ecr.id) FROM compta_ecriture as ecr WHERE compta_compte_cumul.id=cumul_id;
  RETURN NULL;
END;
      </code>
    </function>


    <function name="tg_complete_compta_piece" type="trigger" schema="societe">
      <code>
  total integer;
  ok boolean;
BEGIN
  IF TG_OP='INSERT' THEN
    NEW.debit:=0;
    NEW.credit:=0;
    SELECT count(*) FROM compta_exercice WHERE actif AND NOT cloture INTO total; 
    IF total!=1 THEN
      RAISE EXCEPTION 'Il n''y a pas un seul et unique exercice actif.';
    END IF;
    IF NEW.exercice_id IS NULL THEN
      SELECT id FROM compta_exercice WHERE actif AND NOT cloture INTO NEW.exercice_id;
    ELSE
      SELECT cloture FROM compta_exercice WHERE id=NEW.exercice_id INTO ok; 
      IF ok THEN
        RAISE EXCEPTION 'L''exercice comptable choisi est déjà clotûré. Vous ne pouvez pas rajouter des pièces.'; 
      END IF;
    END IF;
  END IF;
  IF (NEW.date IS NULL) THEN
    RAISE EXCEPTION 'La pièce doit être datée.';
  END IF;
  SELECT code FROM compta_exercice WHERE id=NEW.exercice_id INTO NEW.exercice_code;
  SELECT NEW.debit-NEW.credit INTO NEW.solde;
  SELECT count(*) FROM compta_journal WHERE mois=EXTRACT(MONTH FROM NEW.date)::integer AND annee=EXTRACT(YEAR FROM NEW.date)::integer AND type_id=NEW.journal_type_id INTO total;
  IF 0>=total THEN
    INSERT INTO compta_journal(type_id,mois,annee) SELECT NEW.journal_type_id, EXTRACT(MONTH FROM NEW.date)::integer, EXTRACT(YEAR FROM NEW.date)::integer;
  ELSIF total>1 THEN
    RAISE EXCEPTION 'Un seul journal par mois et par type doit être ouvert.';
  END IF;
  SELECT id FROM compta_journal WHERE mois=EXTRACT(MONTH FROM NEW.date)::integer AND annee=EXTRACT(YEAR FROM NEW.date)::integer AND type_id=NEW.journal_type_id INTO NEW.journal_id;
  SELECT COALESCE(MAX(numero),0)+1 FROM compta_piece WHERE journal_id=NEW.journal_id INTO NEW.numero;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_manage_compta_piece" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='INSERT' THEN
    UPDATE compta_journal  SET debit=debit+NEW.debit, credit=credit+NEW.credit WHERE id=NEW.journal_id;
    UPDATE compta_exercice SET debit=debit+NEW.debit, credit=credit+NEW.credit, nb_ecritures=nb_ecritures+1 WHERE id=NEW.exercice_id;
  ELSIF TG_OP='UPDATE' THEN
    UPDATE compta_journal  SET debit=debit+NEW.debit-OLD.debit, credit=credit+NEW.credit-OLD.credit WHERE id=NEW.journal_id;
    UPDATE compta_exercice SET debit=debit+NEW.debit-OLD.debit, credit=credit+NEW.credit-OLD.credit WHERE id=NEW.exercice_id;
  ELSIF TG_OP='DELETE' THEN
    UPDATE compta_journal  SET debit=debit-OLD.debit, credit=credit-OLD.credit WHERE id=NEW.journal_id;
    UPDATE compta_exercice SET debit=debit-OLD.debit, credit=credit-OLD.credit, nb_ecritures=nb_ecritures-1 WHERE id=NEW.exercice_id;
  END IF;
  RETURN NULL;
END;
      </code>
    </function>




    <function name="tg_complete_compta_standard" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='INSERT' THEN
    NEW.debit  := 0;
    NEW.credit := 0;
    NEW.nb_ecritures := 0;
  END IF;
  NEW.solde := NEW.debit-NEW.credit;
  RETURN NEW;
END;
      </code>
    </function>



    <function name="tg_complete_compta_journal" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='INSERT' THEN
    NEW.debit  := 0;
    NEW.credit := 0;
    SELECT debit_compteperm_id, provisoire, contrepartie, code||NEW.annee||to_char(NEW.mois,'FM09'), nom||' ('||to_char(NEW.mois,'FM09')||'/'||NEW.annee||')' FROM compta_journal_type WHERE id=NEW.type_id INTO NEW.debit_compteperm_id, NEW.provisoire, NEW.contrepartie, NEW.code, NEW.nom;
  END IF;
  NEW.solde := NEW.debit-NEW.credit;
  RETURN NEW;
END;
      </code>
    </function>


<!--
    <function name="tg_complete_compta_compteperm" type="trigger" schema="societe">
      <code>
BEGIN
  SELECT numero FROM compta_compteperm WHERE id=NEW.parent_compteperm_id INTO NEW.parent_compteperm_numero;
  RETURN NEW;
END;
      </code>
    </function>
-->


    <function name="fc_get_compte" schema="base">
      <parameters>
        <parameter name="a_compteperm_id" type="id"/>
      </parameters>
      <return type="integer"/>
      <code>
  total integer;
  p_ret integer;
BEGIN
  SELECT count(*) FROM compta_compte WHERE compteperm_id=a_compteperm_id INTO total;
  IF 0>=total THEN
    INSERT INTO compta_compte(compteperm_id) VALUES (a_compteperm_id);
  ELSIF total>1 THEN
    RAISE EXCEPTION 'Impossible mais plusieurs comptes auraient pour parent le même compte permanent.';
  END IF;
  SELECT compteperm_id FROM compta_compte WHERE compteperm_id=a_compteperm_id INTO p_ret;
  RETURN p_ret;
END;
      </code>
    </function>





    <function name="tg_complete_compta_compte" type="trigger" schema="societe">
      <code>
  parent_numero text;
  total integer;
BEGIN
  IF TG_OP='INSERT' THEN
    NEW.debit  := 0;
    NEW.credit := 0;
    NEW.nb_ecritures    := 0;
    NEW.derniere_lettre := '';
    SELECT parent.numero FROM compta_compteperm AS fils LEFT JOIN compta_compteperm AS parent ON (parent.id=fils.parent_compteperm_id) WHERE fils.id=NEW.compteperm_id INTO parent_numero;
    IF LENGTH(COALESCE(parent_numero,''))!=0 THEN
      SELECT count(*) FROM compta_compte WHERE numero=parent_numero INTO total;
      IF 0>=total THEN
        INSERT INTO compta_compte(compteperm_id, exercice_id) SELECT parent_compteperm_id, NEW.exercice_id FROM compta_compteperm WHERE id=NEW.compteperm_id;
      END IF;
    END IF;
    SELECT nom,numero,acces_id,immuable,signe,general,accept_aux,utilisable,lettrable,pointable,groupable,echeance,note FROM compta_compteperm WHERE id=NEW.compteperm_id INTO NEW.nom,NEW.numero,NEW.acces_id,NEW.immuable,NEW.signe,NEW.general,NEW.accept_aux,NEW.utilisable,NEW.lettrable,NEW.pointable,NEW.groupable,NEW.echeance,NEW.note;
    SELECT id FROM compta_compte WHERE numero=parent_numero INTO NEW.parent_compte_id;
  END IF;
  IF TG_OP='UPDATE' THEN
    NEW.numero:=OLD.numero;
    IF OLD.immuable THEN
      NEW.immuable := TRUE;
      SELECT OLD.nom,OLD.numero,OLD.acces_id,OLD.immuable,OLD.signe,OLD.general,OLD.accept_aux,OLD.utilisable,OLD.lettrable,OLD.pointable,OLD.groupable,OLD.echeance INTO NEW.nom,NEW.numero,NEW.acces_id,NEW.immuable,NEW.signe,NEW.general,NEW.accept_aux,NEW.utilisable,NEW.lettrable,NEW.pointable,NEW.groupable,NEW.echeance;
    END IF;
  END IF;
  NEW.solde := NEW.debit-NEW.credit;
  RETURN NEW;
END;
      </code>
    </function>


    <function name="tg_complete_compte_cumul" type="trigger" schema="societe">
      <code>
BEGIN
  IF TG_OP='UPDATE' THEN
    NEW.compteperm_id := OLD.compteperm_id;
  END IF;
  SELECT numero, nom||' ('||NEW.mois||'/'||NEW.annee||')' FROM compta_compteperm WHERE id=NEW.compteperm_id INTO NEW.numero, NEW.nom;
  RETURN NEW;
END;
      </code>
    </function>



  </functions>

  <triggers>

    <trigger name="tg_complete_compta_ecriture" schema="societe" function="tg_complete_compta_ecriture">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_ecriture"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_ecriture"/>
    </trigger>

    <trigger name="tg_manage_compta_ecriture" schema="societe" function="tg_manage_compta_ecriture">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="compta_ecriture"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="compta_ecriture"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="compta_ecriture"/>
    </trigger>

    <trigger name="tg_complete_compta_piece" schema="societe" function="tg_complete_compta_piece">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_piece"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_piece"/>
    </trigger>

    <trigger name="tg_manage_compta_piece" schema="societe" function="tg_manage_compta_piece">
      <trigger-event moment="after" event="insert" for-each="row" on-schema="societe" on-table="compta_piece"/>
      <trigger-event moment="after" event="update" for-each="row" on-schema="societe" on-table="compta_piece"/>
      <trigger-event moment="after" event="delete" for-each="row" on-schema="societe" on-table="compta_piece"/>
    </trigger>

    <trigger name="tg_complete_compta_standard" schema="societe" function="tg_complete_compta_standard">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_exercice"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_exercice"/>
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_pointage"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_pointage"/>
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_compte_cumul"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_compte_cumul"/>
    </trigger>

    <trigger name="tg_complete_compta_journal" schema="societe" function="tg_complete_compta_journal">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_journal"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_journal"/>
    </trigger>
<!--
    <trigger name="tg_complete_compta_compteperm" schema="societe" function="tg_complete_compta_compteperm">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_compteperm"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_compteperm"/>
    </trigger>
-->
    <trigger name="tg_complete_compta_compte" schema="societe" function="tg_complete_compta_compte">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_compte"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_compte"/>
    </trigger>

    <trigger name="tg_complete_compte_cumul" schema="societe" function="tg_complete_compte_cumul">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="societe" on-table="compta_compte_cumul"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="societe" on-table="compta_compte_cumul"/>
    </trigger>

  </triggers>

</analysis>
