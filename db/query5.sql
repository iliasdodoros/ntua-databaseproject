

select Research_Field, Research_Field1, count() from pair_of_fields group by Research_Field, Research_Field1 order by count() desc limit 3;