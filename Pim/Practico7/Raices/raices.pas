program raices;
var a, b, c, cant: integer;
var raiz1, raiz2: real;

procedure raices(a, b, c: integer; var raiz1, raiz2: real; var cant: integer);
begin
raiz1:= (-b + sqrt((b*b) - (4*a*c))) / (2*a);
raiz2:= (-b - sqrt((b*b) - (4*a*c))) / (2*a);
cant:= 2;
end;

begin

write('ingrese los coeficientes del polinomio:');
read(a, b, c);
raices(a, b, c, raiz1, raiz2, cant);
write('las raices son: cantidad =', cant:0, ' raiz 1 = ', raiz1:0:2, ' raiz 2 =', raiz2:0:2)

end.