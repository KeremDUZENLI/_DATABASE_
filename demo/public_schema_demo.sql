-- CREATE: Tables demo_values, demo_values_references
create table if not exists "demo_values" (
    "id" serial8 NOT NULL,
    "name" varchar(255) NOT NULL,
    "surname" varchar(255) NOT NULL,
    "alias" varchar(255) NOT NULL,
    "email" varchar(255) NOT NULL,
    "password" varchar(255) NOT NULL,
    "password_hash" varchar(255) NOT NULL,
    "created_at" timestamp,
    "updated_at" timestamp,
    "deleted_at" timestamp,
    PRIMARY KEY ("id")
);

create table IF NOT EXISTS "demo_values_references" (
    "id" serial8 NOT NULL,
    "user_id" int8 NOT NULL,
    "name" varchar(255) NOT NULL,
    "value" varchar(255) NOT NULL,
    PRIMARY KEY ("id")
);

ALTER TABLE "demo_values_references" ADD CONSTRAINT "user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "demo_values" ("id");



--TEST: 
select * from demo_values;
select * from demo_values_references;

drop table demo_values;
drop table demo_values_references;





-----------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION: global_values from global_db
CREATE EXTENSION dblink;
drop extension dblink cascade;





-----------------------------------------------------------------------------------------------------------------------------------
-- INSERT: 10 values
INSERT INTO demo_values (id, "name", surname, alias, email, "password", password_hash, created_at, updated_at, deleted_at)
SELECT id, "name", surname, alias, email, "password", password_hash, created_at, updated_at, deleted_at
FROM dblink('dbname=global_db port=5400 host=192.168.3.204 user=global password=global', 'SELECT id, "name", surname, alias, email, "password", password_hash, created_at, updated_at, deleted_at FROM public.global_values') 
AS getting(id int, "name" text, surname text, alias text, email text, "password" text, password_hash text, created_at timestamp, updated_at timestamp, deleted_at timestamp);



insert into demo_values_references (id, user_id, "name", value) select id, id, concat("name", ' ', surname), password_hash from demo_values;




