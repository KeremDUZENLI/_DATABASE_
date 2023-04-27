-- CREATE: Table global_values
create table if not exists "global_values" (
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


-- INSERT: 10 values
do $$
begin
    for i in 1..10 loop
        insert into global_values ("name", surname, alias, email, "password", password_hash, created_at, updated_at, deleted_at)
        values (
            globals.nameRandom((select queries from globals.global_variables limit 1 offset 0)),
            globals.nameRandom((select queries from globals.global_variables limit 1 offset 1)),
            globals.nameRandom((select queries from globals.global_variables limit 1 offset 2)),
            globals.emailRandom(),
            gen_random_uuid(),
            globals.passwordHashRandom(),
            now(),
            null,
           	'2025-01-01 00:00:00.000'
        );
    end loop;
end $$;



-- TEST: 
select * from global_values;
drop table global_values;




