use coviddb;
select * 
from coviddeaths 
order by 3,4;

select * from covidvaccinations order by 3,4;

/*select data we are going to use*/

select location,date,total_cases,new_cases,total_deaths,population
 from coviddeaths
 order by 1,2;
 
 /*Looking at total cases vs total deaths*/
 
 select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as Deathpercentage
 from coviddeaths
 where location like '%ghan%'
 order by 1,2;
 
/*Looking at total cases vs population*/

select location,date,total_cases,total_deaths,(total_cases/population)*100 as Total_casespercentage
 from coviddeaths
 where location like 'Afg%'
 order by 1,2;
 
 /*Looking countries with Highest Infection rate compared to population*/
 
 Select location,population,Max(total_cases) as Highest_Infection_count,Max(total_cases/population)*100 as Highest_infection_rate_percent
 from coviddeaths
group by location,population
 order by Highest_infection_rate_percent desc;
 
 /*Showing continents with highest death count per population*/
 
 Select continent,count(total_deaths) as Total_death_count 
 from coviddeaths 
 group by continent
 order by Total_death_count desc;
 
 /*Showing continent with highest death count*/
 
 Select continent,count(total_deaths) as Total_death_count 
 from coviddeaths
 group by continent
 order by Total_death_count desc
 limit 1;
 
 /*Global numbers-sum of new cases and new deaths*/
 
 Select date,Sum(new_cases) as Total_newcases,Sum(new_deaths) as Total_newdeaths, (new_deaths/new_cases)*100 as Death_percentage
 from coviddeaths
 where continent is not null
 group by date
 order by 1,2;
 
 /*Joins--->looking at total population vs Vaccinations*/
 
 Select cd.continent,cd.location,cd.date,cd.population, cv.new_vaccinations , (cv.new_vaccinations/cd.population)*100 as percent_of_vaccination 
 from coviddeaths cd join covidvaccinations cv 
 on cd.location = cv.location 
 and cd.date=cv.date
 where cd.continent is not null
 order by 2,3;
 