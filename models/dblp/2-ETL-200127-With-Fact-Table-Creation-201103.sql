-- drop table if exists f_dblp;
-- drop table if exists f_author_group;
drop table if exists t_f_dblp;
drop table if exists t_f_author_group;
-- drop table if exists d_outlet;
-- drop table if exists d_author;
-- drop table if exists d_country;
-- drop table if exists d_institution;

-- create transformation table and extract

create table if not exists t_f_dblp (
   ID int auto_increment,
   DOI VARCHAR(50), 
   URL text,
   TITLE text,
   YEAR int,
   OUTLET_ID int,
   OUTLET TEXT,
   VOLUME INT,
   NUMBER INT,
   AUTHOR_id int,
   AUTHOR_NAME TEXT,
   INSTITUTION_id int,
   INSTITUTION TEXT, 
   INSTITUTION_DEPARTMENT TEXT, 
   INSTITUTION_CITY TEXT, 
   INSTITUTION_COUNTRY_ID CHAR(2),
   INSTITUTION_COUNTRY TEXT,
   Constraint pk_t_f_dblp primary key (ID)
);

truncate t_f_dblp;

insert into t_f_dblp 
  (doi, url, title, year, outlet, volume, number, author_name, INSTITUTION, INSTITUTION_DEPARTMENT, INSTITUTION_CITY, INSTITUTION_COUNTRY)
  select doi, url, title, year, outlet, volume, number, author_name, INSTITUTION, INSTITUTION_DEPARTMENT, INSTITUTION_CITY, INSTITUTION_COUNTRY
  from articles;

-- create dimension tables

create table if not exists d_paper (
    doi varchar(50),
	title text,
    url text,
    year int,
    Constraint pk_d_paper Primary Key (doi)
);

create table if not exists d_author (
	author_id int auto_increment,
    author_name text,
    Constraint pk_d_author primary key (author_id)
);

create table if not exists d_outlet (
    outlet_id int auto_increment,
	Type text,
    Outlet text,
    Journal_Volume int,
    Journal_Number int,
    Constraint pk_d_outlet Primary Key (outlet_id)
);

create Table if not exists d_country (
  country_id char(2),
  country text,
  continent varchar(13),
  constraint pk_country_id primary key (country_id, continent)
);

