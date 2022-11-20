unit eFirebase.response.contract;

interface

uses
  System.Classes;

type
  iResponse = interface
    ['{AB4680D4-C4DC-4330-943D-2290C2657B9D}']
    function Content: string;
    function StatusCode: integer;
    function Headers: TStrings;
  end;

implementation

end.
