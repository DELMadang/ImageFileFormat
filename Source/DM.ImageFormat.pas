//
// 본 소스는 델마당 카페의 "나그네길" 님의 코드를 수정한 것입니다
//

unit DM.ImageFormat;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TImageFormat = class
  strict private
    type
      TFormatPattern = record
        Offset: Integer;
        Signature: TBytes;
        Format: string;
      end;
    const
      MAX_PATTERN = 13;
      PATTERNS: array[0..MAX_PATTERN-1] of TFormatPattern = (
        (Offset: 0; Signature: [$FF, $D8, $FF]; Format: 'JPG'),
        (Offset: 0; Signature: [$42, $4D]; Format: 'BMP'),
        (Offset: 0; Signature: [$47, $49, $46, $38]; Format: 'GIF'),
        (Offset: 8; Signature: [$57, $45, $42, $50]; Format: 'WEBP'),
        (Offset: 0; Signature: [$49, $20, $49]; Format: 'TIFF'),
        (Offset: 0; Signature: [$49, $49, $2A, $00]; Format: 'TIFF'),
        (Offset: 0; Signature: [$4D, $4D, $00, $2A]; Format: 'TIFF'),
        (Offset: 0; Signature: [$4D, $4D, $00, $2B]; Format: 'TIFF'),
        (Offset: 0; Signature: [$38, $42, $50, $53]; Format: 'PSD'),
        (Offset: 0; Signature: [$49, $49, $55, $00]; Format: 'RAW'),
        (Offset: 4; Signature: [$66, $74, $79, $70, $68, $65, $69, $63]; Format: 'RAW'),
        (Offset: 0; Signature: [$25, $50, $44, $46]; Format: 'PDF'),
        (Offset: 0; Signature: [$89, $50, $4E, $47, $0D, $0A, $1A, $0A]; Format: 'PNG')
      );
  private
    function GetBufferSize: Integer;
    function IsPattern(const ABuffer: TBytes; AIndex: Integer; const AValues: array of Byte): Boolean;
  public
    function GetFileFormat(const AFileName: string): string; overload;
    function GetFileFormat(const AStream: TStream): string; overload;
  end;

  function  GetImageType(const AFileName: string): string; overload;
  function  GetImageType(const AStream: TStream): string; overload;

implementation

uses
  System.Math;

function GetImageType(const AFileName: string): string;
begin
  var LFormat := TImageFormat.Create;
  try
    Result := LFormat.GetFileFormat(AFileName);
  finally
    LFormat.Free;
  end;
end;

function GetImageType(const AStream: TStream): string;
begin
  var LFormat := TImageFormat.Create;
  try
    Result := LFormat.GetFileFormat(AStream);
  finally
    LFormat.Free;
  end;
end;

{$REGION 'TImageFormat'}

function TImageFormat.GetBufferSize: Integer;
begin
  Result := 0;

  for var I := 0 to High(PATTERNS) do
    Result := Max(Result, PATTERNS[I].Offset + Length(PATTERNS[I].Signature));
end;

function TImageFormat.GetFileFormat(const AFileName: string): string;
begin
  Result := '';
  if not FileExists(AFileName) then
    Exit;

  var LStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    Result := GetFileFormat(LStream);
  finally
    LStream.Free;
  end;
end;

function TImageFormat.GetFileFormat(const AStream: TStream): string;
begin
  var LMaxCheckSize := GetBufferSize;
  if AStream.Size >= LMaxCheckSize then
  begin
    var LBuffer: TBytes;
    SetLength(LBuffer, LMaxCheckSize);
    AStream.ReadBuffer(LBuffer, LMaxCheckSize);

    for var I := 0 to High(PATTERNS) do
    begin
      if IsPattern(LBuffer, PATTERNS[I].Offset, PATTERNS[I].Signature) then
      begin
        Result := PATTERNS[I].Format;
        Exit;
      end;
    end;
  end;
end;

function TImageFormat.IsPattern(const ABuffer: TBytes; AIndex: Integer; const AValues: array of Byte): Boolean;
begin
  Result := True;
  for var I := Low(AValues) to High(AValues) do
  begin
    if (AIndex + I >= Length(ABuffer)) or (ABuffer[AIndex + I] <> AValues[I]) then
    begin
      Exit(False);
    end;
  end;
end;

{$ENDREGION}

end.
