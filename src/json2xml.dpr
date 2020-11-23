(*
Copyright (C) 2014, Sridharan S

This file is part of Json2Xml.

json2xml is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

json2xml is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License version 3
 along with json2xml.  If not, see <http://www.gnu.org/licenses/>.
*)
program json2xml;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  Json,
  lexlib,
  TextStream in 'TextStream.pas',
  Dialogs;

function Jsn2Xml(const IJSN: TStream): string; overload;
var
  TS: TTextStream;
  OXml: TMemoryStream;
  XName: string;
begin
  yyinput := TTextStream.Create(IJSN);
  OXml :=  TMemoryStream.Create;
  yyoutput :=  OXml;
  try
    yyparse;
    SetString(xName, pchar(OXml.Memory),
      OXml.Size div Sizeof(char));
    Result := xName;
  finally
    yyinput.Free;
    OXml.Free;
  end;
 end;

function Jsn2Xml(const jsnName, xmlName: string): string; overload;
var
  IJSN: TMemoryStream;
  OXml: TMemoryStream;
  XName: string;
begin
  IJSN := TmemoryStream.Create;
  IJSN.LoadFromFile(jsnName);
  IJSN.seek( 0, soFromBeginning	);
  OXml :=  TMemoryStream.Create;
  try
    xName := Jsn2Xml(IJSN);
    if Length(xName) > 0 then
    begin
      OXml.Write(pChar(xName)^, Length(xName));
      OXml.SaveToFile(xmlName);
      Result := xName;
    end;
  finally
    OXml.Free;
  end;
end;

var
  jsonFN: string;
  xmlFN: string;
begin
//  SetLength(sLinem 2048);
//-  yyline := sLine;
  { TODO -oUser -cConsole Main : Insert code here }
  if ParamCount = 0 then
  begin
    writeln('Sytax: json2xml <jsonFileName> [xmlFileName]');
    Exit;
  end;
  if ParamCount = 1 then
  begin
    writeln('Sytax: json2xml <jsonFileName> [xmlFileName]');
    writeln('       Translating to xml.txt');
    jsonFN := ParamStr(1);
    xmlFN := 'xml.txt';
  end;
  if ParamCount = 2 then
  begin
    jsonFN := ParamStr(1);
    xmlFN := ParamStr(2);
  end;
(*
  AssignFile(yyinput, jsonFN);
  FileMode := 0;  {Set file access to read only }
  Reset(yyinput);
*)
//  AssignFile(yyoutput, xmlFN);
//  FileMode := fmOpenRead or fmShareDenyWrite;
//  Rewrite(yyoutput);
  ShowMessage(jsn2Xml(jsonFN, xmlFN));
end.
