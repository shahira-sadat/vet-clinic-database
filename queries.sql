/*Queries to answers the questions from projects requirements*/

SELECT name FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND  '2019-12-31';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name='Agumon' OR  name='Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals WHERE weight_kg  >= 10.4 AND weight_kg <= 17.3;

/* Part 1 */

BEGIN;

UPDATE animals
SET species = 'unspecified';

ROLLBACK;

/* Part 2 */

BEGIN;

UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

/* Part 3 */

BEGIN;

DELETE FROM animals;

ROLLBACK;

/* Part 4 */

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp1;

UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SAVEPOINT sp1;

UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

/* Part 5 */

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT CASE sub.neutered
WHEN sub.neutered = TRUE THEN 'Neutered escaped the most'
ELSE 'Not Neutered escaped the most'
END
FROM (
  SELECT neutered, SUM(escape_attempts) AS res FROM animals GROUP BY neutered
) AS sub
ORDER BY res DESC
LIMIT 1;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2001-01-01' GROUP BY species;
