program appQUIZ;

uses
  System.StartUpCopy,
  FMX.Forms,
  UDM in 'src\services\UDM.pas' {dm: TDataModule},
  FMain in 'src\views\FMain.pas' {frmMain},
  FPlayer in 'src\views\FPlayer.pas' {frmPlayer},
  FQuiz in 'src\views\FQuiz.pas' {frmQuiz};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPlayer, frmPlayer);
  Application.CreateForm(TfrmQuiz, frmQuiz);
  Application.Run;
end.
