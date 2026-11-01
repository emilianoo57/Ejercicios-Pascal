program palabrasCruzadas;

{ Con esta directiva queda incluido el archivo definiciones.pas }
{$INCLUDE definiciones.pas}

{ Forward para poder usar buscarTramoPorPosicion en tarea2.pas}
procedure buscarTramoPorPosicion(pos: TPosicion; ori: TOrientacion;
    tram: TTramos; var encontre: boolean;
    var idTramo: integer); forward;

{ Con esta directiva queda incluido el archivo tarea1.pas }
{$INCLUDE tarea2.pas}

{ Con esta directiva queda incluido el archivo utils.pas }
{$INCLUDE utils.pas}

var 
    partidaActual : TPartida;
    opcion, debug : integer;
    nivel : char;


begin
    imprimirSeparador();
    writeln('PaScAlAbRaS cRuZaDaS');
    imprimirSeparador();
    writeln('Seleccione nivel (número del 1 al 5):');
    readln(nivel);

    cargarNivel(nivel, partidaActual);
    
    
    repeat
        mostrarPartida(partidaActual.tablero, partidaActual.banco);
        writeln('1. Insertar palabra');
        writeln('2. Eliminar palabra');
        writeln('3. Calcular puntaje');
        writeln('4. Verificar funcionalidades individualmente');
        writeln('0. Salir');

        readln(opcion);
        
        case opcion of
            1: begin
                casoInsertarPalabra(partidaActual);
            end;

            2: begin
                casoEliminarPalabra(partidaActual);
            end;

            3: begin
                casoCalcularPuntaje(partidaActual.tablero);
            end;

            4: begin
                writeln('Verificar funcionalidades individualmente');
                repeat
                    verificarFuncionalidadesExtra(debug, partidaActual);
                until debug = 0;
            end;

            0: begin
                opcion := 0;
                writeln('Chau!...');
            end;
            else
                writeln('Opción inválida');
        end;

    until opcion = 0;
end.
