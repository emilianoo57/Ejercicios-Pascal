const BARRA_SEPARADORA = '-------------------';


{ transformar datos a estructurados: }
procedure obtenerOrientacion(oriChar: char; var ori: TOrientacion);
begin
    if oriChar = 'H' then
        ori := horizontal
    else if oriChar = 'V' then
        ori := vertical;
end;

procedure obtenerPosicion(fila, columna: integer; var pos: TPosicion);
begin
    pos.fila := fila;
    pos.columna := columna;
end;

procedure buscarTramoPorPosicion(pos: TPosicion; ori: TOrientacion; tram: TTramos; var encontre: boolean; var idTramo: integer);
{Entrada: la posicion, orientacion y la lista de tramos}
{parametros de salidas: 'encontre' y idTramo del tramo con posicion pos y orientacion ori}
var
    i: integer;
begin
    i := 1;
    encontre := false;
    idTramo := 0;

    while (i <= tram.cantidad) and not encontre do
    begin
        encontre :=
            (tram.arreglo[i].posicion.fila = pos.fila) and
            (tram.arreglo[i].posicion.columna = pos.columna) and
            (tram.arreglo[i].orientacion = ori);

        if encontre then
            idTramo := i
        else
            i := i + 1;
    end;
end;

{ Manejo de E/S }

procedure leerPalabraDesde(var fuente: text; var palabra: TPalabra);
var car : char;
begin
    palabra.largo := 0;
    read(fuente, car);
    while (car <> FINALIZADOR) do
    begin
        palabra.largo := palabra.largo + 1;
        palabra.arreglo[palabra.largo] := car;
        read(fuente, car);
    end;
    readln(fuente);
end;

procedure leerPalabra(var palabra: TPalabra);
begin
    leerPalabraDesde(Input, palabra);
end;

procedure leerLineaDesde(var fuente : text; var id: integer; var orientacion: char; var fila, columna: integer; var palabra: TPalabra);
var descarte : char;
begin
    read(fuente, id, descarte, orientacion, descarte, fila, descarte, columna, descarte);
    leerPalabraDesde(fuente, palabra);
end;

procedure generarPartida(var fuente: text; var partida: TPartida);
var i, j, cantPalabras: integer;
    id: integer;
    oriChar: char;
    ori : TOrientacion;
    fila, columna: integer;
    palabra: TPalabra;

begin
    { Datos del archivo }
    readln(fuente, cantPalabras);
    readln(fuente); {descartar sepeardor}

    partida.banco.cantidad := 0;
    partida.tramos.cantidad := 0;

    { Inicializar partida.tablero }

    {recorrida total en false}
    for i := 1 to TAMANIO_TABLERO do
        for j := 1 to TAMANIO_TABLERO do
            partida.tablero[i][j].editable := false;

    for i:=1 to cantPalabras do
    begin
        palabra.largo := 0;
        leerLineaDesde(fuente, id, oriChar, fila, columna, palabra);
        obtenerOrientacion(oriChar, ori);

        partida.tablero[fila][columna].editable := true;

        partida.banco.arreglo[i].palabra := palabra;
        partida.banco.arreglo[i].insertada := false;
        partida.banco.cantidad := partida.banco.cantidad + 1;

        partida.tramos.cantidad := partida.tramos.cantidad + 1;
        partida.tramos.arreglo[i].orientacion := ori;
        partida.tramos.arreglo[i].posicion.fila := fila;
        partida.tramos.arreglo[i].posicion.columna := columna;
        partida.tramos.arreglo[i].largo := palabra.largo;
        
        partida.tramos.arreglo[i].ocupado := false;

        for j := 1 to palabra.largo do
        begin
            if ori = horizontal then
            begin
                partida.tablero[fila][columna + j - 1].editable := true;
                partida.tablero[fila][columna + j - 1].escrita := false;
            end
            else if ori = vertical then
            begin
                partida.tablero[fila + j - 1][columna].editable := true;
                partida.tablero[fila + j - 1][columna].escrita := false; 
            end;
        end;
    end;
end;

