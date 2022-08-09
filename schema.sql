/* Database schema to keep the structure of entire database. */

CREATE TABLE public.animals
(
    id integer NOT NULL,
    name text NOT NULL,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric,
    PRIMARY KEY (id)
)

-- ################################# DAY 2 ######################################

ALTER TABLE animals
ADD species VARCHAR;