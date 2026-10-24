program maxMin;
var max, min, n: integer;
begin
    read(n);
    while n < 0 do
        begin 
            write('ingrese un numero positivo');
            read(n);
        end;
    max:= n;
    min:= n;

        while n <> -1 do
            begin
            if n < 0 then
                begin
                writeln('ingrese un natural');
                read(n);
                end
            else
                begin
                  if n > max then
                  max:= n;
                  if n< min then
                  min:= n;
                end;
                read(n);
            end;
        writeln(min, max)
end.