program SimpleDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMain in 'UnitMain.pas' {Form2},
  eFirebase.rest in '..\..\source\eFirebase.rest.pas',
  eFirebase.request.contract in '..\..\source\eFirebase.request.contract.pas',
  eFirebase.request in '..\..\source\eFirebase.request.pas',
  eFirebase.response.contract in '..\..\source\eFirebase.response.contract.pas',
  eFirebase.response in '..\..\source\eFirebase.response.pas',
  eFirebase.request.lazarus in '..\..\source\eFirebase.request.lazarus.pas',
  eFirebase.response.lazarus in '..\..\source\eFirebase.response.lazarus.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
