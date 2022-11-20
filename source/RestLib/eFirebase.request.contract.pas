unit eFirebase.request.contract;

interface

uses
  eFirebase.response.contract;

type
  iRequest = interface
    ['{E6F4955A-E71A-4734-9D45-809D9F89FE86}']
    function BaseUrl(Const BaseUrl: string): iRequest;
    function Resource(Const Resource : string): iRequest;
    function Get: iResponse;
  end;

implementation

end.