procedure imprimirPalabra(palabra :TPalabra);
var i :integer;
begin
    for i := 1 to palabra.largo do
        write(palabra.arreglo[i]);
end;

procedure mostrarBanco(banco : TBancoPalabras);
var i : integer;
begin
    if (banco.cantidad = 0) then
        writeln('Banco vacío')
    else
    begin
        for i := 1 to banco.cantidad do
        begin
            write(i:0,'. ');
            imprimirPalabra(banco.arreglo[i].palabra);
            writeln;
        end;
    end;
end;

procedure mostrarTablero(tab : TTablero);
    
    procedure escribirCasilla(casilla : TCasilla);
    begin
        if casilla.editable then
            if casilla.escrita then
                write(casilla.letra)
            else
                write('□')
        else
            write('■');
    end;

var i, j: integer;
begin
    {imprimir primera fila de numeros}
    write('  ');
    for i := 1 to TAMANIO_TABLERO do
    begin
        write(i:0, ' ');
    end;
    writeln;

    for i := 1 to TAMANIO_TABLERO do
    begin
        write(i:0, ' ');
        for j := 1 to TAMANIO_TABLERO do
        begin
            escribirCasilla(tab[i][j]);     
            write(' ');
        end;
        writeln;
    end;
end;

procedure imprimirSeparador();
begin
    writeln(BARRA_SEPARADORA);
end;

procedure mostrarPartida(tab : TTablero; banco: TBancoPalabras);
begin
    imprimirSeparador;
    mostrarBanco(banco);
    imprimirSeparador;
    mostrarTablero(tab);
    imprimirSeparador;
end;

procedure cargarNivel(nivel : char; var partida : TPartida);
var archivoNivel: text;
begin
    Assign(archivoNivel, 'niveles/'+nivel+'.lvl');
    reset(archivoNivel);
    generarPartida(archivoNivel, partida);
    Close(archivoNivel);
end;

function puedoInsertarEnTablero(pos: TPosicion; ori: TOrientacion;
    palabra: TPalabra; var tab: TTablero; tram: TTramos): boolean;
var
    df, dc, fila, columna, i, idTramo: integer;
    puedo, encontreTramo: boolean;
begin
    df := 0;
    dc := 0;
    if ori = horizontal then
        dc := 1
    else
        df := 1;

    { Posición y largo válidos }
    puedo := (pos.fila >= 1) and
             (pos.columna >= 1) and
             (palabra.largo >= 1) and
             (palabra.largo <= N);

    { La palabra completa debe caber en el tablero }
    if puedo then
        puedo := (pos.fila + df * (palabra.largo - 1)
                      <= TAMANIO_TABLERO) and
                 (pos.columna + dc * (palabra.largo - 1)
                      <= TAMANIO_TABLERO);

    { El tramo debe existir y estar libre; el comienzo puede ser un cruce }
    if puedo then
    begin
        buscarTramoPorPosicion(pos, ori, tram, encontreTramo, idTramo);
        puedo := encontreTramo;
        if puedo then
            puedo := not tram.arreglo[idTramo].ocupado;
        if puedo then
            puedo := tram.arreglo[idTramo].largo = palabra.largo;
    end;

    { Revisar todas las casillas y las letras de los cruces }
    i := 1;
    while puedo and (i <= palabra.largo) do
    begin
        fila := pos.fila + df * (i - 1);
        columna := pos.columna + dc * (i - 1);

        puedo := tab[fila][columna].editable;
        if puedo then
            if tab[fila][columna].escrita then
                puedo := tab[fila][columna].letra =
                         palabra.arreglo[i];

        i := i + 1;
    end;

    puedoInsertarEnTablero := puedo;
end;

{TAG: Rojo}
function puedoEliminar(nroLista: integer; banco: TBancoPalabras;
{TODO: Cambiar nroLista a idBanco}
    tram: TTramos): boolean;
var encontre: boolean;
    idTramo: integer;
begin
    puedoEliminar := false;
    if (nroLista >= 1) and (nroLista <= banco.cantidad) then
        if banco.arreglo[nroLista].insertada then
        begin
            buscarTramoPorIdBanco(nroLista, tram, encontre, idTramo);
            puedoEliminar := encontre;
        end;
