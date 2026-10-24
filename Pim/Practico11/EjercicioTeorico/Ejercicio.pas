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

procedure mutarFigura(var fig: figura; t: TipoFigura);

    procedure mutarCirculo(var fig: figura; r: real);
    begin
        with fig do 
        begin
            if t = cuadrado then 
                begin
                    clase := cuadrado;
                    lado:= r * sqrt(3.14);
                    verticeSupIzq.x := 0;
                    verticeSupIzq.y := 0
                end
            else if t = rectangulo then
                begin
                    clase:= rectangulo;
                    base:= r * 3.14;
                    altura:= r;
                    verticeInfIzq.x := 0;
                    verticeInfIzq.y := 0
                end;
        end;
    end;

    procedure mutarCuadrado(var fig: figura; lado: real);
    begin
        with fig do
        begin
            if t = circulo then 
            begin
                clase:= circulo;
                radio:= lado / sqrt(3.14);
                centro.x := 0;
                centro.y := 0;
            end
            else if t = rectangulo then 
            begin
                clase := rectangulo;
                base:= lado / 2;
                altura := 2*lado;
                verticeInfIzq.x := 0;
                verticeInfIzq.y := 0;
            end;
        end;
    end;

    procedure mutarRectangulo(var fig: figura; base, altura: real);
    begin
        with fig do
        begin
            if t = circulo then
            begin
                clase := circulo;
                radio := (base / altura) / sqrt(3.14);
                centro.x := 0;
                centro.y := 0;
            end
            else if t = cuadrado then 
            begin
                clase := cuadrado;
                lado := sqrt(base * altura);
                verticeSupIzq.x := 0;
                verticeSupIzq.y := 0;
            end;
        end;
    end;

begin
    with fig do
    begin
        case clase of 
            circulo: mutarCirculo(fig, radio);
            cuadrado: mutarCuadrado(fig, lado);
            rectangulo: mutarRectangulo(fig, base, altura);
        end;
    end;
end;

procedure imprimirFigura(fig: figura);

begin
    with fig do 
    begin
        if clase = cuadrado then
        begin
            writeln('la figura es un cuadrado');
            writeln('su lado es ', lado:0:2);
            writeln('la coordenada de su vertice es: ', verticeSupIzq.x:0:2, ' , ', verticeSupIzq.y:0:2)
        end
        else if clase = circulo then
        begin
            writeln('la figura es un circulo');
            writeln('su radio es ', radio:0:4);
            writeln('la coordenada de su centro es: ', centro.x:0:2, ' , ', centro.y:0:2)
        end
        else 
        begin
            writeln('la figura es un rectangulo');
            writeln('su base y altura son ', base:0:2, ' , ', altura:0:2);
            writeln('la coordenada de su vertice es: ', verticeInfIzq.x:0:2, ' , ', verticeInfIzq.y:0:2)
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
        lado:= 5;
    end;
masAlto := masArriba(fig, -5);
writeln(masAlto);
imprimirFigura(fig);

mutarFigura(fig, circulo);
imprimirFigura(fig)
end.