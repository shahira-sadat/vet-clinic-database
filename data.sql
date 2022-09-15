/* Insert sample data in to database */

INSERT INTO animals (id, name, date_of_birth , escape_attempts, neutered, weight_kg) 
VALUES (1,'Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (id, name, date_of_birth , escape_attempts, neutered, weight_kg) 
VALUES (2,'Gabumon', '2018-11-15', 2, TRUE, 8);

INSERT INTO animals (id, name, date_of_birth , escape_attempts, neutered, weight_kg) 
VALUES (3,'Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (id, name, date_of_birth , escape_attempts, neutered, weight_kg) 
VALUES (4,'Devimon', '2017-05-12', 5, TRUE, 11);


INSERT INTO animals (id, name, date_of_birth , escape_attempts, neutered, weight_kg) 
VALUES (5,'Charmander', '2020-02-08', 0, FALSE, -11),
       (6,'Plantmon', '2021-11-15', 2, TRUE, -5.7), 
       (7,'Squirtle', '1993-04-02', 3, FALSE, -12.13),
       (8,'Angemon', '2005-06-12', 1, TRUE, -45),
       (9,'Boarmon', '2005-06-7', 7, TRUE, 20.4),
       (10,'Blossom', '1998-10-13', 3, TRUE, 17),
       (11,'Ditto', '2022-05-14', 4, TRUE, 22);


INSERT INTO owners (full_name, age)                                                    
VALUES('Sam Smith', 34),
      ('Jennifer Orwell', 19),
      ('Bob', 45),
      ('Melody Pond', 77 ),
      ('Dean Winchester', 14),
      ('Jodie Whittaker', 38);

INSERT INTO species (name)                                                    
VALUES('Pokemon'),
      ('Digimon');

UPDATE animals SET species_id = 2  WHERE name LIKE '%mon'; 

UPDATE animals                                                                         
SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');


/* add "join table" for visits */

INSERT INTO vets (name, age, date_of_graduation)                                                    
VALUES('William Tatcher', 45 '2000-04-23'),
      ('Maisy Smith', 26, '2019-01-17'),
      ('Stephanie Mendez', 64, '1981-05-04'),
      ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) 
VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id FROM species WHERE name = 'Digimon'));


INSERT INTO visits (animal_id, vet_id, visit_date) 
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'May 24, 2020'),
       ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'July 22, 2020'),
       ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'February 2, 2021'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'January 5, 2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'March 8, 2020'),
       ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'May 14, 2020'),
       ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 4, 2021'),
      ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'February 24, 2021'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'December 21, 2019'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'August 10, 2020'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'April 7, 2021'),
      ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'September 29, 2019'),
      ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'October 3, 2020'),
      ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), 'November 4, 2020'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'January 24, 2019'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), ' May 15, 2019'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'February 27, 2020'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), 'August 3, 2020'),
      ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 'May 24, 2020'),
      ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), 'January 11, 2021');