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
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

procedure TForm2.Button2Click(Sender: TObject);
var
 FResposta : iResponse;
begin
  FResposta := TRest.New.BaseUrl('https://etasks-d6988.firebaseio.com/etasks/v1/tasks/')
                          .Resource('Jbo81zVHQLgo2TqpWSTjgSXqRPu1.json')
                          .Token('eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk1MWMwOGM1MTZhZTM1' + 'MmI4OWU0ZDJlMGUxNDA5NmY3MzQ5NDJhODciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJ' + 'odHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZXRhc2tzLWQ2OTg4IiwiYXVkIjoiZXRhc2t' + 'zLWQ2OTg4IiwiYXV0aF90aW1lIjoxNjcwMTg1MjczLCJ1c2VyX2lkIjoiSmJvODF6VkhRTGdvMlRxcFdTVGpnU1' + 'hxUlB1MSIsInN1YiI6IkpibzgxelZIUUxnbzJUcXBXU1RqZ1NYcVJQdTEiLCJpYXQiOjE2NzAxO' + 'DUyNzMsImV4cCI6MTY3MDE4ODg3MywiZW1haWwiOiJ0ZXN0ZUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW5' + '0aXRpZXMiOnsiZW1haWwiOlsidGVzdGVAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQif' + 'X0.JYgT_AvvbPLu9UimXLCr8_9MnK2QTc_z210wgIeZHjCa2ngmGkxDlLIaVeMnPBcxt9xaRyxbBf9NHXq0RHOmFeq0hfZ' + 'UN2WRZSrykny3-te-BDNvnxtiz9K8l5fb5UuDQIC5NkrW10MAIhL7zBlaccTk8Tw5RyKVC0flIj8vXaMMSiSiTwzPnBU9rC-U7qL35K6DeL1a4SkynvdNiM67TiNS04l_vEZWLBLCCJ4pfEUiIn8kTSVLDQno9SjeG8rN-6xvkI2p_8BVFOzwCwpBYsNC1wfHAuUJnOSuyJNwScYU2JLhcJ6IWpB4BGm8jVKZ80pb-JuSbPpc6_-dCglGKw')
                          .AddParameter('orderBy', '"data"')
                          .AddParameter('equalTo', '"06/09/2022"')
                          .Get;
  Memo1.Lines.Clear;
  Memo1.Lines.Add(FResposta.Content);
end;

end.
