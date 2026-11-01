const N = 100; {Entero mayor estricto que cero}
    FINALIZADOR = '.';
    MAX_CANT_PALABRAS = 100;
    TAMANIO_TABLERO = 9;


type 
    TNatural = 0..maxint;
    TOrientacion =(horizontal,vertical);

    TPalabra = record
      arreglo : array [1..N] of char;
      largo : TNatural;
    end;

    TPosicion = record
        fila, columna : 0..TAMANIO_TABLERO;
    end;

    TCasilla = record
        case editable : boolean of
            true :  (case escrita : boolean of
                        true : ( letra : char; multiplicidad : TNatural);
                        false: ();
                    );
            false : ();
    end;

    TTablero = array [1..TAMANIO_TABLERO, 1..TAMANIO_TABLERO] of TCasilla;

    TPalabraInfo = record
        palabra : TPalabra;
        insertada : boolean;
    end;

    
    TBancoPalabras = record
        arreglo : array [1..MAX_CANT_PALABRAS] of TPalabraInfo;
        cantidad : 0..MAX_CANT_PALABRAS;
    end;

    TTramo = record
        orientacion : TOrientacion;
        posicion : TPosicion;
        largo : 1..N;
        case ocupado : boolean of
            true: (idBanco : 1..MAX_CANT_PALABRAS);
            false: ();
    end;

    TTramos = record
        arreglo : array [1..MAX_CANT_PALABRAS] of TTramo;
        cantidad : 0..MAX_CANT_PALABRAS;
    end;


    TPartida = record
        banco : TBancoPalabras;
        tablero : TTablero;
        tramos : TTramos;
    end;
