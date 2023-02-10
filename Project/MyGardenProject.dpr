program MyGardenProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  MyGarden.DataModule in 'MyGarden.DataModule.pas' {dmData: TDataModule},
  uRESTDWBase, ServerUtils {DataModule1: TDataModule};

  type
    TCore  = class
    private
       Pooler : TRestServicePooler;
       data : TdmData;
       APIState : Boolean;
        procedure SetPoolerSettings;
    public
       constructor Create;
       destructor Destroy; override;
       procedure PoolerState(Value : Boolean);

    end;


{ Core }



constructor TCore.Create;
begin
  Pooler := TRestServicePooler.Create(nil);

  Pooler.ServerMethodClass := TdmData;

  SetPoolerSettings;
end;

destructor TCore.Destroy;
begin
  Pooler.Free;
  inherited;
end;



procedure TCore.PoolerState(Value: Boolean);
begin
 Pooler.Active := Value;
end;

procedure TCore.SetPoolerSettings;
begin
  with Pooler do
  begin
    AuthenticationOptions.AuthorizationOption := rdwAONone;
    ServicePort := 3035;
  end;
end;

//Engine Core ---------------- //

var
 MainCore : TCore;
 State : Boolean;
 MainInput : String;
begin
  try
   State := True;
    Writeln('BEM-VINDO AO TERMINAL DE CONTROLE DO MYGRADEN!.');
    MainCore := TCore.Create;
    Writeln('Modulos carregados com Sucesso');
    Writeln('');
  except
        Writeln('Erro ao Carregar Modulos');
  end;

  try
    while (State) do begin
      System.Readln(MainInput);
      if MainInput <> '' then begin
      
        if MainInput = 'on' then begin
          MainCore.PoolerState(True);  
          Writeln('Servi�o MyGarden Ativo!.') ; 
          Writeln('');    
        end;

        if MainInput = 'off' then begin
          MainCore.PoolerState(False);        
          Writeln('Servi�o MyGarden Desativado.') ;
          Writeln('');
        end;

        if MainInput = 'exit' then begin
          
          State := False;       
          Writeln('At� Logo!') ;
          Writeln('');
        end;
      end;

    end;

   MainCore.Free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
