/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered=true AND escape_attempts <3;
SELECT date_of_birth from animals WHERE name IN('Agumon', 'Pikachu');
SELECT name, escape_attempts from animals WHERE weight_kg >10.5;
SELECT * from animals WHERE neutered=true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;

-- Updating the table with Transactions
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT "sp1";
UPDATE animals SET weight_kg = weight_kg*-1;
ROLLBACK TO "sp1";
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg <0;
COMMIT;

-- STATISTICAL DATA -- aggregation
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered
ORDER BY neutered DESC LIMIT 1;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Querying joined tables
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id= owners.id 
WHERE owners.full_name = 'Melody Pond';
SELECT animals.name AS animal_name, species.name as species_name FROM animals JOIN species 
ON animals.species_id= species.id WHERE species.name = 'Pokemon';

SELECT DISTINCT owners.full_name AS owners_name, animals.name AS animal_name FROM animals 
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.name) FROM animals JOIN species 
ON animals.species_id = species.id GROUP BY species.name;

SELECT owners.full_name, species.name FROM animals JOIN species ON animals.species_id = species.id 
JOIN owners ON animals.owner_id = owners.id  
WHERE owners.full_name='Jennifer Orwell' AND species.name = 'Digimon';

SELECT owners.full_name AS owners_name, animals.name, animals.escape_attempts FROM animals  
JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts =0; 

SELECT owners.full_name AS owners_name, COUNT(animals.name) AS animal_count FROM animals  
JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC LIMIT 1; 