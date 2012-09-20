<?xml version="1.0" encoding="UTF-8"?>

<analysis name="Systeme" version="1">
 
  <infos>
    <info type="author">Brice TEXIER</info>
    <info type="version">0.0.1</info>
  </infos>

  <notes>
    <note date="25/10/2006" title="Mise en place du format OPF 0.2.0.0" author-id="BT"/>
  </notes>
 
  <datatypes>
    <datatype name="serial"    label="systeme.datatypes.serial.label_"    type="serial"  size="4"/>
    <datatype name="id"        label="systeme.datatypes.id.label_"        type="integer" size="4"/>
    <datatype name="char"      label="systeme.datatypes.char.label_"      type="varchar" size="1"/>
    <datatype name="word"      label="systeme.datatypes.word.label_"      type="varchar" size="32"/>
    <datatype name="schema"    label="systeme.datatypes.schema.label_"    type="varchar" size="32"/>
    <datatype name="phrase"    label="systeme.datatypes.phrase.label_"    type="varchar" size="128"/>
    <datatype name="paragraph" label="systeme.datatypes.paragraph.label_" type="varchar" size="512"/>
    <datatype name="text"      label="systeme.datatypes.text.label_"      type="varchar"/>
    <datatype name="boolean"   label="systeme.datatypes.boolean.label_"   type="boolean"/>
    <datatype name="integer"   label="systeme.datatypes.integer.label_"   type="integer" size="4"/>
    <datatype name="datetime"  label="systeme.datatypes.datetime.label_"  type="timestamp"/>
    <datatype name="date"                                                type="date"/>
  </datatypes>

  <schemas>
    <schema name="systeme" type="static" label="systeme" uuid="e80c1a94-224f-4e0d-9c39-c0c26fb9b014"/>
  </schemas>
  
  <classes>

    <!-- Schémas -->
    <class name="systeme_schema" schema="systeme" primary-key="id">
      <property uid="1001" name="id"       type="serial"  notnull="true" mode="auto"/>
      <property uid="1003" name="nom"      type="schema"  notnull="true" unique="true" meaning="major"/>
    </class>

    <!-- Groupes et utilisateurs -->
    <class name="systeme_utilisateur" schema="systeme" primary-key="id">
      <property uid="1001" name="id"           type="serial"  notnull="true"/>
      <property uid="1002" name="login"        type="word"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="password"     type="word"    notnull="true" default="**********"/>
      <property uid="1005" name="email"        type="phrase"/>
      <property uid="1006" name="can_login"    type="boolean" notnull="true" default="false"/>
      <property uid="1006" name="deja_present" type="boolean" notnull="true" default="false"/>
      <property uid="1006" name="superuser"    type="boolean" notnull="true" default="false"/>
      <property uid="1008" name="createrole"   type="boolean" notnull="true" default="false"/>
      <property uid="1009" name="maxconn"      type="integer" notnull="true" default="-1"/>
      <property uid="1010" name="jusqua"       type="date"/>
      <record type="partial">
        <field property="login">brice</field>
        <field property="deja_present">true</field>
      </record>
    </class>


    <!-- Extraction de données -->
    <class name="systeme_extraction" schema="systeme" primary-key="id">
      <property uid="1001" name="id"       type="serial"  notnull="true"/>
      <property uid="1003" name="code"     type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"      type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="requete"  type="text"    notnull="true"/>
    </class>

    <class name="systeme_extraction_parametre" schema="systeme" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1003" name="nom"           type="name"    notnull="true" meaning="major"/>
      <property uid="1003" name="extraction_id" type="id"      notnull="true" meaning="significant"/>
      <property uid="1003" name="type_id"       type="id"      notnull="true" meaning="significant"/>
      <constraint type="foreign-key" column="extraction_id" references="systeme_extraction(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="type_id" references="systeme_extraction_parametre_type(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="systeme_extraction_parametre_type" schema="systeme" primary-key="id">
      <property uid="1001" name="id"               type="serial"  notnull="true"/>
      <property uid="1003" name="code"             type="code"    notnull="true" unique="true" meaning="major"/>
      <property uid="1003" name="nom"              type="name"    notnull="true" meaning="significant"/>
      <property uid="1003" name="type_base"        type="integer" notnull="true"/>
      <property uid="1003" name="lien"             type="boolean" notnull="true" default="false"/>
      <property uid="1003" name="table_etrangere"  type="name"/>
      <property uid="1003" name="cle_etrangere"    type="name"/>
      <record type="partial">
        <field property="code">INTE</field>
        <field property="nom">Entier</field>
        <field property="type_base">1</field>
      </record>
      <record type="partial">
        <field property="code">REAL</field>
        <field property="nom">Réel</field>
        <field property="type_base">2</field>
      </record>
      <record type="partial">
        <field property="code">BOOL</field>
        <field property="nom">Booléen</field>
        <field property="type_base">3</field>
      </record>
      <record type="partial">
        <field property="code">TEXT</field>
        <field property="nom">Texte</field>
        <field property="type_base">4</field>
      </record>
    </class>

    <class name="systeme_extraction_execution" schema="systeme" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1003" name="nom"           type="name"    notnull="true" meaning="major"/>
      <property uid="1003" name="extraction_id" type="id"      notnull="true" meaning="significant"/>
      <constraint type="foreign-key" column="extraction_id" references="systeme_extraction(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

    <class name="systeme_extraction_execution_parametre" schema="systeme" primary-key="id">
      <property uid="1001" name="id"            type="serial"  notnull="true"/>
      <property uid="1003" name="valeur"        type="text"    notnull="true" meaning="major"/>
      <property uid="1003" name="parametre_id"  type="id"      notnull="true" meaning="significant"/>
      <property uid="1003" name="execution_id"  type="id"      notnull="true"/>
      <constraint type="foreign-key" column="execution_id" references="systeme_extraction_execution(id)" ondelete="restrict" onupdate="cascade"/>
      <constraint type="foreign-key" column="parametre_id" references="systeme_extraction_parametre(id)" ondelete="restrict" onupdate="cascade"/>
    </class>

  </classes>

  <functions>
    <function name="tg_manage_role" type="trigger" schema="systeme">
      <code>
  query text;
  mdp text;
BEGIN
  mdp:='**********';
  IF TG_OP='INSERT'  THEN
    NEW.login:=LOWER(REPLACE(NEW.login,' ',''));
    IF NOT NEW.deja_present THEN
      query:='CREATE ROLE '||NEW.login||' NOCREATEDB ';
      IF NOT NEW.createrole THEN
        query:=query||'NO';
      END IF;
      query:=query||'CREATEROLE ';
      IF NOT NEW.superuper THEN
        query:=query||'NO';
      END IF;
      query:=query||'SUPERUSER';
      query:=query||' LOGIN';
      query:=query||' ENCRYPTED PASSWORD '''||NEW.password||''';';
      EXECUTE query;
    END IF;
    NEW.password:=mdp;
    RETURN NEW;
  ELSIF TG_OP='UPDATE' THEN
    NEW.login:=LOWER(REPLACE(NEW.login,' ',''));
    IF NEW.login!=OLD.login THEN
      query:='ALTER ROLE '||OLD.login||' RENAME TO '||NEW.login||';';
      EXECUTE query;
    END IF;
    IF NEW.password!=OLD.password THEN
      query:='ALTER ROLE '||NEW.login||' ENCRYPTED PASSWORD '''||NEW.password||''';';
      EXECUTE query;
      New.EM_Password:=mdp;
    END IF;
    IF NEW.superuser!=OLD.superuser THEN
      query:='ALTER ROLE '||NEW.login;
      IF NOT NEW.superuser THEN
        query:=query||'NO';
      END IF;
      query:=query||'SUPERUSER';
      EXECUTE query;
    END IF;
    IF NEW.createrole!=OLD.createrole THEN
      query:='ALTER ROLE '||NEW.login;
      IF NOT NEW.createrole THEN
        query:=query||'NO';
      END IF;
      query:=query||'CREATEROLE';
      EXECUTE query;
    END IF;
    RETURN NEW;
  ELSIF TG_OP='DELETE' THEN
    query:='DROP ROLE '||OLD.login;
    EXECUTE query;
    RETURN OLD;
  END IF;
END;

      </code>
    </function>


    <function name="soundex2" schema="systeme">
      <parameters>
        <parameter name="a_mot" type="text"/>
      </parameters>
      <return type="soundex2"/>
      <code>
  mot text;
  car varchar(1);
  n integer;
BEGIN
  SELECT LOWER(TRIM(a_mot)) INTO mot;
  mot := REPLACE(mot,'â','a');
  mot := REPLACE(mot,'ä','a');
  mot := REPLACE(mot,'à','a');
  mot := REPLACE(mot,'ê','e');
  mot := REPLACE(mot,'ë','e');
  mot := REPLACE(mot,'œ','e');
  mot := REPLACE(mot,'é','e');
  mot := REPLACE(mot,'è','e');
  mot := REPLACE(mot,'î','i');
  mot := REPLACE(mot,'ï','i');
  mot := REPLACE(mot,'ì','i');
  mot := REPLACE(mot,'ô','o');
  mot := REPLACE(mot,'ö','o');
  mot := REPLACE(mot,'ò','o');
  mot := REPLACE(mot,'û','u');
  mot := REPLACE(mot,'ü','u');
  mot := REPLACE(mot,'ù','u');
  mot := REPLACE(mot,'ŷ','y');
  mot := REPLACE(mot,'ÿ','y');
  mot := REPLACE(mot,'ỳ','y');
  mot := REPLACE(mot,'ç','c');
  mot := REPLACE(mot,'.','');
  mot := REPLACE(mot,',','');
  mot := REPLACE(mot,':','');
  mot := REPLACE(mot,';','');
  mot := REPLACE(mot,'?','');
  mot := REPLACE(mot,'!','');
  mot := REPLACE(mot,'(','');
  mot := REPLACE(mot,')','');
  mot := REPLACE(mot,'-','');
  mot := REPLACE(mot,'+','');
  mot := REPLACE(mot,' ','');
  mot := REPLACE(mot,'_','');
  mot := REPLACE(mot,'#','');
  mot := REPLACE(mot,'*','');
  mot := REPLACE(mot,',','');
  mot := UPPER(mot);

  mot := REPLACE(mot,'GUI','KI');
  mot := REPLACE(mot,'GUE','KE');
  mot := REPLACE(mot,'GA','KA');
  mot := REPLACE(mot,'GO','KO');
  mot := REPLACE(mot,'GU','K');
  mot := REPLACE(mot,'CA','KA');
  mot := REPLACE(mot,'CO','KO');
  mot := REPLACE(mot,'CU','KU');
  mot := REPLACE(mot,'Q', 'K');
  mot := REPLACE(mot,'CC','K');
  mot := REPLACE(mot,'CK','K');

  IF SUBSTR(mot,1,1)!='A' THEN
    mot := REPLACE(mot,'E','A');
    mot := REPLACE(mot,'I','A');
    mot := REPLACE(mot,'O','A');
    mot := REPLACE(mot,'U','A');
  END IF;
  
  mot := REPLACE(mot,'MAC','MCC');
  mot := REPLACE(mot,'ASA','AZA');
  mot := REPLACE(mot,'KN', 'NN');
  mot := REPLACE(mot,'PF', 'FF');
  mot := REPLACE(mot,'SCH','SSS');
  mot := REPLACE(mot,'PH', 'FF');

  mot := REPLACE(mot,'CH','#');
  mot := REPLACE(mot,'SH','*');
  mot := REPLACE(mot,'H','');
  mot := REPLACE(mot,'#','CH');
  mot := REPLACE(mot,'*','SH');

  mot := REPLACE(mot,'AY','#');
  mot := REPLACE(mot,'Y','');
  mot := REPLACE(mot,'#','AY');

  car := SUBSTR(mot,LENGTH(mot),1);
  IF car='A' OR car='T' OR car='D' OR car='S' THEN
    mot := SUBSTR(mot,1,LENGTH(mot)-1);
  END IF;

  car := SUBSTR(mot,1,1);
  mot := car||REPLACE(SUBSTR(mot,2,LENGTH(mot)),'A','');
 
  FOR n IN 2..LENGTH(mot) LOOP
    car := SUBSTR(mot, n, 1);
    IF car=SUBSTR(mot, n-1, 1) THEN
      mot := SUBSTR(mot, 1, n-1)||SUBSTR(mot, n+1, LENGTH(mot));
    END IF;
  END LOOP;

  mot := SUBSTR(mot||'    ',1,4);

  RETURN mot;
END;
      </code>
    </function>


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




  </functions>

  <triggers>
    <trigger name="tg_manage_role" schema="systeme" function="tg_manage_role">
      <trigger-event moment="before" event="insert" for-each="row" on-schema="systeme" on-table="systeme_utilisateur"/>
      <trigger-event moment="before" event="update" for-each="row" on-schema="systeme" on-table="systeme_utilisateur"/>
      <trigger-event moment="before" event="delete" for-each="row" on-schema="systeme" on-table="systeme_utilisateur"/>
    </trigger>
  </triggers>


</analysis>
