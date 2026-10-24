program ejercicio5;

const N = 3;
const M = 10;  

type largoN = array [1..N] of char;
     largoM = array [1..M] of char;

var cadnN: largoN;
    cadnM: largoM;
    indice: integer;

procedure leerCadenaN(var cadn: largoN);
    var i: integer;

    begin
        for i:=1 to N do read(cadn[i]);
    end;

procedure leerCadenaM(var cadn: largoM);
    var i: integer;

    begin
        for i:=1 to M do read(cadn[i]);
    end;

function indiceSubCadena(cadnM: largoM; cadnN: largoN): integer;
var i, j: integer;
var encontrado: boolean;

    begin
        i:= 1;
        encontrado:= false;
        while (i<=(M - N + 1)) and (not encontrado) do 
        begin
            j:=1;
            while (j <= N) and (cadnN[j] = cadnM[i + j -1]) do j:= j + 1;

            if j > N then encontrado := true
            else i:= i + 1;
        end;

        if encontrado then indiceSubCadena:= i
        else indiceSubCadena := 0;
    end;

begin

    write('Ingrese los N caracteres de la cadena N: ');
     leerCadenaN(cadnN);
    readln();

    write('Ingrese los M caracteres de la cadena M: ');
    leerCadenaM(cadnM);

    indice := indiceSubCadena(cadnM, cadnN);
    if indice > 0 then writeln('la cadena se encuentra a partir de la posicion ', indice:0)
    else writeln('la cadena no se encuentra')

end.