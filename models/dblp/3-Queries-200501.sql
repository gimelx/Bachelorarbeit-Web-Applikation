-- RQ1 --

-- which outltets exist (Table 1)

create view 1_outlets as (
select Outlet, Type, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author, min(year), max(year) 
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
group by Outlet, Type);  -- institution_country_id

-- RQ2--

-- distribution worldwide (Total values of Table 2)

create view 2_geo_continent as (
select '2005-2019', continent as Continent, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019
group by continent);  -- institution_country_id

-- distribution worldwide (Sunburst)


-- select Year, continent as Continent, Country_ID, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
create view 2_geo_continent_country as (
select continent as Continent, Country_ID, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019
group by Continent, Country_ID);  -- institution_country_id

-- RQ3 --

-- evolvement over time in terms of content and geographical distribution?

-- per-continent quantity of Table 2

create view 3_geo_continent_over_time_05_09 as (
select '2005-2009', continent as Continent, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2009
group by continent);  -- institution_country_id

create view 3_geo_continent_over_time_10_14 as (
select '2010-2014', continent as Continent, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2010 and 2014
group by continent);  -- institution_country_id

create view 3_geo_continent_over_time_15_19 as (
select '2015-2019', continent as Continent, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2015 and 2019
group by continent);  -- institution_country_id

-- continent over time line chart

create view 3_year_continent_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019
group by Year, Continent);  -- institution_country_id

-- per-continent line chart

create view 3_year_continent_asia_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and continent = 'Asia'
group by Year, Continent);

create view 3_year_continent_europe_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and continent = 'Europe'
group by Year, Continent);

create view 3_year_continent_north_america_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and continent = 'North America'
group by Year, Continent);

create view 3_year_continent_south_america_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and continent = 'South America'
group by Year, Continent);

create view 3_year_continent_oceania_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and continent = 'Oceania'
group by Year, Continent);

create view 3_year_continent_africa_05_19 as (
select Year, continent as Continent, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and continent = 'Africa'
group by Year, Continent);


-- RQ4 --

-- quantity in total

create view 4_year_npapers_nauthors as (
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f inner join d_paper d on f.doi = d.doi
where year between 2005 and 2019
group by Year);  -- institution_country_id

-- per-outlet quantity (Table 3)

create view 4_outlet_over_time_05_09 as (
select '2005-2009', outlet as Outlet, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2009
group by outlet);  -- institution_country_id

create view 4_outlet_over_time_10_14 as (
select '2010-2014', outlet as Outlet, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2010 and 2014
group by outlet);  -- institution_country_id

create view 4_outlet_over_time_15_19 as (
select '2015-2019', outlet as Outlet, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2015 and 2019
group by outlet);  -- institution_country_id

create view 4_outlet_over_time_05_19 as (
select '2005-2019', outlet as Outlet, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019
group by outlet);  -- institution_country_id

-- quantity for specific outlets

create view 4_year_outlet_bmsd_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'BMSD'
group by Year, outlet);

create view 4_year_outlet_bpmds_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'BPMDS'
group by Year, outlet);

create view 4_year_outlet_models_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'MoDELS'
group by Year, outlet);

create view 4_year_outlet_sosym_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'SoSym'
group by Year, outlet);

create view 4_year_outlet_emisa_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'EMISA'
group by Year, outlet);

create view 4_year_outlet_er_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'ER'
group by Year, outlet);

create view 4_year_outlet_csimq_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'CSIMQ'
group by Year, outlet);

create view 4_year_outlet_poem_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'PoEM'
group by Year, outlet);

create view 4_year_outlet_ijismd_05_19 as(
select Year, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
where year between 2005 and 2019 and outlet = 'IJISMD'
group by Year, outlet);

-- quantity for specific authors


-- RQ5

create view 5_community_author_by_outlet as (
select distinct outlet, author_id
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
);

