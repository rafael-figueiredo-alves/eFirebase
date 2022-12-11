unit UnitMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  eFirebase;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  Teste : tConteudo;
begin
  Teste := teFirebase.RestTest;
  memo1.Lines.Add(Teste.Conteudo);
  ShowMessage(IntToStr(Teste.StatusCode));
  Memo1.Lines.Add(Teste.Headers);
  Memo1.Lines.Add(Teste.StatusMsg);
  Memo1.Lines.Add('Versão da biblioteca: ' + TeFirebase.GetVersion);
end;

end.
