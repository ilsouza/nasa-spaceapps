program appQUIZ;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMain in 'src\FMain.pas' {frmMain},
  FQuiz in 'src\FQuiz.pas' {frmQuiz},
  FPlayer in 'src\FPlayer.pas' {frmPlayer},
  UDM in 'src\UDM.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmQuiz, frmQuiz);
  Application.CreateForm(TfrmPlayer, frmPlayer);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
