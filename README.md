# _DATABASE_
SQL WORKS


# POSTGRES DB CONNECTION
CREATE EXTENSION dblink;

SELECT id, "name", surname, created_at
FROM dblinkdblink('dbname= port= host= user= password=', 'SELECT id, "name", surname, created_at FROM schema.table')
AS getting(id int, "name" text, surname text, created_at timestamp);
