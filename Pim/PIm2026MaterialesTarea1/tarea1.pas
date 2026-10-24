procedure conteoOracion (maxCantPalabras: integer;
                        var cantA, cantE, cantI, cantO, cantU, cantConsonantes: integer;
                        var oracionNula, superaMaximo : boolean;
                        var largoPromedio : real);

   {Variables internas del procedimiento}
   var letraActual: char;
   var cantPalabras, cantLetras : integer;

      {Procedimiento para contar palabras y letras}

      procedure actualizarConteo (var superaMaximo: boolean; var cantPalabras, cantLetras: integer);
         begin
            if letraActual = SEPARADOR then
               begin
                  cantPalabras := cantPalabras +1;
                  if cantPalabras > maxCantPalabras then
                     superaMaximo:= true
               end
            else cantLetras:= cantLetras + 1
         end;

      {Funcion que devuelve el promedio de letras por palabra}

      function Promedio(var largoPromedio: real; cantPalabras, cantLetras: integer): real;
         begin

         {Se evita la ultima ejecucion cuando se supera el maximo}
            if not superaMaximo then

               Promedio := cantLetras / cantPalabras

            else Promedio:= cantLetras / (cantPalabras - 1)

         end;

      {Procedimiento para contar vocales y consonantes}
      
      procedure contarVocales(var cantA, cantE, cantI, cantO, cantU, cantConsonantes: integer; letraActual: char);
         begin

         {Se evita contar separadores como consonantes con un if}
          if letraActual <> SEPARADOR then
          begin 
            case letraActual of 
            'A', 'a': cantA:= cantA + 1;
            'E', 'e': cantE:= cantE + 1;
            'I', 'i': cantI:= cantI + 1;
            'O', 'o': cantO:= cantO + 1;
            'U', 'u': cantU:= cantU + 1;
            else cantConsonantes := cantConsonantes +1;
            end;
         end;
         end;

   {Ejecucion del procedimiento conteoOracion}

   begin

      {Inicializamos la letra actual y verificamos si es la palabra nula}

      read(letraActual);
      if letraActual = FINALIZADOR then 
      oracionNula := true;

      cantPalabras:= 1;
      cantLetras:= 0;

      while (not superaMaximo) and (letraActual <> FINALIZADOR) do
         begin

            actualizarConteo(superaMaximo, cantPalabras, cantLetras);
            largoPromedio:= Promedio(largoPromedio, cantPalabras, cantLetras);
            contarVocales(cantA, cantE, cantI, cantO, cantU, cantConsonantes, letraActual);

            read(letraActual)
         end;
   end;