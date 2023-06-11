create table nombre
(m1 varchar(1),
a2 varchar(1),
r3 varchar(1),
t4 varchar(1),
h5 varchar(1),
a6 varchar(1)
)

select LEFT('martha',1), LEN('martha')

select * from INFORMATION_SCHEMA.TABLES

declare @sql nvarchar(4000)
set @sql = 'select * from INFORMATION_SCHEMA.TABLES'
exec sp_executesql @sql

declare @sql nvarchar(4000)
declare @palabra1 varchar(10),
    @palabra2 varchar(10),
    @contador int,
    @longitud1 int,
    @longitud2 int,
    @caracter varchar(3)
set @palabra1='martha'
set @palabra2='marta'
set @longitud1=LEN(@palabra1)
set @longitud2=LEN(@palabra2)
set @contador=1
set @sql='create table nombre('
while @contador<=@longitud1
begin
  set @caracter=LEFT(@palabra1, 1)
  set @sql=@sql+@caracter+cast(@contador as varchar(1))
  set @sql=@sql+@caracter+' int,'
  set @palabra1=RIGHT(@palabra1, LEN(@palabra1)-1)
  set @contador=@contador+1
end
set @sql=LEFT(@sql,LEN(@sql)-1)
set @sql=@sql+')'
exec sp_executesql @sql
declare @sql nvarchar(4000)
declare @palabra1 varchar(10),
    @palabra2 varchar(10),
    @contador int,
    @longitud1 int,
    @longitud2 int,
    @caracter varchar(3)
set @palabra1='martha'
set @palabra2='marta'
set @longitud1=LEN(@palabra1)
set @longitud2=LEN(@palabra2)
set @contador=1
set @sql='create table nombre('
while @contador<=@longitud1
begin
  set @caracter=LEFT(@palabra1, 1)
  set @sql=@sql+@caracter+cast(@contador as varchar(1))
  set @sql=@sql+@caracter+' int,'
  set @palabra1=RIGHT(@palabra1, LEN(@palabra1)-1)
  set @contador=@contador+1
end
set @sql=LEFT(@sql,LEN(@sql)-1)
set @sql=@sql+')'
exec sp_executesql @sql

set @contador=1
while @contador<=@longitud2
begin
  set @caracter=LEFT(@palabra1, 1)
  set @sql='select * from INFORMATION_SCHEMA.COLUMNS where LEFT(COLUMN_NAME,1)=''+@caracter+'' and  and ordinal_position>=1'
  set @palabra2=RIGHT(@palabra2, LEN(@palabra2)-1)
  set @contador=@contador+1
end
print @sql