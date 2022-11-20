program SimpleDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMain in 'UnitMain.pas' {Form2},
  eFirebase.rest in '..\..\source\eFirebase.rest.pas',
  eFirebase.request.contract in '..\..\source\RestLib\eFirebase.request.contract.pas',
  eFirebase.request.lazarus in '..\..\source\RestLib\eFirebase.request.lazarus.pas',
  eFirebase.request in '..\..\source\RestLib\eFirebase.request.pas',
  eFirebase.response.contract in '..\..\source\RestLib\eFirebase.response.contract.pas',
  eFirebase.response.lazarus in '..\..\source\RestLib\eFirebase.response.lazarus.pas',
  eFirebase.response in '..\..\source\RestLib\eFirebase.response.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
