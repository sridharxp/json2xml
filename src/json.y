%{
(*
Copyright (C) 2014, Sridharan S

This file is part of json2xml.

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
%}

%token LCB RCB LSB RSB COMMA COLON QUOTE
%token TEXT QTEXT COMMENT
%{
type YYSType = AnsiString;
var
  xmlText: ansiString;
  Id: AnsiString;
  Strs: array[0..4] of AnsiString;

  function EscapeXml(const str: AnsiString): AnsiString;
  procedure TagPush(const aStr: AnsiString);
  function TagPop: AnsiString;
%}
%%

root:      object {$$ := $1 ; xmlText := preamble + #13#10 + '<ENVELOPE>' + #13#10 + $$ + #13#10 + '</ENVELOPE>';
           yyoutput.Write(pChar(XmlText)^, Length(XmlText)); }
        |  {TagPush('ENVELOPE'); Id := 'ENVELOPE';}array {Id := TagPop;}{$$ := $2 ; xmlText := preamble + #13#10 + $$;
           yyoutput.Write(pChar(XmlText)^, Length(XmlText)); }
        ;
object:   LCB RCB {$$ := ''}
        | LCB bson_list RCB {$$ := $2;}
	;
bson_list:      bson
        |       bson_list COMMA bson {$$ := $1 + #13#10 + $3;}
        ;
arr_list:  aitem
        |  arr_list COMMA aitem {$$ :=  $1 + #13#10 + $3;}
        ;
        ;
bson:      element COLON element
           {
             $$ := '<'+ $1 +'>'+  $3 + '</'+ $1 +'>';
           }
        |  element COLON object
           {
             $$ := '<'+ $1 +'>'+  #13#10 + $3 + #13#10 + '</'+ $1 +'>';
           }

        |  element COLON {TagPush(Id); Id := $1;} array {Id := TagPop;}
           {
             $$ := $4;
           }
        ;
array:
          LSB RSB {$$ := '';}
        |  LSB arr_list RSB {$$ := $2;}
        ;
aitem:    element
           {
           $$ := '<' + id + '>' + $1 + '</' + id +'>';
           }
        | object
           {
           $$ := '<' + id + '>' + #13#10 + $1 + #13#10 + '</' + id +'>';
           }
        |  array
           {
           $$ := '<' + id + '>' + #13#10 + $1 + #13#10 + '</' + id +'>';
           }
        ;
element:   QUOTE QUOTE {$$ := '';}
        |  QUOTE QTEXT {$2 := yytext;} QUOTE {$$ := EscapeXml($2);}
        |  TEXT {$$ := yytext;}
        ;
%%
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
