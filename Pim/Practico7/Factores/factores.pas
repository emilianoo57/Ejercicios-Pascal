program factores;
var numero, i: integer;
var primerFactor: boolean;

procedure multiplicidadFactor(factor: integer; var numero: integer; var primerFactor: boolean);
begin
    while (numero mod factor) = 0 do
    begin

        if primerFactor then
            begin
                primerFactor:= false;
                numero:= numero div factor;
                write(factor:0, ' ')
            end
        else
            begin
                numero:= numero div factor;
                write( '* ', factor:0, ' ')
            end
            
    end;
end;

begin

read(numero);

while numero <> -1 do
    begin

        write(numero:0, ' = ');
        primerFactor:= true;

        for i:=2 to numero do multiplicidadFactor(i, numero, primerFactor);

        writeln();
        read(numero);

    end;

end.