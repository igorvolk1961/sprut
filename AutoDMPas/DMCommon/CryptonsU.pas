unit CryptonsU;


(****************************************)
(* *)
(* Модуль шифрования по алгоритму*)
(* используестся 128 битный ключ *)
(* ==================================== *)
(* *)
(****************************************)

interface

uses
windows,
sysutils,
classes;

const
  delta = $9e3779b9; // Смещение контрольной суммы ~ 32 бит
  _k0: int64 = $982c98c1; // Главный 128 битный ключ (4 части по 32 бита)
  _k1: int64 = $7f8f4d4b; // Его нужно изменить на свой аналог...
  _k2: int64 = $bcae3151;
  _k3: int64 = $971bc789;
  header = 'eta'; // enhanced tea

type
  phash = ^thash;
  thash = array of byte;

function decript(var s: thash): boolean;
function decript2(var s: thash): boolean;
procedure encript(var s: thash);

implementation

////////////////////////////////////////////////////////////////////////////////
procedure encript(var s: thash);
var
  inbuf,
  outbuf,
  resultbuf: thash; // Входной, выходной и результирующий буфера
  y, z, sum: int64;//longword; // Временные переменные для кодируемых блоков данных
  k0, k1, k2 , k3: int64;//longword; // Текущий ключ для шифрования
  i, a, len: integer; // Переменные для циклов
  c: byte; // Счетчик кол-ва мусора
  guid, key: string;
  g: tguid;
begin
  // Проверка размера данных
  if length(s) = 0 then exit;

//  createguid(g); // Генерируем ключик на основе guid - а :)
//  guid := guidtostring(g);
//  for i := 1 to length(guid) do
//    if guid[i] in ['0'..'9', 'a'..'f'] then
//      key := key + guid[i];
  key := '89203465321384960234974983687645';

  k0 := strtoint64('$' + copy(key, 1, 8));
  k1 := strtoint64('$' + copy(key, 9, 8));
  k2 := strtoint64('$' + copy(key, 17, 8));
  k3 := strtoint64('$' + copy(key, 25, 8));

  c := 0; // Инициализируем счетчик дозаполнений
  // Дозаполняем данные чтобы последний блок данных был равен 64 битам
  while (length(s) div 8) * 8 <> length(s) do // 64 бита = 8 байтам :)
    begin
      len := length(s);
      inc(len);
      setlength(s, len);
      s[len - 1] := random(255); // Заполняем случайными данными
      inc(c);
    end;

  len := length(s); // Вычисляем размер кодируемого блока
  setlength(inbuf, len); // Устанавливаем размер буферов

