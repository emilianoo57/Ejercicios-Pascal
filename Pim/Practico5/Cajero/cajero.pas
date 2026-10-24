program cajero;
var importe, saldo: real;
var tipo: char;
begin
    readln(saldo);
    read(tipo);
    while tipo <> 'X' do 
    begin
    readln(importe);
        if (tipo = 'D') then
         saldo:= importe + saldo
        else if (tipo = 'R') then
            saldo:= saldo - importe
        else
            writeln('ingrese un tipo valido');
        read(tipo)
    end;
    writeln('tu saldo actual es ', saldo:8:2);
end.