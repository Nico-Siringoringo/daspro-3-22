program tugas_2_no1;
uses crt;
function Range(n : integer; min,max : integer) : boolean;
begin
    Range := (n >= min) and (n <= max);
end;
var
a,i,j,n,min,max : integer;
nilai : array [0..100] of integer;
begin
clrscr;
min := 0;
max := 10;
repeat
    write('Masukkan jumlah mahasiswa : '); readln(n);
until Range(n,min,max);
max := 100;
for i := 1 to n do begin
    repeat
        write('Nilai mahasiswa ke-',i,' : '); readln(nilai[i]);
    until Range(nilai[i],min,max);
end;
for i := 2 to n do 
    begin
        a := nilai[i];
        j := i-1;
        while (j > 0) and (nilai[j]<a) do 
        begin
            nilai[j+1] := nilai[j];
            j -= 1;
        end;
        nilai[j+1] := a;
    end;
writeln;
writeln('urutan nilai UAS');
for i := 1 to n do begin
    write(nilai[i]);
    if i <> n then begin
        write(', ');
    end;
end;
end.