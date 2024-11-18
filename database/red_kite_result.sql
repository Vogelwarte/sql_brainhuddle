

SELECT distinct  min(ilh.bird_id) as bird_id, min(nl."ID") as nest_id,  min(nl."coordX") as "CoordX", min(nl."coordY") as "CoordY"
FROM nest_list nl
left join join_table_year_nests ny on nl."ID" = ny.nest_id
left join individual_life_history ilh on ilh.bird_id = ny.bird_id
where ilh.age = '1CY' and ilh.transm_gsm is not null
group by ilh.bird_id
order by 1;