end;

{ CASOS DE USO }
procedure casoInsertarPalabra(var partida: TPartida);
var
    oriChar : char;
    fila, columna, idLista : integer;
    ori : TOrientacion;
    pos : TPosicion;
    pal : TPalabra;
    estaEnBanco : boolean;
begin
    writeln('Insertar palabra:');
    writeln('Ingrese orientación (H/V), numero de fila y numero de columna separada por espacios:');
    writeln('Ejemplo: H 3 5');
    readln(oriChar, fila, columna);

    obtenerOrientacion(oriChar, ori);
    obtenerPosicion(fila, columna, pos);

    writeln('Ingrese palabra (terminada en punto): ');
    leerPalabra(pal);

    buscarPalabraEnBanco(pal, partida.banco, estaEnBanco, idLista);
    if not estaEnBanco then
        writeln('Palabra no válida')
    else if partida.banco.arreglo[idLista].insertada then
        writeln('La palabra ya está insertada')
    else if puedoInsertarEnTablero(pos, ori, pal, partida.tablero, partida.tramos) then
        insertarPalabra(pos, ori, pal, partida)
    else
        writeln('No se pudo insertar');
end;

procedure casoEliminarPalabra(var partida: TPArtida);
var
    id : integer;
begin
    writeln('Eliminar palabra');
    writeln('Ingrese número de lista de la palabra a eliminar');
    readln(id);
    if puedoEliminar(id, partida.banco, partida.tramos) then
        eliminarPalabra(id, partida)
    else
        writeln('No se pudo eliminar');
end;

procedure casoCalcularPuntaje(tablero : TTablero);
begin
    writeln('Calcular puntaje');
    writeln('Puntos: ', calcularPuntaje(tablero):0);
    write('Presione enter para continuar...');
    readln;
end;

{ VERIFICADORES }
{
procedure verificarLeerPalabra();
var
    palabra: TPalabra;
    i : integer;
begin
    writeln('Ingrese una palabra:');
    leerPalabra(palabra);
    write('Palabra: ');
    for i := 1 to palabra.largo do
        write(palabra.arreglo[i]);
    writeln;

    writeln('Largo: ', palabra.largo:0)
end;
}

procedure verCasillaDetalles(pos: TPosicion; var tab: TTablero);
begin
    if (pos.fila < 1) or (pos.columna < 1) then
        writeln('Posición inválida')
    else
    begin
        writeln('casilla (', pos.fila:0, ', ', pos.columna:0, '):');
        writeln('  editable: ', tab[pos.fila][pos.columna].editable);

        if tab[pos.fila][pos.columna].editable then
        begin
            writeln('  escrita: ', tab[pos.fila][pos.columna].escrita);

            if tab[pos.fila][pos.columna].escrita then
            begin
                writeln('  Letra: ', tab[pos.fila][pos.columna].letra);
                writeln('  Multiplicidad: ',
                        tab[pos.fila][pos.columna].multiplicidad:0);
            end;
        end;
    end;
end;

procedure verBancoDetalles(banco: TBancoPalabras);
var
    i: integer;
begin
    writeln('Cantidad de palabras: ', banco.cantidad:0);

    for i := 1 to banco.cantidad do
    begin
        writeln('Entrada ', i:0, ':');

        write('  Palabra: ');
        imprimirPalabra(banco.arreglo[i].palabra);
        writeln;

        writeln('  Largo: ', banco.arreglo[i].palabra.largo:0);
        writeln('  Insertada: ', banco.arreglo[i].insertada);
    end;
end;

procedure verTramos(tram: TTramos);
var
    i: integer;
begin
    writeln('Cantidad de tramos: ', tram.cantidad:0);

    for i := 1 to tram.cantidad do
    begin
        writeln('Tramo ', i:0, ':');
        writeln('  Fila: ', tram.arreglo[i].posicion.fila:0);
        writeln('  Columna: ', tram.arreglo[i].posicion.columna:0);

        write('  Orientación: ');
        if tram.arreglo[i].orientacion = horizontal then
            writeln('Horizontal')
        else
            writeln('Vertical');

        writeln('  Largo: ', tram.arreglo[i].largo:0);
        writeln('  Ocupado: ', tram.arreglo[i].ocupado);

        if tram.arreglo[i].ocupado then
            writeln('  Id en banco: ', tram.arreglo[i].idBanco:0);

        writeln;
    end;
