<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet ?><analysis name="" table="" view="">
  <table name="account_account" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="close_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="code" type="VARCHAR(64)"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="company_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
    <column name="shortcut" type="VARCHAR(12)"></column>
    <column name="sign" type="INTEGER" notnull="true"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="res_currency(id)" opt="odsn"></column>
    <column name="note" type="TEXT"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="reconcile" type="BOOLEAN"></column>
  </table>
  <table name="account_account_rel" label="">
    <column name="child_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
    <column name="parent_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
  </table>
  <table name="account_account_tax_default_rel" label="">
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
    <column name="tax_id" type="INTEGER" notnull="true" fkey="account_tax(id)" opt="odc"></column>
  </table>
  <table name="account_account_type" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(32)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="code_from" type="VARCHAR(10)"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="close_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="partner_account" type="BOOLEAN"></column>
    <column name="code_to" type="VARCHAR(10)"></column>
  </table>
  <table name="account_analytic_account" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="date" type="DATE"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="quantity_max" type="DOUBLE"></column>
    <column name="date_start" type="DATE"></column>
    <column name="contact_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="type" type="VARCHAR(16)"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="account_analytic_journal" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="account_analytic_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="general_account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
    <column name="product_uom_id" type="INTEGER" fkey="product_uom(id)" opt="odsn"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_analytic_journal(id)" opt="odc"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_analytic_account(id)" opt="odc"></column>
    <column name="amount" type="DOUBLE" notnull="true"></column>
    <column name="unit_amount" type="DOUBLE"></column>
    <column name="date" type="DATE" notnull="true"></column>
    <column name="move_id" type="INTEGER" fkey="account_move_line(id)" opt="odc"></column>
    <column name="product_id" type="INTEGER" fkey="product_product(id)" opt="odsn"></column>
  </table>
  <table name="account_bank" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="note" type="TEXT"></column>
    <column name="code" type="VARCHAR(6)"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="account_bank_account" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(6)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
    <column name="bank_id" type="INTEGER" fkey="account_bank(id)" opt="odsn"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="res_currency(id)" opt="odsn"></column>
    <column name="iban" type="VARCHAR(24)"></column>
    <column name="swift" type="VARCHAR(24)"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="account_bank_statement" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="state" type="VARCHAR(16)" notnull="true"></column>
    <column name="balance_start" type="NUMERIC(16,2)"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
    <column name="period_id" type="INTEGER" notnull="true" fkey="account_period(id)" opt="odsn"></column>
    <column name="date" type="DATE" notnull="true"></column>
    <column name="balance_end_real" type="NUMERIC(16,2)"></column>
  </table>
  <table name="account_bank_statement_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="statement_id" type="INTEGER" fkey="account_bank_statement(id)" opt="odsn"></column>
    <column name="amount" type="DOUBLE"></column>
    <column name="date" type="DATE"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="account_budget_post" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="sens" type="VARCHAR(16)" notnull="true"></column>
    <column name="code" type="VARCHAR(64)" notnull="true"></column>
    <column name="name" type="VARCHAR(256)" notnull="true"></column>
  </table>
  <table name="account_budget_post_dotation" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="post_id" type="INTEGER" fkey="account_budget_post(id)" opt="odsn"></column>
    <column name="amount" type="NUMERIC(16,2)"></column>
    <column name="period_id" type="INTEGER" fkey="account_period(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
    <column name="quantity" type="NUMERIC(16,2)"></column>
  </table>
  <table name="account_budget_rel" label="">
    <column name="budget_id" type="INTEGER" notnull="true" fkey="account_budget_post(id)" opt="odc"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
  </table>
  <table name="account_fiscalyear" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="date_stop" type="DATE" notnull="true"></column>
    <column name="code" type="VARCHAR(6)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_start" type="DATE" notnull="true"></column>
    <column name="company_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
  </table>
  <table name="account_invoice" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="comment" type="TEXT"></column>
    <column name="date_due" type="DATE"></column>
    <column name="reference" type="VARCHAR(64)"></column>
    <column name="payment_term" type="INTEGER" fkey="account_payment_term(id)" opt="odsn"></column>
    <column name="partner_contact" type="VARCHAR(64)"></column>
    <column name="number" type="VARCHAR(32)"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="res_currency(id)" opt="odsn"></column>
    <column name="address_invoice_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="project_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
    <column name="date_invoice" type="DATE" notnull="true"></column>
    <column name="period_id" type="INTEGER" fkey="account_period(id)" opt="odsn"></column>
    <column name="partner_ref" type="VARCHAR(64)"></column>
    <column name="move_id" type="INTEGER" fkey="account_move(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="address_contact_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
  </table>
  <table name="account_invoice_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="uos_id" type="INTEGER" fkey="product_uom(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(256)" notnull="true"></column>
    <column name="invoice_id" type="INTEGER" fkey="account_invoice(id)" opt="odc"></column>
    <column name="price_unit" type="DOUBLE" notnull="true"></column>
    <column name="note" type="TEXT"></column>
    <column name="discount" type="NUMERIC(16,2)"></column>
    <column name="product_id" type="INTEGER" fkey="product_product(id)" opt="odsn"></column>
    <column name="quantity" type="DOUBLE" notnull="true"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="account_invoice_line_tax" label="">
    <column name="invoice_line_id" type="INTEGER" notnull="true" fkey="account_invoice_line(id)" opt="odc"></column>
    <column name="tax_id" type="INTEGER" notnull="true" fkey="account_tax(id)" opt="odc"></column>
  </table>
  <table name="account_invoice_tax" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="tax_amount" type="NUMERIC(16,2)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="invoice_id" type="INTEGER" fkey="account_invoice(id)" opt="odc"></column>
    <column name="manual" type="BOOLEAN"></column>
    <column name="base_amount" type="NUMERIC(16,2)"></column>
    <column name="base_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="tax_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="amount" type="NUMERIC(16,2)"></column>
    <column name="base" type="NUMERIC(16,2)"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="account_journal" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="default_debit_account_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
    <column name="update_posted" type="BOOLEAN"></column>
    <column name="code" type="VARCHAR(9)"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="centralisation" type="BOOLEAN"></column>
    <column name="view_id" type="INTEGER" notnull="true" fkey="account_journal_view(id)" opt="odsn"></column>
    <column name="sequence_id" type="INTEGER" fkey="ir_sequence(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="default_credit_account_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="account_journal_column" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="view_id" type="INTEGER" fkey="account_journal_view(id)" opt="odsn"></column>
    <column name="required" type="BOOLEAN"></column>
    <column name="field" type="VARCHAR(32)" notnull="true"></column>
    <column name="readonly" type="BOOLEAN"></column>
  </table>
  <table name="account_journal_group_rel" label="">
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odc"></column>
    <column name="group_id" type="INTEGER" notnull="true" fkey="res_groups(id)" opt="odc"></column>
  </table>
  <table name="account_journal_period" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odc"></column>
    <column name="state" type="VARCHAR(16)" notnull="true"></column>
    <column name="period_id" type="INTEGER" notnull="true" fkey="account_period(id)" opt="odc"></column>
    <column name="active" type="BOOLEAN" notnull="true"></column>
  </table>
  <table name="account_journal_type_rel" label="">
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odc"></column>
    <column name="type_id" type="INTEGER" notnull="true" fkey="account_account_type(id)" opt="odc"></column>
  </table>
  <table name="account_journal_view" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="account_model" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="ref" type="VARCHAR(64)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
  </table>
  <table name="account_model_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="model_id" type="INTEGER" notnull="true" fkey="account_model(id)" opt="odc"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
    <column name="currency_id" type="INTEGER" fkey="res_currency(id)" opt="odsn"></column>
    <column name="credit" type="NUMERIC(16,2)"></column>
    <column name="date_maturity" type="VARCHAR(16)"></column>
    <column name="debit" type="NUMERIC(16,2)"></column>
    <column name="date" type="VARCHAR(16)" notnull="true"></column>
    <column name="amount_currency" type="DOUBLE"></column>
    <column name="ref" type="VARCHAR(16)"></column>
    <column name="quantity" type="NUMERIC(16,2)"></column>
    <column name="CONSTRAINT" type="ACCOUNT_MODEL_LINE_CREDIT_DEBIT1"></column>
    <column name="CONSTRAINT" type="ACCOUNT_MODEL_LINE_CREDIT_DEBIT2"></column>
  </table>
  <table name="account_move" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)" notnull="true"></column>
    <column name="period_id" type="INTEGER" notnull="true" fkey="account_period(id)" opt="odsn"></column>
    <column name="ref" type="VARCHAR(64)"></column>
  </table>
  <table name="account_move_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="statement_id" type="INTEGER" fkey="account_bank_statement(id)" opt="odsn"></column>
    <column name="currency_id" type="INTEGER" fkey="res_currency(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="date_maturity" type="DATE"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="blocked" type="BOOLEAN"></column>
    <column name="centralisation" type="VARCHAR(16)"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
    <column name="tax_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="debit" type="NUMERIC(16,2)"></column>
    <column name="ref" type="VARCHAR(32)"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
    <column name="period_id" type="INTEGER" notnull="true" fkey="account_period(id)" opt="odsn"></column>
    <column name="date_created" type="DATE"></column>
    <column name="date" type="DATE" notnull="true"></column>
    <column name="move_id" type="INTEGER" notnull="true" fkey="account_move(id)" opt="odc"></column>
    <column name="reconcile_id" type="INTEGER" fkey="account_move_reconcile(id)" opt="odsn"></column>
    <column name="tax_amount" type="NUMERIC(16,2)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="credit" type="NUMERIC(16,2)"></column>
    <column name="amount_currency" type="DOUBLE"></column>
    <column name="quantity" type="NUMERIC(16,2)"></column>
    <column name="CONSTRAINT" type="ACCOUNT_MOVE_LINE_CREDIT_DEBIT1"></column>
    <column name="CONSTRAINT" type="ACCOUNT_MOVE_LINE_CREDIT_DEBIT2"></column>
  </table>
  <table name="account_move_reconcile" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="account_payment_term" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="note" type="TEXT"></column>
    <column name="name" type="VARCHAR(32)"></column>
  </table>
  <table name="account_payment_term_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="payment_id" type="INTEGER" notnull="true" fkey="account_payment_term(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(32)" notnull="true"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="days" type="INTEGER" notnull="true"></column>
    <column name="value" type="VARCHAR(16)" notnull="true"></column>
    <column name="condition" type="VARCHAR(16)" notnull="true"></column>
    <column name="value_amount" type="DOUBLE"></column>
  </table>
  <table name="account_period" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="date_stop" type="DATE" notnull="true"></column>
    <column name="code" type="VARCHAR(12)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_start" type="DATE" notnull="true"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="fiscalyear_id" type="INTEGER" notnull="true" fkey="account_fiscalyear(id)" opt="odsn"></column>
  </table>
  <table name="account_subscription" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="model_id" type="INTEGER" notnull="true" fkey="account_model(id)" opt="odsn"></column>
    <column name="period_nbr" type="INTEGER" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_start" type="DATE" notnull="true"></column>
    <column name="period_total" type="INTEGER" notnull="true"></column>
    <column name="state" type="VARCHAR(16)" notnull="true"></column>
    <column name="period_type" type="VARCHAR(16)" notnull="true"></column>
    <column name="ref" type="VARCHAR(16)"></column>
  </table>
  <table name="account_subscription_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="date" type="DATE" notnull="true"></column>
    <column name="subscription_id" type="INTEGER" notnull="true" fkey="account_subscription(id)" opt="odsn"></column>
    <column name="move_id" type="INTEGER" fkey="account_move(id)" opt="odsn"></column>
  </table>
  <table name="account_tax" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="domain" type="VARCHAR(32)"></column>
    <column name="ref_tax_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="base_sign" type="DOUBLE"></column>
    <column name="child_depend" type="BOOLEAN"></column>
    <column name="applicable_type" type="VARCHAR(16)" notnull="true"></column>
    <column name="company_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="tax_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="account_tax(id)" opt="odsn"></column>
    <column name="ref_tax_sign" type="DOUBLE"></column>
    <column name="python_applicable" type="TEXT"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="ref_base_sign" type="DOUBLE"></column>
    <column name="tax_group" type="VARCHAR(16)"></column>
    <column name="base_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="ref_base_code_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
    <column name="account_paid_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
    <column name="account_collected_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
    <column name="amount" type="NUMERIC(14,4)" notnull="true"></column>
    <column name="python_compute" type="TEXT"></column>
    <column name="tax_sign" type="DOUBLE"></column>
  </table>
  <table name="account_tax_code" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="info" type="TEXT"></column>
    <column name="code" type="VARCHAR(16)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="parent_id" type="INTEGER" fkey="account_tax_code(id)" opt="odsn"></column>
  </table>
  <table name="account_transfer" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="reference" type="VARCHAR(64)"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="journal_id" type="INTEGER" notnull="true" fkey="account_journal(id)" opt="odsn"></column>
    <column name="adjust_account_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="account_dest_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
    <column name="period_id" type="INTEGER" notnull="true" fkey="account_period(id)" opt="odsn"></column>
    <column name="move_id" type="INTEGER" fkey="account_move(id)" opt="odsn"></column>
    <column name="date" type="DATE" notnull="true"></column>
    <column name="adjust_amount" type="DOUBLE"></column>
    <column name="amount" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="project_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="account_src_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odsn"></column>
    <column name="change" type="NUMERIC(16,2)"></column>
  </table>
  <table name="account_transfer_invoice" label="">
    <column name="transfer_id" type="INTEGER" notnull="true" fkey="account_transfer(id)" opt="odc"></column>
    <column name="invoice_id" type="INTEGER" notnull="true" fkey="account_invoice(id)" opt="odc"></column>
  </table>
  <table name="crm_case" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="date_closed" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="probability" type="DOUBLE"></column>
    <column name="canal_id" type="INTEGER" fkey="res_partner_canal(id)" opt="odsn"></column>
    <column name="partner_address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="som" type="INTEGER" fkey="res_partner_som(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="date_action_next" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="planned_revenue" type="DOUBLE"></column>
    <column name="priority" type="VARCHAR(16)"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="email_cc" type="VARCHAR(252)"></column>
    <column name="ref" type="VARCHAR(128)"></column>
    <column name="description" type="TEXT"></column>
    <column name="date_action_last" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="planned_cost" type="DOUBLE"></column>
    <column name="ref2" type="VARCHAR(128)"></column>
    <column name="section_id" type="INTEGER" notnull="true" fkey="crm_case_section(id)" opt="odsn"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="categ_id" type="INTEGER" fkey="crm_case_categ(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_deadline" type="DATE"></column>
    <column name="email_last" type="TEXT"></column>
    <column name="email_from" type="VARCHAR(128)"></column>
  </table>
  <table name="crm_case_categ" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="section_id" type="INTEGER" fkey="crm_case_section(id)" opt="odsn"></column>
  </table>
  <table name="crm_case_history" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
    <column name="canal_id" type="INTEGER" fkey="res_partner_canal(id)" opt="odsn"></column>
    <column name="som" type="INTEGER" fkey="res_partner_som(id)" opt="odsn"></column>
    <column name="case_id" type="INTEGER" notnull="true" fkey="crm_case(id)" opt="odc"></column>
    <column name="date" type="DATE"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="crm_case_rule" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="trg_categ_id" type="INTEGER" fkey="crm_case_categ(id)" opt="odsn"></column>
    <column name="trg_section_id" type="INTEGER" fkey="crm_case_section(id)" opt="odsn"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="act_remind_partner" type="BOOLEAN"></column>
    <column name="trg_date_range_type" type="VARCHAR(16)"></column>
    <column name="act_section_id" type="INTEGER" fkey="crm_case_section(id)" opt="odsn"></column>
    <column name="trg_date_range" type="INTEGER"></column>
    <column name="act_remind_user" type="BOOLEAN"></column>
    <column name="trg_priority_from" type="VARCHAR(16)"></column>
    <column name="trg_date_type" type="VARCHAR(16)"></column>
    <column name="act_method" type="VARCHAR(64)"></column>
    <column name="act_email_cc" type="VARCHAR(250)"></column>
    <column name="act_priority" type="VARCHAR(16)"></column>
    <column name="trg_state_to" type="VARCHAR(16)"></column>
    <column name="act_mail_to_email" type="VARCHAR(128)"></column>
    <column name="trg_user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="act_state" type="VARCHAR(16)"></column>
    <column name="act_mail_to_partner" type="BOOLEAN"></column>
    <column name="trg_priority_to" type="VARCHAR(16)"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="act_mail_to_watchers" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="trg_state_from" type="VARCHAR(16)"></column>
    <column name="act_user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="act_mail_to_user" type="BOOLEAN"></column>
    <column name="trg_partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="trg_partner_categ_id" type="INTEGER" fkey="res_partner_category(id)" opt="odsn"></column>
    <column name="act_mail_body" type="TEXT"></column>
  </table>
  <table name="crm_case_section" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="reply_to" type="VARCHAR(64)"></column>
    <column name="parent_id" type="INTEGER" fkey="crm_case_section(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
  </table>
  <table name="crm_segmentation" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="som_interval_max" type="INTEGER"></column>
    <column name="categ_id" type="INTEGER" notnull="true" fkey="res_partner_category(id)" opt="odsn"></column>
    <column name="som_interval_default" type="DOUBLE"></column>
    <column name="som_interval_decrease" type="DOUBLE"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="exclusif" type="BOOLEAN"></column>
    <column name="partner_id" type="INTEGER"></column>
    <column name="som_interval" type="INTEGER"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="crm_segmentation_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="segmentation_id" type="INTEGER" fkey="crm_segmentation(id)" opt="odsn"></column>
    <column name="expr_name" type="VARCHAR(16)" notnull="true"></column>
    <column name="expr_value" type="DOUBLE" notnull="true"></column>
    <column name="operator" type="VARCHAR(16)" notnull="true"></column>
    <column name="expr_operator" type="VARCHAR(16)" notnull="true"></column>
  </table>
  <table name="delivery_carrier" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="partner_id" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
  </table>
  <table name="delivery_grid" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="carrier_id" type="INTEGER" notnull="true" fkey="delivery_carrier(id)" opt="odc"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="zip_from" type="VARCHAR(12)"></column>
    <column name="zip_to" type="VARCHAR(12)"></column>
  </table>
  <table name="delivery_grid_country_rel" label="">
    <column name="grid_id" type="INTEGER" notnull="true" fkey="delivery_grid(id)" opt="odc"></column>
    <column name="country_id" type="INTEGER" notnull="true" fkey="res_country(id)" opt="odc"></column>
  </table>
  <table name="delivery_grid_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="list_price" type="DOUBLE" notnull="true"></column>
    <column name="name" type="VARCHAR(32)" notnull="true"></column>
    <column name="price_type" type="VARCHAR(16)" notnull="true"></column>
    <column name="max_value" type="DOUBLE" notnull="true"></column>
    <column name="standard_price" type="DOUBLE" notnull="true"></column>
    <column name="grid_id" type="INTEGER" notnull="true" fkey="delivery_grid(id)" opt="odsn"></column>
    <column name="variable_factor" type="VARCHAR(16)" notnull="true"></column>
    <column name="operator" type="VARCHAR(16)" notnull="true"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
  </table>
  <table name="delivery_grid_state_rel" label="">
    <column name="grid_id" type="INTEGER" notnull="true" fkey="delivery_grid(id)" opt="odc"></column>
    <column name="state_id" type="INTEGER" notnull="true" fkey="res_country_state(id)" opt="odc"></column>
  </table>
  <table name="hr_action_reason" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="action_type" type="VARCHAR(16)"></column>
  </table>
  <table name="hr_attendance" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="action" type="VARCHAR(16)"></column>
    <column name="employee_id" type="INTEGER" notnull="true" fkey="hr_employee(id)" opt="odsn"></column>
    <column name="name" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="action_desc" type="INTEGER" fkey="hr_action_reason(id)" opt="odsn"></column>
  </table>
  <table name="hr_employee" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="started" type="DATE"></column>
    <column name="notes" type="TEXT"></column>
    <column name="company_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="hr_employee(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="category_id" type="INTEGER" fkey="hr_employee_category(id)" opt="odsn"></column>
    <column name="holiday_max" type="INTEGER"></column>
    <column name="bank_account" type="VARCHAR(16)"></column>
    <column name="regime" type="DOUBLE"></column>
  </table>
  <table name="hr_employee_category" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="hr_employee_category(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="hr_holidays" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="employee_id" type="INTEGER" fkey="hr_employee(id)" opt="odsn"></column>
    <column name="date_from" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="holiday_status" type="INTEGER" fkey="hr_holidays_status(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_to" type="TIMESTAMP WITHOUT TIME ZONE"></column>
  </table>
  <table name="hr_holidays_status" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="hr_timesheet" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="dayofweek" type="VARCHAR(16)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="tgroup_id" type="INTEGER" fkey="hr_timesheet_group(id)" opt="odsn"></column>
    <column name="date_from" type="DATE"></column>
    <column name="hour_from" type="VARCHAR(8)"></column>
    <column name="hour_to" type="VARCHAR(8)"></column>
  </table>
  <table name="hr_timesheet_employee_rel" label="">
    <column name="emp_id" type="INTEGER" notnull="true" fkey="hr_employee(id)" opt="odc"></column>
    <column name="tgroup_id" type="INTEGER" notnull="true" fkey="hr_timesheet_group(id)" opt="odc"></column>
  </table>
  <table name="hr_timesheet_group" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="manager" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="inherit" label="">
    <column name="obj_type" type="VARCHAR(128)" notnull="true"></column>
    <column name="obj_id" type="INTEGER" notnull="true"></column>
    <column name="inst_type" type="VARCHAR(128)" notnull="true"></column>
    <column name="inst_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="ir_actions" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true" default="''::character varying"></column>
    <column name="type" type="VARCHAR(64)" notnull="true" default="'window'::character varying"></column>
    <column name="usage" type="VARCHAR(32)"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
  </table>
  <table name="ir_act_execute" label="">
    <column name="func_name" type="VARCHAR(64)" notnull="true"></column>
    <column name="func_arg" type="VARCHAR(64)"></column>
  </table>
  <table name="ir_act_group" label="">
    <column name="exec_type" type="VARCHAR(64)" notnull="true" default="'serial'::character varying"></column>
  </table>
  <table name="ir_act_group_link" label="">
    <column name="aid" type="INTEGER" notnull="true"></column>
    <column name="gid" type="INTEGER" notnull="true"></column>
  </table>
  <table name="ir_act_report_custom" label="">
    <column name="report_id" type="INTEGER" notnull="true"></column>
    <column name="model" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="ir_act_report_xml" label="">
    <column name="model" type="VARCHAR(64)" notnull="true"></column>
    <column name="report_name" type="VARCHAR(64)" notnull="true"></column>
    <column name="auto" type="BOOLEAN" notnull="true" default="true"></column>
    <column name="report_xsl" type="VARCHAR(256)"></column>
    <column name="report_rml" type="VARCHAR(256)"></column>
    <column name="report_xml" type="VARCHAR(256)"></column>
  </table>
  <table name="ir_act_window" label="">
    <column name="view_id" type="INTEGER"></column>
    <column name="res_model" type="VARCHAR(64)"></column>
    <column name="view_type" type="VARCHAR(16)"></column>
    <column name="domain" type="VARCHAR(250)"></column>
    <column name="view_mode" type="VARCHAR(16)"></column>
    <column name="context" type="VARCHAR(250)"></column>
  </table>
  <table name="ir_act_wizard" label="">
    <column name="wiz_name" type="VARCHAR(64)" notnull="true"></column>
    <column name="multi" type="BOOLEAN"></column>
  </table>
  <table name="ir_attachment" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="description" type="TEXT"></column>
    <column name="res_model" type="VARCHAR(64)" notnull="true"></column>
    <column name="link" type="VARCHAR(256)"></column>
    <column name="datas_fname" type="VARCHAR(64)"></column>
    <column name="res_id" type="INTEGER" notnull="true"></column>
    <column name="datas" type="BYTEA"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="ir_cron" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="function" type="VARCHAR(64)"></column>
    <column name="args" type="TEXT"></column>
    <column name="user_id" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(60)" notnull="true"></column>
    <column name="interval_type" type="VARCHAR(16)"></column>
    <column name="numbercall" type="INTEGER"></column>
    <column name="nextcall" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="priority" type="INTEGER"></column>
    <column name="doall" type="BOOLEAN"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="interval_number" type="INTEGER"></column>
    <column name="model" type="VARCHAR(64)"></column>
  </table>
  <table name="ir_default" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="ref_table" type="VARCHAR(64)"></column>
    <column name="value" type="VARCHAR(64)"></column>
    <column name="ref_id" type="INTEGER"></column>
    <column name="field_tbl" type="VARCHAR(64)"></column>
    <column name="field_name" type="VARCHAR(64)"></column>
    <column name="page" type="VARCHAR(64)"></column>
  </table>
  <table name="ir_exports" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="resource" type="VARCHAR(128)"></column>
    <column name="name" type="VARCHAR(128)"></column>
  </table>
  <table name="ir_exports_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="export_id" type="INTEGER" fkey="ir_exports(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="ir_model" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="model" type="VARCHAR(64)" notnull="true" default="''::character varying"></column>
    <column name="name" type="VARCHAR(64)"></column>
    <column name="info" type="TEXT"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
  </table>
  <table name="ir_model_access" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="model_id" type="INTEGER" notnull="true" fkey="ir_model(id)" opt="odsn"></column>
    <column name="perm_read" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="perm_write" type="BOOLEAN"></column>
    <column name="perm_create" type="BOOLEAN"></column>
    <column name="group_id" type="INTEGER" fkey="res_groups(id)" opt="odsn"></column>
  </table>
  <table name="ir_model_data" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="noupdate" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_init" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="date_update" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="module" type="VARCHAR(64)" notnull="true"></column>
    <column name="model" type="VARCHAR(64)" notnull="true"></column>
    <column name="res_id" type="INTEGER"></column>
  </table>
  <table name="ir_model_fields" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="model" type="VARCHAR(64)" notnull="true" default="''::character varying"></column>
    <column name="model_id" type="INTEGER" notnull="true" fkey="ir_model(id);" opt=""></column>
    <column name="name" type="VARCHAR(64)" default="''::character varying"></column>
    <column name="relation" type="VARCHAR(64)"></column>
    <column name="field_description" type="VARCHAR(256)"></column>
    <column name="ttype" type="VARCHAR(64)"></column>
    <column name="view_load" type="BOOLEAN"></column>
    <column name="relate" type="BOOLEAN" default="false"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="group_name" type="VARCHAR(128)"></column>
  </table>
  <table name="ir_model_fields_group_rel" label="">
    <column name="field_id" type="INTEGER" notnull="true" fkey="ir_model_fields(id)" opt="odc"></column>
    <column name="group_id" type="INTEGER" notnull="true" fkey="res_groups(id)" opt="odc"></column>
  </table>
  <table name="ir_module_category" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="ir_module_category(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
  </table>
  <table name="ir_module_module" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="website" type="VARCHAR(256)"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="author" type="VARCHAR(128)"></column>
    <column name="url" type="VARCHAR(128)"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="latest_version" type="VARCHAR(64)"></column>
    <column name="shortdesc" type="VARCHAR(256)"></column>
    <column name="category_id" type="INTEGER" fkey="ir_module_category(id)" opt="odsn"></column>
    <column name="description" type="TEXT"></column>
    <column name="demo" type="BOOLEAN" default="false"></column>
  </table>
  <table name="ir_module_module_dependency" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(128)"></column>
    <column name="version_pattern" type="VARCHAR(128)"></column>
    <column name="module_id" type="INTEGER" fkey="ir_module_module(id)" opt="odc"></column>
  </table>
  <table name="ir_module_repository" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="url" type="VARCHAR(256)" notnull="true"></column>
    <column name="name" type="VARCHAR(128)"></column>
  </table>
  <table name="ir_property" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="fields_id" type="INTEGER" notnull="true" fkey="ir_model_fields(id)" opt="odc"></column>
    <column name="res_id" type="VARCHAR(128)"></column>
    <column name="name" type="VARCHAR(128)"></column>
    <column name="value" type="VARCHAR(128)"></column>
    <column name="company_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
  </table>
  <table name="ir_report_custom" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="menu_id" type="INTEGER" fkey="ir_ui_menu(id)" opt="odsn"></column>
    <column name="model_id" type="INTEGER" notnull="true" fkey="ir_model(id)" opt="odsn"></column>
    <column name="limitt" type="VARCHAR(9)"></column>
    <column name="print_format" type="VARCHAR(16)" notnull="true"></column>
    <column name="title" type="VARCHAR(64)" notnull="true"></column>
    <column name="repeat_header" type="BOOLEAN"></column>
    <column name="footer" type="VARCHAR(64)" notnull="true"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="frequency" type="VARCHAR(16)"></column>
    <column name="sortby" type="VARCHAR(64)"></column>
    <column name="print_orientation" type="VARCHAR(16)" notnull="true"></column>
    <column name="field_parent" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="ir_report_custom_fields" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="fc2_op" type="VARCHAR(16)"></column>
    <column name="operation" type="VARCHAR(16)"></column>
    <column name="fc1_op" type="VARCHAR(16)"></column>
    <column name="alignment" type="VARCHAR(16)" notnull="true"></column>
    <column name="fc2_operande" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="fc2_condition" type="VARCHAR(64)"></column>
    <column name="width" type="INTEGER"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="fc3_operande" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="fc0_condition" type="VARCHAR(64)"></column>
    <column name="fc0_op" type="VARCHAR(16)"></column>
    <column name="fontcolor" type="VARCHAR(64)"></column>
    <column name="fc1_operande" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="field_child1" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="field_child0" type="INTEGER" notnull="true" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="field_child3" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="field_child2" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="fc1_condition" type="VARCHAR(64)"></column>
    <column name="cumulate" type="BOOLEAN"></column>
    <column name="report_id" type="INTEGER" fkey="ir_report_custom(id)" opt="odsn"></column>
    <column name="fc3_op" type="VARCHAR(16)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="bgcolor" type="VARCHAR(64)"></column>
    <column name="fc3_condition" type="VARCHAR(64)"></column>
    <column name="fc0_operande" type="INTEGER" fkey="ir_model_fields(id)" opt="odsn"></column>
    <column name="groupby" type="BOOLEAN"></column>
  </table>
  <table name="ir_sequence" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(64)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="number_next" type="INTEGER" notnull="true"></column>
    <column name="padding" type="INTEGER" notnull="true"></column>
    <column name="number_increment" type="INTEGER" notnull="true"></column>
    <column name="prefix" type="VARCHAR(64)"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="suffix" type="VARCHAR(64)"></column>
  </table>
  <table name="ir_sequence_type" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(32)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="ir_translation" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="lang" type="VARCHAR(5)"></column>
    <column name="src" type="TEXT"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="res_id" type="INTEGER"></column>
    <column name="value" type="TEXT"></column>
    <column name="type" type="VARCHAR(16)"></column>
  </table>
  <table name="ir_ui_menu" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="ir_ui_menu(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true" default="''::character varying"></column>
    <column name="icon" type="VARCHAR(64)" default="''::character varying"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="sequence" type="INTEGER"></column>
  </table>
  <table name="ir_ui_menu_group_rel" label="">
    <column name="menu_id" type="INTEGER" notnull="true" fkey="ir_ui_menu(id)" opt="odc"></column>
    <column name="gid" type="INTEGER" notnull="true" fkey="res_groups(id)" opt="odc"></column>
  </table>
  <table name="ir_ui_view" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true" default="''::character varying"></column>
    <column name="model" type="VARCHAR(64)" notnull="true" default="''::character varying"></column>
    <column name="type" type="VARCHAR(64)" notnull="true" default="'form'::character varying"></column>
    <column name="arch" type="TEXT" notnull="true"></column>
    <column name="field_parent" type="VARCHAR(64)"></column>
    <column name="priority" type="INTEGER" notnull="true" default="5"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="inherit_id" type="INTEGER" fkey="ir_ui_view(id)" opt="odsn"></column>
    <column name="CONSTRAINT" type="IR_UI_VIEW_TYPE"></column>
  </table>
  <table name="ir_ui_view_sc" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="resource" type="VARCHAR(64)" notnull="true"></column>
    <column name="user_id" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odc"></column>
    <column name="res_id" type="INTEGER" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
  </table>
  <table name="ir_values" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(128)"></column>
    <column name="key" type="VARCHAR(128)"></column>
    <column name="model" type="VARCHAR(128)"></column>
    <column name="value" type="TEXT"></column>
    <column name="meta" type="TEXT"></column>
    <column name="res_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odc"></column>
    <column name="key2" type="VARCHAR(256)"></column>
    <column name="object" type="BOOLEAN"></column>
  </table>
  <table name="mrp_bom" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="product_rounding" type="DOUBLE"></column>
    <column name="date_stop" type="DATE"></column>
    <column name="code" type="VARCHAR(16)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="revision_type" type="VARCHAR(16)"></column>
    <column name="date_start" type="DATE"></column>
    <column name="product_efficiency" type="DOUBLE" notnull="true"></column>
    <column name="routing_id" type="INTEGER" fkey="mrp_routing(id)" opt="odsn"></column>
    <column name="bom_id" type="INTEGER" fkey="mrp_bom(id)" opt="odc"></column>
    <column name="product_qty" type="DOUBLE" notnull="true"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="position" type="VARCHAR(64)"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
    <column name="CONSTRAINT" type="MRP_BOM_BOM_QTY_ZERO"></column>
  </table>
  <table name="mrp_bom_property_rel" label="">
    <column name="bom_id" type="INTEGER" notnull="true" fkey="mrp_bom(id)" opt="odc"></column>
    <column name="property_id" type="INTEGER" notnull="true" fkey="mrp_property(id)" opt="odc"></column>
  </table>
  <table name="mrp_bom_revision" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="indice" type="VARCHAR(16)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="bom_id" type="INTEGER" fkey="mrp_bom(id)" opt="odsn"></column>
    <column name="last_indice" type="VARCHAR(64)"></column>
    <column name="date" type="DATE"></column>
    <column name="author_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="mrp_procurement" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="purchase_id" type="INTEGER" fkey="purchase_order(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="date_planned" type="DATE" notnull="true"></column>
    <column name="close_move" type="BOOLEAN" notnull="true"></column>
    <column name="date_close" type="DATE"></column>
    <column name="priority" type="VARCHAR(16)" notnull="true"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="product_qty" type="DOUBLE" notnull="true"></column>
    <column name="procure_method" type="VARCHAR(16)"></column>
    <column name="purchase_line_id" type="INTEGER" fkey="purchase_order_line(id)" opt="odsn"></column>
    <column name="location_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="message" type="VARCHAR(64)"></column>
    <column name="move_id" type="INTEGER" fkey="stock_move(id)" opt="odc"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="mrp_procurement_property_rel" label="">
    <column name="procurement_id" type="INTEGER" notnull="true" fkey="mrp_procurement(id)" opt="odc"></column>
    <column name="property_id" type="INTEGER" notnull="true" fkey="mrp_property(id)" opt="odc"></column>
  </table>
  <table name="mrp_production" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="location_src_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="product_uom" type="INTEGER" fkey="product_uom(id)" opt="odsn"></column>
    <column name="date_planned" type="DATE" notnull="true"></column>
    <column name="date_start" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="priority" type="VARCHAR(16)"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="location_dest_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="date_finnished" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="product_qty" type="DOUBLE" notnull="true"></column>
    <column name="bom_id" type="INTEGER" fkey="mrp_bom(id)" opt="odsn"></column>
    <column name="move_prod_id" type="INTEGER" fkey="stock_move(id)" opt="odsn"></column>
    <column name="picking_id" type="INTEGER" fkey="stock_picking(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
  </table>
  <table name="mrp_production_move_ids" label="">
    <column name="production_id" type="INTEGER" notnull="true" fkey="mrp_production(id)" opt="odc"></column>
    <column name="move_id" type="INTEGER" notnull="true" fkey="stock_move(id)" opt="odc"></column>
  </table>
  <table name="mrp_production_product_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="production_id" type="INTEGER" fkey="mrp_production(id)" opt="odsn"></column>
    <column name="product_qty" type="DOUBLE" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
  </table>
  <table name="mrp_production_workcenter_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="hour" type="DOUBLE"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="production_id" type="INTEGER" fkey="mrp_production(id)" opt="odsn"></column>
    <column name="workcenter_id" type="INTEGER" notnull="true" fkey="mrp_workcenter(id)" opt="odsn"></column>
    <column name="cycle" type="DOUBLE"></column>
  </table>
  <table name="mrp_property" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="description" type="TEXT"></column>
    <column name="group_id" type="INTEGER" notnull="true" fkey="mrp_property_group(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="composition" type="VARCHAR(16)" notnull="true"></column>
  </table>
  <table name="mrp_property_group" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="mrp_routing" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="note" type="TEXT"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="location_id" type="INTEGER" fkey="stock_location(id)" opt="odsn"></column>
  </table>
  <table name="mrp_routing_workcenter" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="cycle_nbr" type="DOUBLE" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="note" type="TEXT"></column>
    <column name="routing_id" type="INTEGER" fkey="mrp_routing(id)" opt="odsn"></column>
    <column name="workcenter_id" type="INTEGER" notnull="true" fkey="mrp_workcenter(id)" opt="odsn"></column>
    <column name="hour_nbr" type="DOUBLE" notnull="true"></column>
  </table>
  <table name="mrp_workcenter" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="capacity_per_cycle" type="DOUBLE"></column>
    <column name="time_efficiency" type="DOUBLE"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="time_start" type="DOUBLE"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="time_stop" type="DOUBLE"></column>
    <column name="costs_journal_id" type="INTEGER" fkey="account_analytic_journal(id)" opt="odsn"></column>
    <column name="costs_hour" type="DOUBLE"></column>
    <column name="note" type="TEXT"></column>
    <column name="timesheet_id" type="INTEGER" fkey="hr_timesheet_group(id)" opt="odsn"></column>
    <column name="costs_hour_account_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="costs_cycle" type="DOUBLE"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="costs_cycle_account_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="costs_general_account_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
    <column name="time_cycle" type="DOUBLE"></column>
  </table>
  <table name="perm" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="level" type="SMALLINT" notnull="true" default="4"></column>
    <column name="uid" type="INTEGER"></column>
    <column name="gid" type="INTEGER"></column>
  </table>
  <table name="pricelist_partnerinfo" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="min_quantity" type="DOUBLE" notnull="true"></column>
    <column name="price" type="DOUBLE" notnull="true"></column>
    <column name="suppinfo_id" type="INTEGER" notnull="true" fkey="product_supplierinfo(id)" opt="odc"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="product_category" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="product_category(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
  </table>
  <table name="product_packaging" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="rows" type="INTEGER" notnull="true"></column>
    <column name="product_id" type="INTEGER" fkey="product_product(id)" opt="odsn"></column>
    <column name="weight" type="DOUBLE"></column>
    <column name="ean" type="VARCHAR(14)"></column>
    <column name="ul_qty" type="INTEGER"></column>
    <column name="qty" type="DOUBLE"></column>
    <column name="ul" type="INTEGER" notnull="true" fkey="product_ul(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(14)"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="weight_ul" type="DOUBLE"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="product_price_type" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="field" type="VARCHAR(16)" notnull="true"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="res_currency(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(32)" notnull="true"></column>
  </table>
  <table name="product_pricelist" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="res_currency(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="product_pricelist_item" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="price_round" type="DOUBLE"></column>
    <column name="price_min_margin" type="DOUBLE"></column>
    <column name="name" type="VARCHAR(64)"></column>
    <column name="base_pricelist_id" type="INTEGER" fkey="product_pricelist(id)" opt="odsn"></column>
    <column name="sequence" type="INTEGER" notnull="true"></column>
    <column name="price_max_margin" type="DOUBLE"></column>
    <column name="product_tmpl_id" type="INTEGER" fkey="product_template(id)" opt="odsn"></column>
    <column name="base" type="INTEGER" notnull="true"></column>
    <column name="price_discount" type="DOUBLE"></column>
    <column name="price_version_id" type="INTEGER" notnull="true" fkey="product_pricelist_version(id)" opt="odsn"></column>
    <column name="min_quantity" type="INTEGER" notnull="true"></column>
    <column name="price_surcharge" type="DOUBLE"></column>
    <column name="categ_id" type="INTEGER" fkey="product_category(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" fkey="product_product(id)" opt="odsn"></column>
  </table>
  <table name="product_pricelist_type" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="key" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="product_pricelist_version" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_end" type="DATE"></column>
    <column name="date_start" type="DATE"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="pricelist_id" type="INTEGER" notnull="true" fkey="product_pricelist(id)" opt="odsn"></column>
  </table>
  <table name="product_product" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="ean13" type="VARCHAR(13)"></column>
    <column name="price_extra" type="DOUBLE"></column>
    <column name="product_tmpl_id" type="INTEGER" notnull="true" fkey="product_template(id)" opt="odsn"></column>
    <column name="default_code" type="VARCHAR(64)"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="variants" type="VARCHAR(64)"></column>
    <column name="price_margin" type="DOUBLE"></column>
  </table>
  <table name="product_supplierinfo" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_template(id)" opt="odc"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="qty" type="INTEGER" notnull="true"></column>
    <column name="delay" type="INTEGER" notnull="true"></column>
    <column name="product_code" type="VARCHAR(64)"></column>
    <column name="product_name" type="VARCHAR(128)"></column>
    <column name="name" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odc"></column>
  </table>
  <table name="product_taxes_rel" label="">
    <column name="prod_id" type="INTEGER" notnull="true" fkey="product_template(id)" opt="odc"></column>
    <column name="tax_id" type="INTEGER" notnull="true" fkey="account_tax(id)" opt="odc"></column>
  </table>
  <table name="product_template" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="warranty" type="DOUBLE"></column>
    <column name="supply_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="uos_id" type="INTEGER" fkey="product_uom(id)" opt="odsn"></column>
    <column name="list_price" type="DOUBLE"></column>
    <column name="weight" type="DOUBLE"></column>
    <column name="standard_price" type="DOUBLE" notnull="true"></column>
    <column name="mes_type" type="VARCHAR(16)" notnull="true"></column>
    <column name="uom_id" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="description_purchase" type="TEXT"></column>
    <column name="uos_coeff" type="DOUBLE"></column>
    <column name="sale_ok" type="BOOLEAN"></column>
    <column name="categ_id" type="INTEGER" notnull="true" fkey="product_category(id)" opt="odsn"></column>
    <column name="product_manager" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="uom_po_id" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="description" type="TEXT"></column>
    <column name="intrastat" type="VARCHAR(16)"></column>
    <column name="volume" type="DOUBLE"></column>
    <column name="tracking" type="BOOLEAN"></column>
    <column name="description_sale" type="TEXT"></column>
    <column name="procure_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="cost_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="rental" type="BOOLEAN"></column>
    <column name="sale_delay" type="DOUBLE"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="produce_delay" type="DOUBLE"></column>
    <column name="purchase_ok" type="BOOLEAN"></column>
  </table>
  <table name="product_ul" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="product_uom" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="rounding" type="NUMERIC(16,3)" notnull="true"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="category_id" type="INTEGER" notnull="true" fkey="product_uom_categ(id)" opt="odc"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="factor" type="DOUBLE" notnull="true"></column>
  </table>
  <table name="product_uom_categ" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="purchase_order" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="partner_address_id" type="INTEGER" notnull="true" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="date_order" type="DATE" notnull="true"></column>
    <column name="partner_id" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odsn"></column>
    <column name="invoiced" type="BOOLEAN"></column>
    <column name="dest_address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="location_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="pricelist_id" type="INTEGER" notnull="true" fkey="product_pricelist(id)" opt="odsn"></column>
    <column name="project_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="ref" type="VARCHAR(64)"></column>
    <column name="warehouse_id" type="INTEGER" fkey="stock_warehouse(id)" opt="odsn"></column>
    <column name="partner_ref" type="VARCHAR(64)"></column>
    <column name="date_approve" type="DATE"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="invoice_id" type="INTEGER" fkey="account_invoice(id)" opt="odsn"></column>
    <column name="notes" type="TEXT"></column>
    <column name="invoice_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="shipped" type="BOOLEAN"></column>
    <column name="validator" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="picking_id" type="INTEGER" fkey="stock_picking(id)" opt="odsn"></column>
  </table>
  <table name="purchase_order_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" fkey="product_product(id)" opt="odsn"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="date_planned" type="DATE" notnull="true"></column>
    <column name="order_id" type="INTEGER" fkey="purchase_order(id)" opt="odsn"></column>
    <column name="price_unit" type="DOUBLE" notnull="true"></column>
    <column name="move_dest_id" type="INTEGER" fkey="stock_move(id)" opt="odsn"></column>
    <column name="product_qty" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="notes" type="TEXT"></column>
    <column name="move_id" type="INTEGER" fkey="stock_move(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="purchase_order_taxe" label="">
    <column name="ord_id" type="INTEGER" notnull="true" fkey="purchase_order_line(id)" opt="odc"></column>
    <column name="tax_id" type="INTEGER" notnull="true" fkey="account_tax(id)" opt="odc"></column>
  </table>
  <table name="res_company" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="rml_footer1" type="VARCHAR(200)"></column>
    <column name="rml_footer2" type="VARCHAR(200)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="currency_id" type="INTEGER" notnull="true" fkey="res_currency(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
    <column name="rml_header1" type="VARCHAR(200)"></column>
    <column name="partner_id" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odsn"></column>
  </table>
  <table name="res_country" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(2)"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="res_country_state" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(2)"></column>
    <column name="country_id" type="INTEGER" fkey="res_country(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="res_currency" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(3)"></column>
    <column name="name" type="VARCHAR(32)" notnull="true"></column>
    <column name="rounding" type="DOUBLE"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="rate" type="NUMERIC(12,6)"></column>
    <column name="date" type="DATE"></column>
    <column name="accuracy" type="INTEGER"></column>
  </table>
  <table name="res_groups" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="res_groups_users_rel" label="">
    <column name="uid" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odc"></column>
    <column name="gid" type="INTEGER" notnull="true" fkey="res_groups(id)" opt="odc"></column>
  </table>
  <table name="res_lang" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="code" type="VARCHAR(5)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="translatable" type="BOOLEAN"></column>
  </table>
  <table name="res_partner" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="lang" type="VARCHAR(5)"></column>
    <column name="website" type="VARCHAR(64)"></column>
    <column name="credit_limit" type="DOUBLE"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="title" type="VARCHAR(32)"></column>
    <column name="responsible" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="comment" type="TEXT"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="parent_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="ean13" type="VARCHAR(13)"></column>
    <column name="date" type="DATE"></column>
    <column name="ref" type="VARCHAR(64)"></column>
    <column name="vat" type="VARCHAR(32)"></column>
    <column name="debit_limit" type="DOUBLE"></column>
  </table>
  <table name="res_partner_address" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="function" type="INTEGER" fkey="res_partner_function(id)" opt="odsn"></column>
    <column name="city" type="VARCHAR(128)"></column>
    <column name="fax" type="VARCHAR(64)"></column>
    <column name="name" type="VARCHAR(64)"></column>
    <column name="zip" type="VARCHAR(24)"></column>
    <column name="title" type="VARCHAR(32)"></column>
    <column name="mobile" type="VARCHAR(64)"></column>
    <column name="partner_id" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odc"></column>
    <column name="street2" type="VARCHAR(128)"></column>
    <column name="country_id" type="INTEGER" fkey="res_country(id)" opt="odsn"></column>
    <column name="birthdate" type="VARCHAR(64)"></column>
    <column name="phone" type="VARCHAR(64)"></column>
    <column name="street" type="VARCHAR(128)"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="state_id" type="INTEGER" fkey="res_country_state(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)"></column>
    <column name="email" type="VARCHAR(64)"></column>
  </table>
  <table name="res_partner_bank" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="bank_name" type="VARCHAR(64)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="partner_id" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odc"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="iban" type="VARCHAR(64)"></column>
    <column name="bank_guichet" type="VARCHAR(64)"></column>
    <column name="swift" type="VARCHAR(64)"></column>
  </table>
  <table name="res_partner_canal" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="res_partner_category" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="type_id" type="INTEGER" fkey="res_partner_category_type(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="res_partner_category(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
  </table>
  <table name="res_partner_category_rel" label="">
    <column name="partner_id" type="INTEGER" notnull="true" fkey="res_partner(id)" opt="odc"></column>
    <column name="category_id" type="INTEGER" notnull="true" fkey="res_partner_category(id)" opt="odc"></column>
  </table>
  <table name="res_partner_category_type" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="res_partner_event" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="probability" type="DOUBLE"></column>
    <column name="canal_id" type="INTEGER" fkey="res_partner_canal(id)" opt="odsn"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="planned_cost" type="DOUBLE"></column>
    <column name="som" type="INTEGER" fkey="res_partner_som(id)" opt="odsn"></column>
    <column name="partner_type" type="VARCHAR(16)"></column>
    <column name="type" type="VARCHAR(16)"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="document" type="VARCHAR(128)"></column>
    <column name="planned_revenue" type="DOUBLE"></column>
    <column name="event_ical_id" type="VARCHAR(64)"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="res_partner_event_type" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="key" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="res_partner_function" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="code" type="VARCHAR(8)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="res_partner_som" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="factor" type="DOUBLE" notnull="true"></column>
  </table>
  <table name="res_partner_title" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="domain" type="VARCHAR(16)" notnull="true"></column>
    <column name="name" type="VARCHAR(46)" notnull="true"></column>
    <column name="shortcut" type="VARCHAR(16)" notnull="true"></column>
  </table>
  <table name="res_payterm" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="res_request" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="body" type="TEXT"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="ref_doc1" type="VARCHAR(128)"></column>
    <column name="state" type="VARCHAR(16)" notnull="true"></column>
    <column name="priority" type="VARCHAR(16)" notnull="true"></column>
    <column name="date_sent" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="ref_doc2" type="VARCHAR(128)"></column>
    <column name="act_from" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odsn"></column>
    <column name="ref_partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="trigger_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="act_to" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odsn"></column>
  </table>
  <table name="res_request_history" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="body" type="TEXT"></column>
    <column name="name" type="VARCHAR(128)" notnull="true"></column>
    <column name="act_from" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odsn"></column>
    <column name="req_id" type="INTEGER" notnull="true" fkey="res_request(id)" opt="odc"></column>
    <column name="date_sent" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="act_to" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odsn"></column>
  </table>
  <table name="res_request_link" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="priority" type="INTEGER"></column>
    <column name="object" type="VARCHAR(64)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="res_roles" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="parent_id" type="INTEGER" fkey="res_roles(id)" opt="odsn"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)"></column>
  </table>
  <table name="res_roles_users_rel" label="">
    <column name="uid" type="INTEGER" notnull="true" fkey="res_users(id)" opt="odc"></column>
    <column name="rid" type="INTEGER" notnull="true" fkey="res_roles(id)" opt="odc"></column>
  </table>
  <table name="res_users" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="active" type="BOOLEAN" default="true"></column>
    <column name="login" type="VARCHAR(64)" notnull="true"></column>
    <column name="perm_default" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="action_id" type="INTEGER"></column>
    <column name="address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="company_id" type="INTEGER" fkey="res_company(id)" opt="odsn"></column>
    <column name="signature" type="TEXT"></column>
    <column name="password" type="VARCHAR(64)"></column>
  </table>
  <table name="sale_order" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="picking_policy" type="VARCHAR(16)" notnull="true"></column>
    <column name="order_policy" type="VARCHAR(16)" notnull="true"></column>
    <column name="shop_id" type="INTEGER" notnull="true" fkey="sale_shop(id)" opt="odsn"></column>
    <column name="client_order_ref" type="VARCHAR(64)"></column>
    <column name="date_order" type="DATE" notnull="true"></column>
    <column name="partner_id" type="INTEGER" fkey="res_partner(id)" opt="odsn"></column>
    <column name="invoiced" type="BOOLEAN"></column>
    <column name="user_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="note" type="TEXT"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="pricelist_id" type="INTEGER" notnull="true" fkey="product_pricelist(id)" opt="odsn"></column>
    <column name="project_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="incoterm" type="VARCHAR(3)"></column>
    <column name="partner_order_id" type="INTEGER" notnull="true" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="partner_invoice_id" type="INTEGER" notnull="true" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="partner_shipping_id" type="INTEGER" notnull="true" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="shipped" type="BOOLEAN"></column>
    <column name="invoice_quantity" type="VARCHAR(16)"></column>
    <column name="carrier_id" type="INTEGER" fkey="delivery_carrier(id)" opt="odsn"></column>
  </table>
  <table name="sale_order_invoice_rel" label="">
    <column name="order_id" type="INTEGER" notnull="true" fkey="sale_order(id)" opt="odc"></column>
    <column name="invoice_id" type="INTEGER" notnull="true" fkey="account_invoice(id)" opt="odc"></column>
  </table>
  <table name="sale_order_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="product_uos_qty" type="DOUBLE"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="sequence" type="INTEGER"></column>
    <column name="price_unit" type="DOUBLE" notnull="true"></column>
    <column name="product_uom_qty" type="NUMERIC(16,2)" notnull="true"></column>
    <column name="product_uos" type="INTEGER" fkey="product_uom(id)" opt="odsn"></column>
    <column name="invoiced" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(256)" notnull="true"></column>
    <column name="price_unit_customer" type="DOUBLE"></column>
    <column name="state" type="VARCHAR(16)" notnull="true"></column>
    <column name="product_packaging" type="INTEGER" fkey="product_packaging(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="procurement_id" type="INTEGER" fkey="mrp_procurement(id)" opt="odsn"></column>
    <column name="order_id" type="INTEGER" notnull="true" fkey="sale_order(id)" opt="odc"></column>
    <column name="discount" type="NUMERIC(16,2)"></column>
    <column name="product_id" type="INTEGER" fkey="product_product(id)" opt="odsn"></column>
    <column name="date_planned" type="DATE" notnull="true"></column>
    <column name="notes" type="TEXT"></column>
    <column name="th_weight" type="DOUBLE"></column>
    <column name="address_allotment_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
  </table>
  <table name="sale_order_line_invoice_rel" label="">
    <column name="order_line_id" type="INTEGER" notnull="true" fkey="sale_order_line(id)" opt="odc"></column>
    <column name="invoice_id" type="INTEGER" notnull="true" fkey="account_invoice_line(id)" opt="odc"></column>
  </table>
  <table name="sale_order_line_property_rel" label="">
    <column name="order_id" type="INTEGER" notnull="true" fkey="sale_order_line(id)" opt="odc"></column>
    <column name="property_id" type="INTEGER" notnull="true" fkey="mrp_property(id)" opt="odc"></column>
  </table>
  <table name="sale_order_payment" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="order_id" type="INTEGER" fkey="sale_order(id)" opt="odsn"></column>
    <column name="amount" type="DOUBLE" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="account_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="sale_order_tax" label="">
    <column name="order_line_id" type="INTEGER" notnull="true" fkey="sale_order_line(id)" opt="odc"></column>
    <column name="tax_id" type="INTEGER" notnull="true" fkey="account_tax(id)" opt="odc"></column>
  </table>
  <table name="sale_shop" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="warehouse_id" type="INTEGER" fkey="stock_warehouse(id)" opt="odsn"></column>
    <column name="pricelist_id" type="INTEGER" fkey="product_pricelist(id)" opt="odsn"></column>
    <column name="project_id" type="INTEGER" fkey="account_analytic_account(id)" opt="odsn"></column>
    <column name="payment_default_id" type="INTEGER" notnull="true" fkey="account_payment_term(id)" opt="odsn"></column>
  </table>
  <table name="sale_shop_account" label="">
    <column name="shop_id" type="INTEGER" notnull="true" fkey="sale_shop(id)" opt="odc"></column>
    <column name="account_id" type="INTEGER" notnull="true" fkey="account_account(id)" opt="odc"></column>
  </table>
  <table name="stock_incoterms" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="code" type="VARCHAR(3)" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="stock_inventory" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_done" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
  </table>
  <table name="stock_inventory_line" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="inventory_id" type="INTEGER" fkey="stock_inventory(id)" opt="odc"></column>
    <column name="location_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="product_qty" type="DOUBLE"></column>
  </table>
  <table name="stock_inventory_move_rel" label="">
    <column name="inventory_id" type="INTEGER" notnull="true" fkey="stock_inventory(id)" opt="odc"></column>
    <column name="move_id" type="INTEGER" notnull="true" fkey="stock_move(id)" opt="odc"></column>
  </table>
  <table name="stock_location" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="comment" type="TEXT"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="posy" type="INTEGER" notnull="true"></column>
    <column name="usage" type="VARCHAR(16)"></column>
    <column name="posz" type="INTEGER" notnull="true"></column>
    <column name="posx" type="INTEGER" notnull="true"></column>
    <column name="allocation_method" type="VARCHAR(16)" notnull="true"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="location_id" type="INTEGER" fkey="stock_location(id)" opt="odsn"></column>
    <column name="account_id" type="INTEGER" fkey="account_account(id)" opt="odsn"></column>
  </table>
  <table name="stock_lot" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="tracking" type="VARCHAR(64)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="stock_move" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="product_uos_qty" type="DOUBLE"></column>
    <column name="address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="product_qty" type="DOUBLE" notnull="true"></column>
    <column name="product_uos" type="INTEGER" fkey="product_uom(id)" opt="odsn"></column>
    <column name="lot_id" type="INTEGER" fkey="stock_lot(id)" opt="odsn"></column>
    <column name="location_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="priority" type="VARCHAR(16)"></column>
    <column name="note" type="TEXT"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="product_packaging" type="INTEGER" fkey="product_packaging(id)" opt="odsn"></column>
    <column name="prodlot_id" type="INTEGER" fkey="stock_production_lot(id)" opt="odsn"></column>
    <column name="move_dest_id" type="INTEGER" fkey="stock_move(id)" opt="odsn"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
    <column name="date_planned" type="DATE" notnull="true"></column>
    <column name="location_dest_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="tracking_id" type="INTEGER" fkey="stock_tracking(id)" opt="odsn"></column>
    <column name="picking_id" type="INTEGER" fkey="stock_picking(id)" opt="odsn"></column>
    <column name="production_id" type="INTEGER" fkey="mrp_production(id)" opt="odsn"></column>
    <column name="sale_line_id" type="INTEGER" fkey="sale_order_line(id)" opt="odsn"></column>
  </table>
  <table name="stock_move_history_ids" label="">
    <column name="parent_id" type="INTEGER" notnull="true" fkey="stock_move(id)" opt="odc"></column>
    <column name="child_id" type="INTEGER" notnull="true" fkey="stock_move(id)" opt="odc"></column>
  </table>
  <table name="stock_move_lot" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date_planned" type="DATE"></column>
    <column name="date_moved" type="DATE"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="loc_dest_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="lot_id" type="INTEGER" notnull="true" fkey="stock_lot(id)" opt="odsn"></column>
    <column name="serial" type="VARCHAR(32)"></column>
  </table>
  <table name="stock_picking" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="origin" type="VARCHAR(64)"></column>
    <column name="address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="work" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="lot_id" type="INTEGER" fkey="stock_lot(id)" opt="odsn"></column>
    <column name="type" type="VARCHAR(16)" notnull="true"></column>
    <column name="move_type" type="VARCHAR(16)" notnull="true"></column>
    <column name="invoice_state" type="VARCHAR(16)"></column>
    <column name="note" type="TEXT"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="state" type="VARCHAR(16)"></column>
    <column name="location_dest_id" type="INTEGER" fkey="stock_location(id)" opt="odsn"></column>
    <column name="auto_picking" type="BOOLEAN"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="loc_move_id" type="INTEGER" fkey="stock_location(id)" opt="odsn"></column>
    <column name="move_lot_id" type="INTEGER" fkey="stock_move_lot(id)" opt="odsn"></column>
    <column name="location_id" type="INTEGER" fkey="stock_location(id)" opt="odsn"></column>
    <column name="sale_id" type="INTEGER" fkey="sale_order(id)" opt="odsn"></column>
    <column name="weight" type="DOUBLE"></column>
    <column name="carrier_id" type="INTEGER" fkey="delivery_carrier(id)" opt="odsn"></column>
    <column name="volume" type="DOUBLE"></column>
  </table>
  <table name="stock_production_lot" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="ref" type="VARCHAR(64)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="stock_production_lot_revision" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="indice" type="VARCHAR(16)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="date" type="DATE"></column>
    <column name="lot_id" type="INTEGER" fkey="stock_production_lot(id)" opt="odsn"></column>
    <column name="author_id" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="description" type="TEXT"></column>
  </table>
  <table name="stock_tracking" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="serial" type="VARCHAR(64)"></column>
    <column name="date" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
  </table>
  <table name="stock_warehouse" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="lot_input_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="partner_address_id" type="INTEGER" fkey="res_partner_address(id)" opt="odsn"></column>
    <column name="lot_output_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(60)" notnull="true"></column>
    <column name="lot_stock_id" type="INTEGER" notnull="true" fkey="stock_location(id)" opt="odsn"></column>
  </table>
  <table name="stock_warehouse_orderpoint" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="create_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="create_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_date" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="write_uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="product_max_qty" type="DOUBLE" notnull="true"></column>
    <column name="product_min_qty" type="DOUBLE" notnull="true"></column>
    <column name="qty_multiple" type="INTEGER" notnull="true"></column>
    <column name="procurement_id" type="INTEGER" fkey="mrp_procurement(id)" opt="odsn"></column>
    <column name="product_id" type="INTEGER" notnull="true" fkey="product_product(id)" opt="odsn"></column>
    <column name="product_uom" type="INTEGER" notnull="true" fkey="product_uom(id)" opt="odsn"></column>
    <column name="warehouse_id" type="INTEGER" notnull="true" fkey="stock_warehouse(id)" opt="odsn"></column>
    <column name="logic" type="VARCHAR(16)" notnull="true"></column>
    <column name="active" type="BOOLEAN"></column>
    <column name="name" type="VARCHAR(32)" notnull="true"></column>
  </table>
  <table name="wkf" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="osv" type="VARCHAR(64)" notnull="true"></column>
    <column name="on_create" type="BOOLEAN" default="false"></column>
  </table>
  <table name="wkf_activity" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="wkf_id" type="INTEGER" notnull="true" fkey="wkf(id)" opt="odc"></column>
    <column name="subflow_id" type="INTEGER" fkey="wkf(id)" opt="odsn"></column>
    <column name="split_mode" type="VARCHAR(3)" notnull="true" default="'XOR'::character varying"></column>
    <column name="join_mode" type="VARCHAR(3)" notnull="true" default="'XOR'::character varying"></column>
    <column name="kind" type="VARCHAR(16)" notnull="true" default="'dummy'::character varying"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="signal_send" type="VARCHAR(32)"></column>
    <column name="flow_start" type="BOOLEAN" default="false"></column>
    <column name="flow_stop" type="BOOLEAN" default="false"></column>
    <column name="action" type="VARCHAR(64)"></column>
  </table>
  <table name="wkf_instance" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wkf_id" type="INTEGER" fkey="wkf(id)" opt="odsn"></column>
    <column name="uid" type="INTEGER"></column>
    <column name="res_id" type="INTEGER"></column>
    <column name="res_type" type="VARCHAR(64)"></column>
    <column name="state" type="VARCHAR(32)" default="'active'::character varying"></column>
  </table>
  <table name="wkf_logs" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="res_type" type="VARCHAR(128)" notnull="true"></column>
    <column name="res_id" type="INTEGER" notnull="true"></column>
    <column name="uid" type="INTEGER" fkey="res_users(id)" opt="odsn"></column>
    <column name="act_id" type="INTEGER" fkey="wkf_activity(id)" opt="odsn"></column>
    <column name="time" type="TIME WITHOUT TIME ZONE" notnull="true"></column>
    <column name="info" type="VARCHAR(128)"></column>
  </table>
  <table name="wkf_transition" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER" fkey="perm(id)" opt="odsn"></column>
    <column name="act_from" type="INTEGER" notnull="true" fkey="wkf_activity(id)" opt="odc"></column>
    <column name="act_to" type="INTEGER" notnull="true" fkey="wkf_activity(id)" opt="odc"></column>
    <column name="condition" type="VARCHAR(128)" notnull="true"></column>
    <column name="trigger_type" type="VARCHAR(128)"></column>
    <column name="trigger_expr_id" type="VARCHAR(128)"></column>
    <column name="signal" type="VARCHAR(64)"></column>
    <column name="role_id" type="INTEGER" fkey="res_roles(id)" opt="odsn"></column>
    <column name="trigger_model" type="VARCHAR(128)"></column>
  </table>
  <table name="wkf_triggers" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="perm_id" type="INTEGER"></column>
    <column name="instance_id" type="INTEGER" fkey="wkf_instance(id)" opt="odc"></column>
    <column name="workitem_id" type="INTEGER" notnull="true" fkey="wkf_workitem(id)" opt="odc"></column>
    <column name="model" type="VARCHAR(128)"></column>
    <column name="res_id" type="INTEGER"></column>
  </table>
  <table name="wkf_witm_trans" label="">
    <column name="trans_id" type="INTEGER" notnull="true" fkey="wkf_transition(id)" opt="odc"></column>
    <column name="inst_id" type="INTEGER" notnull="true" fkey="wkf_instance(id)" opt="odc"></column>
  </table>
  <table name="wkf_workitem" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="act_id" type="INTEGER" notnull="true" fkey="wkf_activity(id)" opt="odc"></column>
    <column name="inst_id" type="INTEGER" notnull="true" fkey="wkf_instance(id)" opt="odc"></column>
    <column name="subflow_id" type="INTEGER" fkey="wkf_instance(id)" opt="odc"></column>
    <column name="state" type="VARCHAR(64)" default="'blocked'::character varying"></column>
  </table>
</analysis>
