program SimpleDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMain in 'UnitMain.pas' {Form2},
  eFirebase.request.contract in '..\..\source\RestLib\eFirebase.request.contract.pas',
  eFirebase.request.lazarus in '..\..\source\RestLib\eFirebase.request.lazarus.pas',
  eFirebase.request in '..\..\source\RestLib\eFirebase.request.pas',
  eFirebase.response.contract in '..\..\source\RestLib\eFirebase.response.contract.pas',
  eFirebase.response.lazarus in '..\..\source\RestLib\eFirebase.response.lazarus.pas',
  eFirebase.response in '..\..\source\RestLib\eFirebase.response.pas',
  eFirebase in '..\..\source\eFirebase.pas',
  eFirebase.rest in '..\..\source\RestLib\eFirebase.rest.pas',
  eFirebase.Interfaces in '..\..\source\eFirebase.Interfaces.pas',
  eFirebase.Types in '..\..\source\eFirebase.Types.pas',
  eFirebase.Responses.Auth in '..\..\source\FirebaseLib\Response Classes\eFirebase.Responses.Auth.pas',
  eFirebase.Auth in '..\..\source\FirebaseLib\eFirebase.Auth.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
