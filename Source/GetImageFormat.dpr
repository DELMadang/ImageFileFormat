program GetImageFormat;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  DM.ImageFormat in 'DM.ImageFormat.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
