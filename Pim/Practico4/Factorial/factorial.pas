program fact;
var k, fact, n: integer;
begin
readln(n);
    fact:= 1;
    for k := 2 to n do
    fact:= k * fact;
writeln(fact)
end.