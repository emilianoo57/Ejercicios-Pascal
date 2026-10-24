program ej3;

const N = 67;

type cadenaN = array [1..N] of integer;

function cantMayores(cadn: cadenaN; num: integer): integer;

    var i, contador: integer;

    begin
        for i:=1 to N do   
            if cadn[i] > num then contador:= contador + 1;
        cantMayores := contador
    end;

function ordenado (cadn : cadenaN): boolean;

    var i: integer;

    begin
        i:=1;
        while (i < N) and (cadn[i+1] >= cadn[i]) do i:= i + 1;
        ordenado:= (i = N); 
    end;


