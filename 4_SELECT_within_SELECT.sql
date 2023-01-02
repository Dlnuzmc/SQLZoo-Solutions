
-- # In which we form queries using other queries.

-- # 1. List each country name where the population is larger than 'Russia'.
SELECT name FROM world
 WHERE population > (
  SELECT population FROM world
   WHERE name = 'Russia');

-- # 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name FROM world
 WHERE continent = 'Europe'
  AND gdp/population > (
   SELECT gdp/population FROM world
    WHERE name = 'United Kingdom');

-- # 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent FROM world
 WHERE continent IN (
  SELECT continent FROM world
   WHERE name IN ('Argentina', 'Australia'));

-- # 4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
SELECT name, population FROM world
 WHERE population > (
   SELECT population FROM world
    WHERE name = 'United Kingdom')
  AND population < (
   SELECT population FROM world
    WHERE name = 'Germany');

-- # 5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONCAT(CAST(100*ROUND((population / (SELECT population FROM world WHERE name ='Germany')), 2) AS INT), '%')
FROM world
 WHERE continent = 'Europe';

-- # 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world
 WHERE gdp > (
  SELECT MAX(gdp) FROM world
   WHERE continent = 'Europe');

-- # 7. Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT x.continent, x.name, x.area
FROM world AS x
WHERE x.area = (
  SELECT MAX(y.area)
  FROM world AS y
  WHERE x.continent = y.continent);

-- # 8. List each continent and the name of the country that comes first alphabetically.
SELECT continent, name FROM world x
 WHERE name <= ALL(SELECT name FROM world y WHERE y.continent = x.continent)
 
 
-- # 9.
/*
Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents. Show name, continent and population.
*/
SELECT name, continent, population
FROM world x
WHERE 25000000  > ALL(SELECT population FROM world y WHERE x.continent = y.continent AND y.population > 0)


-- # 10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world x
WHERE population > ALL(SELECT population*3 FROM world y WHERE x.continent = y.continent AND population > 0 AND y.name != x.name)

  
