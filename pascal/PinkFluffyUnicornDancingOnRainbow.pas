Program PinkFluffyUnicornDancingOnRainbow;
uses Crt, sysutils;
const
  UNICORN_HEIGHT = 5;
  UNICORN_WIDTH = 21;
  SPACE_OFFSET = 13;
type
  unicorn_array = array [1..UNICORN_HEIGHT] of string[UNICORN_WIDTH];
const
  RATE = 100;
  COLORS_COUNT = 5;
  OPEN_UNICORN : unicorn_array = (
          '          /| ',
          ' ~～～～~/ | ',
          '|       O  O ',
          '|         ∇ |',
          ' ~~~~∪∪~~~∪∪ '
  );
  CLOSE_UNICORN : unicorn_array = (
          '          /| ',
          ' ～～～～/ | ',
          '|       ⌒  ⌒ ',
          '|         ∇ |',
          ' ~~∪∪~~~∪∪~~ '
  );
  COLORS : array [1..COLORS_COUNT] of byte = (LightRed, Yellow, LightGreen, LightCyan, Magenta);
var
  term_width : integer = 64;
  counter : integer = 0;
  unicorn_offset : integer;

procedure RenderSpace (_offset : integer);
var i : integer = 0;
begin
  for i := 0 to _offset do
    Write(' ');
end;

procedure Pinkify (_ : string);
begin
  Textcolor(LightMagenta);
  WriteLn(_);
end;

procedure RenderUnicorn (_unicorns : unicorn_array);
var i : integer = 0;
begin
  for i := 0 to UNICORN_HEIGHT do
  begin
    RenderSpace(unicorn_offset);
    Pinkify(_unicorns[i]);
  end;
end;

procedure Rainbowify (_: string; index : integer);
begin
  Textcolor(COLORS[index]);
  Write(_);
end;

procedure RenderRainbow (_counter : integer);
var i, j : integer;
begin
  for i := 0 to (COLORS_COUNT) do
  begin
    for j := 0 to (term_width - 1) do
    begin
      if (_counter + j) mod 2 = 0 then
        Rainbowify('-', i)
      else
        Rainbowify('_', i);
    end;
    WriteLn('');
  end;
end;

procedure Draw (_counter : integer);
begin
  if _counter mod 10 > 5 then
    RenderUnicorn(OPEN_UNICORN)
  else
    RenderUnicorn(CLOSE_UNICORN);

  RenderRainbow(_counter);
end;

Begin
  unicorn_offset := round((term_width - UNICORN_WIDTH) / 2);

  while (true) do
  begin
    clrscr;

    Draw(counter);
    counter += 1;

    Textcolor(White);
    WriteLn('Press Ctrl-C to exit...');

    Delay(RATE);

    if KeyPressed then
      if ReadKey = ^C then
        break;
  end;
End.
