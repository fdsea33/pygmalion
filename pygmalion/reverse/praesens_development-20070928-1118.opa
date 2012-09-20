<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet ?><analysis name="" table="" view="">
  <table name="account_balances" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="accounts(id)" opt="odrouc"></column>
    <column name="year" type="INTEGER" notnull="true" default="1"></column>
    <column name="month" type="INTEGER" notnull="true" default="0"></column>
    <column name="debit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="credit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="balance" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="accountancies" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)"></column>
    <column name="comment" type="TEXT"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="currencies(id)" opt="odrouc"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="accounts" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="number" type="VARCHAR(19)" notnull="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="usable" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="groupable" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="letterable" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="pointable" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="is_debit" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="last_letter" type="VARCHAR(8)"></column>
    <column name="comment" type="TEXT"></column>
    <column name="deadline_id" type="INTEGER" fkey="deadlines(id)" opt="odrouc"></column>
    <column name="entity_id" type="INTEGER" fkey="entities(id)" opt="odrouc"></column>
    <column name="parent_id" type="INTEGER" fkey="accounts(id)" opt="odrouc"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="bank_account_statements" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="bank_account_id" type="INTEGER" notnull="true" fkey="bank_accounts(id)" opt="odcouc"></column>
    <column name="started_on" type="DATE" notnull="true"></column>
    <column name="stopped_on" type="DATE" notnull="true"></column>
    <column name="printed_on" type="DATE" notnull="true"></column>
    <column name="virtual" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="number" type="VARCHAR(255)" notnull="true"></column>
    <column name="debit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="credit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="bank_accounts" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="iban" type="VARCHAR(34)" notnull="true"></column>
    <column name="iban_text" type="VARCHAR(48)" notnull="true"></column>
    <column name="bic" type="VARCHAR(255)"></column>
    <column name="bank_id" type="INTEGER" notnull="true" fkey="banks(id)" opt="odcouc"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="journals(id)" opt="odrouc"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="currencies(id)" opt="odcouc"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="accounts(id)" opt="odcouc"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="banks" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="code" type="VARCHAR(16)" notnull="true"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="companies" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="code" type="VARCHAR(8)" notnull="true"></column>
    <column name="admin" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="siren" type="VARCHAR(9)" notnull="true" default="'000000000'::character varying"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="company_departments" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="parent_id" type="INTEGER" fkey="company_departments(id)" opt="odrour"></column>
    <column name="company_establishment_id" type="INTEGER" notnull="true" fkey="company_establishments(id)" opt="odrour"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odrour"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="company_employees" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="company_department_id" type="INTEGER" notnull="true" fkey="company_departments(id)" opt="odrour"></column>
    <column name="user_id" type="INTEGER" fkey="users(id)" opt="odrour"></column>
    <column name="title" type="VARCHAR(32)" notnull="true"></column>
    <column name="surname" type="VARCHAR(255)" notnull="true"></column>
    <column name="first_name" type="VARCHAR(255)" notnull="true"></column>
    <column name="arrived_on" type="DATE" notnull="true"></column>
    <column name="role" type="VARCHAR(255)"></column>
    <column name="phone" type="VARCHAR(32)"></column>
    <column name="email" type="VARCHAR(255)"></column>
    <column name="mobile" type="VARCHAR(32)"></column>
    <column name="fax" type="VARCHAR(32)"></column>
    <column name="office" type="VARCHAR(32)"></column>
    <column name="note" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odrour"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="company_establishments" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="nic" type="VARCHAR(5)" notnull="true"></column>
    <column name="siret" type="VARCHAR(255)" notnull="true"></column>
    <column name="address" type="TEXT"></column>
    <column name="note" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odrour"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="currencies" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="code" type="VARCHAR(255)" notnull="true"></column>
    <column name="format" type="VARCHAR(16)" notnull="true"></column>
    <column name="rate" type="NUMERIC(16,6)" notnull="true" default="1"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="comment" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="currency_rates" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="format" type="VARCHAR(16)" notnull="true"></column>
    <column name="rate" type="NUMERIC(16,6)" notnull="true" default="1"></column>
    <column name="started_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true" default="'1970-01-01 01:00:00'::timestamp without time zone"></column>
    <column name="stopped_at" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="currencies(id)" opt="odcouc"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="deadlines" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="months" type="INTEGER" notnull="true" default="0"></column>
    <column name="days" type="INTEGER" notnull="true" default="0"></column>
    <column name="end_of_month" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="additional_days" type="INTEGER" notnull="true" default="0"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entities" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="nature_id" type="INTEGER" notnull="true" fkey="entity_natures(id)" opt="odrouc"></column>
    <column name="language_id" type="INTEGER" notnull="true" fkey="languages(id)" opt="odrouc"></column>
    <column name="code" type="VARCHAR(255)" notnull="true"></column>
    <column name="surname" type="VARCHAR(255)" notnull="true"></column>
    <column name="first_name" type="VARCHAR(255)"></column>
    <column name="full_name" type="VARCHAR(255)" notnull="true"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="born_on" type="DATE"></column>
    <column name="ean13" type="VARCHAR(13)"></column>
    <column name="surname_soundex2" type="VARCHAR(4)"></column>
    <column name="web_site" type="VARCHAR(255)"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entity_contact_norm_items" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="contact_norm_id" type="INTEGER" notnull="true" fkey="entity_contact_norms(id)" opt="odcouc"></column>
    <column name="title" type="VARCHAR(255)" notnull="true"></column>
    <column name="nature" type="VARCHAR(15)" notnull="true" default="'content'::character varying"></column>
    <column name="maxlength" type="INTEGER" notnull="true" default="38"></column>
    <column name="content" type="VARCHAR(255)"></column>
    <column name="left_nature" type="VARCHAR(15)"></column>
    <column name="left_value" type="VARCHAR(63)"></column>
    <column name="right_nature" type="VARCHAR(15)" default="'space'::character varying"></column>
    <column name="right_value" type="VARCHAR(63)"></column>
    <column name="position" type="INTEGER"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entity_contact_norms" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="reference" type="VARCHAR(255)"></column>
    <column name="preferred" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="rtl" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="align" type="VARCHAR(7)" notnull="true" default="'left'::character varying"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entity_contact_types" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="description" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entity_contact_versions" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="contact_id" type="INTEGER" notnull="true" fkey="entities(id)" opt="odcouc"></column>
    <column name="installed_at" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="abandoned_at" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="ligne_2" type="VARCHAR(38)"></column>
    <column name="ligne_3" type="VARCHAR(38)"></column>
    <column name="ligne_4_number" type="VARCHAR(38)"></column>
    <column name="ligne_4_street" type="VARCHAR(38)"></column>
    <column name="ligne_5" type="VARCHAR(38)"></column>
    <column name="ligne_6_code" type="VARCHAR(38)"></column>
    <column name="ligne_6_city" type="VARCHAR(38)"></column>
    <column name="phone" type="VARCHAR(32)"></column>
    <column name="fax" type="VARCHAR(32)"></column>
    <column name="mobile" type="VARCHAR(32)"></column>
    <column name="email" type="VARCHAR(255)"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entity_contacts" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="entity_id" type="INTEGER" notnull="true" fkey="entities(id)" opt="odcouc"></column>
    <column name="contact_type_id" type="INTEGER" notnull="true" fkey="entity_contact_types(id)" opt="odrouc"></column>
    <column name="contact_norm_id" type="INTEGER" notnull="true" fkey="entity_contact_norms(id)" opt="odrouc"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="closed_on" type="DATE"></column>
    <column name="line_2" type="VARCHAR(38)"></column>
    <column name="line_3" type="VARCHAR(38)"></column>
    <column name="line_4_number" type="VARCHAR(38)"></column>
    <column name="line_4_street" type="VARCHAR(38)"></column>
    <column name="line_5" type="VARCHAR(38)"></column>
    <column name="line_6_code" type="VARCHAR(38)"></column>
    <column name="line_6_city" type="VARCHAR(38)"></column>
    <column name="phone" type="VARCHAR(32)"></column>
    <column name="fax" type="VARCHAR(32)"></column>
    <column name="mobile" type="VARCHAR(32)"></column>
    <column name="email" type="VARCHAR(255)"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entity_natures" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="physical" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="title" type="VARCHAR(255)" notnull="true"></column>
    <column name="description" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="entries" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="record_id" type="INTEGER" notnull="true" fkey="journal_records(id)" opt="odrouc"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="accounts(id)" opt="odrouc"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="currency_debit" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="currency_credit" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="currency_rate_id" type="INTEGER" notnull="true" fkey="currency_rates(id)" opt="odrouc"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="currencies(id)" opt="odrouc"></column>
    <column name="debit" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="credit" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="virtual_statement_id" type="INTEGER" notnull="true" fkey="bank_account_statements(id)" opt="odrouc"></column>
    <column name="statement_id" type="INTEGER" notnull="true" fkey="bank_account_statements(id)" opt="odrouc"></column>
    <column name="letter" type="VARCHAR(8)"></column>
    <column name="expired_on" type="DATE"></column>
    <column name="position" type="INTEGER"></column>
    <column name="comment" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="financialyear_types" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="code" type="VARCHAR(2)" notnull="true"></column>
    <column name="fiscal" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="financialyears" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="code" type="VARCHAR(8)" notnull="true"></column>
    <column name="type_id" type="INTEGER" notnull="true" fkey="financialyear_types(id)" opt="odrouc"></column>
    <column name="started_on" type="DATE" notnull="true"></column>
    <column name="stopped_on" type="DATE" notnull="true"></column>
    <column name="written_on" type="DATE" notnull="true"></column>
    <column name="debit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="credit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="journal_records" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="created_on" type="DATE" notnull="true"></column>
    <column name="printed_on" type="DATE" notnull="true"></column>
    <column name="number" type="INTEGER" notnull="true"></column>
    <column name="status" type="VARCHAR(1)" notnull="true" default="'A'::character varying"></column>
    <column name="debit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="credit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="balance" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="position" type="INTEGER" notnull="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="journals(id)" opt="odrouc"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="journal_records_periods" label="">
    <column name="period_id" type="INTEGER" notnull="true" fkey="periods(id)" opt="odrouc"></column>
    <column name="record_id" type="INTEGER" notnull="true" fkey="journal_records(id)" opt="odrouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="journal_types" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="comment" type="TEXT"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="journals" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="type_id" type="INTEGER" notnull="true" fkey="journal_types(id)" opt="odrouc"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="abbreviation" type="VARCHAR(4)"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="languages" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="code" type="VARCHAR(255)" notnull="true"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="part_component_procedures" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="controller_path" type="VARCHAR(255)" notnull="true" default="'[NoControllerPath]'::character varying"></column>
    <column name="contextual" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="actions" type="TEXT" notnull="true" default="':'::text"></column>
    <column name="part_component_id" type="INTEGER" notnull="true" fkey="part_components(id)" opt="odcour"></column>
    <column name="parent_id" type="INTEGER" fkey="part_component_procedures(id)" opt="odcouc"></column>
    <column name="position" type="INTEGER"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="part_components" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="part_id" type="INTEGER" notnull="true" fkey="parts(id)" opt="odcour"></column>
    <column name="position" type="INTEGER"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="parts" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="code" type="VARCHAR(8)" notnull="true"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="image_url" type="VARCHAR(255)"></column>
    <column name="position" type="INTEGER"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="periods" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="journals(id)" opt="odrouc"></column>
    <column name="financialyear_id" type="INTEGER" notnull="true" fkey="financialyears(id)" opt="odrouc"></column>
    <column name="opened_on" type="DATE" notnull="true"></column>
    <column name="closed_on" type="DATE"></column>
    <column name="debit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="credit" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="balance" type="NUMERIC(16,2)" notnull="true" default="0"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="rights" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="role_id" type="INTEGER" notnull="true" fkey="roles(id)" opt="odcouc"></column>
    <column name="active" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="part_component_procedure_id" type="INTEGER" notnull="true" fkey="part_component_procedures(id)" opt="odcouc"></column>
    <column name="part_component_id" type="INTEGER" notnull="true" fkey="part_components(id)" opt="odcouc"></column>
    <column name="part_id" type="INTEGER" notnull="true" fkey="parts(id)" opt="odcouc"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="roles" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(255)" notnull="true"></column>
    <column name="admin" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcour"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="schema_info" label="">
    <column name="version" type="INTEGER"></column>
  </table>
  <table name="sessions" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="session_id" type="VARCHAR(255)"></column>
    <column name="data" type="TEXT"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE"></column>
  </table>
  <table name="users" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(32)" notnull="true"></column>
    <column name="hashed_password" type="VARCHAR(255)" notnull="true"></column>
    <column name="salt" type="VARCHAR(255)" notnull="true"></column>
    <column name="locked" type="BOOLEAN" notnull="true" default="false"></column>
    <column name="email" type="VARCHAR(255)"></column>
    <column name="created_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="created_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="updated_at" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="updated_by" type="INTEGER" fkey="users(id)" opt="odrouc"></column>
    <column name="lock_version" type="INTEGER" notnull="true" default="0"></column>
    <column name="company_id" type="INTEGER" notnull="true" fkey="companies(id)" opt="odcour"></column>
    <column name="language_id" type="INTEGER" notnull="true" fkey="languages(id)" opt="odrour"></column>
    <column name="role_id" type="INTEGER" notnull="true" fkey="roles(id)" opt="odrour"></column>
  </table>
</analysis>