end;

procedure verMultiplicidades(tab: TTablero);
var
    i, j: integer;
begin
    write('   ');
    for j := 1 to TAMANIO_TABLERO do
        write(j:3);
    writeln;

    for i := 1 to TAMANIO_TABLERO do
    begin
        write(i:3);
        for j := 1 to TAMANIO_TABLERO do
        begin
            if not tab[i][j].editable then
                write('-':3)
            else if not tab[i][j].escrita then
                write('*':3)
            else
                write(tab[i][j].multiplicidad:3);
        end;
        writeln;
    end;
end;

procedure verificarSonIgualesPalabras(pal1, pal2: TPalabra);
begin
    writeln('sonIgualesPalabras: ', sonIgualesPalabras(pal1, pal2));
end;

procedure verificarBuscarPalabraEnBanco(palabra: TPalabra; banco: TBancoPalabras; var encontre : boolean; var idLista : integer);
begin
    buscarPalabraEnBanco(palabra, banco, encontre, idLista);
    writeln('Encontré: ', encontre);
    if encontre then
        writeln('Número de lista: ', idLista:0);
end;

procedure verificarBuscarTramoPorIdBanco(idBanco: integer; tram: TTramos);
var
    encontre: boolean;
    idTramo: integer;
begin
    buscarTramoPorIdBanco(idBanco, tram, encontre, idTramo);
    writeln('Encontré: ', encontre);
    if encontre then
        writeln('Id de tramo: ', idTramo:0);
end;

procedure verificarFuncionalidadesExtra(var debug: integer; var partida: TPartida);
var fila, columna, idLista, idBanco : integer;
    encontre : boolean;
    pos : TPosicion;
    pal1, pal2 : TPalabra;
begin
    with partida do
    begin
        imprimirSeparador();
        writeln('MENU DE FUNCIONALIDADES EXTRA');
        imprimirSeparador();
        writeln('1. Ver Banco en detalle');
        writeln('2. Ver Casilla en detalle');
        writeln('3. Ver Tramos');
        writeln('4. Ver mapa de multiplicidades');
        writeln('5. Verificar sonIgualesPalabras');
        writeln('6. Verificar buscarPalabraEnBanco');
        writeln('7. Verificar buscarTramoPorIdBanco');

        writeln('0. Volver a la partida');

        readln(debug);
        case debug of
            1: begin
                writeln('verBancoDetalles');
                verBancoDetalles(banco);
            end;

            2: begin
                writeln('verCasillaDetalles');
                writeln('Ingrese posición (fila columna)');
                readln(fila, columna);
                obtenerPosicion(fila, columna, pos);
                verCasillaDetalles(pos, tablero);
            end;

            3: begin
                writeln('verTramos');
                verTramos(tramos);
            end;

            4: begin
                writeln('verMultiplicidades');
                verMultiplicidades(tablero);
            end;

            5: begin
                writeln('sonIgualesPalabras');
                writeln('Ingrese palabra 1 (terminada en punto):');
                leerPalabra(pal1);
                writeln('Ingrese palabra 2 (terminada en punto):');
                leerPalabra(pal2);
                verificarSonIgualesPalabras(pal1, pal2);
            end;

            6: begin
                writeln('buscarPalabraEnBanco');
                writeln('Ingrese palabra (terminada en punto):');
                leerPalabra(pal1);
                verificarBuscarPalabraEnBanco(pal1, banco, encontre, idLista);
            end;

            7: begin
                writeln('buscarTramoPorIdBanco');
                writeln('Ingrese número de lista de la palabra en el banco:');
                readln(idBanco);
                verificarBuscarTramoPorIdBanco(idBanco, tramos);
            end;

        end;

        write('Presione enter para continuar...');
        readln;
    end;
end;
