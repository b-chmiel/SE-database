DROP TYPE IF EXISTS "insurance_types" CASCADE;
DROP TYPE IF EXISTS "employee_type" CASCADE;
DROP TYPE IF EXISTS "department_type" CASCADE;
DROP TYPE IF EXISTS "insurance_types" CASCADE;
DROP TYPE IF EXISTS "visit_type" CASCADE;
DROP TYPE IF EXISTS "car_type" CASCADE;
DROP TYPE IF EXISTS "visit_status" CASCADE;

DROP TABLE IF EXISTS "action" CASCADE;
DROP TABLE IF EXISTS "car" CASCADE;
DROP TABLE IF EXISTS "client" CASCADE;
DROP TABLE IF EXISTS "department" CASCADE;
DROP TABLE IF EXISTS "department_equipment" CASCADE;
DROP TABLE IF EXISTS "diagnostic_profile" CASCADE;
DROP TABLE IF EXISTS "employee" CASCADE;
DROP TABLE IF EXISTS "insurance" CASCADE;
DROP TABLE IF EXISTS "item" CASCADE;
DROP TABLE IF EXISTS "visit" CASCADE;
DROP TABLE IF EXISTS "workshop" CASCADE;
DROP TABLE IF EXISTS "employee_visit" CASCADE;
DROP TABLE IF EXISTS "employee_car" CASCADE;
DROP TABLE IF EXISTS "workshop_department" CASCADE;

CREATE TYPE "insurance_types" AS ENUM (
  'OC',
  'AC'
);

CREATE TYPE "employee_type" AS ENUM (
  'MANAGER',
  'ADMINISTRATOR'
);

CREATE TYPE "car_type" AS ENUM (
  'SEDAN',
  'COUPE',
  'SPORTS_CAR',
  'STATION_WAGON',
  'HATCHBACK',
  'CONVERTIBLE',
  'SUV',
  'MPV',
  'MINIVAN',
  'PICKUP_TRUCK',
  'CROSSOVER',
  'VAN'
);

CREATE TYPE "visit_type" AS ENUM (
  'MAINTENANCE',
  'REPAIR'
);

CREATE TYPE "department_type" AS ENUM (
  'REPAIR_STATION',
  'DIAGNOSTIC_STATION',
  'AUTOMOTIVE_SHOP'
);

CREATE TYPE "visit_status" AS ENUM (
    'PENDING',
    'DONE'
);

CREATE TABLE "insurance" (
  "date_of_expiry" timestamp,
  "coverage" numeric,
  "type" insurance_types,
  "car_id" int,
  PRIMARY KEY (car_id, type)
);

CREATE TABLE "diagnostic_profile" (
  "car_id" int PRIMARY KEY,
  "visit_id" int,
  "employee_id" int,
  "engine" varchar,
  "body" varchar,
  "low_voltage" varchar,
  "lighting" varchar,
  "breakes" varchar,
  "sensors" varchar,
  "miscellaneous" varchar,
  "conditioning" varchar
);

CREATE TABLE "employee_car" (
  "employee_id" int,
  "car_id" int,
  PRIMARY KEY (employee_id, car_id)
);

CREATE TABLE "employee" (
  "employee_id" SERIAL PRIMARY KEY,
  "department_id" int,
  "type" employee_type
);

CREATE TABLE "employee_visit" (
  "employee_id" int,
  "visit_id" int,
  PRIMARY KEY (employee_id, visit_id)
);

CREATE TABLE "car" (
  "car_id" SERIAL PRIMARY KEY,
  "client_id" int,
  "model" varchar,
  "brand" varchar,
  "type" car_type
);

CREATE TABLE "visit" (
  "visit_id" SERIAL PRIMARY KEY,
  "client_id" int,
  "car_id" int,
  "date_of_visit" timestamp,
  "price" numeric,
  "type" visit_type,
  "status" visit_status
);

CREATE TABLE "action" (
  "visit_id" int,
  "action_desc" varchar
);

CREATE TABLE "client" (
  "client_id" SERIAL PRIMARY KEY,
  "name" varchar,
  "surname" varchar,
  "phone_number" varchar
);

CREATE TABLE "workshop" (
  "workshop_id" SERIAL PRIMARY KEY,
  "type" department_type,
  "latitude" float8,
  "longitude" float8
);

CREATE TABLE "workshop_department" (
  "workshop_id" int,
  "department_id" int,
  PRIMARY KEY (workshop_id, department_id)
);

CREATE TABLE "department" (
  "department_id" SERIAL PRIMARY KEY,
  "type" department_type
);

CREATE TABLE "department_equipment" (
  "department_id" int,
  "equipment" varchar,
  "quantity" numeric
);

CREATE TABLE "item" (
  "id" SERIAL UNIQUE PRIMARY KEY,
  "department_id" int,
  "name" varchar,
  "quantity" numeric
);

ALTER TABLE "insurance" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "diagnostic_profile" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "diagnostic_profile" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "diagnostic_profile" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "employee_car" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "employee_car" ADD FOREIGN KEY ("car_id") REFERENCES "diagnostic_profile" ("car_id");

ALTER TABLE "employee" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");

ALTER TABLE "visit" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("client_id");

ALTER TABLE "visit" ADD FOREIGN KEY ("car_id") REFERENCES "diagnostic_profile" ("car_id");

ALTER TABLE "action" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "department_equipment" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");

ALTER TABLE "item" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");

ALTER TABLE "employee_visit" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "employee_visit" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "car" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("client_id");

ALTER TABLE "workshop_department" ADD FOREIGN KEY ("workshop_id") REFERENCES "workshop" ("workshop_id");

ALTER TABLE "workshop_department" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");