-- for all pairs of outlets: determine the number of outlets publishing in both
create view 5_community_shared_authors as (
select count(a.author_id) as n_authors, a.outlet as outlet1, b.outlet as outlet2
from 5_community_author_by_outlet a, 5_community_author_by_outlet b
where a.author_id = b.author_id and a.outlet <> b.outlet and a.outlet < b.outlet
group by a.outlet, b.outlet
);

create view 5_community_coauthor_graph_gephi as (
select co_authors.id1 as Source, co_authors.id2 as Target from
(
select distinct f1.author_id as id1, f2.author_id as id2, f1.doi
from f_dblp f1, f_dblp f2
where f1.doi = f2.doi and f1.author_id <> f2.author_id and f1.author_id < f2.author_id
) as co_authors
   inner join d_author d1 on co_authors.id1 = d1.author_id
   inner join d_author d2 on co_authors.id2 = d2.author_id
);

create view 5_community_coauthor_graph_gephi_node_labels as (
select author_id as ID, author_name as Label
from d_author
);

-- RQ7

-- Authors: typical number of publications

select f.author_id, author_name, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_author dau on f.author_id = dau.author_id
where year between 2005 and 2019
group by  f.author_id, author_name
order by n desc


select f.author_id, author_name, outlet, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_author dau on f.author_id = dau.author_id
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
where year between 2005 and 2019 and outlet = 'SoSyM'
group by  f.author_id, author_name
order by n desc


select f.author_id, author_name, outlet, count(distinct f.doi) as n
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_author dau on f.author_id = dau.author_id
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
where year between 2005 and 2019 and outlet = 'ER'
group by  f.author_id, author_name
order by n desc


-- additional excel analysis

-- authors per paper
select avg(groupn)
from (
 select f.doi, title, count(distinct author_id) as groupn 
 from f_dblp f
	inner join d_paper dp on f.doi = dp.doi
 group by title order by groupn desc
) as t;



-- Author group analysis (not included in the paper)

select d1.author_name as author1_name,
	   d2.author_name as author2_name,
       d3.author_name as author3_name,
       d4.author_name as author4_name,
       nPapers
from f_author_group_2005_2009 f
	   inner join d_author d1 on f.author1_id = d1.author_id
       left join d_author d2 on f.author2_id = d2.author_id
       left join d_author d3 on f.author3_id = d3.author_id
	   left join d_author d4 on f.author4_id = d4.author_id
order by npapers desc;


select d1.author_name as author1_name,
	   d2.author_name as author2_name,
       d3.author_name as author3_name,
       d4.author_name as author4_name,
       nPapers
from f_author_group_2010_2014 f
	   inner join d_author d1 on f.author1_id = d1.author_id
       left join d_author d2 on f.author2_id = d2.author_id
       left join d_author d3 on f.author3_id = d3.author_id
	   left join d_author d4 on f.author4_id = d4.author_id
order by npapers desc;


select d1.author_name as author1_name,
	   d2.author_name as author2_name,
       d3.author_name as author3_name,
       d4.author_name as author4_name,
       nPapers
from f_author_group_2015_2019 f
	   inner join d_author d1 on f.author1_id = d1.author_id
       left join d_author d2 on f.author2_id = d2.author_id
       left join d_author d3 on f.author3_id = d3.author_id
	   left join d_author d4 on f.author4_id = d4.author_id
order by npapers desc;



-- Number of publications over timeframes: 2005 - 2009

SET SQL_SAFE_UPDATES = 0;

