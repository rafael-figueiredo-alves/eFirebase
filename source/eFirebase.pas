unit eFirebase;

//--------------------------------------------------------------------------------
//  eFirebase - versão 0.0.4-a
//  --------------------------
//  Biblioteca para consumo de recursos do Firebase
//  Desenvolvido por Rafael de Figueiredo Alves (DevPegasus)
//  -------------------------------------------------------
//  Dedicatória: "Dedico esta biblioteca aos grandes amores da minha vida, minha esposa Jailza e meus filhos Rafaela e Davi."
//--------------------------------------------------------------------------------

interface

Uses
  eFirebase.response.contract;

Type
 iResponse = eFirebase.response.contract.iResponse;

 tConteudo = record
   Conteudo   : string;
   StatusCode : integer;
   Headers    : string;
   StatusMsg  : string;
 end;

  TeFirebase = class
    private
    public
     class function RestTest: TConteudo;
     class function GetVersion: string;
  end;

implementation

uses
  eFirebase.rest;

{ TeFirebase }

class function TeFirebase.GetVersion: string;
begin
  Result := '0.0.4-a';
end;

class function TeFirebase.RestTest: TConteudo;
var
 FResposta : iResponse;
begin
  FResposta := TRest.New.BaseUrl('https://etasks-d6988.firebaseio.com/etasks/v1')
                         .Resource('version.json')
                         .Get;
  Result.Conteudo := FResposta.Content;
  Result.StatusCode := FResposta.StatusCode;
  Result.Headers := FResposta.Headers.Text;
  Result.StatusMsg := FResposta.StatusMsg;
end;

end.
