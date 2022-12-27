/* creating Databasetop_20_energy_production_countries World_energy*/
create database world_energy;

/* imported 2 tables named as energy_production_Consumption and population_and_gdp 
     using insert table wizard */
     
     /*======== View tables=======*/
     
select*from energy_production_consumption;
select*from population_and_gdp;
     
/* need to create primary key for both tables */
/* first altering table energy_production_consumption */
ALTER TABLE `world_energy`.`energy_production_consumption` 
CHANGE COLUMN `S_NO` `S_NO` INT NOT NULL ,
ADD PRIMARY KEY (`S_NO`);
;

/* second altering table population_and_gdp */
ALTER TABLE `world_energy`.`population_and_gdp` 
CHANGE COLUMN `S_NO` `S_NO` INT NOT NULL ,
ADD PRIMARY KEY (`S_NO`);
;

/* Creating foreign key*/
ALTER TABLE `world_energy`.`energy_production_consumption` 
ADD CONSTRAINT `S_NO`
  FOREIGN KEY (`S_NO`)
  REFERENCES `world_energy`.`population_and_gdp` (`S_NO`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  /* calculating difference between energy production and energy consumption */
  
  /* Negative value reperesents that country
  depends on other country for its energy consumption*/
  
  /*  Positive  value reperesents that country
  used to sell excess energy to other country*/  
  
  Select country, year, Energy_type, energy_production, energy_consumption, (energy_production - energy_consumption) as Energy_Status 
  from energy_production_consumption where year = 2015
  order by Energy_Status asc;
  
                 /*  =======Calculating Energy per capita======*/
 
  
  select*from energy_production_consumption;
  select*from population_and_gdp;
  
  select  energy_production_consumption.Country, energy_production_consumption.Energy_production, energy_production_consumption.Energy_consumption, energy_production_consumption.Year, population_and_gdp.Population from world_energy.population_and_gdp
  left join energy_production_consumption
  on energy_production_consumption.S_NO = population_and_gdp.S_NO;
  
 /* Energy per capita represents 
  when the total energy consumption is divided by the total population*/

select energy_production_consumption.Country, energy_production_consumption.Year, (energy_production_consumption.Energy_consumption / population_and_gdp.Population) as Energy_Per_Capita
from world_energy.population_and_gdp
  left join energy_production_consumption
  on energy_production_consumption.S_NO = population_and_gdp.S_NO
  where energy_production_consumption.Country <> 'world' and energy_production_consumption.Year = 2015 order by Energy_per_capita desc;
		
				/*=====created view based on the results=====*/
                
  create view Energy_per_capita_calc as select energy_production_consumption.Country, energy_production_consumption.Year, (energy_production_consumption.Energy_consumption / population_and_gdp.Population) as Energy_Per_Capita
from world_energy.population_and_gdp
  left join energy_production_consumption
  on energy_production_consumption.S_NO = population_and_gdp.S_NO
 where energy_production_consumption.Country <> ' world' order by Energy_Per_Capita asc;
 
 select*from Energy_per_capita_calc;
  
          /*=========Showing top 20 countries that produce more energy========*/
          
select country, year, Energy_production from energy_production_consumption
where country <> 'world' and year = 2014 and Energy_type = 'all_energy_types' order by Energy_production desc LIMIT 20;

Create view top_20_energy_production_countries as select country, year, Energy_production from energy_production_consumption
where country <> 'world' and year = 2014 and Energy_type = 'all_energy_types' order by Energy_production desc LIMIT 20;

select*from top_20_energy_production_countries;

		/* ======= showing top 20 countries that produce more CO2 emission ====*/
select*from population_and_gdp;

select country, year, population, CO2_emission from population_and_gdp
where country <> 'world' and year = 2014  order by CO2_emission desc LIMIT 20;

select energy_production_consumption.Country, energy_production_consumption.Year,  energy_production_consumption.Energy_type,population_and_gdp.CO2_emission
from world_energy.population_and_gdp
  left join energy_production_consumption
  on energy_production_consumption.S_NO = population_and_gdp.S_NO
  where energy_production_consumption.Country <> 'world' and energy_production_consumption.Year = 2015 order by population_and_gdp.CO2_emission desc limit 20;
		
create view top_20_CO2_Emission_countries as select energy_production_consumption.Country, energy_production_consumption.Year,  energy_production_consumption.Energy_type,population_and_gdp.CO2_emission
from world_energy.population_and_gdp
  left join energy_production_consumption
  on energy_production_consumption.S_NO = population_and_gdp.S_NO
  where energy_production_consumption.Country <> 'world' and energy_production_consumption.Year = 2015 order by population_and_gdp.CO2_emission desc limit 20;

alter view top_20_CO2_Emission_countries as select distinct energy_production_consumption.Country, energy_production_consumption.Year,  energy_production_consumption.Energy_type,population_and_gdp.CO2_emission
from world_energy.population_and_gdp
  left join energy_production_consumption
  on energy_production_consumption.S_NO = population_and_gdp.S_NO
  where energy_production_consumption.Country <> 'world' and energy_production_consumption.Year = 2015 and Energy_type = 'all_energy_types' order by population_and_gdp.CO2_emission desc limit 20;

select*from	top_20_CO2_Emission_countries;



  