// Размер выходного буфера увеличен на 21 байт из-за
// 3 байта - заголовок eta
// 1 байт - счетчик кол-ва мусора в конце буфера
// 16 байт - кодированный ключ - 4 cardinal
// 1 байт - метка расположения кодированного ключа
  inc(len, 21);
  setlength(outbuf, len);
  setlength(resultbuf, len);

  inc(c);// Увеличим кол-во мусора для удаления самого поля счетчика
  outbuf[0] := ord(header[1]); // добавляем идентификатор
  outbuf[1] := ord(header[2]);
  outbuf[2] := ord(header[3]);
  outbuf[3] := c; // Добавляем счетчик мусора

  move(s[0], inbuf[0], length(s));// Заполняем входной буфер данными

  i := 0;
  while i < len - 21 do begin // Непосредственно кодировка
    move(inbuf[i], y, 4); // Берем первые 32 бита
    move(inbuf[i + 4], z, 4); // Берем вторые 32 бита
    // Кодируем
    sum := 0;
    for a := 0 to 31 do begin// 64 битный кодируемый блок (2 части по 32 бита)
      inc(sum, delta);
      inc(y, ((z shl 4) + k0) xor (z + sum) xor ((z shr 5) + k1));
      inc(z, ((y shl 4) + k2) xor (y + sum) xor ((y shr 5) + k3));
    end;
    move (y, outbuf[i + 4], 4); // Помещаем кодированные блоки в выходном буфер
    move (z, outbuf[i + 8], 4);
    inc(i, 8); // Пропускаем обработанный блок, переходим к следующему
  end;

  sum := 0;
  for a := 0 to 31 do begin// Кодируем первые 2 части ключа внутренним ключем
    inc(sum,delta);
    inc(k0, ((k1 shl 4) + _k0) xor (k1 + sum) xor ((k1 shr 5) + _k1));
    inc(k1, ((k0 shl 4) + _k2) xor (k0 + sum) xor ((k0 shr 5) + _k3));
  end;

  sum := 0;
  for a := 0 to 31 do begin// Кодируем вторые 2 части ключа внутренним ключем
    inc(sum, delta);
    inc(k2, ((k3 shl 4) + _k0) xor (k3 + sum) xor ((k3 shr 5) + _k1));
    inc(k3, ((k2 shl 4) + _k2) xor (k2 + sum) xor ((k2 shr 5) + _k3));
  end;

  // Определяем позицию размещения ключа в блоке данных
  randomize;
  if len < 255 then
    i := len
  else
    i := 255;
  repeat
    i := random(i);
    if i < 4 then i := 4;
  until i <= len - 17;

  // Смещаем данные освобождая место для четырех
  // частей ключа
  move(outbuf[0], resultbuf[0], i);
  move(outbuf[i], resultbuf[i + 16], len - i - 17);

  // Разбиваем четвертую четверть ключа на 4 восьмибитных части
  resultbuf[i] := byte(k3 shr 24);
  resultbuf[i + 1] := byte(k3 shr 16);
  resultbuf[i + 2] := byte(k3 shr 8);
  resultbuf[i + 3] := byte(k3);

  // Разбиваем третью четверть ключа на 4 восьмибитных части
  resultbuf[i + 4] := byte(k2 shr 24);
  resultbuf[i + 5] := byte(k2 shr 16);
  resultbuf[i + 6] := byte(k2 shr 8);
  resultbuf[i + 7] := byte(k2);

  // Разбиваем первую четверть ключа на 4 восьмибитных части
  resultbuf[i + 8] := byte(k0 shr 24);
  resultbuf[i + 9] := byte(k0 shr 16);
  resultbuf[i + 10] := byte(k0 shr 8);
  resultbuf[i + 11] := byte(k0);

  // Разбиваем вторую четверть ключа на 4 восьмибитных части
  resultbuf[i + 12] := byte(k1 shr 24);
  resultbuf[i + 13] := byte(k1 shr 16);
  resultbuf[i + 14] := byte(k1 shr 8);
  resultbuf[i + 15] := byte(k1);

  // Сдвигаем данные с 14 позиции на одну вправо для метки
  // (буфер начинается с нуля)
  for a := len - 1 downto 14 do
    resultbuf[a] := resultbuf[a - 1];

  // Помещаем метку начала ключа (14-й байт)
  resultbuf[13] := i;

  s := resultbuf;
end;

////////////////////////////////////////////////////////////////////////////////
//
// ЧАСТЬ ВТОРАЯ * * * ДЕКОДИРОВАНИЕ * * *

function decript (var s: thash): boolean;
var
inbuf,
outbuf,
resultbuf: thash; // Входной, выходной и результирующий буфера
y , z, sum: longword; // Временные переменные для кодируемых блоков данных
k0, k1, k2, k3: longword; // Текущий ключ для шифрования
i, a, len: integer; // Переменные для циклов 
aheader: string; 
begin 
result := false; 

len := length(s); // Вычисляем размер декодируемого блока 

// Проверка размера 
if len < 27 then exit; 
if len <> (((len - 21) div 8) * 8) + 21 then exit; 

// Проверка заголовка 
aheader := char(s[0]) + char(s[1]) + char(s[2]); 
if aheader <> header then exit; 

// Проверка позиции ключа 
if not(s[13] in [4..255]) then exit; 
if s[13] + 16 > len then exit; 