truncate d_country;
insert ignore into d_country values ('US', 'United States', 'North America');
insert ignore into d_country values ('CA', 'Canada', 'North America');
insert ignore into d_country values ('DE', 'Germany', 'Europe');
insert ignore into d_country values ('ES', 'Spain', 'Europe');
insert ignore into d_country values ('NO', 'Norway', 'Europe');
insert ignore into d_country values ('GB', 'United Kingdom', 'Europe');
insert ignore into d_country values ('AT', 'Austria', 'Europe');
insert ignore into d_country values ('CH', 'Switzerland', 'Europe');
insert ignore into d_country values ('DK', 'Denmark', 'Europe');
insert ignore into d_country values ('KR', 'Korea South', 'Asia');
insert ignore into d_country values ('FR', 'France', 'Europe');
insert ignore into d_country values ('IT', 'Italy', 'Europe');
insert ignore into d_country values ('SE', 'Sweden', 'Europe');
insert ignore into d_country values ('BR', 'Brazil', 'South America');
insert ignore into d_country values ('HU', 'Hungary', 'Europe');
insert ignore into d_country values ('CN', 'China', 'Asia');
insert ignore into d_country values ('AU', 'Australia', 'Oceania');
insert ignore into d_country values ('PT', 'Portugal', 'Europe');
insert ignore into d_country values ('FI', 'Finland', 'Europe');
insert ignore into d_country values ('NL', 'Netherlands', 'Europe');
insert ignore into d_country values ('IL', 'Israel', 'Asia');
insert ignore into d_country values ('BE', 'Belgium', 'Europe');
insert ignore into d_country values ('BA', 'Bosnia Herzegovina', 'Europe');
insert ignore into d_country values ('SA', 'Saudi Arabia', 'Asia');
insert ignore into d_country values ('TH', 'Thailand', 'Asia');
insert ignore into d_country values ('TR', 'Turkey', 'Asia');
insert ignore into d_country values ('NZ', 'New Zealand', 'Oceania');
insert ignore into d_country values ('IE', 'Ireland', 'Europe');
insert ignore into d_country values ('RO', 'Romania', 'Europe');
insert ignore into d_country values ('SI', 'Slovenia', 'Europe');
insert ignore into d_country values ('LU', 'Luxembourg', 'Europe');
insert ignore into d_country values ('LV', 'Latvia', 'Europe');
insert ignore into d_country values ('JP', 'Japan', 'Asia');
insert ignore into d_country values ('CU', 'Cuba', 'North America');
insert ignore into d_country values ('PK', 'Pakistan', 'Asia');
insert ignore into d_country values ('ZA', 'South Africa', 'Africa');
insert ignore into d_country values ('IR', 'Iran', 'Asia');
insert ignore into d_country values ('MX', 'Mexico', 'North America');
insert ignore into d_country values ('GR', 'Greece', 'Europe');
insert ignore into d_country values ('PL', 'Poland', 'Europe');
insert ignore into d_country values ('TN', 'Tunisia', 'Africa');
insert ignore into d_country values ('UY', 'Uruguay', 'South America');
insert ignore into d_country values ('AE', 'United Arab Emirates', 'Asia');
insert ignore into d_country values ('CL', 'Chile', 'South America');
insert ignore into d_country values ('AR', 'Argentina', 'South America');
insert ignore into d_country values ('CO', 'Colombia', 'South America');
insert ignore into d_country values ('IN', 'India', 'Asia');
insert ignore into d_country values ('CY', 'Cyprus', 'Asia');
insert ignore into d_country values ('DZ', 'Algeria', 'Africa');
insert ignore into d_country values ('SG', 'Singapore', 'Asia');
insert ignore into d_country values ('VN', 'Vietnam', 'Asia');
insert ignore into d_country values ('OM', 'Oman', 'Asia');
insert ignore into d_country values ('CZ', 'Czech Republic', 'Europe');
insert ignore into d_country values ('MY', 'Malaysia', 'Asia');
insert ignore into d_country values ('LB', 'Lebanon', 'Asia');
insert ignore into d_country values ('TW', 'Taiwan', 'Asia');
insert ignore into d_country values ('RS', 'Serbia', 'Europe');
insert ignore into d_country values ('RU', 'Russian Federation', 'Europe');
insert ignore into d_country values ('UA', 'Ukraine', 'Europe');
insert ignore into d_country values ('UG', 'Uganda', 'Africa');
insert ignore into d_country values ('EC', 'Ecuador', 'South America');
insert ignore into d_country values ('MT', 'Malta', 'Europe');
insert ignore into d_country values ('HR', 'Croatia', 'Europe');
insert ignore into d_country values ('LT', 'Lithuania', 'Europe');
insert ignore into d_country values ('PH', 'Philippines', 'Asia');
insert ignore into d_country values ('TR', 'Turkey', 'Europe');
insert ignore into d_country values ('ID', 'Indonesia', 'Asia');
insert ignore into d_country values ('PE', 'Peru', 'South America');
insert ignore into d_country values ('VE', 'Venezuela', 'South America');
insert ignore into d_country values ('ET', 'Costa Rica', 'North America');
insert ignore into d_country values ('KE', 'Kenya', 'Africa');
insert ignore into d_country values ('BG', 'Bulgaria', 'Europe');
insert ignore into d_country values ('CM', 'Cameroon', 'Africa');
insert ignore into d_country values ('EG', 'Egypt', 'Africa');
insert ignore into d_country values ('MA', 'Morocco', 'Africa');
insert ignore into d_country values ('KZ', 'Kazakhstan', 'Asia');
insert ignore into d_country values ('PS', 'Palestine', 'Asia');
insert ignore into d_country values ('CY', 'Cyprus', 'Europe');
insert ignore into d_country values ('KZ', 'Kazakhstan', 'Europe');
insert ignore into d_country values ('RU', 'Russian Federation', 'Asia');
insert ignore into d_country values ('  ', '', '');

