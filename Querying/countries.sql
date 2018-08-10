-- Showing what countries use the language Slovene and the percentage
SELECT countries.name, languages.language, languages.percentage 
FROM countries
LEFT JOIN languages ON countries.id = languages.country_id
WHERE languages.language = "Slovene" 
ORDER BY languages.percentage DESC;

-- Shows number of cities a country has

SELECT countries.name, COUNT(cities.id)
FROM countries
LEFT JOIN cities ON countries.id = cities.country_id
GROUP BY countries.id
ORDER BY COUNT(cities.id) DESC;

-- Shows cities in Mexico with popualtions greater than 500,000

SELECT countries.name, cities.name, cities.population
FROM countries
LEFT JOIN cities ON countries.id = cities.country_id
WHERE countries.name = "Mexico" and cities.population > 500000;

-- Shows languages in each country with a percentage greater than 89%

SELECT countries.name, languages.language, languages.percentage
FROM countries
LEFT JOIN languages ON countries.id = languages.country_id
WHERE languages.percentage > 89.0
ORDER BY languages.percentage DESC;

-- Shows all countries with Surface Area below 501 and population greater than 100,000

SELECT countries.name, countries.surface_area, countries.population
FROM countries
WHERE countries.surface_area < 501 and countries.population > 100000;

-- Shows all countries with only Constitutional Monarchy with a capital greater than 200 and a life expectancy greater than 75 years

SELECT countries.name, countries.government_form, countries.capital, countries.life_expectancy
FROM countries
WHERE countries.government_form = "Constitutional Monarchy" and countries.capital > 200 and countries.life_expectancy > 75;

-- Shows all cities in Argentina inside the Buenos Aires district that have the population greater than 500,000

SELECT countries.name, cities.name, cities.district, cities.population
FROM countries
LEFT JOIN cities ON countries.id = cities.country_id
WHERE countries.name = "Argentina" and cities.district = "Buenos Aires" and cities.population > 500000;

-- Shows number of countries in each region, in descending order by country count

SELECT countries.region, COUNT(countries.id)
FROM countries
GROUP BY countries.region
ORDER BY COUNT(countries.id) DESC


