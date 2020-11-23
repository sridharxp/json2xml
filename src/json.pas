
(* Yacc parser template (TP Yacc V3.0), V1.2 6-17-91 AG *)

(* global definitions: *)

(*
Copyright (C) 2014, Sridharan S

This file is part of Json2Xml.

Json2Xml is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Json2Xml is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License version 3
along with json2xml.  If not, see <http://www.gnu.org/licenses/>.
*)
unit json;

interface

uses
  SysUtils, LexLib, YaccLib, jsonlex, Dialogs;
const
  preamble = '<?xml version="1.0" encoding="UTF-8"?>';
const LCB = 257;
const RCB = 258;
const LSB = 259;
const RSB = 260;
const COMMA = 261;
const COLON = 262;
const QUOTE = 263;
const TEXT = 264;
const QTEXT = 265;
const COMMENT = 266;

type YYSType = AnsiString;
var
  xmlText: ansiString;
  Id: AnsiString;
  Strs: array[0..4] of AnsiString;

  function EscapeXml(const str: AnsiString): AnsiString;
  procedure TagPush(const aStr: AnsiString);
  function TagPop: AnsiString;

var yylval : YYSType;

function yyparse: integer;

implementation

function yyparse : Integer;

var yystate, yysp, yyn : Integer;
    yys : array [1..yymaxdepth] of Integer;
    yyv : array [1..yymaxdepth] of YYSType;
    yyval : YYSType;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
begin
  (* actions: *)
  case yyruleno of
   1 : begin
         yyval := yyv[yysp-0] ; xmlText := preamble + #13#10 + '<ENVELOPE>' + #13#10 + yyval + #13#10 + '</ENVELOPE>';
         yyoutput.Write(pChar(XmlText)^, Length(XmlText)); 
       end;
   2 : begin
         TagPush('ENVELOPE'); Id := 'ENVELOPE';
       end;
   3 : begin
         Id := TagPop;
         yyval := yyv[yysp-0] ; xmlText := preamble + #13#10 + yyval;
         yyoutput.Write(pChar(XmlText)^, Length(XmlText)); 
       end;
   4 : begin
       end;
   5 : begin
         yyval := ''
       end;
   6 : begin
         yyval := yyv[yysp-1];
       end;
   7 : begin
         yyval := yyv[yysp-0];
       end;
   8 : begin
         yyval := yyv[yysp-2] + #13#10 + yyv[yysp-0];
       end;
   9 : begin
         yyval := yyv[yysp-0];
       end;
  10 : begin
         yyval :=  yyv[yysp-2] + #13#10 + yyv[yysp-0];
       end;
  11 : begin
         
         yyval := '<'+ yyv[yysp-2] +'>'+  yyv[yysp-0] + '</'+ yyv[yysp-2] +'>';
         
       end;
  12 : begin
         
         yyval := '<'+ yyv[yysp-2] +'>'+  #13#10 + yyv[yysp-0] + #13#10 + '</'+ yyv[yysp-2] +'>';
         
       end;
  13 : begin
         TagPush(Id); Id := yyv[yysp-1];
       end;
  14 : begin
         Id := TagPop;
         
         yyval := yyv[yysp-0];
         
       end;
  15 : begin
       end;
  16 : begin
         yyval := '';
       end;
  17 : begin
         yyval := yyv[yysp-1];
       end;
  18 : begin
         
         yyval := '<' + id + '>' + yyv[yysp-0] + '</' + id +'>';
         
       end;
  19 : begin
         
         yyval := '<' + id + '>' + #13#10 + yyv[yysp-0] + #13#10 + '</' + id +'>';
         
       end;
  20 : begin
         
         yyval := '<' + id + '>' + #13#10 + yyv[yysp-0] + #13#10 + '</' + id +'>';
         
       end;
  21 : begin
         yyval := '';
       end;
  22 : begin
         yyv[yysp-0] := yytext;
       end;
  23 : begin
         yyval := EscapeXml(yyv[yysp-2]);
       end;
  24 : begin
         yyval := yytext;
       end;
  end;
end(*yyaction*);

(* parse table: *)

type YYARec = record
                sym, act : Integer;
              end;
     YYRRec = record
                len, sym : Integer;
              end;

const

yynacts   = 31;
yyngotos  = 25;
yynstates = 36;
yynrules  = 24;

