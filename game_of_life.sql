CREATE TABLE living_cell (
  `x` INTEGER,
  `y` INTEGER
 );
  
 
 INSERT INTO living_cell VALUES (3,4),(4,4),(4,5),(5,3),(5,4);

select 
  l.x + filters.dx as new_x,
  l.y + filters.dy as new_y,
  sum(is_neighbour) neighbours, 
  sum(is_living) living 
from 
  living_cell l,
  (select -1 as dx, -1 as dy, 1 as is_neighbour, 0 as is_living union
    select -1, 0,1,0 union
    select -1, 1,1,0 union
    select  0,-1,1,0 union
    select  0, 0,0,1 union
    select  0, 1,1,0 union
    select  1,-1,1,0 union
    select  1, 0,1,0 union
    select  1, 1,1,0
  ) as filters
group by new_x, new_y
having neighbours = 3 or (neighbours = 2 and living = 1);
