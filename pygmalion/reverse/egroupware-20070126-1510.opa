<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet ?><analysis name="" table="" view="">
  <table name="egw_access_log" label="">
    <column name="sessionid" type="VARCHAR(128)" notnull="true"></column>
    <column name="loginid" type="VARCHAR(64)" notnull="true"></column>
    <column name="ip" type="VARCHAR(40)" notnull="true"></column>
    <column name="li" type="INTEGER" notnull="true"></column>
    <column name="lo" type="INTEGER" default="0"></column>
    <column name="account_id" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="egw_accounts" label="">
    <column name="account_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="account_lid" type="VARCHAR(64)" notnull="true"></column>
    <column name="account_pwd" type="VARCHAR(100)" notnull="true"></column>
    <column name="account_firstname" type="VARCHAR(50)"></column>
    <column name="account_lastname" type="VARCHAR(50)"></column>
    <column name="account_lastlogin" type="INTEGER"></column>
    <column name="account_lastloginfrom" type="VARCHAR(255)"></column>
    <column name="account_lastpwd_change" type="INTEGER"></column>
    <column name="account_status" type="VARCHAR(1)" notnull="true" default="'A'::character varying"></column>
    <column name="account_expires" type="INTEGER"></column>
    <column name="account_type" type="VARCHAR(1)"></column>
    <column name="person_id" type="INTEGER"></column>
    <column name="account_primary_group" type="INTEGER" notnull="true" default="0"></column>
    <column name="account_email" type="VARCHAR(100)"></column>
    <column name="account_challenge" type="VARCHAR(100)"></column>
    <column name="account_response" type="VARCHAR(100)"></column>
  </table>
  <table name="egw_acl" label="">
    <column name="acl_appname" type="VARCHAR(50)" notnull="true"></column>
    <column name="acl_location" type="VARCHAR(255)" notnull="true"></column>
    <column name="acl_account" type="INTEGER" notnull="true"></column>
    <column name="acl_rights" type="INTEGER"></column>
  </table>
  <table name="egw_addressbook" label="">
    <column name="id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="lid" type="VARCHAR(32)"></column>
    <column name="tid" type="VARCHAR(1)"></column>
    <column name="owner" type="BIGINT"></column>
    <column name="access" type="VARCHAR(7)"></column>
    <column name="cat_id" type="VARCHAR(32)"></column>
    <column name="fn" type="VARCHAR(64)"></column>
    <column name="n_family" type="VARCHAR(64)"></column>
    <column name="n_given" type="VARCHAR(64)"></column>
    <column name="n_middle" type="VARCHAR(64)"></column>
    <column name="n_prefix" type="VARCHAR(64)"></column>
    <column name="n_suffix" type="VARCHAR(64)"></column>
    <column name="sound" type="VARCHAR(64)"></column>
    <column name="bday" type="VARCHAR(32)"></column>
    <column name="note" type="TEXT"></column>
    <column name="tz" type="VARCHAR(8)"></column>
    <column name="geo" type="VARCHAR(32)"></column>
    <column name="url" type="VARCHAR(128)"></column>
    <column name="pubkey" type="TEXT"></column>
    <column name="org_name" type="VARCHAR(64)"></column>
    <column name="org_unit" type="VARCHAR(64)"></column>
    <column name="title" type="VARCHAR(64)"></column>
    <column name="adr_one_street" type="VARCHAR(64)"></column>
    <column name="adr_one_locality" type="VARCHAR(64)"></column>
    <column name="adr_one_region" type="VARCHAR(64)"></column>
    <column name="adr_one_postalcode" type="VARCHAR(64)"></column>
    <column name="adr_one_countryname" type="VARCHAR(64)"></column>
    <column name="adr_one_type" type="VARCHAR(32)"></column>
    <column name="label" type="TEXT"></column>
    <column name="adr_two_street" type="VARCHAR(64)"></column>
    <column name="adr_two_locality" type="VARCHAR(64)"></column>
    <column name="adr_two_region" type="VARCHAR(64)"></column>
    <column name="adr_two_postalcode" type="VARCHAR(64)"></column>
    <column name="adr_two_countryname" type="VARCHAR(64)"></column>
    <column name="adr_two_type" type="VARCHAR(32)"></column>
    <column name="tel_work" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_home" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_voice" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_fax" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_msg" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_cell" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_pager" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_bbs" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_modem" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_car" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_isdn" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_video" type="VARCHAR(40)" notnull="true" default="'+1 (000) 000-0000'::character varying"></column>
    <column name="tel_prefer" type="VARCHAR(32)"></column>
    <column name="email" type="VARCHAR(64)"></column>
    <column name="email_type" type="VARCHAR(32)" default="'INTERNET'::character varying"></column>
    <column name="email_home" type="VARCHAR(64)"></column>
    <column name="email_home_type" type="VARCHAR(32)" default="'INTERNET'::character varying"></column>
    <column name="last_mod" type="BIGINT" notnull="true"></column>
  </table>
  <table name="egw_addressbook_extra" label="">
    <column name="contact_id" type="INTEGER" notnull="true"></column>
    <column name="contact_owner" type="BIGINT"></column>
    <column name="contact_name" type="VARCHAR(255)" notnull="true"></column>
    <column name="contact_value" type="TEXT"></column>
  </table>
  <table name="egw_api_content_history" label="">
    <column name="sync_appname" type="VARCHAR(60)" notnull="true"></column>
    <column name="sync_contentid" type="VARCHAR(60)" notnull="true"></column>
    <column name="sync_added" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="sync_modified" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="sync_deleted" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="sync_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="sync_guid" type="VARCHAR(120)" notnull="true"></column>
    <column name="sync_changedby" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_app_sessions" label="">
    <column name="sessionid" type="VARCHAR(128)" notnull="true"></column>
    <column name="loginid" type="INTEGER" notnull="true"></column>
    <column name="app" type="VARCHAR(25)" notnull="true"></column>
    <column name="location" type="VARCHAR(128)" notnull="true"></column>
    <column name="content" type="TEXT"></column>
    <column name="session_dla" type="BIGINT"></column>
  </table>
  <table name="egw_applications" label="">
    <column name="app_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="app_name" type="VARCHAR(25)" notnull="true"></column>
    <column name="app_enabled" type="INTEGER" notnull="true"></column>
    <column name="app_order" type="INTEGER" notnull="true"></column>
    <column name="app_tables" type="TEXT"></column>
    <column name="app_version" type="VARCHAR(20)" notnull="true" default="'0.0'::character varying"></column>
  </table>
  <table name="egw_async" label="">
    <column name="async_id" type="VARCHAR(255)" notnull="true" pkey="true"></column>
    <column name="async_next" type="INTEGER" notnull="true"></column>
    <column name="async_times" type="VARCHAR(255)" notnull="true"></column>
    <column name="async_method" type="VARCHAR(80)" notnull="true"></column>
    <column name="async_data" type="TEXT"></column>
    <column name="async_account_id" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="egw_bookmarks" label="">
    <column name="bm_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="bm_owner" type="INTEGER"></column>
    <column name="bm_access" type="VARCHAR(255)"></column>
    <column name="bm_url" type="VARCHAR(255)"></column>
    <column name="bm_name" type="VARCHAR(255)"></column>
    <column name="bm_desc" type="TEXT"></column>
    <column name="bm_keywords" type="VARCHAR(255)"></column>
    <column name="bm_category" type="INTEGER"></column>
    <column name="bm_rating" type="INTEGER"></column>
    <column name="bm_info" type="VARCHAR(255)"></column>
    <column name="bm_visits" type="INTEGER"></column>
  </table>
  <table name="egw_cal" label="">
    <column name="cal_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="cal_uid" type="VARCHAR(255)" notnull="true"></column>
    <column name="cal_owner" type="INTEGER" notnull="true"></column>
    <column name="cal_category" type="VARCHAR(30)"></column>
    <column name="cal_modified" type="BIGINT"></column>
    <column name="cal_priority" type="SMALLINT" notnull="true" default="2"></column>
    <column name="cal_public" type="SMALLINT" notnull="true" default="1"></column>
    <column name="cal_title" type="VARCHAR(255)" notnull="true" default="'1'::character varying"></column>
    <column name="cal_description" type="TEXT"></column>
    <column name="cal_location" type="VARCHAR(255)"></column>
    <column name="cal_reference" type="INTEGER" notnull="true" default="0"></column>
    <column name="cal_modifier" type="INTEGER"></column>
    <column name="cal_non_blocking" type="SMALLINT" default="0"></column>
  </table>
  <table name="egw_cal_dates" label="">
    <column name="cal_id" type="INTEGER" notnull="true"></column>
    <column name="cal_start" type="BIGINT" notnull="true"></column>
    <column name="cal_end" type="BIGINT" notnull="true"></column>
  </table>
  <table name="egw_cal_extra" label="">
    <column name="cal_id" type="INTEGER" notnull="true"></column>
    <column name="cal_extra_name" type="VARCHAR(40)" notnull="true"></column>
    <column name="cal_extra_value" type="VARCHAR(255)" notnull="true" default="''::character varying"></column>
  </table>
  <table name="egw_cal_holidays" label="">
    <column name="hol_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="hol_locale" type="VARCHAR(2)" notnull="true"></column>
    <column name="hol_name" type="VARCHAR(50)" notnull="true"></column>
    <column name="hol_mday" type="BIGINT" notnull="true" default="0"></column>
    <column name="hol_month_num" type="BIGINT" notnull="true" default="0"></column>
    <column name="hol_occurence" type="BIGINT" notnull="true" default="0"></column>
    <column name="hol_dow" type="BIGINT" notnull="true" default="0"></column>
    <column name="hol_observance_rule" type="BIGINT" notnull="true" default="0"></column>
  </table>
  <table name="egw_cal_repeats" label="">
    <column name="cal_id" type="INTEGER" notnull="true" pkey="true"></column>
    <column name="recur_type" type="SMALLINT" notnull="true"></column>
    <column name="recur_enddate" type="BIGINT"></column>
    <column name="recur_interval" type="SMALLINT" default="1"></column>
    <column name="recur_data" type="SMALLINT" default="1"></column>
    <column name="recur_exception" type="TEXT"></column>
  </table>
  <table name="egw_cal_user" label="">
    <column name="cal_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="cal_recur_date" type="BIGINT" notnull="true" default="0"></column>
    <column name="cal_user_type" type="VARCHAR(1)" notnull="true" default="'u'::character varying"></column>
    <column name="cal_user_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="cal_status" type="VARCHAR(1)" default="'A'::character varying"></column>
    <column name="cal_quantity" type="INTEGER" default="1"></column>
  </table>
  <table name="egw_categories" label="">
    <column name="cat_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="cat_main" type="INTEGER" notnull="true" default="0"></column>
    <column name="cat_parent" type="INTEGER" notnull="true" default="0"></column>
    <column name="cat_level" type="SMALLINT" notnull="true" default="0"></column>
    <column name="cat_owner" type="INTEGER" notnull="true" default="0"></column>
    <column name="cat_access" type="VARCHAR(7)"></column>
    <column name="cat_appname" type="VARCHAR(50)" notnull="true"></column>
    <column name="cat_name" type="VARCHAR(150)" notnull="true"></column>
    <column name="cat_description" type="VARCHAR(255)" notnull="true"></column>
    <column name="cat_data" type="TEXT"></column>
    <column name="last_mod" type="BIGINT" notnull="true"></column>
  </table>
  <table name="egw_config" label="">
    <column name="config_app" type="VARCHAR(50)" notnull="true"></column>
    <column name="config_name" type="VARCHAR(255)" notnull="true"></column>
    <column name="config_value" type="TEXT"></column>
  </table>
  <table name="egw_contentmap" label="">
    <column name="map_id" type="VARCHAR(128)" notnull="true"></column>
    <column name="map_guid" type="VARCHAR(100)" notnull="true"></column>
    <column name="map_locuid" type="VARCHAR(100)" notnull="true"></column>
    <column name="map_timestamp" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="map_expired" type="BOOLEAN" notnull="true"></column>
  </table>
  <table name="egw_emailadmin" label="">
    <column name="ea_profile_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="ea_smtp_server" type="VARCHAR(80)"></column>
    <column name="ea_smtp_type" type="INTEGER"></column>
    <column name="ea_smtp_port" type="INTEGER"></column>
    <column name="ea_smtp_auth" type="VARCHAR(3)"></column>
    <column name="ea_editforwardingaddress" type="VARCHAR(3)"></column>
    <column name="ea_smtp_ldap_server" type="VARCHAR(80)"></column>
    <column name="ea_smtp_ldap_basedn" type="VARCHAR(200)"></column>
    <column name="ea_smtp_ldap_admindn" type="VARCHAR(200)"></column>
    <column name="ea_smtp_ldap_adminpw" type="VARCHAR(30)"></column>
    <column name="ea_smtp_ldap_use_default" type="VARCHAR(3)"></column>
    <column name="ea_imap_server" type="VARCHAR(80)"></column>
    <column name="ea_imap_type" type="INTEGER"></column>
    <column name="ea_imap_port" type="INTEGER"></column>
    <column name="ea_imap_login_type" type="VARCHAR(20)"></column>
    <column name="ea_imap_tsl_auth" type="VARCHAR(3)"></column>
    <column name="ea_imap_tsl_encryption" type="VARCHAR(3)"></column>
    <column name="ea_imap_enable_cyrus" type="VARCHAR(3)"></column>
    <column name="ea_imap_admin_user" type="VARCHAR(40)"></column>
    <column name="ea_imap_admin_pw" type="VARCHAR(40)"></column>
    <column name="ea_imap_enable_sieve" type="VARCHAR(3)"></column>
    <column name="ea_imap_sieve_server" type="VARCHAR(80)"></column>
    <column name="ea_imap_sieve_port" type="INTEGER"></column>
    <column name="ea_description" type="VARCHAR(200)"></column>
    <column name="ea_default_domain" type="VARCHAR(100)"></column>
    <column name="ea_organisation_name" type="VARCHAR(100)"></column>
    <column name="ea_user_defined_accounts" type="VARCHAR(3)"></column>
    <column name="ea_imapoldcclient" type="VARCHAR(3)"></column>
    <column name="ea_order" type="INTEGER"></column>
    <column name="ea_appname" type="VARCHAR(80)"></column>
    <column name="ea_group" type="VARCHAR(80)"></column>
  </table>
  <table name="egw_etemplate" label="">
    <column name="et_name" type="VARCHAR(80)" notnull="true"></column>
    <column name="et_template" type="VARCHAR(20)" notnull="true" default="''::character varying"></column>
    <column name="et_lang" type="VARCHAR(5)" notnull="true" default="''::character varying"></column>
    <column name="et_group" type="INTEGER" notnull="true" default="0"></column>
    <column name="et_version" type="VARCHAR(20)" notnull="true" default="''::character varying"></column>
    <column name="et_data" type="TEXT"></column>
    <column name="et_size" type="VARCHAR(128)"></column>
    <column name="et_style" type="TEXT"></column>
    <column name="et_modified" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="egw_felamimail_cache" label="">
    <column name="fmail_accountid" type="INTEGER" notnull="true"></column>
    <column name="fmail_hostname" type="VARCHAR(60)" notnull="true"></column>
    <column name="fmail_accountname" type="VARCHAR(128)" notnull="true"></column>
    <column name="fmail_foldername" type="VARCHAR(128)" notnull="true"></column>
    <column name="fmail_uid" type="INTEGER" notnull="true"></column>
    <column name="fmail_subject" type="TEXT"></column>
    <column name="fmail_striped_subject" type="TEXT"></column>
    <column name="fmail_sender_name" type="VARCHAR(120)"></column>
    <column name="fmail_sender_address" type="VARCHAR(120)"></column>
    <column name="fmail_to_name" type="VARCHAR(120)"></column>
    <column name="fmail_to_address" type="VARCHAR(120)"></column>
    <column name="fmail_date" type="BIGINT"></column>
    <column name="fmail_size" type="INTEGER"></column>
    <column name="fmail_attachments" type="VARCHAR(120)"></column>
  </table>
  <table name="egw_felamimail_displayfilter" label="">
    <column name="fmail_filter_accountid" type="INTEGER" notnull="true" pkey="true"></column>
    <column name="fmail_filter_data" type="TEXT"></column>
  </table>
  <table name="egw_felamimail_folderstatus" label="">
    <column name="fmail_accountid" type="INTEGER" notnull="true"></column>
    <column name="fmail_hostname" type="VARCHAR(60)" notnull="true"></column>
    <column name="fmail_accountname" type="VARCHAR(128)" notnull="true"></column>
    <column name="fmail_foldername" type="VARCHAR(128)" notnull="true"></column>
    <column name="fmail_messages" type="INTEGER"></column>
    <column name="fmail_recent" type="INTEGER"></column>
    <column name="fmail_unseen" type="INTEGER"></column>
    <column name="fmail_uidnext" type="INTEGER"></column>
    <column name="fmail_uidvalidity" type="INTEGER"></column>
  </table>
  <table name="egw_history_log" label="">
    <column name="history_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="history_record_id" type="INTEGER" notnull="true"></column>
    <column name="history_appname" type="VARCHAR(64)" notnull="true"></column>
    <column name="history_owner" type="INTEGER" notnull="true"></column>
    <column name="history_status" type="VARCHAR(2)" notnull="true"></column>
    <column name="history_new_value" type="TEXT"></column>
    <column name="history_timestamp" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true" default="now()"></column>
    <column name="history_old_value" type="TEXT"></column>
  </table>
  <table name="egw_hooks" label="">
    <column name="hook_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="hook_appname" type="VARCHAR(255)"></column>
    <column name="hook_location" type="VARCHAR(255)"></column>
    <column name="hook_filename" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_infolog" label="">
    <column name="info_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="info_type" type="VARCHAR(40)" notnull="true" default="'task'::character varying"></column>
    <column name="info_from" type="VARCHAR(255)"></column>
    <column name="info_addr" type="VARCHAR(255)"></column>
    <column name="info_subject" type="VARCHAR(255)"></column>
    <column name="info_des" type="TEXT"></column>
    <column name="info_owner" type="INTEGER" notnull="true"></column>
    <column name="info_responsible" type="VARCHAR(255)" notnull="true" default="'0'::character varying"></column>
    <column name="info_access" type="VARCHAR(10)" default="'public'::character varying"></column>
    <column name="info_cat" type="INTEGER" notnull="true" default="0"></column>
    <column name="info_datemodified" type="BIGINT" notnull="true"></column>
    <column name="info_startdate" type="BIGINT" notnull="true" default="0"></column>
    <column name="info_enddate" type="BIGINT" notnull="true" default="0"></column>
    <column name="info_id_parent" type="INTEGER" notnull="true" default="0"></column>
    <column name="info_planned_time" type="INTEGER" notnull="true" default="0"></column>
    <column name="info_used_time" type="INTEGER" notnull="true" default="0"></column>
    <column name="info_status" type="VARCHAR(40)" default="'done'::character varying"></column>
    <column name="info_confirm" type="VARCHAR(10)" default="'not'::character varying"></column>
    <column name="info_modifier" type="INTEGER" notnull="true" default="0"></column>
    <column name="info_link_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="info_priority" type="SMALLINT" default="1"></column>
    <column name="pl_id" type="INTEGER"></column>
    <column name="info_price" type="DOUBLE"></column>
    <column name="info_percent" type="SMALLINT" default="0"></column>
    <column name="info_datecompleted" type="BIGINT"></column>
    <column name="info_location" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_infolog_extra" label="">
    <column name="info_id" type="INTEGER" notnull="true"></column>
    <column name="info_extra_name" type="VARCHAR(32)" notnull="true"></column>
    <column name="info_extra_value" type="VARCHAR(255)" notnull="true" default="''::character varying"></column>
  </table>
  <table name="egw_interserv" label="">
    <column name="server_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="server_name" type="VARCHAR(64)"></column>
    <column name="server_host" type="VARCHAR(255)"></column>
    <column name="server_url" type="VARCHAR(255)"></column>
    <column name="trust_level" type="INTEGER"></column>
    <column name="trust_rel" type="INTEGER"></column>
    <column name="username" type="VARCHAR(64)"></column>
    <column name="password" type="VARCHAR(255)"></column>
    <column name="admin_name" type="VARCHAR(255)"></column>
    <column name="admin_email" type="VARCHAR(255)"></column>
    <column name="server_mode" type="VARCHAR(16)" notnull="true" default="'xmlrpc'::character varying"></column>
    <column name="server_security" type="VARCHAR(16)"></column>
  </table>
  <table name="egw_lang" label="">
    <column name="lang" type="VARCHAR(5)" notnull="true" default="''::character varying"></column>
    <column name="app_name" type="VARCHAR(32)" notnull="true" default="'common'::character varying"></column>
    <column name="message_id" type="VARCHAR(128)" notnull="true" default="''::character varying"></column>
    <column name="content" type="TEXT"></column>
  </table>
  <table name="egw_languages" label="">
    <column name="lang_id" type="VARCHAR(5)" notnull="true" pkey="true"></column>
    <column name="lang_name" type="VARCHAR(50)" notnull="true"></column>
  </table>
  <table name="egw_links" label="">
    <column name="link_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="link_app1" type="VARCHAR(25)" notnull="true"></column>
    <column name="link_id1" type="VARCHAR(50)" notnull="true"></column>
    <column name="link_app2" type="VARCHAR(25)" notnull="true"></column>
    <column name="link_id2" type="VARCHAR(50)" notnull="true"></column>
    <column name="link_remark" type="VARCHAR(100)"></column>
    <column name="link_lastmod" type="INTEGER" notnull="true"></column>
    <column name="link_owner" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_log" label="">
    <column name="log_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="log_date" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="log_user" type="INTEGER" notnull="true"></column>
    <column name="log_app" type="VARCHAR(50)" notnull="true"></column>
    <column name="log_severity" type="VARCHAR(1)" notnull="true"></column>
  </table>
  <table name="egw_log_msg" label="">
    <column name="log_msg_log_id" type="INTEGER" notnull="true"></column>
    <column name="log_msg_seq_no" type="INTEGER" notnull="true"></column>
    <column name="log_msg_date" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="log_msg_tx_fid" type="VARCHAR(4)"></column>
    <column name="log_msg_tx_id" type="VARCHAR(4)"></column>
    <column name="log_msg_severity" type="VARCHAR(1)" notnull="true"></column>
    <column name="log_msg_code" type="VARCHAR(30)" notnull="true"></column>
    <column name="log_msg_msg" type="TEXT"></column>
    <column name="log_msg_parms" type="TEXT"></column>
    <column name="log_msg_file" type="VARCHAR(255)" notnull="true"></column>
    <column name="log_msg_line" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_news" label="">
    <column name="news_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="news_date" type="BIGINT"></column>
    <column name="news_subject" type="VARCHAR(255)"></column>
    <column name="news_submittedby" type="VARCHAR(255)"></column>
    <column name="news_content" type="BYTEA"></column>
    <column name="news_begin" type="BIGINT" notnull="true" default="0"></column>
    <column name="news_end" type="BIGINT"></column>
    <column name="news_cat" type="INTEGER"></column>
    <column name="news_teaser" type="VARCHAR(255)"></column>
    <column name="is_html" type="SMALLINT" notnull="true" default="0"></column>
  </table>
  <table name="egw_news_export" label="">
    <column name="cat_id" type="INTEGER" notnull="true" pkey="true"></column>
    <column name="export_type" type="SMALLINT"></column>
    <column name="export_itemsyntax" type="SMALLINT"></column>
    <column name="export_title" type="VARCHAR(255)"></column>
    <column name="export_link" type="VARCHAR(255)"></column>
    <column name="export_description" type="TEXT"></column>
    <column name="export_img_title" type="VARCHAR(255)"></column>
    <column name="export_img_url" type="VARCHAR(255)"></column>
    <column name="export_img_link" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_nextid" label="">
    <column name="id" type="INTEGER"></column>
    <column name="appname" type="VARCHAR(25)" notnull="true" pkey="true"></column>
  </table>
  <table name="egw_pm_constraints" label="">
    <column name="pm_id" type="INTEGER" notnull="true"></column>
    <column name="pe_id_end" type="INTEGER" notnull="true"></column>
    <column name="pe_id_start" type="INTEGER" notnull="true"></column>
    <column name="ms_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_pm_elements" label="">
    <column name="pm_id" type="INTEGER" notnull="true"></column>
    <column name="pe_id" type="INTEGER" notnull="true"></column>
    <column name="pe_title" type="VARCHAR(255)" notnull="true"></column>
    <column name="pe_completion" type="SMALLINT"></column>
    <column name="pe_planned_time" type="INTEGER"></column>
    <column name="pe_used_time" type="INTEGER"></column>
    <column name="pe_planned_budget" type="NUMERIC(20,2)"></column>
    <column name="pe_used_budget" type="NUMERIC(20,2)"></column>
    <column name="pe_planned_start" type="BIGINT"></column>
    <column name="pe_real_start" type="BIGINT"></column>
    <column name="pe_planned_end" type="BIGINT"></column>
    <column name="pe_real_end" type="BIGINT"></column>
    <column name="pe_overwrite" type="INTEGER" notnull="true" default="0"></column>
    <column name="pl_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="pe_synced" type="BIGINT"></column>
    <column name="pe_modified" type="BIGINT" notnull="true"></column>
    <column name="pe_modifier" type="INTEGER" notnull="true"></column>
    <column name="pe_status" type="VARCHAR(8)" notnull="true" default="'new'::character varying"></column>
    <column name="pe_unitprice" type="NUMERIC(20,2)"></column>
    <column name="cat_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="pe_share" type="INTEGER"></column>
    <column name="pe_health" type="SMALLINT"></column>
    <column name="pe_resources" type="VARCHAR(255)"></column>
    <column name="pe_details" type="TEXT"></column>
    <column name="pe_planned_quantity" type="DOUBLE"></column>
    <column name="pe_used_quantity" type="DOUBLE"></column>
  </table>
  <table name="egw_pm_extra" label="">
    <column name="pm_id" type="INTEGER" notnull="true"></column>
    <column name="pm_extra_name" type="VARCHAR(40)" notnull="true"></column>
    <column name="pm_extra_value" type="TEXT"></column>
  </table>
  <table name="egw_pm_members" label="">
    <column name="pm_id" type="INTEGER" notnull="true"></column>
    <column name="member_uid" type="INTEGER" notnull="true"></column>
    <column name="role_id" type="INTEGER" default="0"></column>
    <column name="member_availibility" type="DOUBLE"></column>
  </table>
  <table name="egw_pm_milestones" label="">
    <column name="ms_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="pm_id" type="INTEGER" notnull="true"></column>
    <column name="ms_date" type="BIGINT" notnull="true"></column>
    <column name="ms_title" type="VARCHAR(255)"></column>
    <column name="ms_description" type="TEXT"></column>
  </table>
  <table name="egw_pm_pricelist" label="">
    <column name="pl_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="pl_title" type="VARCHAR(255)" notnull="true"></column>
    <column name="pl_description" type="TEXT"></column>
    <column name="cat_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="pl_unit" type="VARCHAR(20)" notnull="true"></column>
  </table>
  <table name="egw_pm_prices" label="">
    <column name="pm_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="pl_id" type="INTEGER" notnull="true"></column>
    <column name="pl_validsince" type="BIGINT" notnull="true" default="0"></column>
    <column name="pl_price" type="DOUBLE"></column>
    <column name="pl_modifier" type="INTEGER" notnull="true"></column>
    <column name="pl_modified" type="BIGINT" notnull="true"></column>
    <column name="pl_customertitle" type="VARCHAR(255)"></column>
    <column name="pl_billable" type="SMALLINT" default="1"></column>
  </table>
  <table name="egw_pm_projects" label="">
    <column name="pm_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="pm_number" type="VARCHAR(64)" notnull="true"></column>
    <column name="pm_title" type="VARCHAR(255)" notnull="true"></column>
    <column name="pm_description" type="TEXT"></column>
    <column name="pm_creator" type="INTEGER" notnull="true"></column>
    <column name="pm_created" type="BIGINT" notnull="true"></column>
    <column name="pm_modifier" type="INTEGER"></column>
    <column name="pm_modified" type="BIGINT"></column>
    <column name="pm_planned_start" type="BIGINT"></column>
    <column name="pm_planned_end" type="BIGINT"></column>
    <column name="pm_real_start" type="BIGINT"></column>
    <column name="pm_real_end" type="BIGINT"></column>
    <column name="cat_id" type="INTEGER" default="0"></column>
    <column name="pm_access" type="VARCHAR(7)" default="'public'::character varying"></column>
    <column name="pm_priority" type="SMALLINT" default="1"></column>
    <column name="pm_status" type="VARCHAR(9)" default="'active'::character varying"></column>
    <column name="pm_completion" type="SMALLINT" default="0"></column>
    <column name="pm_used_time" type="INTEGER"></column>
    <column name="pm_planned_time" type="INTEGER"></column>
    <column name="pm_used_budget" type="NUMERIC(20,2)"></column>
    <column name="pm_planned_budget" type="NUMERIC(20,2)"></column>
    <column name="pm_overwrite" type="INTEGER" default="0"></column>
    <column name="pm_accounting_type" type="VARCHAR(10)" default="'times'::character varying"></column>
  </table>
  <table name="egw_pm_roles" label="">
    <column name="role_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="pm_id" type="INTEGER" default="0"></column>
    <column name="role_title" type="VARCHAR(80)" notnull="true"></column>
    <column name="role_description" type="VARCHAR(255)"></column>
    <column name="role_acl" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_preferences" label="">
    <column name="preference_owner" type="INTEGER" notnull="true"></column>
    <column name="preference_app" type="VARCHAR(25)" notnull="true"></column>
    <column name="preference_value" type="TEXT"></column>
  </table>
  <table name="egw_reg_accounts" label="">
    <column name="reg_id" type="VARCHAR(32)" notnull="true"></column>
    <column name="reg_lid" type="VARCHAR(255)" notnull="true"></column>
    <column name="reg_info" type="TEXT"></column>
    <column name="reg_dla" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_reg_fields" label="">
    <column name="field_name" type="VARCHAR(255)" notnull="true"></column>
    <column name="field_text" type="TEXT"></column>
    <column name="field_type" type="VARCHAR(255)" notnull="true"></column>
    <column name="field_values" type="TEXT"></column>
    <column name="field_required" type="VARCHAR(1)" notnull="true"></column>
    <column name="field_order" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_resources" label="">
    <column name="res_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="name" type="VARCHAR(100)"></column>
    <column name="short_description" type="VARCHAR(100)"></column>
    <column name="cat_id" type="INTEGER" notnull="true"></column>
    <column name="quantity" type="INTEGER" default="1"></column>
    <column name="useable" type="INTEGER" default="1"></column>
    <column name="location" type="VARCHAR(100)"></column>
    <column name="bookable" type="VARCHAR(1)"></column>
    <column name="buyable" type="VARCHAR(1)"></column>
    <column name="prize" type="VARCHAR(200)"></column>
    <column name="long_description" type="TEXT"></column>
    <column name="picture_src" type="VARCHAR(20)"></column>
    <column name="accessory_of" type="INTEGER" default="-1"></column>
    <column name="storage_info" type="VARCHAR(200)"></column>
    <column name="inventory_number" type="VARCHAR(20)"></column>
  </table>
  <table name="egw_resources_extra" label="">
    <column name="extra_id" type="INTEGER" notnull="true"></column>
    <column name="extra_name" type="VARCHAR(40)" notnull="true"></column>
    <column name="extra_owner" type="INTEGER" notnull="true" default="-1"></column>
    <column name="extra_value" type="VARCHAR(255)" notnull="true" default="''::character varying"></column>
  </table>
  <table name="egw_sessions" label="">
    <column name="session_id" type="VARCHAR(128)" notnull="true" pkey="true"></column>
    <column name="session_lid" type="VARCHAR(128)"></column>
    <column name="session_ip" type="VARCHAR(40)"></column>
    <column name="session_logintime" type="BIGINT"></column>
    <column name="session_dla" type="BIGINT"></column>
    <column name="session_action" type="VARCHAR(255)"></column>
    <column name="session_flags" type="VARCHAR(2)"></column>
  </table>
  <table name="egw_sitemgr_active_modules" label="">
    <column name="area" type="VARCHAR(50)" notnull="true"></column>
    <column name="cat_id" type="INTEGER" notnull="true"></column>
    <column name="module_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_sitemgr_blocks" label="">
    <column name="block_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="area" type="VARCHAR(50)"></column>
    <column name="cat_id" type="INTEGER"></column>
    <column name="page_id" type="INTEGER"></column>
    <column name="module_id" type="INTEGER" notnull="true"></column>
    <column name="sort_order" type="INTEGER"></column>
    <column name="viewable" type="INTEGER"></column>
  </table>
  <table name="egw_sitemgr_blocks_lang" label="">
    <column name="block_id" type="INTEGER" notnull="true"></column>
    <column name="lang" type="VARCHAR(5)" notnull="true"></column>
    <column name="title" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_sitemgr_categories_lang" label="">
    <column name="cat_id" type="INTEGER" notnull="true"></column>
    <column name="lang" type="VARCHAR(5)" notnull="true"></column>
    <column name="name" type="VARCHAR(100)"></column>
    <column name="description" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_sitemgr_categories_state" label="">
    <column name="cat_id" type="INTEGER" notnull="true" pkey="true"></column>
    <column name="state" type="SMALLINT"></column>
    <column name="index_page_id" type="INTEGER" default="0"></column>
  </table>
  <table name="egw_sitemgr_content" label="">
    <column name="version_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="block_id" type="INTEGER" notnull="true"></column>
    <column name="arguments" type="TEXT"></column>
    <column name="state" type="SMALLINT"></column>
  </table>
  <table name="egw_sitemgr_content_lang" label="">
    <column name="version_id" type="INTEGER" notnull="true"></column>
    <column name="lang" type="VARCHAR(5)" notnull="true"></column>
    <column name="arguments_lang" type="TEXT"></column>
  </table>
  <table name="egw_sitemgr_modules" label="">
    <column name="module_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="module_name" type="VARCHAR(25)"></column>
    <column name="description" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_sitemgr_notifications" label="">
    <column name="notification_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="site_id" type="INTEGER" notnull="true"></column>
    <column name="site_language" type="VARCHAR(3)" notnull="true" default="'all'::character varying"></column>
    <column name="cat_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="email" type="VARCHAR(255)" notnull="true"></column>
  </table>
  <table name="egw_sitemgr_notify_messages" label="">
    <column name="message_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="site_id" type="INTEGER" notnull="true"></column>
    <column name="language" type="VARCHAR(3)"></column>
    <column name="message" type="TEXT"></column>
    <column name="subject" type="TEXT"></column>
  </table>
  <table name="egw_sitemgr_pages" label="">
    <column name="page_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="cat_id" type="INTEGER"></column>
    <column name="sort_order" type="INTEGER"></column>
    <column name="hide_page" type="INTEGER"></column>
    <column name="name" type="VARCHAR(100)"></column>
    <column name="state" type="SMALLINT"></column>
  </table>
  <table name="egw_sitemgr_pages_lang" label="">
    <column name="page_id" type="INTEGER" notnull="true"></column>
    <column name="lang" type="VARCHAR(5)" notnull="true"></column>
    <column name="title" type="VARCHAR(255)"></column>
    <column name="subtitle" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_sitemgr_properties" label="">
    <column name="area" type="VARCHAR(50)" notnull="true"></column>
    <column name="cat_id" type="INTEGER" notnull="true"></column>
    <column name="module_id" type="INTEGER" notnull="true"></column>
    <column name="properties" type="TEXT"></column>
  </table>
  <table name="egw_sitemgr_sites" label="">
    <column name="site_id" type="INTEGER" notnull="true" pkey="true"></column>
    <column name="site_name" type="VARCHAR(255)"></column>
    <column name="site_url" type="VARCHAR(255)"></column>
    <column name="site_dir" type="VARCHAR(255)"></column>
    <column name="themesel" type="VARCHAR(50)"></column>
    <column name="site_languages" type="VARCHAR(50)"></column>
    <column name="home_page_id" type="INTEGER"></column>
    <column name="anonymous_user" type="VARCHAR(50)"></column>
    <column name="anonymous_passwd" type="VARCHAR(50)"></column>
    <column name="upload_dir" type="VARCHAR(255)"></column>
    <column name="upload_url" type="VARCHAR(255)"></column>
  </table>
  <table name="egw_syncmldevinfo" label="">
    <column name="dev_id" type="VARCHAR(255)" notnull="true" pkey="true"></column>
    <column name="dev_dtdversion" type="VARCHAR(10)" notnull="true"></column>
    <column name="dev_numberofchanges" type="BOOLEAN" notnull="true"></column>
    <column name="dev_largeobjs" type="BOOLEAN" notnull="true"></column>
    <column name="dev_swversion" type="VARCHAR(100)" notnull="true"></column>
    <column name="dev_oem" type="VARCHAR(100)" notnull="true"></column>
    <column name="dev_model" type="VARCHAR(100)" notnull="true"></column>
    <column name="dev_manufacturer" type="VARCHAR(100)" notnull="true"></column>
    <column name="dev_devicetype" type="VARCHAR(100)" notnull="true"></column>
    <column name="dev_deviceid" type="VARCHAR(100)" notnull="true"></column>
    <column name="dev_datastore" type="TEXT"></column>
  </table>
  <table name="egw_syncmlsummary" label="">
    <column name="dev_id" type="VARCHAR(255)" notnull="true"></column>
    <column name="sync_path" type="VARCHAR(100)" notnull="true"></column>
    <column name="sync_serverts" type="VARCHAR(20)" notnull="true"></column>
    <column name="sync_clientts" type="VARCHAR(20)" notnull="true"></column>
  </table>
  <table name="egw_timesheet" label="">
    <column name="ts_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="ts_project" type="VARCHAR(80)"></column>
    <column name="ts_title" type="VARCHAR(80)" notnull="true"></column>
    <column name="ts_description" type="TEXT"></column>
    <column name="ts_start" type="BIGINT" notnull="true"></column>
    <column name="ts_duration" type="BIGINT" notnull="true" default="0"></column>
    <column name="ts_quantity" type="DOUBLE" notnull="true"></column>
    <column name="ts_unitprice" type="DOUBLE"></column>
    <column name="cat_id" type="INTEGER" default="0"></column>
    <column name="ts_owner" type="INTEGER" notnull="true"></column>
    <column name="ts_modified" type="BIGINT" notnull="true"></column>
    <column name="ts_modifier" type="INTEGER" notnull="true"></column>
    <column name="pl_id" type="INTEGER" default="0"></column>
  </table>
  <table name="egw_vfs" label="">
    <column name="vfs_file_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="vfs_owner_id" type="INTEGER" notnull="true"></column>
    <column name="vfs_createdby_id" type="INTEGER"></column>
    <column name="vfs_modifiedby_id" type="INTEGER"></column>
    <column name="vfs_created" type="DATE" notnull="true" default="'1970-01-01'::date"></column>
    <column name="vfs_modified" type="DATE"></column>
    <column name="vfs_size" type="INTEGER"></column>
    <column name="vfs_mime_type" type="VARCHAR(64)"></column>
    <column name="vfs_deleteable" type="VARCHAR(1)" default="'Y'::character varying"></column>
    <column name="vfs_comment" type="VARCHAR(255)"></column>
    <column name="vfs_app" type="VARCHAR(25)"></column>
    <column name="vfs_directory" type="VARCHAR(233)"></column>
    <column name="vfs_name" type="VARCHAR(100)" notnull="true"></column>
    <column name="vfs_link_directory" type="VARCHAR(255)"></column>
    <column name="vfs_link_name" type="VARCHAR(128)"></column>
    <column name="vfs_version" type="VARCHAR(30)" notnull="true" default="'0.0.0.0'::character varying"></column>
    <column name="vfs_content" type="TEXT"></column>
  </table>
  <table name="egw_wf_activities" label="">
    <column name="wf_activity_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_name" type="VARCHAR(80)"></column>
    <column name="wf_normalized_name" type="VARCHAR(80)"></column>
    <column name="wf_p_id" type="INTEGER" notnull="true"></column>
    <column name="wf_type" type="VARCHAR(25)"></column>
    <column name="wf_is_autorouted" type="VARCHAR(1)"></column>
    <column name="wf_flow_num" type="INTEGER"></column>
    <column name="wf_is_interactive" type="VARCHAR(1)"></column>
    <column name="wf_last_modif" type="INTEGER"></column>
    <column name="wf_description" type="TEXT"></column>
    <column name="wf_default_user" type="VARCHAR(200)" default="'*'::character varying"></column>
  </table>
  <table name="egw_wf_activity_agents" label="">
    <column name="wf_activity_id" type="INTEGER" notnull="true"></column>
    <column name="wf_agent_id" type="INTEGER" notnull="true"></column>
    <column name="wf_agent_type" type="VARCHAR(15)" notnull="true"></column>
  </table>
  <table name="egw_wf_activity_roles" label="">
    <column name="wf_activity_id" type="INTEGER" notnull="true"></column>
    <column name="wf_role_id" type="INTEGER" notnull="true"></column>
    <column name="wf_readonly" type="SMALLINT" notnull="true" default="0"></column>
  </table>
  <table name="egw_wf_agent_mail_smtp" label="">
    <column name="wf_agent_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_to" type="VARCHAR(255)" notnull="true" default="'%roles%'::character varying"></column>
    <column name="wf_cc" type="VARCHAR(255)"></column>
    <column name="wf_bcc" type="VARCHAR(255)"></column>
    <column name="wf_from" type="VARCHAR(255)" default="'%user%'::character varying"></column>
    <column name="wf_replyto" type="VARCHAR(255)" default="'%user%'::character varying"></column>
    <column name="wf_subject" type="VARCHAR(255)"></column>
    <column name="wf_message" type="TEXT"></column>
    <column name="wf_send_mode" type="INTEGER" default="0"></column>
  </table>
  <table name="egw_wf_instance_activities" label="">
    <column name="wf_instance_id" type="INTEGER" notnull="true"></column>
    <column name="wf_activity_id" type="INTEGER" notnull="true"></column>
    <column name="wf_started" type="INTEGER" notnull="true"></column>
    <column name="wf_ended" type="INTEGER"></column>
    <column name="wf_user" type="VARCHAR(200)"></column>
    <column name="wf_status" type="VARCHAR(25)"></column>
  </table>
  <table name="egw_wf_instance_supplements" label="">
    <column name="wf_supplement_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_supplement_type" type="VARCHAR(50)"></column>
    <column name="wf_supplement_name" type="VARCHAR(100)"></column>
    <column name="wf_supplement_value" type="TEXT"></column>
    <column name="wf_workitem_id" type="INTEGER"></column>
    <column name="wf_supplement_blob" type="BYTEA"></column>
  </table>
  <table name="egw_wf_instances" label="">
    <column name="wf_instance_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_p_id" type="INTEGER" notnull="true"></column>
    <column name="wf_started" type="INTEGER"></column>
    <column name="wf_owner" type="VARCHAR(200)"></column>
    <column name="wf_next_activity" type="BYTEA"></column>
    <column name="wf_next_user" type="VARCHAR(200)"></column>
    <column name="wf_ended" type="INTEGER"></column>
    <column name="wf_status" type="VARCHAR(25)"></column>
    <column name="wf_priority" type="INTEGER" default="0"></column>
    <column name="wf_properties" type="BYTEA"></column>
    <column name="wf_name" type="VARCHAR(120)"></column>
    <column name="wf_category" type="INTEGER"></column>
  </table>
  <table name="egw_wf_process_config" label="">
    <column name="wf_p_id" type="INTEGER" notnull="true"></column>
    <column name="wf_config_name" type="VARCHAR(255)" notnull="true"></column>
    <column name="wf_config_value" type="TEXT"></column>
    <column name="wf_config_value_int" type="INTEGER"></column>
  </table>
  <table name="egw_wf_processes" label="">
    <column name="wf_p_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_name" type="VARCHAR(80)"></column>
    <column name="wf_is_valid" type="VARCHAR(1)"></column>
    <column name="wf_is_active" type="VARCHAR(1)"></column>
    <column name="wf_version" type="VARCHAR(12)"></column>
    <column name="wf_description" type="TEXT"></column>
    <column name="wf_last_modif" type="INTEGER"></column>
    <column name="wf_normalized_name" type="VARCHAR(80)"></column>
  </table>
  <table name="egw_wf_roles" label="">
    <column name="wf_role_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_p_id" type="INTEGER" notnull="true"></column>
    <column name="wf_last_modif" type="INTEGER"></column>
    <column name="wf_name" type="VARCHAR(80)"></column>
    <column name="wf_description" type="TEXT"></column>
  </table>
  <table name="egw_wf_transitions" label="">
    <column name="wf_p_id" type="INTEGER" notnull="true"></column>
    <column name="wf_act_from_id" type="INTEGER" notnull="true"></column>
    <column name="wf_act_to_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="egw_wf_user_roles" label="">
    <column name="wf_role_id" type="SERIAL" notnull="true"></column>
    <column name="wf_p_id" type="INTEGER" notnull="true"></column>
    <column name="wf_user" type="VARCHAR(200)" notnull="true"></column>
    <column name="wf_account_type" type="VARCHAR(1)" notnull="true" default="'u'::character varying"></column>
  </table>
  <table name="egw_wf_workitems" label="">
    <column name="wf_item_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="wf_instance_id" type="INTEGER" notnull="true"></column>
    <column name="wf_order_id" type="INTEGER" notnull="true"></column>
    <column name="wf_properties" type="BYTEA"></column>
    <column name="wf_activity_id" type="INTEGER" notnull="true"></column>
    <column name="wf_started" type="INTEGER"></column>
    <column name="wf_ended" type="INTEGER"></column>
    <column name="wf_user" type="VARCHAR(200)"></column>
    <column name="wf_note" type="TEXT"></column>
    <column name="wf_action" type="TEXT"></column>
  </table>
  <table name="egw_wiki_interwiki" label="">
    <column name="wiki_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="interwiki_prefix" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_name" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_lang" type="VARCHAR(5)" notnull="true" default="''::character varying"></column>
    <column name="interwiki_url" type="VARCHAR(255)" notnull="true" default="''::character varying"></column>
  </table>
  <table name="egw_wiki_links" label="">
    <column name="wiki_id" type="SMALLINT" notnull="true" default="0"></column>
    <column name="wiki_name" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_lang" type="VARCHAR(5)" notnull="true" default="''::character varying"></column>
    <column name="wiki_link" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_count" type="INTEGER" notnull="true" default="0"></column>
  </table>
  <table name="egw_wiki_pages" label="">
    <column name="wiki_id" type="SMALLINT" notnull="true" default="0"></column>
    <column name="wiki_name" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_lang" type="VARCHAR(5)" notnull="true" default="''::character varying"></column>
    <column name="wiki_version" type="INTEGER" notnull="true" default="1"></column>
    <column name="wiki_time" type="INTEGER"></column>
    <column name="wiki_supercede" type="INTEGER"></column>
    <column name="wiki_readable" type="INTEGER" notnull="true" default="0"></column>
    <column name="wiki_writable" type="INTEGER" notnull="true" default="0"></column>
    <column name="wiki_username" type="VARCHAR(80)"></column>
    <column name="wiki_hostname" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_comment" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_title" type="VARCHAR(80)"></column>
    <column name="wiki_body" type="TEXT"></column>
  </table>
  <table name="egw_wiki_rate" label="">
    <column name="wiki_rate_ip" type="VARCHAR(20)" notnull="true" pkey="true" default="''::character varying"></column>
    <column name="wiki_rate_time" type="INTEGER"></column>
    <column name="wiki_rate_viewlimit" type="SMALLINT"></column>
    <column name="wiki_rate_searchlimit" type="SMALLINT"></column>
    <column name="wiki_rate_editlimit" type="SMALLINT"></column>
  </table>
  <table name="egw_wiki_remote_pages" label="">
    <column name="wiki_remote_page" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_remote_site" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
  </table>
  <table name="egw_wiki_sisterwiki" label="">
    <column name="wiki_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="sisterwiki_prefix" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_name" type="VARCHAR(80)" notnull="true" default="''::character varying"></column>
    <column name="wiki_lang" type="VARCHAR(5)" notnull="true" default="''::character varying"></column>
    <column name="sisterwiki_url" type="VARCHAR(255)" notnull="true" default="''::character varying"></column>
  </table>
  <table name="phpgw_kb_articles" label="">
    <column name="art_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="q_id" type="BIGINT" notnull="true"></column>
    <column name="title" type="VARCHAR(255)" notnull="true"></column>
    <column name="topic" type="VARCHAR(255)" notnull="true"></column>
    <column name="text" type="TEXT"></column>
    <column name="cat_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="published" type="SMALLINT" notnull="true" default="0"></column>
    <column name="user_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="views" type="INTEGER" notnull="true" default="0"></column>
    <column name="created" type="INTEGER"></column>
    <column name="modified" type="INTEGER"></column>
    <column name="modified_user_id" type="INTEGER" notnull="true"></column>
    <column name="votes_1" type="INTEGER" notnull="true"></column>
    <column name="votes_2" type="INTEGER" notnull="true"></column>
    <column name="votes_3" type="INTEGER" notnull="true"></column>
    <column name="votes_4" type="INTEGER" notnull="true"></column>
    <column name="votes_5" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_kb_comment" label="">
    <column name="comment_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="user_id" type="INTEGER" notnull="true"></column>
    <column name="comment" type="TEXT"></column>
    <column name="entered" type="INTEGER"></column>
    <column name="art_id" type="INTEGER" notnull="true"></column>
    <column name="published" type="SMALLINT" notnull="true"></column>
  </table>
  <table name="phpgw_kb_files" label="">
    <column name="art_id" type="INTEGER" notnull="true"></column>
    <column name="art_file" type="VARCHAR(255)" notnull="true"></column>
    <column name="art_file_comments" type="VARCHAR(255)"></column>
  </table>
  <table name="phpgw_kb_questions" label="">
    <column name="question_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="user_id" type="INTEGER" notnull="true"></column>
    <column name="summary" type="TEXT"></column>
    <column name="details" type="TEXT"></column>
    <column name="cat_id" type="INTEGER" notnull="true" default="0"></column>
    <column name="creation" type="INTEGER"></column>
    <column name="published" type="SMALLINT" notnull="true"></column>
  </table>
  <table name="phpgw_kb_ratings" label="">
    <column name="user_id" type="INTEGER" notnull="true"></column>
    <column name="art_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_kb_related_art" label="">
    <column name="art_id" type="INTEGER" notnull="true"></column>
    <column name="related_art_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_kb_search" label="">
    <column name="keyword" type="VARCHAR(30)" notnull="true"></column>
    <column name="art_id" type="INTEGER" notnull="true"></column>
    <column name="score" type="BIGINT" notnull="true"></column>
  </table>
  <table name="phpgw_kb_urls" label="">
    <column name="art_id" type="INTEGER" notnull="true"></column>
    <column name="art_url" type="VARCHAR(255)" notnull="true"></column>
    <column name="art_url_title" type="VARCHAR(255)"></column>
  </table>
  <table name="phpgw_polls_data" label="">
    <column name="poll_id" type="INTEGER" notnull="true"></column>
    <column name="option_text" type="VARCHAR(100)" notnull="true"></column>
    <column name="option_count" type="INTEGER" notnull="true"></column>
    <column name="vote_id" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_polls_desc" label="">
    <column name="poll_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="poll_title" type="VARCHAR(100)" notnull="true"></column>
    <column name="poll_timestamp" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_polls_settings" label="">
    <column name="setting_name" type="VARCHAR(255)"></column>
    <column name="setting_value" type="VARCHAR(255)"></column>
  </table>
  <table name="phpgw_polls_user" label="">
    <column name="poll_id" type="INTEGER" notnull="true"></column>
    <column name="vote_id" type="INTEGER" notnull="true"></column>
    <column name="user_id" type="INTEGER" notnull="true"></column>
    <column name="vote_timestamp" type="INTEGER"></column>
  </table>
  <table name="phpgw_vfs2_customfields" label="">
    <column name="customfield_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="customfield_name" type="VARCHAR(60)" notnull="true"></column>
    <column name="customfield_description" type="VARCHAR(255)"></column>
    <column name="customfield_type" type="VARCHAR(20)" notnull="true"></column>
    <column name="customfield_precision" type="INTEGER"></column>
    <column name="customfield_active" type="VARCHAR(1)" notnull="true" default="'N'::character varying"></column>
  </table>
  <table name="phpgw_vfs2_customfields_data" label="">
    <column name="file_id" type="INTEGER" notnull="true"></column>
    <column name="customfield_id" type="INTEGER" notnull="true"></column>
    <column name="data" type="TEXT"></column>
  </table>
  <table name="phpgw_vfs2_files" label="">
    <column name="file_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="mime_id" type="INTEGER"></column>
    <column name="owner_id" type="INTEGER" notnull="true"></column>
    <column name="createdby_id" type="INTEGER"></column>
    <column name="modifiedby_id" type="INTEGER"></column>
    <column name="created" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true" default="'1970-01-01 00:00:00'::timestamp without time zone"></column>
    <column name="modified" type="TIMESTAMP WITHOUT TIME ZONE"></column>
    <column name="size" type="BIGINT"></column>
    <column name="deleteable" type="VARCHAR(1)" default="'Y'::character varying"></column>
    <column name="comment" type="VARCHAR(255)"></column>
    <column name="app" type="VARCHAR(25)"></column>
    <column name="directory" type="VARCHAR(255)"></column>
    <column name="name" type="VARCHAR(64)" notnull="true"></column>
    <column name="link_directory" type="VARCHAR(255)"></column>
    <column name="link_name" type="VARCHAR(128)"></column>
    <column name="version" type="VARCHAR(30)" notnull="true" default="'0.0.0.0'::character varying"></column>
    <column name="content" type="TEXT"></column>
    <column name="is_backup" type="VARCHAR(1)" notnull="true" default="'N'::character varying"></column>
    <column name="shared" type="VARCHAR(1)" notnull="true" default="'N'::character varying"></column>
    <column name="proper_id" type="VARCHAR(45)"></column>
  </table>
  <table name="phpgw_vfs2_mimetypes" label="">
    <column name="mime_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="extension" type="VARCHAR(10)" notnull="true"></column>
    <column name="mime" type="VARCHAR(50)" notnull="true"></column>
    <column name="mime_magic" type="VARCHAR(255)"></column>
    <column name="friendly" type="VARCHAR(50)" notnull="true"></column>
    <column name="image" type="BYTEA"></column>
    <column name="proper_id" type="VARCHAR(4)"></column>
  </table>
  <table name="phpgw_vfs2_prefixes" label="">
    <column name="prefix_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="prefix" type="VARCHAR(8)" notnull="true"></column>
    <column name="owner_id" type="INTEGER" notnull="true"></column>
    <column name="prefix_description" type="VARCHAR(30)"></column>
    <column name="prefix_type" type="VARCHAR(1)" notnull="true" default="'p'::character varying"></column>
  </table>
  <table name="phpgw_vfs2_quota" label="">
    <column name="account_id" type="INTEGER" notnull="true" pkey="true"></column>
    <column name="quota" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_vfs2_shares" label="">
    <column name="account_id" type="INTEGER" notnull="true"></column>
    <column name="file_id" type="INTEGER" notnull="true"></column>
    <column name="acl_rights" type="INTEGER" notnull="true"></column>
  </table>
  <table name="phpgw_vfs2_versioning" label="">
    <column name="version_id" type="SERIAL" notnull="true" pkey="true"></column>
    <column name="file_id" type="INTEGER" notnull="true"></column>
    <column name="operation" type="INTEGER" notnull="true"></column>
    <column name="modifiedby_id" type="INTEGER" notnull="true"></column>
    <column name="modified" type="TIMESTAMP WITHOUT TIME ZONE" notnull="true"></column>
    <column name="version" type="VARCHAR(30)" notnull="true"></column>
    <column name="comment" type="VARCHAR(255)"></column>
    <column name="backup_file_id" type="INTEGER"></column>
    <column name="backup_content" type="TEXT"></column>
    <column name="src" type="VARCHAR(255)"></column>
    <column name="dest" type="VARCHAR(255)"></column>
  </table>
</analysis>
