program ejercicio12;

const CANT_LETRAS = 200;
    CANT_ARTICULOS = 20;

type 
    TIdioma = (es, en, pt);
    TFecha = record 
        dia: 1..31;
        mes: 1..12;
        anio: 2001..9999
    end;

    Tnombre = array [1..CANT_LETRAS] of char;

    TArticulo = record
        nombre: Tnombre;
        idioma: Tidioma;
        visitas: integer;
        ultima_act: Tfecha
    end;

    Wikipedia = array [1..CANT_ARTICULOS] OF TArticulo;

function esPosterior (f1, f2: TFecha) : boolean;

    begin
        if f1.anio <> f2.anio then 
            esPosterior:= f1.anio > f2.anio

        else if f1.mes <> f2.mes then 
            esPosterior:= f1.mes > f2.mes
            
        else 
            esPosterior:= f1.dia > f2.dia
    end;

procedure articuloMasReciente (wiki: Wikipedia; idioma: TIdioma; VAR art: TArticulo);

    var i, j, ulTart: integer;

    begin
    // Se asume por la letra que hay al menos un articulo del idioma especificado en la wikipedia
        j:= 1;
        while wiki[j].idioma <> idioma do j:= j +1;
        ulTart := j;

        for i:=j to CANT_ARTICULOS do 
            if (wiki[i].idioma = idioma) then 
            if esPosterior(wiki[i].ultima_act, wiki[ulTart].ultima_act) then ulTart:= i;

        art:= wiki[ulTart];           
    end;

begin

end.