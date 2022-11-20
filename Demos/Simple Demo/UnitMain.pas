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
  eFirebase.rest;

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
Var
 FResposta : iResponse;
begin
  FResposta := TRest.New.BaseUrl('https://etasks-d6988.firebaseio.com/etasks/v1')
                         .Resource('version.json')
                         .Get;
//  FResposta := TRest.New2.BaseUrl('https://etasks-d6988.firebaseio.com/etasks/v1')
//                         .Resource('version.json')
//                         .Get;
  memo1.Lines.Add(FResposta.content);
  ShowMessage(IntToStr(FResposta.StatusCode));
  Memo1.Lines.Add(FResposta.Headers.Text);
  Memo1.Lines.Add('Versão da biblioteca: ' + TRest.Versao);
end;

end.
