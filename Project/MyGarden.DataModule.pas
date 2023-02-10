unit MyGarden.DataModule;

interface

uses
  System.SysUtils, System.Classes, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, uRESTDWBase, UDWDataModule, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait;

type

  TdmData = class(TServerMethodDataModule)
    events: TDWServerEvents;
    fdMainConnection: TFDConnection;
    mainQuery: TFDQuery;
    queryAux: TFDQuery;
    procedure DWServerEvents1EventsstatusReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure fdMainConnectionBeforeConnect(Sender: TObject);
    procedure eventsEventsnewReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure eventsEventseditReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure eventsEventsdeleteReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure eventsEventsnodeReplyEvent(var Params: TDWParams;
      var Result: string);

  private

    PathDB : String;
    function isScheduleExist(DATE , TIME : String) : Boolean;
  end;

var
  dmData: TdmData;

implementation

uses
  Vcl.Forms, System.JSON;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}


procedure TdmData.DWServerEvents1EventsstatusReplyEvent(var Params: TDWParams;
  var Result: string);
begin
 Result := '{"status":ok}';
end;

//Remover agendamento
procedure TdmData.eventsEventsdeleteReplyEvent(var Params: TDWParams;
  var Result: string);
begin
  try
    with mainQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM GARDEN WHERE ID = :id');
    end;

    mainQuery.ParamByName('id').AsInteger := Params[0].Value;
    mainQuery.ExecSQL;

    Result := '{"status":Horario removido do Agendamento}'
  except
    Result := '{"status":Houve um Problema ao remover seu Agendamento}'
  end;
end;

//Atualizar agendamento
procedure TdmData.eventsEventseditReplyEvent(var Params: TDWParams;
  var Result: string);
begin
  try
    if not isScheduleExist(Params[3].Value, Params[2].Value) then
    begin

      with mainQuery do
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE GARDEN SET SECTOR = :sc , DATE = :dt, TIME = :tm, DURATION = :dr '
          + 'WHERE ID = :id');
      end;

      mainQuery.ParamByName('id').AsInteger := Params[0].Value;
      mainQuery.ParamByName('tm').AsString := Params[3].Value;
      mainQuery.ParamByName('dt').AsString := Params[2].Value;
      mainQuery.ParamByName('dr').AsString := Params[4].Value;
      mainQuery.ParamByName('sc').AsString := Params[1].Value;

      mainQuery.ExecSQL;
      Result := '{"status": Horario Atualizado com sucesso}';
    end
    else
    begin
       Result := '{"status": J� existe um agendamento com seus horarios}';
    end;

  except
    Result := '{"status":Houve um Problema ao Atualizar o horario em seu jardin}';
  end;
end;

//Inserir novo Agendamento
procedure TdmData.eventsEventsnewReplyEvent(var Params: TDWParams;
  var Result: string);
begin
  try
    if not isScheduleExist(Params[2].value,Params[1].value) then
    begin

      with mainQuery do
      begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO GARDEN (TIME, DATE, DURATION, SECTOR) VALUES (:tm, :dt, :dr, :sc)');
      end;

      mainQuery.ParamByName('tm').AsString := Params[2].Value;
      mainQuery.ParamByName('dt').AsString := Params[1].Value;
      mainQuery.ParamByName('dr').AsString := Params[3].Value;
      mainQuery.ParamByName('sc').AsString := Params[0].Value;

      mainQuery.ExecSQL;
      Result := '{"status": Horario Adicionado com sucesso}';
    end
    else
    begin
      Result := '{"status": J� existe um agendamento com seus horarios}';
    end;
  except
    Result := '{"status":Houve um Problema ao adicionar um novo horario em seu jardin}';
  end;
end;

procedure TdmData.eventsEventsnodeReplyEvent(var Params: TDWParams;
  var Result: string);
  var JObj : TJSONObject;
begin
 JObj := TJSONObject.Create;
  try
     with queryAux do begin
     Close;
     SQL.Clear;
     SQL.Add(' SELECT DATE ,TIME , DURATION FROM GARDEN ORDER BY DATE AND TIME');
     Open;

     JObj.AddPair('date',FieldByName('DATE').text);
     JObj.AddPair('time',FieldByName('TIME').Text);
     JObj.AddPair('duration',FieldByName('DURATION').Text);

     Result := JObj.ToString;
   end;
  finally
    JObj.Free;
  end;
end;

procedure TdmData.fdMainConnectionBeforeConnect(Sender: TObject);
begin
 //Carrega o banco de dados da pasta padr�o no atual diretorio.
PathDB := ExtractFilePath(Application.ExeName) + 'database\mygarden.db';
fdMainConnection.Params.Database := PathDB;

end;

//valida��o Horario Existente
function TdmData.isScheduleExist(DATE, TIME: String): Boolean;
begin
  with queryAux do begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DATE, TIME FROM GARDEN WHERE DATE = :dt AND TIME = :tm');
    ParamByName('dt').AsString := DATE ;
    ParamByName('tm').AsString := TIME;
    Open;

    if RecordCount > 0 then
     Result := True
     else
     Result := False;

  end;
end;

end.
