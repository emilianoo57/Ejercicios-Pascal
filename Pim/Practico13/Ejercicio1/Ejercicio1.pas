program Ejercicio1;

const
    MAX = 10; {entero mayor estricto que 0}
type
    ArregloEnteros = array [1..MAX] of integer;

function cuantosMayores(v:integer; a:arregloEnteros):integer;

var i, contador: integer;

begin
    contador:= 0;
    for i:=1 to MAX do if a[i] > v then contador:= contador + 1;
    cuantosMayores:= contador
end;

function ultimaOcurrencia(e:integer; a:arregloEnteros):integer;

var i, pos: integer;

begin
    pos:= 0;
    for i:=1 to MAX do if a[i] = e then pos := i;
    ultimaOcurrencia:= pos
end;

function todosMayores(v:integer; a:arregloEnteros):boolean;
var i: integer;
begin
    i:= 0;
    while (i <= MAX) and (a[i] > v) do i:= i + 1;
    todosMayores:= (i > MAX)
end;

var v, i, o, c: integer;
    a: arregloEnteros;

begin
writeln('introduce las entradas del arreglo: ');
for i:= 1 to MAX do readln(a[i]);

writeln('introduce el valor');
readln(v);


o:= ultimaOcurrencia(v, a);

writeln('la ultima ocurrencia es: ', o:0);

c:= cuantosMayores(v, a);
writeln('la cantidad de numeros mayores es: ', c:0)

end.