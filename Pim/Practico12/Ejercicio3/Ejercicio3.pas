program ejercicio3;

var b,n, potenciab, log: integer;


function potencia (b , n : integer ): integer ;

begin
    if n = 0 then
    potencia := 1
    else potencia := b * potencia(b, n-1)

end;

function logaritmo (b , n : integer ): integer ;

begin
    if  n < b then
        logaritmo := 0
    else logaritmo := 1 + logaritmo(b, (n div b)) 
end;

begin
readln(b, n);
potenciab := potencia(b, n);
log:= logaritmo(b, n);
writeln(potenciab, log)
end.