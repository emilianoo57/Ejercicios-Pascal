program ejercicio13;

const CANT_SALONES = 15;
    MAX_PIZARRONES = 25;

type
    TSalon = record
        asientos : Integer;
        pizarrones : 1..MAX_PIZARRONES;
        hayProyector : Boolean;
    end;

    TFacultad = array [1..CANT_SALONES] of TSalon;

procedure informeSalones (facu: TFacultad);
var i:integer;

begin
    for i:= 1 to CANT_SALONES do 
    begin
        with facu[i] do
        begin
            writeln('Asientos: ', asientos);
            writeln('Pizarrones: ', pizarrones);
            writeln('Proyector: ', hayProyector)
        end;
    end;
end;

procedure salonMasAsientos (facu: TFacultad; var indSalon: Integer; var maxAsientos: Integer);

var i, masAsientos:integer;

begin
    masAsientos:= 1;
    for i:= 1 to CANT_SALONES do
        if facu[i].asientos > facu[masAsientos].asientos then masAsientos:= i;

    indSalon:= masAsientos;
    maxAsientos:= facu[masAsientos].asientos
end;

function primerSalonSinAsientos (facu: TFacultad) : Integer;
var i: integer;

begin
    i:= 1;
    while (i <= CANT_SALONES) and (facu[i].asientos > 0) do i:= i+1;
    if i > CANT_SALONES then primerSalonSinAsientos:= 0
    else primerSalonSinAsientos:= i
end;

begin
end.