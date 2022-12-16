program tugas_2_no2;
uses crt;
function faktorial(i : integer):longint;
begin
    if i = 1 then
        faktorial := 1
    else
        faktorial := faktorial(i-1) * i;
end;
var
n : integer;
begin
clrscr;
write('masukkan input : '); readln(n);
write('hasil faktorial : ');
write(faktorial(n));
end.