DROP TYPE IF EXISTS "insurance_types" CASCADE;
DROP TYPE IF EXISTS "employee_type" CASCADE;
DROP TYPE IF EXISTS "company_type" CASCADE;
DROP TYPE IF EXISTS "insurance_types" CASCADE;
DROP TYPE IF EXISTS "visit_type" CASCADE;
DROP TYPE IF EXISTS "car_type" CASCADE;
DROP TYPE IF EXISTS "visit_status" CASCADE;

DROP TABLE IF EXISTS "action" CASCADE;
DROP TABLE IF EXISTS "car" CASCADE;
DROP TABLE IF EXISTS "client" CASCADE;
DROP TABLE IF EXISTS "company" CASCADE;
DROP TABLE IF EXISTS "diagnostic_profile" CASCADE;
DROP TABLE IF EXISTS "employee" CASCADE;
DROP TABLE IF EXISTS "insurance" CASCADE;
DROP TABLE IF EXISTS "auto_part" CASCADE;
DROP TABLE IF EXISTS "visit" CASCADE;
DROP TABLE IF EXISTS "employee_visit" CASCADE;
DROP TABLE IF EXISTS "payment" CASCADE;

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

CREATE TYPE "company_type" AS ENUM (
  'REPAIR_STATION',
  'DIAGNOSTIC_STATION',
  'AUTOMOTIVE_SHOP'
);

CREATE TYPE "visit_status" AS ENUM (
    'AT_SERVICE',
    'REPAIRED',
    'CHECKED_IN'
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
  "engine" varchar,
  "body" varchar,
  "low_voltage" varchar,
  "lighting" varchar,
  "breakes" varchar,
  "sensors" varchar,
  "miscellaneous" varchar,
  "conditioning" varchar
);

CREATE TABLE "employee" (
  "employee_id" SERIAL PRIMARY KEY,
  "company_id" int,
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
  "car_id" int,
  "date_of_visit" timestamp,
  "price" numeric,
  "type" visit_type,
  "status" visit_status
);

CREATE TABLE "action" (
  "visit_id" int,
  "action_desc" varchar,
  PRIMARY KEY (visit_id, action_desc)
);

CREATE TABLE "client" (
  "client_id" SERIAL PRIMARY KEY,
  "name" varchar,
  "surname" varchar,
  "phone_number" varchar,
  "email" varchar,
  "discount" numeric
);

CREATE TABLE company (
  "company_id" SERIAL PRIMARY KEY,
  "type" company_type,
  "latitude" float8,
  "longitude" float8
);

CREATE TABLE auto_part (
  "part_id" SERIAL UNIQUE PRIMARY KEY,
  "company_id" int,
  "model" varchar,
  "amount" numeric,
  "price" numeric
);

CREATE TABLE "payment" (
    "visit_id" int PRIMARY KEY,
    "employee_id" int,
    "amount" numeric,
    "advance" numeric,
    "is_fulfilled" bool
);

ALTER TABLE "insurance" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "diagnostic_profile" ADD FOREIGN KEY ("car_id") REFERENCES "car" ("car_id");

ALTER TABLE "diagnostic_profile" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "employee" ADD FOREIGN KEY ("company_id") REFERENCES company ("company_id");

ALTER TABLE "visit" ADD FOREIGN KEY ("car_id") REFERENCES "diagnostic_profile" ("car_id");

ALTER TABLE "action" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "auto_part" ADD FOREIGN KEY ("company_id") REFERENCES company ("company_id");

ALTER TABLE "employee_visit" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "employee_visit" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

ALTER TABLE "car" ADD FOREIGN KEY ("client_id") REFERENCES "client" ("client_id");

ALTER TABLE "payment" ADD FOREIGN KEY ("employee_id") REFERENCES "employee" ("employee_id");

ALTER TABLE "payment" ADD FOREIGN KEY ("visit_id") REFERENCES "visit" ("visit_id");

