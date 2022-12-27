program snake_game;
uses crt;
label start;
const
    witdh = 80;
    height = 25;
Type
    indicator = ^part;

    part = record
        segment : char;
        coordinate_x,coordinate_y: byte;
        next : indicator;
    end;

var
    body,tail : indicator;
    i,headX,headY,foodX,foodY,boardX,boardY : byte;
    input, key, repeat_game, mode : char;
    FoodInsideSnake, TheEnd : boolean;
    score : word;
    board : array [1..height,1..witdh] of byte;
    speed : integer;

procedure SnakeDisplay(var count_loop : byte);
begin
    while tail^.next <> nil do
        with tail^ do
            begin
                if FoodInsideSnake = false then
                    if count_loop = 1 then
                        begin
                            gotoxy(coordinate_x,coordinate_y);
                            write(' ');
                            board[coordinate_y,coordinate_x] := 0;
                        end;
                coordinate_y := next^.coordinate_y;
                coordinate_x := next^.coordinate_x;

                if (headY = coordinate_y) and (headX = coordinate_x) then
                    TheEnd := true;

                gotoxy(coordinate_x,coordinate_y);
                writeln(segment);
                board[coordinate_y,coordinate_x] := 1;
                count_loop := count_loop + 1;
                tail := next;
            end;
end;

procedure AddSegment(length : byte);
var
    i : byte;
begin
    for i := 1 to length do
        begin
            new(tail);
            tail^.next := body;
            with tail^ do
                begin
                    segment := 'o';
                    coordinate_y := headY;
                    coordinate_x := headX;
                end;
            body := tail;
        end;
end;

procedure game_mode(var select_mode : char);
begin
    case select_mode of
        '1' : speed := 150 - score;
        '2' : speed := 125 - (2 * score);
        '3' : speed := 100 - (10 * score);
        '4' : speed := 1 - score;
    end;
end;

begin
clrscr;
        gotoxy(30,12);
        write('Welcome to snake game');
        gotoxy(30,14);
        write('game rules :');
        gotoxy(28,15);
        write('1. press "w" to move up');
        gotoxy(28,16);
        write('2. press "s" to move down');
        gotoxy(28,17);
        write('3. press "a" to move left');
        gotoxy(28,18);
        write('4. press "d" to move right');
        gotoxy(28,19);
        write('5. press "Esc" to close the game');
        gotoxy(28,21);
        write('Press any key to continue');
        readkey;
        clrscr;     
start : 
begin
        clrscr;
        new(body);
        tail := nil;
        body := nil;

        while (true) do begin
            gotoxy(30,12);
            write('select the mode');
            gotoxy(25,14);
            write('1 : Baby');
            gotoxy(25,15);
            write('2 : Normal');
            gotoxy(25,16);
            write('3 : Hard');
            gotoxy(25,17);
            write('4 : Impossible');
            mode := readkey;
            if (mode = '1') or (mode = '2') or (mode = '3') or (mode = '4') then
                break
            else
                continue;
        end;

        clrscr;
        gotoxy(1,2); write('#');
        gotoxy(witdh,2); write('#');

        for boardX := 2 to witdh-1 do begin
            gotoxy(boardX,2);
            write('#');
            gotoxy(boardX,height);
            write('#');
        end;

        for boardY := 3 to height-1 do begin
            gotoxy(1,boardY);
            write('#');
            gotoxy(witdh,boardY);
            write('#');
        end;

        gotoxy(1,height); write('#');
        gotoxy(witdh,height); write('#');

        headY := 12; headX := 40;
        foodY := random(height-3)+3; foodX := random(witdh-2)+2;
        AddSegment(1);
        input := 'a';

        FoodInsideSnake := true; TheEnd := false; score := 0;

        repeat
            if (headX = foodX) and (headY = foodY) then
                begin
                    AddSegment(1);
                    while board[foodY,foodX] = 1 do
                        begin
                            foodX := random(witdh-2) + 2;
                            foodY := random(height-3) + 3;
                        end;
                    FoodInsideSnake := true;
                    score := score + 1;
                end
            else
                begin
                    FoodInsideSnake := false;
                end;
            tail := body;

            if keypressed then
                begin
                    key := readkey;
                    if (key = 'w') and (input <> 's') or (key = 's') and (input <> 'w')
                        or (key = 'a') and (input <> 'd') or (key = 'd') and (input <> 'a') or (key = #27) then
                        input := key;
                end;
            if input = 'w' then headY := headY - 1;
            if input = 's' then headY := headY + 1;
            if input = 'a' then headX := headX - 1;
            if input = 'd' then headX := headX + 1;
            if input = #27 then halt;

            i := 1;
            SnakeDisplay(i);

            if i = 1 then
                begin
                    gotoxy(tail^.coordinate_x,tail^.coordinate_y);
                    write(' ')
                end;
            tail^.coordinate_y := headY;
            tail^.coordinate_x := headX;

            with tail^ do
                begin
                    gotoxy(coordinate_x,coordinate_y);
                    board[coordinate_y,coordinate_x] := 1;
                    write('O');
                end;

            gotoxy(foodX,foodY);
            writeln(chr(42));
            gotoxy(35,1);
            writeln('Score : ',score);
            game_mode(mode);

            if (headX = witdh) or (headX = 1) or (headY = 2) or (headY = height) then
                    TheEnd := true; 

            delay(speed)
        until TheEnd = true;
end;
clrscr;
while (true) do begin
    gotoxy(35,12);
    write('GAME OVER');
    gotoxy(33,13);
    write('Your Score : ',score);
    gotoxy(19,14);
    write('Press "Enter" to play again or "Esc" to quit');
    repeat_game := readkey;
    if repeat_game = #27 then halt
    else if repeat_game = #13 then goto start
    else continue;
end;
end.