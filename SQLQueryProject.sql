--select * FROM 
--Portfolioproject..CovidDeaths$ order by 3,4
--select * from 
--Portfolioproject..CovidVaccinations$ order by 3,4
select location,date,total_cases,new_cases,total_deaths,population 
from Portfolioproject..CovidDeaths$
order by 1,2
--looking for deathPercentage in different countries
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from Portfolioproject..CovidDeaths$ where continent is not null
order by 1,2

--looking for india DeathPercentage

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from Portfolioproject..CovidDeaths$ where location like '%india%' and  continent is not null
order by 1,2
--looking for india CovidPercentage
select location,date,total_cases,population,(total_cases/population)*100 as CovidPercentage
from Portfolioproject..CovidDeaths$ where location like '%india%'
order by 1,2

--looking for country with highest infection rate compared to population
select location,max(total_cases) as HighestInfectionCount,population,max((total_cases/population))*100 as PercentPopulationInfected
from Portfolioproject..CovidDeaths$ 
where continent is not null
group by location,population
order by PercentPopulationInfected desc

--Showing countries with highest death count per population
select Location,max(cast(Total_Deaths as int))as TotalDeathCount
from Portfolioproject..CovidDeaths$ 
where continent is not null
group by Location
order by TotalDeathCount desc

--Showing continents with highest death count per population
select continent,max(cast(Total_Deaths as int))as TotalDeathCount
from Portfolioproject..CovidDeaths$ 
where continent is not null
group by continent
order by TotalDeathCount desc
--Golbal figures
select date ,sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,(sum(cast(new_deaths as int))/sum(new_cases))*100 
from Portfolioproject..CovidDeaths$ 
where continent is not null
group by date
order by 1,2

select * from Portfolioproject..CovidVaccinations$

--joining of two tables
select * from Portfolioproject..CovidDeaths$ as dea
join Portfolioproject..CovidVaccinations$ as vac
on dea.date=vac.date and dea.location=vac.location

--looking at total populations and vaccination
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations from Portfolioproject..CovidDeaths$ as dea
join Portfolioproject..CovidVaccinations$ as vac
on dea.date=vac.date and dea.location=vac.location
where dea.continent is not null
order by 2,3