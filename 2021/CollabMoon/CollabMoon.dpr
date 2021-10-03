program CollabMoon;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMain in 'src\views\FMain.pas' {frmMain},
  FUser.Login in 'src\views\FUser.Login.pas' {frmUserLogin},
  FUser.Register in 'src\views\FUser.Register.pas' {frmUserRegister},
  FUser.Profile in 'src\views\FUser.Profile.pas' {frmUserProfile};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmUserLogin, frmUserLogin);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmUserRegister, frmUserRegister);
  Application.CreateForm(TfrmUserProfile, frmUserProfile);
  Application.Run;
end.
