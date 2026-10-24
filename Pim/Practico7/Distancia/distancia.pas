program distancia;
var x1, y1, x2, y2: real;
function distancias(x1, y1, x2, y2: real): real;
    var x, y: real; 
    begin
        x:= x1-x2;
        y:= y1 - y2;
        distancias := sqrt((x * x) + (y*y));
    end;
begin
    read(x1, y1, x2 , y2);

    writeln('la distancia es:', distancias(x1, y1, x2, y2):4:2);
end.