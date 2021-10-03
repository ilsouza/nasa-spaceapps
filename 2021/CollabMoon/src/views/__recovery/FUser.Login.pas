unit FUser.Login;

interface

uses
  FMX.Helpers.Android,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Math,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.DialogService,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Objects,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.VirtualKeyboard,
  FMX.Platform,
//  Storage.Chronos,
  Service.Login,
  REST.Types,
  System.JSON,
  Interfaces.SimulateTransparency, Android.KeyguardManager, FMX.ISBaseButtons, FMX.ISButtons, FMX.ISBase, FMX.ISPanel, FMX.ISBase.Presented, FMX.ISAlcinoe;

type
  TfrmUserLogin = class(TForm, ISimulateTransparency)
    layPrincipal: TLayout;
    layTopo: TLayout;
    Image1: TImage;
    Image2: TImage;
    Label8: TLabel;
    Label1: TLabel;
    StyleBook1: TStyleBook;
    Line1: TLine;
    layRodape: TLayout;
    recRodape: TRectangle;
    Image3: TImage;
    Line2: TLine;
    recRodapeTexto: TRectangle;
    Label4: TLabel;
    Label9: TLabel;
    vsbMain: TVertScrollBox;
    layCentro: TLayout;
    layMain: TLayout;
    BlurEffect1: TBlurEffect;
    sclayMain: TScaledLayout;
    Layout6: TLayout;
    imgBiometria: TImage;
    ISButtonStyle1: TISButtonStyle;
    ISPanel1: TISPanel;
    edtEmail: TEdit;
    btnContinueLogin: TISTextButton;
    Layout1: TLayout;
    Label2: TLabel;
    Layout2: TLayout;
    Label12: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtEmailKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure vsbMainCalcContentBounds(Sender: TObject; var ContentBounds: TRectF);
    procedure FormCreate(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure imgBiometriaClick(Sender: TObject);
    procedure btnContinueLoginClick(Sender: TObject);
  private
    { Private declarations }
    FsrvLogin: TsrvServiceLogin;
    FParametro: TJSONObject;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    procedure RestorePosition;
    procedure UpdateKBBounds;
    procedure ClearParams;
    property NeedOffSet: Boolean read FNeedOffset write FNeedOffset;
  public
    { Public declarations }
    procedure ProcessCallback(const AStatusCode: Integer);
    procedure SetBlurredBackground(out ABitmap: TBitmap);
  end;

var
  frmUserLogin: TfrmUserLogin;

implementation

{$R *.fmx}

uses
  FMain.Splash1,
  FUser.Register,
  FUser.Password,
  uJSONHelper,
  USharedConsts,
  FMX.TextEditHandler;

procedure TfrmUserLogin.ClearParams;
begin
  if Assigned(FParametro) then
  begin
    FParametro.DisposeOf;
    FParametro := nil;
  end;
end;

procedure TfrmUserLogin.edtEmailKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    btnContinueLogin.OnClick(btnContinueLogin);
  end;
end;

procedure TfrmUserLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMainSplash1.indWait.Visible        := False;
  frmMainSplash1.tabSplashGeral.Visible := False;
  frmMainSplash1.tabSplash.Visible      := True;
end;

procedure TfrmUserLogin.FormCreate(Sender: TObject);
var
  Android : TEventResultClass;
begin
  try
    Android := TEventResultClass.Create(self);
    imgBiometria.Visible := Android.DeviceSecure;
  finally
    Android.Free;
    Android.DisposeOf;
  end;

  if (TOSVersion.Platform = pfAndroid) or (TOSVersion.Platform = pfiOS) then
  begin
    VKAutoShowMode := TVKAutoShowMode.Always;
  end
  else
  begin
    VKAutoShowMode := TVKAutoShowMode.DefinedBySystem;
  end;
end;

procedure TfrmUserLogin.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TfrmUserLogin.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService : IFMXVirtualKeyboardService;
{$ENDIF}
begin
{$IFDEF ANDROID}
  if (Key = vkHardwareBack) then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
    begin
      {
        Botão back pressionado e teclado visível
        Apenas fecha o teclado
      }
    end
      else
      begin
        {Botão back presionado e teclado NÃO visível}
        Key := 0;
        frmMainSplash1.Show;
        frmMainSplash1.tabSplashGeral.Visible := False;
        frmMainSplash1.tabSplash.ActiveTab := frmMainSplash1.tabSplash1;
      end;
  end;
{$ENDIF}
end;

procedure TfrmUserLogin.FormShow(Sender: TObject);
var
  LAdvTextEditHandler: TAdvTextEditHandler;
begin
  LAdvTextEditHandler.Handle(edtEmail, tfNoEmoji);
  edtEmail.SetFocus;
end;

procedure TfrmUserLogin.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  NeedOffSet := False;
  RestorePosition;
end;

procedure TfrmUserLogin.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TfrmUserLogin.imgBiometriaClick(Sender: TObject);
var
 Android:TEventResultClass;
begin
  try
    Android := TEventResultClass.Create(self);
    Android.StartActivityKeyGuard;
  finally
    Android.Free;
    Android.DisposeOf;
  end;
end;

procedure TfrmUserLogin.btnContinueLoginClick(Sender: TObject);
begin
  frmUserRegister.lblEmail.Text := edtEmail.Text.Trim;

  if edtEmail.Text.IsEmpty then
  begin
    edtEmail.SetFocus;
    Exit;
  end;

  Chronos.SetItem<string>(APP_USER_EMAIL, Trim(edtEmail.Text));

  ClearParams;

  FParametro := TJSONObject.Create;
  if (FsrvLogin = nil) then
  begin
    FsrvLogin := TsrvServiceLogin.Create(self);
  end;

  FParametro.AddPair('user', Trim(edtEmail.Text));

  FsrvLogin.DoLogin(FParametro);
end;

procedure TfrmUserLogin.ProcessCallback(const AStatusCode: Integer);
begin
  case AStatusCode of
    HTTP_SUCCESSFUL_REQUEST:
      begin
        frmUserPassword.tabCadastro.ActiveTab := frmUserPassword.tab5_CadastrarSenha;
        frmUserPassword.Show;
      end;
    HTTP_ERROR_NOT_FOUND:
      begin
        frmUserRegister.lblEmail.Text := edtEmail.Text;
        frmUserRegister.tabCadastro.ActiveTab := frmUserRegister.tab1_NomeCompleto;
        frmUserRegister.Show;
      end;
    HTTP_RESPONSE_UNASSIGNED:
      begin
        edtEmail.SetFocus;
      end;
  end;

  ClearParams;

  if Assigned(FsrvLogin) then
  begin
    FsrvLogin.DisposeOf;
    FsrvLogin := nil;
  end;
end;

procedure TfrmUserLogin.RestorePosition;
begin
  vsbMain.ViewportPosition := PointF(vsbMain.ViewportPosition.X, 0);
  layPrincipal.Align := TAlignLayout.Client;
  vsbMain.RealignContent;
end;

procedure TfrmUserLogin.SetBlurredBackground(out ABitmap: TBitmap);
begin
  BlurEffect1.Enabled := True;
  ABitmap := layMain.MakeScreenshot;
  BlurEffect1.Enabled := False;
end;

procedure TfrmUserLogin.UpdateKBBounds;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  NeedOffSet := False;
  if Assigned(Focused) then
  begin
    //LFocused := TControl(Focused.GetObject);
    LFocused := TControl(layCentro);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vsbMain.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
      (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      NeedOffSet := True;
      layPrincipal.Align := TAlignLayout.Horizontal;
      vsbMain.RealignContent;
      Application.ProcessMessages;
      vsbMain.ViewportPosition := PointF(vsbMain.ViewportPosition.X,
        LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not NeedOffSet then
    RestorePosition;

end;

procedure TfrmUserLogin.vsbMainCalcContentBounds(Sender: TObject; var ContentBounds: TRectF);
begin
  if NeedOffSet and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
      2 * ClientHeight - FKBBounds.Top);
  end;
end;

end.