yya : array [1..yynacts] of YYARec = (
{ 0: }
  ( sym: 257; act: 4 ),
  ( sym: 259; act: -2 ),
{ 1: }
  ( sym: 259; act: 6 ),
{ 2: }
{ 3: }
  ( sym: 0; act: 0 ),
{ 4: }
  ( sym: 258; act: 10 ),
  ( sym: 263; act: 11 ),
  ( sym: 264; act: 12 ),
{ 5: }
{ 6: }
  ( sym: 257; act: 4 ),
  ( sym: 259; act: 6 ),
  ( sym: 260; act: 19 ),
  ( sym: 263; act: 11 ),
  ( sym: 264; act: 12 ),
{ 7: }
  ( sym: 262; act: 20 ),
{ 8: }
{ 9: }
  ( sym: 258; act: 21 ),
  ( sym: 261; act: 22 ),
{ 10: }
{ 11: }
  ( sym: 263; act: 23 ),
  ( sym: 265; act: 24 ),
{ 12: }
{ 13: }
{ 14: }
{ 15: }
{ 16: }
  ( sym: 260; act: 25 ),
  ( sym: 261; act: 26 ),
{ 17: }
{ 18: }
{ 19: }
{ 20: }
  ( sym: 257; act: 4 ),
  ( sym: 263; act: 11 ),
  ( sym: 264; act: 12 ),
  ( sym: 259; act: -13 ),
{ 21: }
{ 22: }
  ( sym: 263; act: 11 ),
  ( sym: 264; act: 12 ),
{ 23: }
{ 24: }
{ 25: }
{ 26: }
  ( sym: 257; act: 4 ),
  ( sym: 259; act: 6 ),
  ( sym: 263; act: 11 ),
  ( sym: 264; act: 12 ),
{ 27: }
  ( sym: 259; act: 6 ),
{ 28: }
{ 29: }
{ 30: }
{ 31: }
  ( sym: 263; act: 34 )
{ 32: }
{ 33: }
{ 34: }
{ 35: }
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -5; act: 1 ),
  ( sym: -3; act: 2 ),
  ( sym: -2; act: 3 ),
{ 1: }
  ( sym: -4; act: 5 ),
{ 2: }
{ 3: }
{ 4: }
  ( sym: -11; act: 7 ),
  ( sym: -8; act: 8 ),
  ( sym: -7; act: 9 ),
{ 5: }
  ( sym: -6; act: 13 ),
{ 6: }
  ( sym: -11; act: 14 ),
  ( sym: -10; act: 15 ),
  ( sym: -9; act: 16 ),
  ( sym: -4; act: 17 ),
  ( sym: -3; act: 18 ),
{ 7: }
{ 8: }
{ 9: }
{ 10: }
{ 11: }
{ 12: }
{ 13: }
{ 14: }
{ 15: }
{ 16: }
{ 17: }
{ 18: }
{ 19: }
{ 20: }
  ( sym: -12; act: 27 ),
  ( sym: -11; act: 28 ),
  ( sym: -3; act: 29 ),
{ 21: }
{ 22: }
  ( sym: -11; act: 7 ),
  ( sym: -8; act: 30 ),
{ 23: }
{ 24: }
  ( sym: -14; act: 31 ),
{ 25: }
{ 26: }
  ( sym: -11; act: 14 ),
  ( sym: -10; act: 32 ),
  ( sym: -4; act: 17 ),
  ( sym: -3; act: 18 ),
{ 27: }
  ( sym: -4; act: 33 ),
{ 28: }
{ 29: }
{ 30: }
{ 31: }
{ 32: }
{ 33: }
  ( sym: -13; act: 35 )
{ 34: }
{ 35: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } -1,
{ 3: } 0,
{ 4: } 0,
{ 5: } -3,
{ 6: } 0,
{ 7: } 0,
{ 8: } -7,
{ 9: } 0,
{ 10: } -5,
{ 11: } 0,
{ 12: } -24,
{ 13: } -4,
{ 14: } -18,
{ 15: } -9,
{ 16: } 0,
{ 17: } -20,
{ 18: } -19,
{ 19: } -16,
{ 20: } 0,
{ 21: } -6,
{ 22: } 0,
{ 23: } -21,
{ 24: } -22,
{ 25: } -17,
{ 26: } 0,
{ 27: } 0,
{ 28: } -11,
{ 29: } -12,
{ 30: } -8,
{ 31: } 0,
{ 32: } -10,
{ 33: } -14,
{ 34: } -23,
{ 35: } -15
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 3,
{ 2: } 4,
{ 3: } 4,
{ 4: } 5,
{ 5: } 8,
{ 6: } 8,
{ 7: } 13,
{ 8: } 14,
{ 9: } 14,
{ 10: } 16,
{ 11: } 16,
{ 12: } 18,
{ 13: } 18,
{ 14: } 18,
{ 15: } 18,
{ 16: } 18,
{ 17: } 20,
{ 18: } 20,
{ 19: } 20,
{ 20: } 20,
{ 21: } 24,
{ 22: } 24,
{ 23: } 26,
{ 24: } 26,
{ 25: } 26,
{ 26: } 26,
{ 27: } 30,
{ 28: } 31,
{ 29: } 31,
{ 30: } 31,
{ 31: } 31,
{ 32: } 32,
{ 33: } 32,
{ 34: } 32,
{ 35: } 32
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 2,
{ 1: } 3,
{ 2: } 3,
{ 3: } 4,
{ 4: } 7,
{ 5: } 7,
{ 6: } 12,
{ 7: } 13,
{ 8: } 13,
{ 9: } 15,
{ 10: } 15,
{ 11: } 17,
{ 12: } 17,
{ 13: } 17,
{ 14: } 17,
{ 15: } 17,
{ 16: } 19,
{ 17: } 19,
{ 18: } 19,
{ 19: } 19,
{ 20: } 23,
{ 21: } 23,
{ 22: } 25,
{ 23: } 25,
{ 24: } 25,
{ 25: } 25,
{ 26: } 29,
{ 27: } 30,
{ 28: } 30,
{ 29: } 30,
{ 30: } 30,
{ 31: } 31,
{ 32: } 31,
{ 33: } 31,
{ 34: } 31,
{ 35: } 31
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 4,
{ 2: } 5,
{ 3: } 5,
{ 4: } 5,
{ 5: } 8,
{ 6: } 9,
{ 7: } 14,
{ 8: } 14,
{ 9: } 14,
{ 10: } 14,
{ 11: } 14,
{ 12: } 14,
{ 13: } 14,
{ 14: } 14,
{ 15: } 14,
{ 16: } 14,
{ 17: } 14,
{ 18: } 14,
{ 19: } 14,
{ 20: } 14,
{ 21: } 17,
{ 22: } 17,
{ 23: } 19,
{ 24: } 19,
{ 25: } 20,
{ 26: } 20,
{ 27: } 24,
{ 28: } 25,
{ 29: } 25,
{ 30: } 25,
{ 31: } 25,
{ 32: } 25,
{ 33: } 25,
{ 34: } 26,
{ 35: } 26
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 3,
{ 1: } 4,
{ 2: } 4,
{ 3: } 4,
{ 4: } 7,
{ 5: } 8,
{ 6: } 13,
{ 7: } 13,
{ 8: } 13,
{ 9: } 13,
{ 10: } 13,
{ 11: } 13,
{ 12: } 13,
{ 13: } 13,
{ 14: } 13,
{ 15: } 13,
{ 16: } 13,
{ 17: } 13,
{ 18: } 13,
{ 19: } 13,
{ 20: } 16,
{ 21: } 16,
{ 22: } 18,
{ 23: } 18,
{ 24: } 19,
{ 25: } 19,
{ 26: } 23,
{ 27: } 24,
{ 28: } 24,
{ 29: } 24,
{ 30: } 24,
{ 31: } 24,
{ 32: } 24,
{ 33: } 25,
{ 34: } 25,
{ 35: } 25
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 1; sym: -2 ),
{ 2: } ( len: 0; sym: -5 ),
{ 3: } ( len: 0; sym: -6 ),
{ 4: } ( len: 3; sym: -2 ),
{ 5: } ( len: 2; sym: -3 ),
{ 6: } ( len: 3; sym: -3 ),
{ 7: } ( len: 1; sym: -7 ),
{ 8: } ( len: 3; sym: -7 ),
{ 9: } ( len: 1; sym: -9 ),
{ 10: } ( len: 3; sym: -9 ),
{ 11: } ( len: 3; sym: -8 ),
{ 12: } ( len: 3; sym: -8 ),
{ 13: } ( len: 0; sym: -12 ),
{ 14: } ( len: 0; sym: -13 ),
{ 15: } ( len: 5; sym: -8 ),
{ 16: } ( len: 2; sym: -4 ),
{ 17: } ( len: 3; sym: -4 ),
{ 18: } ( len: 1; sym: -10 ),
{ 19: } ( len: 1; sym: -10 ),
{ 20: } ( len: 1; sym: -10 ),
{ 21: } ( len: 2; sym: -11 ),
{ 22: } ( len: 0; sym: -14 ),
{ 23: } ( len: 4; sym: -11 ),
{ 24: } ( len: 1; sym: -11 )
);