create table t_f_author_group_timeframe (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

create table t_paper_ids (paper_id int auto_increment primary key, doi text);

insert into t_paper_ids (doi) 
	select distinct f.doi
    from f_dblp f inner join d_paper d
    where f.doi = d.doi and 
          year between 2005 and 2009;

create table t_paper_authors (paper_id int, author_id int);
insert into t_paper_authors (paper_id, author_id) 
	select paper_id,author_id 
    from f_dblp f inner join t_paper_ids p on f.doi = p.doi;

create table t_paper_authors_pairs (paper_id int, author1_id int, author2_id int);

insert into t_paper_authors_pairs
select t1.paper_id, t1.author_id, t2.author_id
from t_paper_authors t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and t1.author_id <> t2.author_id;

insert into t_f_author_group_timeframe (author1_id, nPapers)
select t1.author_id as author1_id, count(*) as nPapers
from t_paper_authors t1
group by t1.author_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, nPapers)
select author1_id, author2_id, count(*) as nPapers
from t_paper_authors_pairs
group by author1_id, author2_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, author3_id, nPapers)
select author1_id, author2_id, t2.author_id as author3_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author_id and 
      t1.author2_id <> t2.author_id
group by author1_id, author2_id, t2.author_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, author3_id, author4_id, nPapers)
select t1.author1_id as author1_id, t1.author2_id as author2_id, t2.author1_id as author3_id, t2.author2_id as author4_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors_pairs t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author1_id and 
      t1.author1_id <> t2.author2_id and
      t1.author2_id <> t2.author1_id and
      t1.author2_id <> t2.author2_id
group by  t1.author1_id, t1.author2_id, t2.author1_id, t2.author2_id
order by nPapers desc;

delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is null and
    author4_id is null and
    author1_id >= author2_id;
delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is null and
    author1_id >= author2_id or author2_id >= author3_id;
delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is not null and
    author1_id >= author2_id or author2_id >= author3_id or author3_id >= author4_id;

create table f_author_group_2005_2009 (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

insert ignore into f_author_group_2005_2009
	(author1_id, author2_id, author3_id, author4_id, nPapers)
    select author1_id, author2_id, author3_id, author4_id, nPapers
    from t_f_author_group_timeframe;

drop table t_paper_ids;
drop table t_paper_authors;
drop table t_paper_authors_pairs;
drop table t_f_author_group_timeframe;


-- Number of publications over timeframes: 2010 - 2014

SET SQL_SAFE_UPDATES = 0;

create table t_f_author_group_timeframe (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

create table t_paper_ids (paper_id int auto_increment primary key, doi text);

insert into t_paper_ids (doi) 
	select distinct f.doi
    from f_dblp f inner join d_paper d
    where f.doi = d.doi and 
          year between 2010 and 2014;

create table t_paper_authors (paper_id int, author_id int);
insert into t_paper_authors (paper_id, author_id) 
	select paper_id,author_id 
    from f_dblp f inner join t_paper_ids p on f.doi = p.doi;

create table t_paper_authors_pairs (paper_id int, author1_id int, author2_id int);

insert into t_paper_authors_pairs
select t1.paper_id, t1.author_id, t2.author_id
from t_paper_authors t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and t1.author_id <> t2.author_id;

insert into t_f_author_group_timeframe (author1_id, nPapers)
select t1.author_id as author1_id, count(*) as nPapers
from t_paper_authors t1
group by t1.author_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, nPapers)
select author1_id, author2_id, count(*) as nPapers
from t_paper_authors_pairs
group by author1_id, author2_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, author3_id, nPapers)
select author1_id, author2_id, t2.author_id as author3_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author_id and 
      t1.author2_id <> t2.author_id
group by author1_id, author2_id, t2.author_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, author3_id, author4_id, nPapers)
select t1.author1_id as author1_id, t1.author2_id as author2_id, t2.author1_id as author3_id, t2.author2_id as author4_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors_pairs t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author1_id and 
      t1.author1_id <> t2.author2_id and
      t1.author2_id <> t2.author1_id and
      t1.author2_id <> t2.author2_id
group by  t1.author1_id, t1.author2_id, t2.author1_id, t2.author2_id
order by nPapers desc;

delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is null and
    author4_id is null and
    author1_id >= author2_id;
delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is null and
    author1_id >= author2_id or author2_id >= author3_id;
delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is not null and
    author1_id >= author2_id or author2_id >= author3_id or author3_id >= author4_id;