create table if not exists d_institution (
	institution_id int auto_increment,
    INSTITUTION TEXT, 
    INSTITUTION_DEPARTMENT TEXT, 
    INSTITUTION_CITY TEXT, 
    INSTITUTION_COUNTRY_ID char(2),
    Constraint pk_d_institution primary key (institution_id)
);

-- create fact table

CREATE TABLE `f_dblp` (
  `DOI` varchar(50) NOT NULL,
  `OUTLET_ID` int(11) NOT NULL,
  `AUTHOR_id` int(11) NOT NULL,
  `INSTITUTION_id` int(11) NOT NULL,
  PRIMARY KEY (`DOI`,`AUTHOR_id`,`OUTLET_ID`,`INSTITUTION_id`),
  KEY `fk_d_outlet` (`OUTLET_ID`),
  KEY `fk_d_author` (`AUTHOR_id`),
  KEY `fk_d_institution` (`INSTITUTION_id`),
  CONSTRAINT `fk_d_author` FOREIGN KEY (`AUTHOR_id`) REFERENCES `d_author` (`author_id`),
  CONSTRAINT `fk_d_institution` FOREIGN KEY (`INSTITUTION_id`) REFERENCES `d_institution` (`institution_id`),
  CONSTRAINT `fk_d_outlet` FOREIGN KEY (`OUTLET_ID`) REFERENCES `d_outlet` (`outlet_id`),
  CONSTRAINT `fk_d_paper` FOREIGN KEY (`DOI`) REFERENCES `d_paper` (`doi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- transform: country dimension

update t_f_dblp tfd
	set tfd.institution_country_id = '  ', tfd.institution_country = ''
    where tfd.institution_country is null or tfd.institution_country regexp '^[ ]*$';
    
update t_f_dblp tfd, d_country dco
	set tfd.institution_country_id = dco.country_id
    where tfd.institution_country = dco.country;

-- load: dimensions

insert ignore into d_paper
	(doi, title, year, url)
    select distinct doi, title, year, url
    from t_f_dblp;

insert ignore into d_institution 
	(INSTITUTION, INSTITUTION_DEPARTMENT, INSTITUTION_CITY, INSTITUTION_COUNTRY_ID) 
    select distinct INSTITUTION, INSTITUTION_DEPARTMENT, INSTITUTION_CITY, INSTITUTION_COUNTRY_ID 
    from t_f_dblp;
    
insert ignore into d_author
	(author_name)
    select distinct author_name from t_f_dblp;
    
insert ignore into d_outlet
	(Type, Outlet, Journal_Volume, Journal_Number)
    select distinct 'Journal', Outlet, Volume, Number from t_f_dblp where outlet IN ('Software and Systems Modeling', 'Enterprise Modelling and Information Systems Architectures', 'CSIMQ', 'IJISMD');
    
insert ignore into d_outlet
	(Type, Outlet, Journal_Volume, Journal_Number)
    select distinct 'Conference', Outlet, Volume, Number from t_f_dblp where outlet IN ('MoDELS', 'ER', 'BMMDS/EMMSAD', 'BPMDS/EMMSAD@CAiSE', 'EJC','MoDELS (1)','MoDELS (2)','PoEM','BMSD');


-- transform: assign dimension IDs for fact table

set sql_safe_updates = 0;
  
update t_f_dblp tfd, d_outlet dou
	set tfd.OUTLET_ID = dou.OUTLET_ID
    where tfd.outlet = dou.outlet and 
          (tfd.volume = dou.journal_volume or (tfd.volume is null and dou.journal_volume is null)) and 
          (tfd.number = dou.journal_number or (tfd.number is null and dou.journal_number is null));

update t_f_dblp tfd, d_author dau
	set tfd.author_id = dau.author_id
    where tfd.author_name = dau.author_name or (tfd.author_name is null and dau.author_name is null);

update t_f_dblp tfd, d_institution din
	set tfd.institution_id = din.institution_id
    where (tfd.institution = din.institution 						or (tfd.institution is null 			and din.institution is null)) and
		  (tfd.institution_department = din.institution_department 	or (tfd.institution_department is null 	and din.institution_department is null)) and
          (tfd.institution_city = din.institution_city 				or (tfd.institution_city is null 		and din.institution_city is null)) and
          (tfd.institution_country_id = din.institution_country_id	or (tfd.institution_country_id is null 	and din.institution_country_id is null));

-- alter table t_f_dblp drop column outlet, drop column volume, column number, drop column author_name,
--                      drop column institution, drop column institution_department, drop column institution_city, 
--                      drop column institution_country;


-- transform: author group ids

create table if not exists t_f_author_group (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

truncate t_f_author_group;

create table t_paper_ids (paper_id int auto_increment primary key, doi text);
insert into t_paper_ids (doi) select distinct doi from f_dblp;

create table t_paper_authors (paper_id int, author_id int);
insert into t_paper_authors (paper_id, author_id) 
	select paper_id,author_id 
    from f_dblp f inner join t_paper_ids p on f.doi = p.doi;

create table t_paper_authors_pairs (paper_id int, author1_id int, author2_id int);

insert into t_paper_authors_pairs
select t1.paper_id, t1.author_id, t2.author_id
from t_paper_authors t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and t1.author_id <> t2.author_id;

insert into t_f_author_group (author1_id, nPapers)
select t1.author_id as author1_id, count(*) as nPapers
from t_paper_authors t1
group by t1.author_id
order by nPapers desc;

insert into t_f_author_group (author1_id, author2_id, nPapers)
select author1_id, author2_id, count(*) as nPapers
from t_paper_authors_pairs
group by author1_id, author2_id
order by nPapers desc;

insert into t_f_author_group (author1_id, author2_id, author3_id, nPapers)
select author1_id, author2_id, t2.author_id as author3_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author_id and 
      t1.author2_id <> t2.author_id
group by author1_id, author2_id, t2.author_id
order by nPapers desc;

insert into t_f_author_group (author1_id, author2_id, author3_id, author4_id, nPapers)
select t1.author1_id as author1_id, t1.author2_id as author2_id, t2.author1_id as author3_id, t2.author2_id as author4_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors_pairs t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author1_id and 
      t1.author1_id <> t2.author2_id and
      t1.author2_id <> t2.author1_id and
      t1.author2_id <> t2.author2_id
group by  t1.author1_id, t1.author2_id, t2.author1_id, t2.author2_id
order by nPapers desc;

drop table t_paper_ids;
drop table t_paper_authors;
drop table t_paper_authors_pairs;

-- for 2-/3-/4-tuples, only preserve unique combinations ordered by author_id
delete from t_f_author_group where 
	author1_id is not null and
	author2_id is not null and
    author3_id is null and
    author4_id is null and
    author1_id >= author2_id;
delete from t_f_author_group where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is null and
    author1_id >= author2_id or author2_id >= author3_id;
delete from t_f_author_group where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is not null and
    author1_id >= author2_id or author2_id >= author3_id or author3_id >= author4_id;

-- create fact table

create table if not exists f_dblp (
   DOI VARCHAR(50), 
   OUTLET_ID int,
   AUTHOR_id int,
   INSTITUTION_id int,
   Constraint pk_f_dblp primary key (doi, author_id, outlet_id, institution_id),
   Constraint fk_d_paper foreign key (doi) references d_paper(doi),
   Constraint fk_d_outlet foreign key (outlet_id) references d_outlet(outlet_id),
   Constraint fk_d_author foreign key (author_id) references d_author(author_id),
   Constraint fk_d_institution foreign key (institution_id) references d_institution(institution_ID)
);

create table if not exists f_author_group (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

-- load: facts

insert ignore into f_dblp
	(doi, outlet_id, author_id, institution_id)
	select doi, outlet_id, author_id, institution_id
    from t_f_dblp;

insert ignore into f_author_group
	(author1_id, author2_id, author3_id, author4_id, nPapers)
    select author1_id, author2_id, author3_id, author4_id, nPapers
    from t_f_author_group;
