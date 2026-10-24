program ejercicio3;

const MAX = 20; 
type
    Cadena = record
    letras : array [1..MAX] of char;
    largo : 0..MAX;
    end;   

procedure CargarCadena(var cadn: Cadena);
var i: integer;
    v: char;
begin
    i:= 0;
    read(v);
    with cadn do
    begin
    while (i < MAX) and (v <> '.') do 
        begin
            i:= i + 1;
            letras[i] := v;
            read(v)
        end;
    largo := i
    end
end;

procedure imprimirCadn(cadena: Cadena);
var i: integer;
begin
    with cadena do 
        begin
            for i:=1 to largo do write(letras[i])
        end
end;

function contarOcurrencias(frase: Cadena; letra: char): integer;
var i,contador: integer;
begin
    contador:= 0;
    with frase do 
        for i:= 1 to largo do 
            if (letras[i] = letra) then 
                contador:= contador + 1;
    contarOcurrencias := contador
end;

function existeVocal(frase: Cadena): boolean;
begin
    with frase do 
    begin
        
    end;
end;

var cadn: Cadena;
    ocurrencias: integer;

begin
    CargarCadena(cadn);
    imprimirCadn(cadn);
    ocurrencias:= contarOcurrencias(cadn, 'a');
    write(ocurrencias:0)
end.