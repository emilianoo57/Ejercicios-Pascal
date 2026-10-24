program Ejercicio;

type RGBColor = record
    red,green,blue : 0..255;
    end;

    punto = record
        x,y: real;
    end;

    TipoFigura = (circulo,cuadrado,rectangulo);

    figura = record
    color: RGBColor;
    case clase: TipoFigura of
        circulo : (radio: real; centro: punto);
        cuadrado : (lado: real; verticeSupIzq: punto);
        rectangulo: (base,altura: real; verticeInfIzq: punto);
    end;


function masArriba(fig: figura; alt: real): boolean;

begin
    with fig do 
    begin
        case clase of 
            circulo : masArriba:= (centro.y - radio) > alt;
            rectangulo: masArriba:= (verticeInfIzq.y) > alt;
            cuadrado: masArriba:= (verticeSupIzq.y - lado) > alt 
        end;
    end;
end;

procedure mutar(var fig: figura; t: TipoFigura);

procedure mutarCirculo(var fig: figura; r: real);

begin
    with fig do 
    begin
        if t = cuadrado then 
            begin
                clase := cuadrado;
                lado:= r * sqrt(3.14)
            end;
        else if t = rectangulo then
            begin
                clase:= rectangulo;
                base:= r * 3.14;
                altura:= r
            end;
    end;
end;

begin
    with fig do
    begin
        case clase do 
            circulo: mutarCirculo(fig, radio);
            cuadrado: mutarCuadrado(fig, lado);
            rectangulo: mutarRectangulo(fig, base, altura);
        end;
    end;
end;

var fig: figura;
    masAlto: boolean;

begin
    with fig do 
    begin
        clase := cuadrado;
        verticeSupIzq.y := 3;
        verticeSupIzq.x:= 4;
        radio:= 5;
    end;
masAlto := masArriba(fig, -5);
write(masAlto)
end.