unit eFirebase.Storage;

interface

uses
  eFirebase.Interfaces,
  System.Classes;

Type
  TeFirebaseStorage = Class(TInterfacedObject, ieFirebaseStorage)
    Private
     fProjectCode : string;
     fFolders     : string;
     fFilename    : string;
     fContent     : TStream;
     fContentType : string;
    private
     procedure GetContentType(const filename: string);
    Public
     Constructor Create(const ProjectCode: string);
     Destructor Destroy; Override;
     Class function New(const ProjectCode:string): ieFirebaseStorage;
     function Folder   (const name: string) : ieFirebaseStorage;
     function FileName (const name: string) : ieFirebaseStorage;
     function Send(const AuthToken: string) : ieFirebaseStorageResponse;
  End;

  Const
   StorageURL = 'https://firebasestorage.googleapis.com/v0/b/';
   SuffixURL  = '.appspot.com/o/';

implementation

uses
  eFirebase.rest,
  eFirebase.Responses.Storage,
  System.SysUtils;

{ TeFirebaseStorage }

constructor TeFirebaseStorage.Create(const ProjectCode: string);
begin
  fProjectCode := ProjectCode;
  fFilename    := '';
  fFolders     := '';
  fContentType := '';
end;

destructor TeFirebaseStorage.Destroy;
begin

  inherited;
end;

function TeFirebaseStorage.FileName(const name: string): ieFirebaseStorage;
begin
  Result := Self;
  fFilename := name;
end;

function TeFirebaseStorage.Folder(const name: string): ieFirebaseStorage;
begin
  Result := Self;
  fFolders := fFolders + name + '%2f';
end;

procedure TeFirebaseStorage.GetContentType(const filename: string);
var
 FileType: string;
begin
  FileType := LowerCase(ExtractFileExt(filename));

  if pos('.', FileType) > 0 then
   FileType := Copy(FileType, 2, length(FileType) - 1);

  //Verificando se é imagem
  if (FileType = 'png') or (FileType = 'jpg') or (FileType = 'jpeg') or (FileType = 'gif') or (FileType = 'bmp')  then
   fContentType := 'image/' + FileType

  //verificando se é tipo texto TXT
  else if (FileType = 'txt') then
        fContentType := 'text/plain'

       //verificando se é tipo CSV ou CSS
       else if (FileType = 'csv') or (FileType = 'css') then
              fContentType := 'text/' + FileType

             //Verificando se é arquivo PDF
            else if (FileType = 'pdf') then
                  fContentType := 'application/' + FileType

                 //Verificando se é áudio mp3 ou ogg
                 else if (FileType = 'mp3') or (FileType = 'ogg') then
                       fContentType := 'audio/' + FileType
                      else

                       //se não for identificado, vai tipo geral
                       fContentType := '';
end;

class function TeFirebaseStorage.New(const ProjectCode:string): ieFirebaseStorage;
begin
  Result := Self.Create(ProjectCode);
end;

function TeFirebaseStorage.Send(const AuthToken: string): ieFirebaseStorageResponse;
var
 ResponseJSON : string;
 Response     : iResponse;
 fURL         : string;
begin
  GetContentType(fFilename);


  fURL := StorageURL + fProjectCode + SuffixURL + fFolders + ExtractFileName(fFilename);

  Response := TRest.New
                      .BaseUrl(fURL)
                        .AddHeaders('Authorization', 'Bearer ' + AuthToken)
                        .SendFile(fFilename, fContentType)
                        .Post;

  ResponseJSON := Response.Content;
  Result := TeFirebaseStorageResponse.New(ResponseJSON, fURL, Response.StatusCode);
end;

end.
