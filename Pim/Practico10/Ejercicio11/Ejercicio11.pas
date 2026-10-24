program ejercicio11;

type Complejo = record
        re, im : Real;
    end;

procedure sumaComplejos (c1, c2 : Complejo; VAR c3 : Complejo);
begin
    with c3 do
        begin
            re:= c1.re + c2.re;
            im:= c1.im + c2.im
        end;
end;


procedure multComplejos (c1, c2 : Complejo; var c3 : Complejo);
var aux: Complejo;

begin
    
    with aux do
        begin
            re:= (c1.re * c2.re) - (c1.im * c2.im);
            im:= (c1.im * c2.re) + (c2.im * c1.re)
        end;
    c3:= aux;
end;

procedure escribirComplejo(c: Complejo);

begin
    with c do write(re:0:2, ' + ', im:0:2, 'i');
end;

procedure LeerComplejo(var c1, c2: Complejo);

begin

    write('Ingresa el primer complejo: ');
    with c1 do 
        read(re, im);
    write('Ingresa el segundo complejo: ');
    with c2 do read(re, im)

end;

var c1, c2, c3: Complejo;

begin

LeerComplejo(c1, c2);

sumaComplejos(c1, c2, c3);
write('Su suma es: ');
escribirComplejo(c3);
writeln();

multComplejos(c1, c2, c3);
write('Su multiplicacion es: ');
escribirComplejo(c3);
writeln()
end.