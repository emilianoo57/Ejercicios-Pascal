program ejercicio6;

const
    MAXF = 3; {entero mayor estricto que 0}
    MAXC = 3; {entero mayor estricto que 0}
type
    RangoF = 1 .. MAXF;
    RangoC = 1 .. MAXC;
    TVariante = (rojo, azul, verde);
    TFicha = record
        tipo : TVariante;
        puntaje : integer;
    end;
    TTablero = array [rangoF, rangoC] of TFicha;

procedure ordenarTablero(var t:TTablero);

    procedure InsertarFicha(fila: RangoF; columna: RangoC);

        function esMenor(ficha1, ficha2: TFicha): boolean;
        begin
            esMenor := (ficha1.tipo < ficha2.tipo) or ((ficha1.tipo = ficha2.tipo) and (ficha1.puntaje < ficha2.puntaje));
        end;

    var aux: TFicha;

    begin 
        if (columna = MAXC) and (fila < MAXF) and esMenor(t[fila + 1, 1], t[fila, columna]) then 
        begin
            aux := t[fila + 1, 1];
            t[fila + 1, 1] := t[fila, columna];
            t[fila, columna] := aux;
            insertarFicha(fila + 1, 1)
        end
        else if (columna < MAXC) and esMenor(t[fila, columna + 1], t[fila, columna]) then 
        begin
            aux := t[fila, columna + 1];
            t[fila, columna + 1] := t[fila, columna];
            t[fila, columna] := aux;
            insertarFicha(fila, columna + 1);
        end;
    end;

var F: RangoF;
    C: RangoC;

begin
    for F := MAXF downto 1 do
        for C := MAXC downto 1 do
            InsertarFicha(F, C);
end;

procedure inicializarTablero(var t:TTablero);
var i: RangoF;
    j: RangoC;
begin
    for i := 1 to MAXF do
        for j := 1 to MAXC do
        begin
            writeln('Ficha: ', i:0, ' ', j:0);
            write('Tipo (rojo, azul, verde): ');
            readln(t[i,j].tipo);
            write('Puntaje: ');
            readln(t[i,j].puntaje);
        end;
end;

procedure imprimirTablero(t:TTablero);
var i: RangoF;
    j: RangoC;
begin
    for i := 1 to MAXF do
    begin
        for j := 1 to MAXC do if t[i,j].tipo = rojo then write('(', 'Rojo', ', ', t[i,j].puntaje:0, ') ') 
        else if t[i,j].tipo = azul then write('(', 'Azul', ', ', t[i,j].puntaje:0, ') ')
        else write('(', 'Verde', ', ', t[i,j].puntaje:0, ') ');
        writeln;
    end;
end;

var t: TTablero;

begin
inicializarTablero(t);
imprimirTablero(t);
ordenarTablero(t);
imprimirTablero(t)
end.