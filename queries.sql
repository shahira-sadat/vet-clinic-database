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


/*  Query multiple tables  */

SELECT name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';
SELECT a.name FROM animals AS a INNER JOIN species AS s ON species_id = s.id WHERE s.name = 'Pokemon';
SELECT a.name, o.full_name FROM animals AS a RIGHT JOIN owners As o ON owner_id = o.id;
SELECT s.name,COUNT(*) FROM animals  JOIN  species AS s  ON species_id = s.id GROUP BY s.name;

SELECT o.full_name AS owner, a.name AS  Digimon_Owned FROM animals AS a INNER JOIN owners AS o ON owner_id = o.id 
WHERE full_name = 'Jennifer Orwell' AND species_id=2;

SELECT o.full_name AS owner,a.name AS  Not_Tried_To_ESCAPE FROM animals AS a INNER JOIN owners As o ON owner_id = o.id 
WHERE full_name = 'Dean Winchester' and escape_attempts = 0 ;

SELECT o.full_name AS owner, COUNT(*) as owns   FROM animals AS a INNER JOIN owners As o ON owner_id = o.id  
GROUP BY o.full_name ORDER BY owns DESC LIMIT 1;


/* add "join table" for visits */

SELECT animals.name, vets.name, visits.visit_date FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher' 
ORDER BY visits.visit_date DESC LIMIT 1;

SELECT  COUNT(DISTINCT animals.name), vets.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

SELECT vets.name, species.name FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name, vets.name, visits.visit_date FROM animals
JOIN visits on animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id WHERE vets.name ='Stephanie Mendez' 
AND visits.visit_date BETWEEN 'April 1, 2020' AND 'August 30, 2020';

SELECT animals.name, COUNT(visits.animal_id) AS visits_no FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visits_no DESC LIMIT 1;

SELECT animals.name, visits.visit_date  FROM animals
JOIN visits on animals.id = visits.animal_id
JOIN vets on visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date  LIMIT 1;

SELECT animals.name, animals.date_of_birth,
animals.escape_attempts, animals.neutered, 
animals.weight_kg, species.name AS species,
owners.full_name AS owner, vets.name AS vet_name, vets.age,
vets.date_of_graduation AS grad_day,
visits.visit_date FROM animals
JOIN visits ON  animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
ORDER BY visits.visit_date DESC LIMIT 1;


SELECT  COUNT(visits.animal_id) FROM visits JOIN animals 
ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations 
    WHERE vet_id = vets.id
    );

SELECT species.name as advisable_specialization, COUNT(animals.species_id) as visit_no FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_no  DESC
LIMIT 1;
