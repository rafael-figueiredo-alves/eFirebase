program SimpleDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitMain in 'UnitMain.pas' {Form2},
  eFirebase.Interfaces in '..\..\source\eFirebase.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
