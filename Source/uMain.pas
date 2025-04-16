unit uMain;

interface

uses
  System.SysUtils,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    OpenDialog1: TOpenDialog;
    btnBrowse: TButton;
    eFileFormat: TEdit;
    lbFileFormat: TLabel;
    procedure btnBrowseClick(Sender: TObject);
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  DM.ImageFormat;

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TfrmMain.btnBrowseClick(Sender: TObject);
begin
  if OpenDialog1.Execute(Handle) then
    eFileFormat.Text := GetImageType(OpenDialog1.FileName);
end;

end.
