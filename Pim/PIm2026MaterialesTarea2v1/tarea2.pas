function sonIgualesPalabras(palabra1, palabra2: TPalabra): boolean;

    function verificarIgualdad(largo: integer): boolean;
    begin
        if largo = 0 then 
            verificarIgualdad:= true
        else if palabra1.arreglo[largo] <> palabra2.arreglo[largo] then 
            verificarIgualdad:= false
        else 
            verificarIgualdad := verificarIgualdad(largo - 1)
    end;

begin
    if palabra1.largo <> palabra2.largo then sonIgualesPalabras:= false
    else sonIgualesPalabras:= verificarIgualdad(palabra1.largo)
end;

procedure buscarPalabraEnBanco(palabra: TPalabra; banco: TBancoPalabras; var encontre : boolean; var idBanco : integer);
begin
    with banco do 
    begin
        encontre:= false;
        while (cantidad > 0) and (not encontre) do 
        begin
            encontre:= sonIgualesPalabras(arreglo[cantidad].palabra, palabra);
            if not encontre then cantidad:= cantidad - 1
        end;

        if encontre then idBanco:= cantidad;
    end;
end;


procedure insertarPalabra(pos: TPosicion; ori: TOrientacion; palabra: TPalabra; var partida : TPartida);

procedure modificarTramo(idBanco: integer);

var encontre: boolean;
    i: integer;

begin
    with partida do
    begin
        with tramos do
        begin
            i:= cantidad;
            encontre:= false;
            while (i > 0) and (not encontre) do 
            begin
                if arreglo[i].orientacion = ori then
                    if (arreglo[i].posicion.columna = pos.columna) and
                        (arreglo[i].posicion.fila = pos.fila) then
                    begin 
                        arreglo[i].ocupado:= true;
                        arreglo[i].idBanco := idBanco;
                        encontre:= true
                    end;

                if not encontre then i := i - 1
            end;
        end;
    end;
end;

procedure modificarCasillas();
var i: integer;

begin
    with partida do
    begin
        if ori = horizontal then
        begin
            for i:= 0 to palabra.largo - 1 do
            begin
                with tablero[pos.fila, (pos.columna + i)] do
                begin
                    escrita := true;
                    letra := palabra.arreglo[i + 1]; 
                    multiplicidad := multiplicidad + 1
                end;
            end;
        end
        else
        begin
            for i:= 0 to palabra.largo - 1 do
            begin
                with tablero[(pos.fila + i), pos.columna] do
                begin
                    escrita := true;
                    letra := palabra.arreglo[i + 1];
                    multiplicidad := multiplicidad + 1
                end;
            end;
        end;
    end;
end;

var encontre: boolean;
    idBanco: integer;

begin
    encontre:= false;
    idBanco:= 0;
    with partida do
    begin
        buscarPalabraEnBanco(palabra, banco, encontre, idBanco);
        banco.arreglo[idBanco].insertada := true;
        modificarTramo(idBanco);
        modificarCasillas()
    end;
end;


procedure buscarTramoPorIdBanco(idBanco: integer; tram: TTramos; var encontre: boolean; var idTramo: integer);

begin
    with tram do
    begin
        encontre:= false;
        while (cantidad > 0) and (not encontre) do 
            begin
                if arreglo[cantidad].ocupado then encontre:= arreglo[cantidad].idBanco = idBanco;
                if not encontre then cantidad:= cantidad - 1
            end;

            if encontre then idTramo:= cantidad
    end;
end;

procedure eliminarPalabra(idBanco: integer; var partida : TPartida);

var encontre: boolean;
    i, idTramo: integer;

begin
    with partida do
    begin
        buscarTramoPorIdBanco(idBanco, tramos, encontre, idTramo);
        with tramos do
        begin
            arreglo[idTramo].ocupado := false;
            if arreglo[idTramo].orientacion = horizontal then
                for i:= 0 to arreglo[idTramo].largo - 1 do 
                    begin
                        with tablero[arreglo[idTramo].posicion.fila, (arreglo[idTramo].posicion.columna + i)] do
                        begin
                            multiplicidad := multiplicidad - 1;
                            if multiplicidad = 0 then escrita := false
                        end;
                    end
            else 
                for i:= 0 to arreglo[idTramo].largo - 1 do 
                    with tablero[(arreglo[idTramo].posicion.fila + i), arreglo[idTramo].posicion.columna] do
                        begin
                            multiplicidad := multiplicidad - 1;
                            if multiplicidad = 0 then escrita := false
                        end;
        end;
        banco.arreglo[idBanco].insertada:= false
    end;
end;

function calcularPuntaje(tablero : TTablero) : TNatural;

var i, j, puntaje: integer;

begin
    puntaje:= 0;
    for i:= 1 to TAMANIO_TABLERO do
        for j:= 1 to TAMANIO_TABLERO do
                if tablero[i, j].editable then 
                    if tablero[i, j].escrita then puntaje:= puntaje + 1;
    calcularPuntaje:= puntaje
end;
