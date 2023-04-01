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
SELECT animals.name AS animal_name, owners.full_name AS owners_name FROM animals 
JOIN owners ON animals.owner_id= owners.id 
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name AS animal_name, species.name as species_name FROM animals JOIN species 
ON animals.species_id= species.id WHERE species.name = 'Pokemon';

SELECT DISTINCT owners.full_name AS owners_name, animals.name AS animal_name FROM animals 
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name AS animal_species, COUNT(animals.name) as total FROM animals JOIN species 
ON animals.species_id = species.id GROUP BY species.name;

SELECT owners.full_name AS owners_name, animals.name AS animal_name, species.name AS species_name 
FROM animals JOIN species ON animals.species_id = species.id 
JOIN owners ON animals.owner_id = owners.id  
WHERE owners.full_name='Jennifer Orwell' AND species.name = 'Digimon';

SELECT owners.full_name AS owners_name, animals.name AS animal_name, animals.escape_attempts FROM animals  
JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts =0; 

SELECT owners.full_name AS owners_name, COUNT(animals.name) AS animal_count FROM animals  
JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC LIMIT 1; 

-- Multi joined table queries 
SELECT animals.name AS animal_name, vets.name AS vet, visits.visit_date AS visit_data 
FROM animals JOIN vets ON animals.owner_id = vets.id 
JOIN visits ON visits.vets_id = animals.owner_id 
WHERE vets.name = 'William Tatcher' ORDER BY visits.visit_date DESC LIMIT 1;

SELECT vets.name, COUNT(DISTINCT visits.animals_id) FROM vets 
JOIN visits ON vets.id = visits.vets_id WHERE vets.name ='Stephanie Mendez' 
GROUP BY vets.name;

SELECT vets.name AS vet_name, species.name AS species_name, specializations.vets_id AS specialization_id FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species 
ON species.id = specializations.species_id;

SELECT animals.name AS animal_name, visits.visit_date AS visit_date, vets.name AS vet_name 
FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id 
WHERE visit_date BETWEEN '2020-04-01' AND '2020-08-30' ORDER BY visit_date DESC;

SELECT visits.animals_id, animals.name AS animal_name, COUNT(visits.visit_date) AS count FROM visits JOIN animals 
ON animals.id = visits.animals_id GROUP BY animals.name, visits.animals_id ORDER BY count DESC LIMIT 1;


SELECT vets.name AS vets_name, visits.visit_date AS visit_date, animals.name AS animal_name 
FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id 
WHERE vets.name ='Maisy Smith' ORDER BY visits.visit_date DESC LIMIT 1;

SELECT animals.name AS animal_name, visits.visit_date AS visit_date, vets.name AS vet_name 
FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id 
ORDER BY visit_date DESC LIMIT 1;

WITH view AS (SELECT S.name, V.name AS vet FROM vets V 
FULL JOIN visits Vi ON  V.id = Vi.vets_id FULL JOIN specializations SV ON SV.vets_id = V.id 
FULL JOIN species S ON S.id = SV.species_id WHERE S.name is NULL) 
SELECT vet, COUNT(vet) FROM view GROUP BY vet;

SELECT V.name AS vet ,S.name AS species,  COUNT(S.name) AS count 
FROM vets V FULL JOIN visits Vi ON  V.id = Vi.vets_id 
FULL JOIN animals A ON Vi.animals_id = A.id 
FULL JOIN species S ON S.id = A.species_id 
GROUP BY S.name,V.name HAVING V.name = 'Maisy Smith' ORDER BY count DESC LIMIT 1;