// Проверка счетчика мусора 
if s[3] > 8 then exit;

setlength(inbuf, len); // Устанавливаем размер буферов 

move(s[0], inbuf[0], len);// Заполняем входной буфер данными 

i := inbuf[13]; // Узнаем начальную позицию ключа 

// Удаляем метку на начало ключа 
for a := 13 to len - 2 do 
begin 
inbuf[a] := inbuf[a + 1]; 
inbuf[a + 1] := 0; 
end; 
dec(len); 

// Извлекаем ключ 
k3 :=(inbuf[i + 3] or (inbuf[i + 2] shl 8) or (inbuf[i + 1] shl 16) or (inbuf[i] shl 24)); 
k2 :=(inbuf[i + 7] or (inbuf[i + 6] shl 8) or (inbuf[i + 5] shl 16) or (inbuf[i + 4] shl 24)); 
k0 :=(inbuf[i + 11] or (inbuf[i + 10] shl 8) or (inbuf[i + 9] shl 16) or (inbuf[i + 8] shl 24)); 
k1 :=(inbuf[i + 15] or (inbuf[i + 14] shl 8) or (inbuf[i + 13] shl 16) or (inbuf[i + 12] shl 24)); 

// Удаляем ключ из блока данных
for a := i + 16 to len do
begin
inbuf[a - 16] := inbuf[a]; 
inbuf[a] := 0; 
end; 
setlength(outbuf, len); 
zeromemory(outbuf, len); 
dec(len, 16); // Удаляем размер ключа 

// Декодируем первые две части ключа 
sum := delta shl 5; 
for a := 0 to 31 do 
begin 
dec(k1, ((k0 shl 4) + _k2) xor (k0 + sum) xor ((k0 shr 5) + _k3)); 
dec(k0, ((k1 shl 4) + _k0) xor (k1 + sum) xor ((k1 shr 5) + _k1)); 
dec(sum, delta); 
end; 

// Декодируем вторые две части ключа 
sum := delta shl 5;
for a := 0 to 31 do 
begin 
dec(k3, ((k2 shl 4) + _k2) xor (k2 + sum) xor ((k2 shr 5) + _k3)); 
dec(k2, ((k3 shl 4) + _k0) xor (k3 + sum) xor ((k3 shr 5) + _k1)); 
dec(sum, delta); 
end; 

i := 0; 
dec(len); // Удяляем из размера место счетчика мусора 
dec(len, 3); // Удаляем из размера заголовок eta 
while i < len do // Непосредственно декодировка 
begin 
move(inbuf[i + 4], y, 4); // Берем первые 32 бита 
move(inbuf[i + 8], z, 4); // Берем вторые 32 бита 
// Декодируем 
sum := delta shl 5; 
for a := 0 to 31 do // 64 битный кодируемый блок (2 части по 32 бита) 
begin 
dec(z, ((y shl 4) + k2) xor (y + sum) xor ((y shr 5) + k3)); 
dec(y, ((z shl 4) + k0) xor (z + sum) xor ((z shr 5) + k1)); 
dec(sum, delta);
end; 
move(y, outbuf[i], 4); // Запоминаем кодированные блоки в выходном буфере 
move(z, outbuf[i + 4], 4); 
inc(i, 8); // Пропускаем обработанный блок, переходим к следующему 
end; 

// Отрезаем мусор (-1 потому что место для счетчика уже удалено из len) 
len := len - (inbuf[3] - 1); 
setlength(resultbuf, len); 
move(outbuf[0], resultbuf[0], len); 

// Выводим текст из выходного буфера 
s := resultbuf; 
result := true; 
end; 

function decript2 (var s: thash): boolean;
var
inbuf,
outbuf,
resultbuf: thash; // Входной, выходной и результирующий буфера
y , z, sum: Int64; // Временные переменные для кодируемых блоков данных
k0, k1, k2, k3: Int64; // Текущий ключ для шифрования
i, a, len: integer; // Переменные для циклов
aheader: string;
begin
result := false;