create table f_author_group_2010_2014 (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

insert ignore into f_author_group_2010_2014
	(author1_id, author2_id, author3_id, author4_id, nPapers)
    select author1_id, author2_id, author3_id, author4_id, nPapers
    from t_f_author_group_timeframe;

drop table t_paper_ids;
drop table t_paper_authors;
drop table t_paper_authors_pairs;
drop table t_f_author_group_timeframe;


-- Number of publications over timeframes: 2015 - 2019

SET SQL_SAFE_UPDATES = 0;

create table t_f_author_group_timeframe (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

create table t_paper_ids (paper_id int auto_increment primary key, doi text);

insert into t_paper_ids (doi) 
	select distinct f.doi
    from f_dblp f inner join d_paper d
    where f.doi = d.doi and 
          year between 2010 and 2014;

create table t_paper_authors (paper_id int, author_id int);
insert into t_paper_authors (paper_id, author_id) 
	select paper_id,author_id 
    from f_dblp f inner join t_paper_ids p on f.doi = p.doi;

create table t_paper_authors_pairs (paper_id int, author1_id int, author2_id int);

insert into t_paper_authors_pairs
select t1.paper_id, t1.author_id, t2.author_id
from t_paper_authors t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and t1.author_id <> t2.author_id;

insert into t_f_author_group_timeframe (author1_id, nPapers)
select t1.author_id as author1_id, count(*) as nPapers
from t_paper_authors t1
group by t1.author_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, nPapers)
select author1_id, author2_id, count(*) as nPapers
from t_paper_authors_pairs
group by author1_id, author2_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, author3_id, nPapers)
select author1_id, author2_id, t2.author_id as author3_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author_id and 
      t1.author2_id <> t2.author_id
group by author1_id, author2_id, t2.author_id
order by nPapers desc;

insert into t_f_author_group_timeframe (author1_id, author2_id, author3_id, author4_id, nPapers)
select t1.author1_id as author1_id, t1.author2_id as author2_id, t2.author1_id as author3_id, t2.author2_id as author4_id, count(*) as nPapers
from t_paper_authors_pairs t1, t_paper_authors_pairs t2
where t1.paper_id = t2.paper_id and
      t1.author1_id <> t2.author1_id and 
      t1.author1_id <> t2.author2_id and
      t1.author2_id <> t2.author1_id and
      t1.author2_id <> t2.author2_id
group by  t1.author1_id, t1.author2_id, t2.author1_id, t2.author2_id
order by nPapers desc;

delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is null and
    author4_id is null and
    author1_id >= author2_id;
delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is null and
    author1_id >= author2_id or author2_id >= author3_id;
delete from t_f_author_group_timeframe where 
	author1_id is not null and
	author2_id is not null and
    author3_id is not null and
    author4_id is not null and
    author1_id >= author2_id or author2_id >= author3_id or author3_id >= author4_id;

create table f_author_group_2015_2019 (
	author1_id int,
    author2_id int,
    author3_id int,
    author4_id int,
    nPapers int
);

insert ignore into f_author_group_2015_2019
	(author1_id, author2_id, author3_id, author4_id, nPapers)
    select author1_id, author2_id, author3_id, author4_id, nPapers
    from t_f_author_group_timeframe;

drop table t_paper_ids;
drop table t_paper_authors;
drop table t_paper_authors_pairs;
drop table t_f_author_group_timeframe;






------------------------------------------

-- RQ OTHER

create view 0_year_continent_country_outlet as (
select Year, continent as Continent, Country, Outlet, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
group by Year, Continent, Country, Outlet);  -- institution_country_id

create view 0_paper_author_per_year as (
select Year, Country, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
group by Year, Country 
order by country, year);

create view 0_paper_author as (
select Country, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
group by Country 
order by country, year);

create view 0_n_authors_per_paper as (
select Country, count(distinct f.doi) as n_paper, count(distinct author_id) as n_author
from f_dblp f
	inner join d_paper dpa on f.doi = dpa.doi
    inner join d_outlet dou on f.outlet_id = dou.outlet_id
    inner join d_institution din on f.institution_id = din.institution_id
    inner join d_country dco on din.institution_country_id = dco.country_id
group by Country 
order by country, year);

