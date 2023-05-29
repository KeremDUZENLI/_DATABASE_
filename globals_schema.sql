-- CREATE: Schema Globals
create schema globals;
create table globals.global_variables (queries text);
insert into globals.global_variables values 
	('select name from (values (''Alice''),(''Bob''),(''Charlie''),(''David''),(''Emma''),(''Frank''),(''Grace''),(''Henry''),(''Isabella''),(''Jack''),(''Kate''),(''Liam'')) as names(name) order by random() limit 1'),
	('select surname from (values (''Smith''),(''Johnson''),(''Williams''),(''Jones''),(''Brown''),(''Garcia''),(''Miller''),(''Davis''),(''Rodriguez''),(''Martinez''),(''Hernandez''),(''Lopez'')) as names(surname) order by random() limit 1'),
	('select alias from (values (''Batman''),(''Superman''),(''Joker''),(''Spiderman''),(''Wonderwoman''),(''Hulk''),(''Flash''),(''X-Man''),(''Dr. Strange''),(''Samurai Jack''),(''Gumball''),(''RickAndMorty'')) as names(alias) order by random() limit 1');



-- CREATE: nameRandom(query) numberRandom(limitNum) emailRandom() passwordHashRandom()
create or replace function globals.nameRandom(query text) returns text as $$
	declare
	    random_name text;
	begin
	    execute query into random_name;
	    return random_name;
	end $$ 
language plpgsql;


create or replace function globals.numberRandom(limitNum integer) returns integer as $$
	begin 
		return floor(random() * limitNum) + 1;
	end $$
language plpgsql;


create or replace function globals.emailRandom() returns text as $$
	declare
		random_email text;
	begin
		return globals.numberRandom(1000000) || '@example.com';
	end $$
language plpgsql;


create or replace function globals.passwordHashRandom() returns text as $$
	begin
		return '$' || md5(globals.numberRandom(1000000)::text);
	end $$
language plpgsql;



-- TEST:
select * from globals.global_variables;
drop table globals.global_variables;

select globals.nameRandom((select queries from globals.global_variables limit 1 offset 0));
select globals.nameRandom((select queries from globals.global_variables limit 1 offset 1));
select globals.nameRandom((select queries from globals.global_variables limit 1 offset 2));

select globals.numberRandom(12);
select globals.emailRandom();
select globals.passwordHashRandom();




