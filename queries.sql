/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN TRANSACTION;

UPDATE animals SET species = 'unspecified';

SELECT * FROM animals; -- Verify that the species column has been updated

ROLLBACK;

SELECT * FROM animals; -- Verify that the species column has been rolled back to the original state

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

SELECT * FROM animals; -- Verify that the changes have been made and persisted

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

ROLLBACK;

SELECT * FROM animals; -- Verify that all records still exist

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT update_weights;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO update_weights;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

//How many animals are there?

SELECT COUNT(*) FROM animals;

// How many animals have never tried to escape?

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

// What the average weight_kg of animals

SELECT AVG(weight_kg) FROM animals;

// Who escapes the most, neutered  neutered animals?

SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal?*/

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/

SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/*Write queries (using JOIN) to answer the following questions:

/*List of all animals that are pokemon (their type is Pokemon).*/

SELECT animals.name, species.name AS species, owners.full_name AS owner
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

/*What animals belong to Melody Pond?*/
SELECT animals.name, species.name AS species
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT owners.full_name, animals.name AS pet_name, species.name AS species
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
LEFT JOIN species ON animals.species_id = species.id
ORDER BY owners.full_name;


/*How many animals are there per species?*/
SELECT species.name AS species, COUNT(*) AS count
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;


/*List all Digimon owned by Jennifer Orwell.*/
SELECT animals.name, species.name AS species, owners.full_name AS owner
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';


/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT a.name, s.name AS species, o.full_name AS owner
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;


/*Who owns the most animals?*/
SELECT owners.full_name AS owner, COUNT(animals.id) AS num_animals_owned
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY num_animals_owned DESC
LIMIT 1;

/*Write queries to answer the following:
Who was the last animal seen by William Tatcher?
*/


SELECT a.name AS last_animal_seen_by_William_Tatcher
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON vet.id = v.vet_id
WHERE vet.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

/*How many different animals did Stephanie Mendez see?*/
SELECT COUNT(DISTINCT animal_id) AS num_animals_seen_by_stephanie_mendez
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
WHERE ve.name = 'Stephanie Mendez';


/*List all vets and their specialties, including vets with no specialties.*/
SELECT v.name AS vet_name, s.name AS specialty_name
FROM vets v
LEFT JOIN specialties s ON v.specialty_id = s.id
ORDER BY v.name ASC;


/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT v.animal_id, a.name AS animal_name, v.visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.visit_date >= '2020-04-01' AND v.visit_date <= '2020-08-30' AND a.name LIKE '%Mendez%';


/*What animal has the most visits to vets?*/
SELECT a.name AS animal_name, COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;


/*Who was Maisy Smith's first visit?*/
SELECT MIN(visit_date) AS first_visit
FROM visits
WHERE person_name = 'Maisy Smith';


/*Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT a.*, v.*, visit_date
FROM animals a
INNER JOIN (
    SELECT animal_id, MAX(visit_date) AS max_date
    FROM visits
    GROUP BY animal_id
) vm
ON a.id = vm.animal_id
INNER JOIN visits v
ON vm.animal_id = v.animal_id AND vm.max_date = v.visit_date;


/*How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(*) AS num_visits
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
WHERE vt.specialty_id != a.species_id;


/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT animal_name, COUNT(*) AS num_visits
FROM visits
WHERE person_name = 'Maisy Smith'
GROUP BY animal_name
ORDER BY num_visits DESC
LIMIT 1;