const _error = 256; (* error token *)

function yyact(state, sym : Integer; var act : Integer) : Boolean;
  (* search action table *)
  var k : Integer;
  begin
    k := yyal[state];
    while (k<=yyah[state]) and (yya[k].sym<>sym) do inc(k);
    if k>yyah[state] then
      yyact := false
    else
      begin
        act := yya[k].act;
        yyact := true;
      end;
  end(*yyact*);

function yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
  (* search goto table *)
  var k : Integer;
  begin
    k := yygl[state];
    while (k<=yygh[state]) and (yyg[k].sym<>sym) do inc(k);
    if k>yygh[state] then
      yygoto := false
    else
      begin
        nstate := yyg[k].act;
        yygoto := true;
      end;
  end(*yygoto*);

label parse, next, error, errlab, shift, reduce, accept, abort;

begin(*yyparse*)

  (* initialize: *)

  yystate := 0; yychar := -1; yynerrs := 0; yyerrflag := 0; yysp := 0;

{$ifdef yydebug}
  yydebug := true;
{$else}
  yydebug := false;
{$endif}

parse:

  (* push state and value: *)

  inc(yysp);
  if yysp>yymaxdepth then
    begin
      yyerror('yyparse stack overflow');
      goto abort;
    end;
  yys[yysp] := yystate; yyv[yysp] := yyval;

