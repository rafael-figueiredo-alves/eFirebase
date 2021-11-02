program SimpleDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMain in 'UnitMain.pas' {Form2},
  eFirebase.request.contract in '..\..\source\eFirebase.request.contract.pas',
  eFirebase.request in '..\..\source\eFirebase.request.pas',
  eFirebase.response.contract in '..\..\source\eFirebase.response.contract.pas',
  eFirebase.response in '..\..\source\eFirebase.response.pas',
  eFirebase.rest in '..\..\source\eFirebase.rest.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
