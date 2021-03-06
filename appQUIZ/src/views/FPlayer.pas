unit FPlayer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.WebBrowser;

type
  TfrmPlayer = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    btnBack: TButton;
    btnPlayList: TButton;
    webBrowser: TWebBrowser;
    procedure btnPlayListClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlayer: TfrmPlayer;

implementation

{$R *.fmx}

procedure TfrmPlayer.btnBackClick(Sender: TObject);
begin
  frmPlayer.webBrowser.Navigate('https://www.nasa.gov/content/nasa-history/videos');
  Close;
end;

procedure TfrmPlayer.btnPlayListClick(Sender: TObject);
begin
  ShowMessage('adicionado � playList do youtube');
end;

end.
