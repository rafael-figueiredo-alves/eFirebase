unit eFirebase.request.contract;

interface

uses
  eFirebase.response.contract,
  {$IFDEF FPC}
    Classes,
  {$ELSE}
    System.Classes,
  {$ENDIF}
  eFirebase.Types;

type
  iRequest = interface
    ['{E6F4955A-E71A-4734-9D45-809D9F89FE86}']
    function BaseUrl(Const BaseUrl: string): iRequest;
    function Resource(Const Resource : string): iRequest;
    function Body(const body: string): iRequest; overload;
    function Body(const body: TStream; const AOwns: Boolean): iRequest; overload;
    function SendFile(const FileName, ContentType: string):iRequest;
    function Token(Const pToken: string): iRequest;
    function AddParameter(const Key, Value: string):iRequest;
    function AddHeaders(const key, value: string):iRequest;
    function Get    : iResponse;
    function Post   : iResponse;
    function Patch  : iResponse;
    function Delete : iResponse;
    function Put    : iResponse;
  end;

implementation

end.
