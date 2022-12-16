program tugas_2_no3;
uses crt;
type
tanggal_lahir = record
    tanggal, tahun : integer;
    bulan : string;
end;
biodata = record
    nama, nim, alamat, HP, tempat_lahir : string;
    lahir : tanggal_lahir;
end;
var
data : array [0..100] of biodata;
i,n : integer;
begin
clrscr;
write('masukkan jumlah mahasiswa : '); readln(n);
for i := 1 to n do begin
    with data[i] do begin
        write('masukkan Nama          : '); readln(nama);
        write('masukkan NIM           : '); readln(nim);
        write('masukkan alamat        : '); readln(alamat);
        write('masukkan No.HP         : '); readln(HP);
        write('masukkan tempat lahir  : '); readln(tempat_lahir);
        writeln('masukkan tanggal lahir');
            with lahir do begin
                write('tanggal : '); readln(tanggal);
                write('bulan   : '); readln(bulan);
                write('tahun   : '); readln(tahun);
            end;
    end;
    writeln;
end;
clrscr;
for i := 1 to n do begin
writeln('data mahasiswa ke-',i);
    with data[i] do begin
       writeln('Nama          : ',nama);
       writeln('NIM           : ',nim);
       writeln('Alamat        : ',alamat);
       writeln('No.HP         : ',HP);
       writeln('Tempat Lahir  : ',tempat_lahir);
       with lahir do begin
            writeln('Tanggal lahir : ',tanggal,' ',bulan,' ',tahun);
       end; 
    end;
    writeln;
end;
end.