len := length(s); // Вычисляем размер декодируемого блока 

// Проверка размера 
if len < 27 then exit; 
if len <> (((len - 21) div 8) * 8) + 21 then exit; 

// Проверка заголовка 
aheader := char(s[0]) + char(s[1]) + char(s[2]); 
if aheader <> header then exit; 

// Проверка позиции ключа 
if not(s[13] in [4..255]) then exit; 
if s[13] + 16 > len then exit; 

// Проверка счетчика мусора 
if s[3] > 8 then exit; 

setlength(inbuf, len); // Устанавливаем размер буферов 

move(s[0], inbuf[0], len);// Заполняем входной буфер данными 

i := inbuf[13]; // Узнаем начальную позицию ключа 

// Удаляем метку на начало ключа 
for a := 13 to len - 2 do 
begin 
inbuf[a] := inbuf[a + 1]; 
inbuf[a + 1] := 0; 
end; 
dec(len); 

// Извлекаем ключ 
k3 :=(inbuf[i + 3] or (inbuf[i + 2] shl 8) or (inbuf[i + 1] shl 16) or (inbuf[i] shl 24)); 
k2 :=(inbuf[i + 7] or (inbuf[i + 6] shl 8) or (inbuf[i + 5] shl 16) or (inbuf[i + 4] shl 24)); 
k0 :=(inbuf[i + 11] or (inbuf[i + 10] shl 8) or (inbuf[i + 9] shl 16) or (inbuf[i + 8] shl 24));
k1 :=(inbuf[i + 15] or (inbuf[i + 14] shl 8) or (inbuf[i + 13] shl 16) or (inbuf[i + 12] shl 24)); 

// Удаляем ключ из блока данных
for a := i + 16 to len do
begin
inbuf[a - 16] := inbuf[a]; 
inbuf[a] := 0; 
end; 
setlength(outbuf, len); 
zeromemory(outbuf, len); 
dec(len, 16); // Удаляем размер ключа 

// Декодируем первые две части ключа 
sum := delta shl 5; 
for a := 0 to 31 do 
begin 
dec(k1, ((k0 shl 4) + _k2) xor (k0 + sum) xor ((k0 shr 5) + _k3)); 
dec(k0, ((k1 shl 4) + _k0) xor (k1 + sum) xor ((k1 shr 5) + _k1)); 
dec(sum, delta); 
end; 

// Декодируем вторые две части ключа 
sum := delta shl 5; 
for a := 0 to 31 do 
begin 
dec(k3, ((k2 shl 4) + _k2) xor (k2 + sum) xor ((k2 shr 5) + _k3)); 
dec(k2, ((k3 shl 4) + _k0) xor (k3 + sum) xor ((k3 shr 5) + _k1)); 
dec(sum, delta); 
end;

i := 0;
dec(len); // Удяляем из размера место счетчика мусора
dec(len, 3); // Удаляем из размера заголовок eta
while i < len do // Непосредственно декодировка
begin
move(inbuf[i + 4], y, 4); // Берем первые 32 бита
move(inbuf[i + 8], z, 4); // Берем вторые 32 бита
// Декодируем
{sum := delta shl 5;
for a := 0 to 31 do // 64 битный кодируемый блок (2 части по 32 бита)
begin
dec(z, ((y shl 4) + k2) xor (y + sum) xor ((y shr 5) + k3));
dec(y, ((z shl 4) + k0) xor (z + sum) xor ((z shr 5) + k1));
dec(sum, delta);
end;}
move(y, outbuf[i], 4); // Запоминаем кодированные блоки в выходном буфере
move(z, outbuf[i + 4], 4);
inc(i, 8); // Пропускаем обработанный блок, переходим к следующему
end;

// Отрезаем мусор (-1 потому что место для счетчика уже удалено из len)
len := len - (inbuf[3] - 1);
setlength(resultbuf, len);
move(outbuf[0], resultbuf[0], len);

// Выводим текст из выходного буфера
s := resultbuf;
result := true;
end;


end.


