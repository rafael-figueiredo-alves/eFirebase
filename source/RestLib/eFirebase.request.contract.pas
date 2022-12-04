unit eFirebase.request.contract;

interface

uses
  eFirebase.response.contract;

type
  iRequest = interface
    ['{E6F4955A-E71A-4734-9D45-809D9F89FE86}']
    function BaseUrl(Const BaseUrl: string): iRequest;
    function Resource(Const Resource : string): iRequest;
    function Body(const body: string): iRequest;
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
