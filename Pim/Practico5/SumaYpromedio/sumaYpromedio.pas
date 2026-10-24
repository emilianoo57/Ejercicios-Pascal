program sumaYpromedio;
var n, suma, numero, promedio: integer;
begin
    read(numero);
    suma:= 0;
    n:= 0;
    while numero <> -1 do
    begin
        if numero < 0 then 
        begin
        writeln('ingrese un numero positivo por favor');
        readln(numero);
        end
             else
        begin
            n := n+1;
            suma := suma  + numero;
            read(numero);
        end;
    end;
    promedio:= suma div n;
    writeln(suma, promedio)
end.