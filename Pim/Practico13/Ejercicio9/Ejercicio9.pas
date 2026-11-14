program Ejercicio9;

const MAX = 3; {entero mayor estricto que 0}

type
    RangoCalificacion = 1..12;
    TAsignatura = (Criptografia,Programacion,Calculo);

    TEstudiante = record
        idEstudiante : integer;
        asignatura : TAsignatura;
        calificacion : RangoCalificacion;
    end;

    Rango = 1 .. MAX;
    EstudiantesAsignatura = array [rango] of TEstudiante;

procedure ordenarPorAsignatura(var e:EstudiantesAsignatura);

    function seleccionar(R: integer): integer;

        function mayorEstudiante(e1, e2: TEstudiante):boolean;
        begin
        mayorEstudiante:= (e1.asignatura > e2.asignatura) or 
                        ((e1.asignatura = e2.asignatura) and (e1.calificacion > e2.calificacion)) or
                        ((e1.asignatura = e2.asignatura) and (e1.calificacion = e2.calificacion) and (e1.idEstudiante > e2.idEstudiante))
        end;

    var i, mayor: integer;
    begin
        mayor:= 1;
        for i:= 2 to R do if mayorEstudiante(e[i], e[mayor]) then mayor:= i;
        seleccionar:= mayor
    end;

    procedure insertar(R, pos: integer);
    var aux: TEstudiante;
    begin
        aux:= e[pos];
        e[pos]:= e[R];
        e[R] := aux
    end;

var R: integer;
begin
    for R:= MAX downto 1 do
        insertar(R, seleccionar(R));
end;

procedure inicializar(var e: EstudiantesAsignatura);
var i: integer;

begin
    for i := 1 to MAX do
    begin
        writeln('estudiante: ', i:0);
        write('idEstudiante: ');
        readln(e[i].idEstudiante);
        write('Asignatura: ');
        readln(e[i].asignatura);
        write('Calificacion: ');
        readln(e[i].calificacion);
    end;

end;

procedure imprimir(e: EstudiantesAsignatura);
var i: integer;

begin
    for i := 1 to MAX do
    begin
        writeln('idEstudiante: ', e[i].idEstudiante:0);
        if e[i].asignatura = Criptografia then
            writeln('Asignatura: criptografia')
        else if e[i].asignatura = Programacion then 
            writeln('Asignatura: programacion')
        else writeln('Asignatura: calculo');
        writeln('Calificacion: ', e[i].calificacion:0);
    end;

end;

var e: EstudiantesAsignatura;

begin
    inicializar(e);
    ordenarPorAsignatura(e);
    imprimir(e);
end.