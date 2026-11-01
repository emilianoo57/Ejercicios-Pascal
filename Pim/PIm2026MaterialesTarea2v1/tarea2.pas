function sonIgualesPalabras(palabra1, palabra2: TPalabra): boolean;

    function verificarIgualdad(palabra1, palabra2: TPalabra): boolean;
    begin
        with palabra1 do 
        begin
            if largo = 1 then verificarIgualdad:= arreglo[largo] = palabra2.arreglo[largo]
            else if palabra1.arreglo[largo] <> palabra2.arreglo[largo] then verificarIgualdad:= false
            else 
                begin
                    largo := largo - 1;
                    verificarIgualdad := verificarIgualdad(palabra1, palabra2)
                end;
        end;
    end;

begin
    if palabra1.largo <> palabra2.largo then sonIgualesPalabras:= false
    else sonIgualesPalabras:= verificarIgualdad(palabra1, palabra2)
end;

procedure buscarPalabraEnBanco(palabra: TPalabra; banco: TBancoPalabras; var encontre : boolean; var idBanco : integer);
begin   
    while (banco.cantidad > 0) and (not encontre) do 
    begin
        encontre:= sonIgualesPalabras(banco.arreglo[banco.cantidad].palabra, palabra);
        if not encontre then banco.cantidad:= banco.cantidad - 1
    end;

    if encontre then idBanco:= banco.cantidad

end;


procedure insertarPalabra(pos: TPosicion; ori: TOrientacion; palabra: TPalabra; var partida : TPartida);

procedure modificarTramo(pos: TPosicion; ori: TOrientacion; palabra: TPalabra; var partida : TPartida; idBanco: integer);

begin
    with partida do
    begin
        with tramos do
        begin
            while cantidad > 0 do 
            begin
                if arreglo[cantidad].orientacion = ori then
                begin
                    if (arreglo[cantidad].posicion.columna = pos.columna) and
                        (arreglo[cantidad].posicion.fila = pos.fila) then
                    begin 
                        arreglo[cantidad].ocupado:= true;
                        arreglo[cantidad].idBanco := idBanco
                    end;
                end
                else cantidad := cantidad - 1
            end;
                    writeln('se ha completado e lwhile');
        end;
    end;
end;

procedure modificarCasillas(pos: TPosicion; ori: TOrientacion; palabra: TPalabra; var partida: TPartida);
var i: integer;

begin
    with partida do
    begin
        for i:= 1 to palabra.largo do
        begin
            tablero[pos.fila, pos.columna].escrita := true;
            tablero[pos.fila, pos.columna].multiplicidad := tablero[pos.fila, pos.columna].multiplicidad + 1;
        end;
    end;
end;

var encontre: boolean;
    idBanco: integer;

begin
    with partida do
    begin
        buscarPalabraEnBanco(palabra, banco, encontre, idBanco);
        banco.arreglo[idBanco].insertada := true;
        modificarTramo(pos, ori, palabra, partida, idBanco);
        modificarCasillas(pos, ori, palabra, partida)
    end;
end;


procedure buscarTramoPorIdBanco(idBanco: integer; tram: TTramos; var encontre: boolean; var idTramo: integer);
begin

end;

procedure eliminarPalabra(idBanco: integer; var partida : TPartida);
begin

end;

function calcularPuntaje(tablero : TTablero) : TNatural;

begin
    { Reemplace este comentario y la instrucción siguiente por el código correspondiente a calcularPuntaje }
    calcularPuntaje := 0;
end;
