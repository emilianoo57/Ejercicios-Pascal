program rectangulo;
var lado: integer;
var c1, c2: char;
procedure rectangulos (lado: integer; c1, c2:char);
var i, j, z: integer;
begin
    for i:= 1 to lado do
    begin
        for j:=1 to i do write(c1);
        for z:=1 to lado-i do write(c2);
        writeln();
    end
end;

begin
    readln(lado);
    readln(c1);
    readln(c2);
    rectangulos(lado, c1, c2);
end.