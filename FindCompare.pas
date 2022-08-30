unit FindCompare;

interface

//------------------------------------------------------------------------------
//Функция нечеткого сравнения строк БЕЗ УЧЕТА РЕГИСТРА
//------------------------------------------------------------------------------
//MaxMatching - максимальная длина подстроки (достаточно 3-4)
//strInputMatching - сравниваемая строка
//strInputStandart - строка-образец

// Сравнивание без учета регистра
// if IndistinctMatching(4, "поисковая строка", "оригинальная строка  - эталон") > 40 then ...

function IndistinctMatching(MaxMatching     : Integer;
                            strInputMatching: WideString;
                            strInputStandart: WideString): Integer;
function IndistinctMatching2(A,B: String): Real;

implementation

Uses SysUtils;

Type
     TRetCount = packed record
                 lngSubRows   : Word;
                 lngCountLike : Word;
                end;

//------------------------------------------------------------------------------
function Matching(StrInputA: WideString;
                  StrInputB: WideString;
                  lngLen: Integer) : TRetCount;
Var
    TempRet   : TRetCount;
    PosStrA   : Integer;
    PosStrB   : Integer;
    StrA      : WideString;
    StrB      : WideString;
    StrTempA  : WideString;
    StrTempB  : WideString;
begin
    StrA := String(StrInputA);
    StrB := String(StrInputB);

    For PosStrA:= 1 To Length(strA) - lngLen + 1 do
    begin
       StrTempA:= System.Copy(strA, PosStrA, lngLen);

       For PosStrB:= 1 To Length(strB) - lngLen + 1 do
       begin
          StrTempB:= System.Copy(strB, PosStrB, lngLen);
          If SysUtils.AnsiCompareText(StrTempA,StrTempB) = 0 Then
          begin
             Inc(TempRet.lngCountLike);
             break;
          end;
       end;

       Inc(TempRet.lngSubRows);
    end; // PosStrA

    Matching.lngCountLike:= TempRet.lngCountLike;
    Matching.lngSubRows  := TempRet.lngSubRows;
end; { function }

//------------------------------------------------------------------------------
function IndistinctMatching(MaxMatching     : Integer;
                            strInputMatching: WideString;
                            strInputStandart: WideString): Integer;
Var
    gret     : TRetCount;
    tret     : TRetCount;
    lngCurLen: Integer   ; //текущая длина подстроки
begin
    //если не передан какой-либо параметр, то выход
    If (MaxMatching = 0) Or (Length(strInputMatching) = 0) Or
       (Length(strInputStandart) = 0) Then
    begin
        IndistinctMatching:= 0;
        exit;
    end;

    gret.lngCountLike:= 0;
    gret.lngSubRows  := 0;
    // Цикл прохода по длине сравниваемой фразы
    For lngCurLen:= 1 To MaxMatching do
    begin
        //Сравниваем строку A со строкой B
        tret:= Matching(strInputMatching, strInputStandart, lngCurLen);
        gret.lngCountLike := gret.lngCountLike + tret.lngCountLike;
        gret.lngSubRows   := gret.lngSubRows + tret.lngSubRows;
        //Сравниваем строку B со строкой A
        tret:= Matching(strInputStandart, strInputMatching, lngCurLen);
        gret.lngCountLike := gret.lngCountLike + tret.lngCountLike;
        gret.lngSubRows   := gret.lngSubRows + tret.lngSubRows;
    end;

    If gret.lngSubRows = 0 Then
    begin
        IndistinctMatching:= 0;
        exit;
    end;

    IndistinctMatching:= Trunc((gret.lngCountLike / gret.lngSubRows) * 100);
end;

//------------------------------------------------------------------------------
function IndistinctMatching2(A,B: String): Real;

      function Match(i,j: Byte): integer;
      label _Loop;
      var GlobalSumm, Summ, Max: integer;
      begin
          GlobalSumm := 0;    Max := 0;
          _Loop:
             if(A[i]=B[j])then begin
               Inc(GlobalSumm);
               if(i<Byte(Length(A))) and (j<Byte(Length(B)))then begin
                 Inc(i);
                 Inc(j);
                 goto _Loop;
               end;
             end;
          if(i<Byte(Length(A))) and (j<Byte(Length(B)))then begin
             Summ := Match(i+1,j+1);
             if(Max < Summ)then
                Max := Summ;
          end;
          if(i<Byte(Length(A)))then begin
             Summ := Match(i+1,j);
             if(Max < Summ)then
                Max := Summ;
          end;
          if(j<Byte(Length(B)))then begin
             Summ := Match(i,j+1);
             if(Max < Summ)then
                Max := Summ;
          end;
          Match := GlobalSumm + Max;
      end;

begin
   IndistinctMatching2 := Match(1,1) * 2.0 / (Byte(Length(A)) + Byte(Length(B)));
end;


end.
