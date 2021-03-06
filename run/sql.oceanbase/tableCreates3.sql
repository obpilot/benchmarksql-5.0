create table bmsql_config (
  cfg_name    varchar2(30) primary key,
  cfg_value   varchar2(50)
);

create tablegroup "tpcc_group" ;

create table bmsql_warehouse (
  w_id        integer   not null,
  w_ytd       decimal(12,2),
  w_tax       decimal(4,4),
  w_name      varchar2(10),
  w_street_1  varchar2(20),
  w_street_2  varchar2(20),
  w_city      varchar2(20),
  w_state     char(2),
  w_zip       char(9),
  primary key(w_id)
)tablegroup='tpcc_group' ;

create table bmsql_district (
  d_w_id       integer       not null,
  d_id         integer       not null,
  d_ytd        decimal(12,2),
  d_tax        decimal(4,4),
  d_next_o_id  integer,
  d_name       varchar2(10),
  d_street_1   varchar2(20),
  d_street_2   varchar2(20),
  d_city       varchar2(20),
  d_state      char(2),
  d_zip        char(9),
  PRIMARY KEY (d_w_id, d_id)
)tablegroup='tpcc_group' ;

create table bmsql_customer (
  c_w_id         integer        not null,
  c_d_id         integer        not null,
  c_id           integer        not null,
  c_discount     decimal(4,4),
  c_credit       char(2),
  c_last         varchar2(16),
  c_first        varchar2(16),
  c_credit_lim   decimal(12,2),
  c_balance      decimal(12,2),
  c_ytd_payment  decimal(12,2),
  c_payment_cnt  integer,
  c_delivery_cnt integer,
  c_street_1     varchar2(20),
  c_street_2     varchar2(20),
  c_city         varchar2(20),
  c_state        char(2),
  c_zip          char(9),
  c_phone        char(16),
  c_since        timestamp,
  c_middle       char(2),
  c_data         varchar2(500),
  PRIMARY KEY (c_w_id, c_d_id, c_id)
)tablegroup='tpcc_group' ;

create sequence bmsql_hist_id_seq;

create table bmsql_history (
  hist_id  integer,
  h_c_id   integer,
  h_c_d_id integer,
  h_c_w_id integer,
  h_d_id   integer,
  h_w_id   integer,
  h_date   timestamp,
  h_amount decimal(6,2),
  h_data   varchar2(24)
)tablegroup='tpcc_group' ;

create table bmsql_new_order (
  no_w_id  integer   not null ,
  no_d_id  integer   not null,
  no_o_id  integer   not null,
  PRIMARY KEY (no_w_id, no_d_id, no_o_id)
)tablegroup='tpcc_group' ;

create table bmsql_oorder (
  o_w_id       integer      not null,
  o_d_id       integer      not null,
  o_id         integer      not null,
  o_c_id       integer,
  o_carrier_id integer,
  o_ol_cnt     integer,
  o_all_local  integer,
  o_entry_d    timestamp,
  PRIMARY KEY (o_w_id, o_d_id, o_id)
)tablegroup='tpcc_group' ;

create table bmsql_order_line (
  ol_w_id         integer   not null,
  ol_d_id         integer   not null,
  ol_o_id         integer   not null,
  ol_number       integer   not null,
  ol_i_id         integer   not null,
  ol_delivery_d   timestamp,
  ol_amount       decimal(6,2),
  ol_supply_w_id  integer,
  ol_quantity     integer,
  ol_dist_info    char(24),
  PRIMARY KEY (ol_w_id, ol_d_id, ol_o_id, ol_number)
)tablegroup='tpcc_group' ;

create table bmsql_item (
  i_id     integer      not null,
  i_name   varchar2(24),
  i_price  decimal(5,2),
  i_data   varchar2(50),
  i_im_id  integer,
  PRIMARY KEY (i_id)
)locality='F,R{all_server}@zone1, F,R{all_server}@zone2, F,R{all_server}@zone3' primary_zone='zone1'  duplicate_scope='cluster';

create table bmsql_stock (
  s_w_id       integer       not null,
  s_i_id       integer       not null,
  s_quantity   integer,
  s_ytd        integer,
  s_order_cnt  integer,
  s_remote_cnt integer,
  s_data       varchar2(50),
  s_dist_01    char(24),
  s_dist_02    char(24),
  s_dist_03    char(24),
  s_dist_04    char(24),
  s_dist_05    char(24),
  s_dist_06    char(24),
  s_dist_07    char(24),
  s_dist_08    char(24),
  s_dist_09    char(24),
  s_dist_10    char(24),
  PRIMARY KEY (s_w_id, s_i_id)
)tablegroup='tpcc_group' ;


