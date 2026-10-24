program ejercicio4;

const N = 3;
type Matriz = array [1..3, 1..N] of integer;
     Fila = array [1..N] of integer;

var A: Matriz;
    num, m: integer;

procedure escribirMatriz(A: Matriz);
    var i, j: integer;

    begin
    for i:=1 to N do
            for j:=1 to N do
            begin
                if (j = 1) then write('|');
                write(A[i, j]:0);
                if (j = N) then write('|');
                if j = N then writeln(); 
            end; 
    end;

procedure LeerMatriz(var A: Matriz);

    var i, j: integer;

    begin

        for i:=1 to N do
            for j:=1 to N do 
            begin 
                read(A[i,j]);
                readln
            end;
    end;

procedure intercambioFilas(var A: Matriz; n, m: integer);
    var aux: Fila;

    begin
        aux := A[m];
        A[m] := A[n];
        A[n] := aux
    end;

begin
    LeerMatriz(A);
    escribirMatriz(A);
    read(num, m);
    intercambioFilas(A, num, m);
    escribirMatriz(A)
end.