create view 0_co_authorships_per_author as (
select d.author_id, author_name, count(*) as n_coauthors
from d_author d, 0_co_authorships co 
where d.author_id = co.author1 or d.author_id = co.author2
group by d.author_id, author_name
order by author_name desc);

create view 0_co_authorships_and_papers_per_author as (
select f.author_id, n_coauthors, count(distinct doi) as n_papers
from f_dblp f, 0_co_authorships_per_author co
where f.author_id = co.author_id
group by f.author_id
order by n_papers desc);

create view 0_n_authors_per_outlet as (
select outlet, count(distinct author_id) 
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
group by outlet
);

-- Author Communities: Clutering using nominal distance measures defined by "author has published at outlet x?"

create table f_community_author_clustering_vectors_outlet (
	author_id int,
    SoSyM char(10),
    ER char(10),
    EMISA char(10),
    CSIMQ char(10),
    IJISMD char(10),
    MoDELS char(10),
    BPMDS char(10),
    PoEM char(10),
    BMSD char(10),
    primary key (author_id));

create view f_community_author_clustering_vectors_outlet_prep as (
SELECT 
	d.author_id, 
    SoSyM.n as 'SoSyM',
    ER.n as 'ER',
    EMISA.n as 'EMISA',
    CSIMQ.n as 'CSIMQ',
    IJISMD.n as 'IJISMD',
    MoDELS.n as 'MoDELS',
    BPMDS.n as 'BPMDS',
    PoEM.n as 'PoEM',
    BMSD.n as 'BMSD'
FROM
d_author d left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'SoSyM'
group by author_id, outlet) as SoSyM on d.author_id = SoSyM.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'ER'
group by author_id, outlet) as ER on d.author_id = ER.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'EMISA'
group by author_id, outlet) as EMISA on d.author_id = EMISA.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'CSIMQ'
group by author_id, outlet) as CSIMQ on d.author_id = CSIMQ.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'IJISMD'
group by author_id, outlet) as IJISMD on d.author_id = IJISMD.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'MoDELS'
group by author_id, outlet) as MoDELS on d.author_id = MoDELS.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'BPMDS'
group by author_id, outlet) as BPMDS on d.author_id = BPMDS.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'PoEM'
group by author_id, outlet) as PoEM on d.author_id = PoEM.author_id
left join
(
select author_id, outlet, count(distinct doi) as n
from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id
where outlet = 'BMSD'
group by author_id, outlet) as BMSD on d.author_id = BMSD.author_id

ORDER BY
  author_id
);

insert into f_community_author_clustering_vectors_outlet select * from f_community_author_clustering_vectors_outlet_prep;

update f_community_author_clustering_vectors_outlet set SoSyM = concat(author_id,'SoSyM') where SoSym is null;
update f_community_author_clustering_vectors_outlet set ER = concat(author_id,'ER') where ER is null;
update f_community_author_clustering_vectors_outlet set EMISA = concat(author_id,'EMISA') where EMISA is null;
update f_community_author_clustering_vectors_outlet set CSIMQ = concat(author_id,'CSIMQ') where CSIMQ is null;
update f_community_author_clustering_vectors_outlet set IJISMD = concat(author_id,'IJISMD') where IJISMD is null;
update f_community_author_clustering_vectors_outlet set MoDELS = concat(author_id,'MoDELS') where MoDELS is null;
update f_community_author_clustering_vectors_outlet set BPMDS = concat(author_id,'BPMDS') where BPMDS is null;
update f_community_author_clustering_vectors_outlet set PoEM = concat(author_id,'PoEM') where PoEM is null;
update f_community_author_clustering_vectors_outlet set BMSD = concat(author_id,'BMSD') where BMSD is null;

