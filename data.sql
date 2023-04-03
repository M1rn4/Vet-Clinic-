/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
(1, 'Agumon', '2020-02-03', 0, true, 10.23),
(2, 'Gabumon', '2018-11-15', 2, true, 8),
(3, 'Pikachu', '2021-01-07', 1, false, 15.04),
(4, 'Devimon', '2017-05-12', 5, true, 11);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES 
('Charmander', '2020-02-08', 0, false, -11, 'unknown'),
('Plantmon', '2021-11-15', 2, true, -5.7, 'unknown'),
('Squirtle', '1993-04-02', 3, false, -12.13, 'unknown'),
('Angemon', '2005-06-12', 1, true, -45, 'unknown'),
('Boarmon', '2005-06-07', 7, true, 20.4, 'unknown'),
('Blossom', '1998-10-13', 3, true, 17, 'unknown'),
('Ditto', '2022-05-14', 4, true, 22, 'unknown');

/*add new information day 3*/
INSERT INTO owners (full_name, age) VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Update animals table with owner information
UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (
  SELECT id FROM owners WHERE full_name = 'Dean Winchester'
)
WHERE name IN ('Angemon', 'Boarmon');

Para hacer referencia al ID de animal en lugar del nombre, primero necesitamos conocer el ID correspondiente de cada animal en la tabla de animales. Luego podemos modificar las consultas INSERT INTO de visitas para hacer referencia al ID del animal en lugar del nombre.

Suponiendo que los IDs de animales son los siguientes:

Agumon: 1
Gabumon: 2
Pikachu: 3
Devimon: 4
Charmander: 5
Plantmon: 6
Squirtle: 7
Angemon: 8
Boarmon: 9
Blossom: 10
Las consultas actualizadas serían las siguientes:

INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (10, 1, '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date) VALUES (10, 1, '2021-01-11');