DROP TYPE IF EXISTS "insurance_types" CASCADE;
DROP TYPE IF EXISTS "employee_type" CASCADE;
DROP TYPE IF EXISTS "department_type" CASCADE;
DROP TYPE IF EXISTS "insurance_types" CASCADE;
DROP TYPE IF EXISTS "visit_type" CASCADE;
DROP TYPE IF EXISTS "car_type" CASCADE;

DROP TABLE IF EXISTS "action" CASCADE;
DROP TABLE IF EXISTS "car" CASCADE;
DROP TABLE IF EXISTS "client" CASCADE;
DROP TABLE IF EXISTS "department" CASCADE;
DROP TABLE IF EXISTS "department_equipment" CASCADE;
DROP TABLE IF EXISTS "diagnostic_profile" CASCADE;
DROP TABLE IF EXISTS "diagnostic_profile_employee" CASCADE;
DROP TABLE IF EXISTS "employee" CASCADE;
DROP TABLE IF EXISTS "insurance" CASCADE;
DROP TABLE IF EXISTS "item" CASCADE;
DROP TABLE IF EXISTS "visit" CASCADE;
DROP TABLE IF EXISTS "workshop" CASCADE;

CREATE TYPE "insurance_types" AS ENUM (
  'OC',
  'AC'
);

CREATE TYPE "employee_type" AS ENUM (
  'DIAGNOSTIC_EMPLOYEE',
  'CAR_WORKSHOP_EMPLOYEE',
  'AUTOMOTIVE_EMPLOYEE',
  'INSURANCE_EMPLOYEE',
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

CREATE TABLE "insurance" (
  "date_of_expiry" timestamp PRIMARY KEY,
  "coverage" numeric,
  "type" insurance_types,
  "car_id" int
);

CREATE TABLE "diagnostic_profile" (
  "profile_id" SERIAL PRIMARY KEY,
  "car_id" int,
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

CREATE TABLE "diagnostic_profile_employee" (
  "employee_id" int,
  "profile_id" int
);

CREATE TABLE "employee" (
  "employee_id" SERIAL PRIMARY KEY,
  "department_id" int,
  "type" employee_type
);

CREATE TABLE "car" (
  "car_id" SERIAL PRIMARY KEY,
  "model" varchar,
  "brand" varchar,
  "type" car_type
);

CREATE TABLE "visit" (
  "visit_id" SERIAL PRIMARY KEY,
  "employee_id" int,
  "client_id" int,
  "car_id" int,
  "date_of_visit" timestamp,
  "price" numeric,
  "type" visit_type
);

CREATE TABLE "action" (
  "visit_id" int,
  "action_desc" varchar,
  "price" numeric
);

CREATE TABLE "client" (
  "client_id" SERIAL PRIMARY KEY,
  "car_id" int,
  "name" varchar,
  "surname" varchar,
  "phone_number" varchar
);

CREATE TABLE "workshop" (
  "workshop_id" SERIAL PRIMARY KEY,
  "managed_by_department" int,
  "type" department_type,
  "latitude" float8,
  "longitude" float8
);

CREATE TABLE "department" (
  "department_id" SERIAL PRIMARY KEY,
  "manager_id" int,
  "admin_id" int,
  "latitude" float8,
  "longitude" float8
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

ALTER TABLE "diagnostic_profile_employee" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "diagnostic_profile_employee" ADD FOREIGN KEY ("profile_id") REFERENCES "diagnostic_profile" ("profile_id");

ALTER TABLE "employee" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");

ALTER TABLE "visit" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "visit" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("client_id");

ALTER TABLE "visit" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "action" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "workshop" ADD FOREIGN KEY ("managed_by_department") REFERENCES "department" ("department_id");

ALTER TABLE "department" ADD FOREIGN KEY ("manager_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "department" ADD FOREIGN KEY ("admin_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "department_equipment" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");

ALTER TABLE "item" ADD FOREIGN KEY ("department_id") REFERENCES "department" ("department_id");

ALTER TABLE "client" ADD FOREIGN KEY ("client_id") REFERENCES "car" ("car_id");
