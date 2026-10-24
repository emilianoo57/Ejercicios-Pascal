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
    if ((b*b) - (4*a*c)) <> 0 then
    begin
        if ((b*b) - (4*a*c)) < 0 then
        begin
            r.cat := imaginarias;
            r.coeficienteReal := -b / (2*a);
            r.coeficienteImaginario := sqrt(abs((b*b) - (4*a*c))) / (2*a);
        end
        else
        begin
            r.cat:= distintas;
            r.raiz1:= (-b + sqrt((b*b) - (4*a*c))) / (2*a);
            r.raiz2:= (-b - sqrt((b*b) - (4*a*c))) / (2*a);
        end;
    end
    else 
    begin
        with r do 
        begin
            cat:= dobles;
            raiz:= -b / (2*a)
        end;
    end;
end;

procedure mostrarRaices(r: TipoRaices);

begin
    with r do 
    begin
        case cat of 
        distintas: write('las raices son: ', raiz1:0:2, ' y ', raiz2:0:2);
        imaginarias: write('las raices imaginarias son: ', coeficienteReal:0:2, ' +-', coeficienteImaginario:0:2, 'i');
        dobles: write('la raiz doble es ', raiz:0:2)
        end;
    end;
end;

var r: TipoRaices;
    a,b,c: integer;

begin
    readln(a, b, c);
    raices(a, b, c, r);
    mostrarRaices(r)
end.