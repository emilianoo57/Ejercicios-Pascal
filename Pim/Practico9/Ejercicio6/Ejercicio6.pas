program ejercicio6;

const N = 3;

type arr = array [1..N, 1..N] of integer;

var A, b: arr;

procedure TraspuestaMatrizAB(a: arr; var b: arr);
var i, j: integer;

begin
    for i:=1 to N do
        for j:= 1 to N do b[i, j] := a[j, i];
end;

procedure LeerMatriz(var A: arr);
    var i, j: integer;

    begin

        for i:=1 to N do
            for j:=1 to N do 
            begin 
                read(A[i,j]);
                readln()
            end;
    end;

procedure escribirMatriz(A: arr);
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

begin
    LeerMatriz(A);
    writeln('Tu matriz es: ');
    escribirMatriz(A);
    TraspuestaMatrizAB(A, b);
    writeln('Su traspuesta es: ');
    escribirMatriz(b)
end.

                
