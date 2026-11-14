program Ejercicio3;

const
    MAX = 10; {entero mayor estricto que 0}
type
    TComparacion = (mayor, menor, igual);
    TTexto = record
        nombre : array [1 .. MAX] of char;
        tope : 0 .. MAX;
    end;
    ArregloNombres = array [1..MAX] of TTexto;

function comparacionNombres(n1, n2:TTexto):TComparacion;
var i, minTope: integer;

begin
    i:= 1;
    if n1.tope < n2.tope then minTope:= n1.tope 
    else minTope:= n2.tope;

    while (i <= minTope) and (n1.nombre[i] = n2.nombre[i]) do i:= i + 1;

    if i <= minTope then 
        if n1.nombre[i] < n2.nombre[i] then comparacionNombres:= menor
        else comparacionNombres:= mayor
    else
        if (minTope = n1.tope) and (minTope = n2.tope) then comparacionNombres:= igual
        else if (minTope = n1.tope) then comparacionNombres:= menor
        else comparacionNombres:= mayor
end;

function buscarNombre(n:TTexto; a:arregloNombres):boolean;

begin
    case comparacionNombres of
        mayor:
        menor:
        igual:
    end;
end;

begin
end.