next:

  if (yyd[yystate]=0) and (yychar=-1) then
    (* get next symbol *)
    begin
      yychar := yylex; if yychar<0 then yychar := 0;
    end;

  if yydebug then writeln('state ', yystate, ', char ', yychar);

  (* determine parse action: *)

  yyn := yyd[yystate];
  if yyn<>0 then goto reduce; (* simple state *)

  (* no default action; search parse table *)

  if not yyact(yystate, yychar, yyn) then goto error
  else if yyn>0 then                      goto shift
  else if yyn<0 then                      goto reduce
  else                                    goto accept;

error:

  (* error; start error recovery: *)

  if yyerrflag=0 then yyerror('syntax error');

errlab:

  if yyerrflag=0 then inc(yynerrs);     (* new error *)

  if yyerrflag<=2 then                  (* incomplete recovery; try again *)
    begin
      yyerrflag := 3;
      (* uncover a state with shift action on error token *)
      while (yysp>0) and not ( yyact(yys[yysp], _error, yyn) and
                               (yyn>0) ) do
        begin
          if yydebug then
            if yysp>1 then
              writeln('error recovery pops state ', yys[yysp], ', uncovers ',
                      yys[yysp-1])
            else
              writeln('error recovery fails ... abort');
          dec(yysp);
        end;
      if yysp=0 then goto abort; (* parser has fallen from stack; abort *)
      yystate := yyn;            (* simulate shift on error *)
      goto parse;
    end
  else                                  (* no shift yet; discard symbol *)
    begin
      if yydebug then writeln('error recovery discards char ', yychar);
      if yychar=0 then goto abort; (* end of input; abort *)
      yychar := -1; goto next;     (* clear lookahead char and try again *)
    end;

shift:

  (* go to new state, clear lookahead character: *)

  yystate := yyn; yychar := -1; yyval := yylval;
  if yyerrflag>0 then dec(yyerrflag);

  goto parse;

reduce:

  (* execute action, pop rule from stack, and go to next state: *)

  if yydebug then writeln('reduce ', -yyn);

  yyflag := yyfnone; yyaction(-yyn);
  dec(yysp, yyr[-yyn].len);
  if yygoto(yys[yysp], yyr[-yyn].sym, yyn) then yystate := yyn;

  (* handle action calls to yyaccept, yyabort and yyerror: *)

  case yyflag of
    yyfaccept : goto accept;
    yyfabort  : goto abort;
    yyferror  : goto errlab;
  end;

  goto parse;

accept:

  yyparse := 0; exit;

abort:

  yyparse := 1; exit;

end(*yyparse*);

function EscapeXml(const str: AnsiString): AnsiString;
var
  i: integer;
begin
  for i:= 1 to Length(str)do
  begin
  if str[i] ='''' then
    Result :=  Result + '&apos;'
  else
  if str[i] = '"' then
    Result :=  Result + '&quot;'
  else
  if str[i] = '&' then
    Result :=  Result + '&amp;'
  else
  if str[i] = '<' then
    Result :=  Result + '&lt;'
  else
  if str[i] = '<' then
    Result :=  Result + '&gt;'
  else
    Result :=  Result + str[i];
  end;
end;

procedure TagPush(const aStr: AnsiString);
var
  ctr: Integer;
begin
  for ctr := High(Strs)-1 downto Low(Strs) do
    Strs[ctr+1] := Strs[ctr];
  Strs[Low(Strs)] := aStr;
end;

function TagPop: AnsiString;
var
ctr: Integer;
begin
  Id := Strs[Low(Strs)];
  Result := Id;
  for ctr := Low(Strs) to High(Strs)-1  do
    Strs[ctr] := Strs[ctr+1];
  Strs[High(Strs)] := '';
end;

end.