update f_community_author_clustering_vectors_outlet set SoSyM = '1' where length(SoSym) <= 3 and cast(SoSyM AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set ER = '1' where length(ER) <= 2 and Cast(ER AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set EMISA = '1' where length(EMISA) <= 3 and Cast(EMISA AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set CSIMQ = '1' where length(CSIMQ) <= 3 and Cast(CSIMQ AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set IJISMD = '1' where length(IJISMD) <= 3 and Cast(IJISMD AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set MoDELS = '1' where length(MoDELS) <= 3 and Cast(MoDELS AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set BPMDS = '1' where length(BPMDS) <= 3 and Cast(BPMDS AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set PoEM = '1' where length(PoEM) <= 3 and Cast(PoEM AS UNSIGNED) >= 1;
update f_community_author_clustering_vectors_outlet set BMSD = '1' where length(BMSD) <= 3 and Cast(BMSD AS UNSIGNED) >= 1;



-- # OTHER

-- # GENERAL

-- paper, authors, countries

create view papers_authors as (
select doi, title, author_name, country, INSTITUTION,url from
	f_dblp f inner join d_outlet dou on f.outlet_id = dou.outlet_id
			 inner join d_author dau on f.author_id = dau.author_id
			 inner join d_institution din on f.institution_id = din.institution_id
			 inner join d_country c on din.institution_country_id = c.country_id
);

             
-- paper, authors, countries, continents (multiple per country)

select doi, title, author_name, country, continent from
	f_dblp f inner join d_outlet dou on f.outlet_id = dou.outlet_id
			 inner join d_author dau on f.author_id = dau.author_id
			 inner join d_institution din on f.institution_id = din.institution_id
			 inner join d_country c on din.institution_country_id = c.country_id;


-- # N PAPERS

create view n_papers_total as (
select count(distinct doi) as n from f_dblp);

create view n_papers_per_outlet_2005 as (
select outlet,count(distinct doi) as n, min(year), max(year)
from f_dblp f left join d_outlet dou on f.outlet_id = dou.outlet_id
where year >= 2005
group by outlet
order by outlet asc);

create view n_papers_per_year as (
select year,count(distinct doi) as n
from f_dblp f left join d_outlet dou on f.outlet_id = dou.outlet_id
group by year
order by year asc);

create view n_papers_per_outlet_year as (
select outlet,year,count(distinct doi) as n
from f_dblp f left join d_outlet dou on f.outlet_id = dou.outlet_id
group by outlet, year
order by outlet, year);


-- # N Authors

create view n_authors_total as (
select count(distinct author_id) as n from f_dblp);

-- per author papers
select year, author_id, count(distinct doi) as n_papers, count(distinct outlet) as n_outlets
from f_dblp f
	left join d_outlet dou on f.outlet_id = dou.outlet_id
group by year, author_id;

-- avg authors per paper
select avg(groupn)
from (
 select doi, title, count(distinct author_id) as groupn from f_dblp group by title order by groupn desc
) as t;

-- yearly_outlets_papers_authors_countries / yearly avg per author, paper, outlet
-- note: should also contain median, possibly calculated in rapid miner
create view yearly_outlets_papers_authors_countries as (
select year, count(distinct outlet) as n_outlets, count(distinct doi) as n_papers, count(distinct author_id) as n_authors, count(distinct doi)/count(distinct author_id) as avg_papers_per_author, count(distinct author_id)/count(distinct doi) as avg_authors_per_paper, count(distinct doi)/count(distinct outlet) as avg_papers_per_outlet, count(distinct institution_country_id) as n_countries
from f_dblp f
	left join d_outlet dou on f.outlet_id = dou.outlet_id
    left join d_institution din on f.institution_id = din.institution_id
group by year
order by year);

-- author_avg_papers_outlets / avg papers per year
-- note: should also contain median, possibly calculated in rapid miner
create view author_avg_papers_outlets as (
select year, avg(n_papers) as avg_papers, avg(n_outlets) as avg_outlets, max(n_papers) as max_n_papers, max(n_outlets) as max_n_outlets from (
select year, author_id, count(distinct doi) as n_papers, count(distinct outlet) as n_outlets
from f_dblp f
	left join d_outlet dou on f.outlet_id = dou.outlet_id
group by year, author_id
) as t
group by year
order by year);

-- top_authors_per_year
create view top_authors_per_year as (
select f.year, f.author_id, author_name, count(doi) as n_papers, max_n_papers
from f_dblp f
	left join d_author dau on f.author_id = dau.author_id
    left join author_avg_papers_outlets avg_year on f.year = avg_year.year
where f.year > 2000
group by f.year, f.author_id, author_name
having n_papers = max_n_papers
order by year asc, author_name asc);

-- top authors
create view top_authors as (
select f.author_id, author_name, count(distinct doi) as n
from f_dblp f left join d_author a on f.author_id = a.author_id
group by f.author_id
order by count(distinct doi) desc);


-- # OUTLETS

-- papers per outlet

select outlet,count(distinct doi) from
	f_dblp f inner join d_outlet dou on f.outlet_id = dou.outlet_id
			 inner join d_author dau on f.author_id = dau.author_id
			 inner join d_institution din on f.institution_id = din.institution_id
group by outlet;

-- author share per outlet

select f.Author_ID,count(distinct url)/(select count(distinct url) from f_dblp f inner join d_outlet d on f.outlet_id = d.outlet_id where outlet = 'BPMDS') as n_outlet_bmmds from
	 f_dblp f inner join d_outlet dou on f.outlet_id = dou.outlet_id
			inner join d_author dau on f.author_id = dau.author_id
	 		inner join d_institution din on f.institution_id = din.institution_id
where outlet = 'BPMDS'
group by f.Author_ID;

-- author share for outlet

select f.Author_ID,count(distinct url) as n_outlet_er from
	 f_dblp f inner join d_outlet dou on f.outlet_id = dou.outlet_id
			inner join d_author dau on f.author_id = dau.author_id
	 		inner join d_institution din on f.institution_id = din.institution_id
where outlet = 'ER'
group by f.Author_ID;



-- # OTHER

-- papers with authors as columns

Select url, author1, author2, author3, author4, author5, author6, author7, author8, author9, author10, author11, author12,
			   author13, author14, author15, author16, author17, author18 
	    From (
				Select url, author_id as author1, 
					NTH_VALUE(author_id, 2) OVER(PARTITION BY url) as author2,
					NTH_VALUE(author_id, 3) OVER(PARTITION BY url) as author3,
					NTH_VALUE(author_id, 4) OVER(PARTITION BY url) as author4,
					NTH_VALUE(author_id, 5) OVER(PARTITION BY url) as author5,
					NTH_VALUE(author_id, 6) OVER(PARTITION BY url) as author6,
					NTH_VALUE(author_id, 7) OVER(PARTITION BY url) as author7,
					NTH_VALUE(author_id, 8) OVER(PARTITION BY url) as author8,
					NTH_VALUE(author_id, 9) OVER(PARTITION BY url) as author9,
					NTH_VALUE(author_id, 10) OVER(PARTITION BY url) as author10,
					NTH_VALUE(author_id, 11) OVER(PARTITION BY url) as author11,
					NTH_VALUE(author_id, 12) OVER(PARTITION BY url) as author12,
					NTH_VALUE(author_id, 13) OVER(PARTITION BY url) as author13,
					NTH_VALUE(author_id, 14) OVER(PARTITION BY url) as author14,
					NTH_VALUE(author_id, 15) OVER(PARTITION BY url) as author15,
					NTH_VALUE(author_id, 16) OVER(PARTITION BY url) as author16,
					NTH_VALUE(author_id, 17) OVER(PARTITION BY url) as author17,
					NTH_VALUE(author_id, 18) OVER(PARTITION BY url) as author18
				from f_dblp f) as t
                where url = 'https://doi.org/10.1007/s10270-015-0487-8'
		Group By url;