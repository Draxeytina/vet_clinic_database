/*Queries that provide answers to the questions from all projects.*/

-- Name ending in mon
SELECT name FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.

SELECT name from animals WHERE date_of_birth between '2016-01-01' and '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT name from animals WHERE neutered = true and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.

SELECT * from animals WHERE neutered = true;

-- Find all animals not named Gabumon.

SELECT * from animals WHERE name NOT IN ('Gabumon');

-- Find all animals with a weight between 10.4kg and 17.3kg inclusive

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- ################################# DAY 2 ######################################


BEGIN;
UPDATE animals SET species = 'unspecified'
ROLLBACK;
SELECT * from animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS null;
COMMIT;
SELECT * from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

vet_clinic=# BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleteYoung;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO deleteYoung;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT count(id) FROM animals;
SELECT count(id) FROM animals WHERE escape_attempts = 0;
SELECT avg(weight_kg) from animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- ################################# DAY 3 ######################################

SELECT owners.full_name as Owner, animals.name as Animal FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name, species.name as specie FROM animals JOIN species ON species.id = animals.species_id WHERE species.name = 'Pokemon';
SELECT owners.full_name AS owner, animals.name FROM owners LEFT OUTER JOIN animals ON owners.id = animals.owner_id;
SELECT species.name, COUNT(animals.name) FROM animals INNER JOIN species ON species.id = animals.species_id GROUP BY species.name;
SELECT owners.full_name, species.name, animals.name FROM animals INNER JOIN species ON species.id = animals.species_id INNER JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT owners.full_name, animals.name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;
SELECT owners.full_name as Name, COUNT(animals.name) FROM animals JOIN owners ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.id) DESC LIMIT 1;