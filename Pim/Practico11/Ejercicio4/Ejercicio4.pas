program ejercicio4;

type clasificacion = (dobles, imaginarias, distintas);

    TipoRaices = record
        case cat: clasificacion of 
            dobles: (raiz: real);
            imaginarias: (coeficienteReal, coeficienteImaginario: real);
            distintas: (raiz1, raiz2: real;)
        end;

procedure raices (a,b,c : real; var r : TipoRaices);

begin

end;

procedure mostrarRaices(r: TipoRaices);

begin
    with r do 
    begin
        case cat of 
        distintas: write('las raices son: ', raiz1:0:2, ' y ', raiz2:0:2);
        imaginarias: write('las raices imaginarias son: ', coeficienteReal:0:2, ' + ', coeficienteImaginario:0:2, 'i');
        dobles: write('la raiz doble es ')
        end;
    end;
end;

begin
end.