unit FUser.Register;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Layouts,
  FMX.DialogService,
  System.ImageList,
  FMX.ImgList,
  Storage.Chronos,
  StrUtils,
  System.Threading,
  System.SyncObjs,
  System.JSON,
  REST.Types,
  Service.Login,
  Service.Register,
  Interfaces.SimulateTransparency, FMX.Effects;

type
  TfrmUserRegister = class(TForm, ISimulateTransparency)
    layCadastro: TLayout;
    tabCadastro: TTabControl;
    tab2_ValidaEmail: TTabItem;
    tab3_MedicoOuPaciente: TTabItem;
    tab1_NomeCompleto: TTabItem;
    layPrincipal: TLayout;
    lblQualSeuNome: TLabel;
    edtNome: TEdit;
    layValideEmail: TLayout;
    lblTitulo: TLabel;
    lblTexto1: TLabel;
    lblTexto2: TLabel;
    lblEmail: TLabel;
    lblTexto3: TLabel;
    Rectangle1: TRectangle;
    recDigitos: TRectangle;
    Rectangle2: TRectangle;
    Image1: TImage;
    Line1: TLine;
    Line2: TLine;
    Rectangle3: TRectangle;
    Image2: TImage;
    Line3: TLine;
    layCabecalho: TLayout;
    btnVoltar: TButton;
    recCabecalho: TRectangle;
    Label4: TLabel;
    layPassos: TLayout;
    recPassos: TRectangle;
    recPassosItens: TRectangle;
    Circle5: TCircle;
    Circle4: TCircle;
    Circle3: TCircle;
    Circle2: TCircle;
    Layout1: TLayout;
    lineCircle2: TLine;
    Layout2: TLayout;
    lineCircle1: TLine;
    Layout3: TLayout;
    lineCircle3: TLine;
    Layout4: TLayout;
    lineCircle4: TLine;
    Rectangle4: TRectangle;
    layPasso1: TLayout;
    Label5: TLabel;
    Label6: TLabel;
    layEspacoPasso4: TLayout;
    layPasso5: TLayout;
    Label7: TLabel;
    Label8: TLabel;
    layEspacoPasso1: TLayout;
    layPasso4: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    layEspacoPasso3: TLayout;
    layPasso3: TLayout;
    Label11: TLabel;
    Label12: TLabel;
    layEspacoPasso2: TLayout;
    layPasso2: TLayout;
    Label13: TLabel;
    Label14: TLabel;
    tab4_EMedico: TTabItem;
    tab5_CadastrarSenha: TTabItem;
    tab6_Parabens: TTabItem;
    imgCircle2: TImage;
    imgCircle1: TImage;
    imgCircle3: TImage;
    imgCircle4: TImage;
    imgCircle5: TImage;
    Circle1: TCircle;
    ImageList1: TImageList;
    btnPasso_1_2: TButton;
    StyleBook1_: TStyleBook;
    btnPasso2_3: TButton;
    Label1: TLabel;
    lblNomeUser: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    recOpcoes: TRectangle;
    btnOpcaoNao: TButton;
    btnOpcaoSim: TButton;
    layOpcoesMedicoPaciente: TLayout;
    Label17: TLabel;
    lblNomeMedico: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    btnPasso4_5: TButton;
    Label18: TLabel;
    Label21: TLabel;
    lblPasswordTitle: TLabel;
    lblPasswordText1: TLabel;
    lblPasswordText2: TLabel;
    lblPasswordText3: TLabel;
    edtPassword: TEdit;
    swtPasswordShow: TSwitch;
    lblPasswordShow: TLabel;
    btnFinishPassword: TButton;
    Image3: TImage;
    TabControl1: TTabControl;
    TabItem6: TTabItem;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    VertScrollBox1: TVertScrollBox;
    pbPasswordStrength: TProgressBar;
    lblPasswordStrengthText: TLabel;
    layPasswordCreate: TLayout;
    lblPasswordStrengthName: TLabel;
    layPasswordShow: TLayout;
    Line4: TLine;
    aniIndicator: TAniIndicator;
    btnReSendEmailCodeConfirmation: TButton;
    btnChangeEmail: TButton;
    edtCodeConfirmation: TEdit;
    aniIndicator2: TAniIndicator;
    tab7_Unassigned: TTabItem;
    layMain: TLayout;
    BlurEffect1: TBlurEffect;
    sclayMain: TScaledLayout;
    StyleBook1: TStyleBook;
    btnEntrarApp: TButton;
    procedure btnConfirmarCodigoClick(Sender: TObject);
    procedure btnPasso_1_2Click(Sender: TObject);
    procedure btnPasso2_3Click(Sender: TObject);
    procedure btnOpcaoSimClick(Sender: TObject);
    procedure btnOpcaoNaoClick(Sender: TObject);
    procedure btnPasso4_5Click(Sender: TObject);
    procedure btnFinishPasswordClick(Sender: TObject);
    procedure swtPasswordShowClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure edtPasswordTyping(Sender: TObject);
    procedure btnReSendEmailCodeConfirmationClick(Sender: TObject);
    procedure btnChangeEmailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tabCadastroChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEntrarAppClick(Sender: TObject);
  private
    FSrvLogin : TsrvServiceLogin;
    FSrvRegister : TsrvRegister;
    procedure Images(aIndice: Word);
    procedure StrongPassword;
    procedure Thread1_Terminated(Sender: TObject);
    procedure Thread2_Terminated(Sender: TObject);
    procedure SendEmailCodeConfirmation(aEmail : String);
    { Private declarations }
  public
    { Public declarations }
    bApprovedPassword : boolean;
    function validateFormPassword(aPassword : String) : boolean;
    procedure SetBlurredBackground(out ABitmap: TBitmap);
  end;

var
  frmUserRegister: TfrmUserRegister;
  Title, Txt1, Txt2, Txt3 : String;

implementation

{$R *.fmx}

uses
  FUser.Menu,
  FUser.Password,
  uLibCommon,
  USharedConsts,
  FMX.TextEditHandler;

procedure TfrmUserRegister.btnChangeEmailClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUserRegister.btnConfirmarCodigoClick(Sender: TObject);
begin
  tabCadastro.ActiveTab := tab3_MedicoOuPaciente;
end;

procedure TfrmUserRegister.btnEntrarAppClick(Sender: TObject);
begin
  frmUserMenu.Show;
end;

procedure TfrmUserRegister.btnPasso_1_2Click(Sender: TObject);
var
  T      : TThread;
  sEmail : String;
begin
  if (edtNome.Text <> EmptyStr) then
  begin
    Chronos.SetItem<string>(APP_USER_NICKNAME, edtNome.Text);

    sEmail := Chronos.GetItem<string>(APP_USER_EMAIL).Trim;

    if sEmail.IsEmpty then
    begin
      ShowMessage('Você não digitou seu email');
      Close;
    end;

    aniIndicator.Enabled := True;
    aniIndicator.Visible := True;

    T := TThread.CreateAnonymousThread(procedure
         begin
           SendEmailCodeConfirmation(sEmail);

           T.Synchronize(nil, procedure
           begin
             aniIndicator.Enabled := False;
             aniIndicator.Visible := False;
           end);
         end);

    T.OnTerminate := Thread1_Terminated;
    T.Start;
  end
  else
  begin
    TDialogService.MessageDialog(
      WARNING_REGISTER_NICKNAME_REQUIRED,
      TMsgDlgType.mtWarning,
      [TMsgDlgBtn.mbOk],
      TMsgDlgBtn.mbOK,
      0,
      procedure(const AResult: TModalResult)
      begin
        edtNome.SetFocus;
      end);
  end;
end;

procedure TfrmUserRegister.SendEmailCodeConfirmation(aEmail : String);
var
  jParametro, jRetorno : TJSONObject;
  sRetorno : String;

begin
  jRetorno   := nil;
  jParametro := nil;

  try
    if FSrvLogin = nil then
    begin
      FSrvLogin := TsrvServiceLogin.Create(nil);
    end;

    Images(3);

    aniIndicator.Enabled := True;
    aniIndicator.Visible := True;

    jParametro := TJSONObject.Create;
    jParametro.AddPair('email', aEmail);

    FSrvLogin.backEndPointSendEmail.Method := TRESTRequestMethod.rmPOST;
    FSrvLogin.backEndPointSendEmail.Body.Add(jParametro);
    FSrvLogin.backEndPointSendEmail.Resource := 'resSendEmail';

    try
//      FsrvLogin.backEndPointSendEmail.Execute;
    except
    end;

//    jRetorno := TJSONObject.ParseJSONValue(FsrvLogin.rRespSendEmail.Content) as TJSONObject;
//    sRetorno := jRetorno.GetValue('CodeConfirmation').Value;

//    Chronos.SetItem<string>('CodeConfirmation', sRetorno);
  finally
    jParametro.Free;
    jRetorno.Free;
    FsrvLogin.Free;
  end;
end;

procedure TfrmUserRegister.SetBlurredBackground(out ABitmap: TBitmap);
begin
  BlurEffect1.Enabled := True;
  ABitmap := layMain.MakeScreenshot;
  BlurEffect1.Enabled := False;
end;

procedure TfrmUserRegister.btnReSendEmailCodeConfirmationClick(Sender: TObject);
var
  T : TThread;
  sEmail : String;
begin
  Title := lblTitulo.Text;
  Txt1  := lblTexto1.Text;
  Txt2  := lblTexto2.Text;
  Txt3  := lblTexto3.Text;

  lblTitulo.Text := 'Re-enviando código para';
  lblTexto1.Text := '';
  lblTexto2.Text := '';
  lblTexto3.Text := 'Por favor, aguarde';

  sEmail := Chronos.GetItem<string>('LoginEmail').Trim;

  aniIndicator2.Enabled := True;
  aniIndicator2.Visible := True;

  T := TThread.CreateAnonymousThread(procedure
       begin
         SendEmailCodeConfirmation(sEmail);

         T.Synchronize(nil, procedure
           begin
             aniIndicator2.Enabled := False;
             aniIndicator2.Visible := False;
           end);
       end);

  T.OnTerminate := Thread2_Terminated;
  T.Start;
end;

procedure TfrmUserRegister.edtPasswordTyping(Sender: TObject);
begin
  StrongPassword;
end;

procedure TfrmUserRegister.FormCreate(Sender: TObject);
begin
  tabCadastro.ActiveTab := tab7_Unassigned;
  FSrvRegister := TsrvRegister.Create(nil);
end;

procedure TfrmUserRegister.FormDestroy(Sender: TObject);
begin
  FSrvRegister.DisposeOf;
end;

procedure TfrmUserRegister.FormShow(Sender: TObject);
var
  LAdvTextEditHandler: TAdvTextEditHandler;
begin
  LAdvTextEditHandler.Handle(edtNome, tfNoEmoji);
  LAdvTextEditHandler.Handle(edtPassword, tfNoEmoji);
  LAdvTextEditHandler.Handle(edtCodeConfirmation, tfNoEmoji);
end;

procedure TfrmUserRegister.StrongPassword;
begin
  if validateFormPassword(edtPassword.Text.Trim) then
  begin
    pbPasswordStrength.Value          := 100;
    lblPasswordStrengthName.FontColor := TAlphaColor($FF006838);
    lblPasswordStrengthName.Text      := 'forte';
  end
  else
  begin
    pbPasswordStrength.Value          := 0;
    lblPasswordStrengthName.FontColor := TAlphaColor($FF686868);
    lblPasswordStrengthName.Text      := 'fraca';
  end;
end;

procedure TfrmUserRegister.btnPasso4_5Click(Sender: TObject);
begin
  Images(5);
  tabCadastro.ActiveTab := tab5_CadastrarSenha;
end;

procedure TfrmUserRegister.btnFinishPasswordClick(Sender: TObject);
begin
  if validateFormPassword(edtPassword.Text.Trim) then
  begin
    pbPasswordStrength.Value          := 100;
    lblPasswordStrengthName.FontColor := TAlphaColor($FF006838);
    lblPasswordStrengthName.Text      := 'forte';

    Chronos.SetItem<string>(APP_USER_PASSWORD, edtPassword.Text.Trim);

    FSrvRegister.RegisterUser;
  end
  else
  begin
    pbPasswordStrength.Value          := 0;
    lblPasswordStrengthName.FontColor := TAlphaColor($FF686868);
    lblPasswordStrengthName.Text      := 'fraca';
    ShowMessage('Sua senha está fraca. Verifique os requisitos de segurança acima');
  end;
end;

procedure TfrmUserRegister.btnOpcaoNaoClick(Sender: TObject);
begin
  Images(5);
  Chronos.SetItem<string>(APP_USER_TYPE, 'U');
  tabCadastro.ActiveTab := tab5_CadastrarSenha;
end;

procedure TfrmUserRegister.btnOpcaoSimClick(Sender: TObject);
begin
  Chronos.SetItem<string>(APP_USER_TYPE, 'D');
  lblNomeMedico.Text := edtNome.Text;
  tabCadastro.ActiveTab := tab4_EMedico;
end;

procedure TfrmUserRegister.btnPasso2_3Click(Sender: TObject);
var
  sCodeDig, sCodeConfirmation : String;
begin
  sCodeDig := edtCodeConfirmation.Text.Trim;

  sCodeConfirmation := Chronos.GetItem<string>('CodeConfirmation');

  if (sCodeConfirmation <> sCodeDig) then
  begin
    ShowMessage('Código digitado não confere');
    Exit;
  end;

  lblNomeUser.Text := edtNome.Text;
  Images(4);

  tabCadastro.ActiveTab := tab3_MedicoOuPaciente;
end;

procedure TfrmUserRegister.Image3Click(Sender: TObject);
begin
  frmUserMenu.Show;
end;

function TfrmUserRegister.validateFormPassword(aPassword : String) : Boolean;
var
  bHasUppercase, bHasLowercase, bHasNumber, bHasMinSize: Boolean;
begin
  bHasUppercase := UpperContains(aPassword);
  bHasLowercase := LowerContains(aPassword);
  bHasNumber    := NumberContains(aPassword);
  bHasMinSize   := (Length(aPassword) > 7);

  Result := (bHasUppercase and bHasLowercase and bHasNumber and bHasMinSize);
end;

procedure TfrmUserRegister.Images(aIndice : Word);
begin
  case aIndice of
    1 :
      begin
        imgCircle1.Bitmap.Assign(ImageList1.Bitmap(imgCircle1.Size.Size, 0));
        imgCircle2.Bitmap.Assign(ImageList1.Bitmap(imgCircle2.Size.Size, 1));
        imgCircle3.Bitmap.Assign(ImageList1.Bitmap(imgCircle3.Size.Size, 5));
        imgCircle4.Bitmap.Assign(ImageList1.Bitmap(imgCircle4.Size.Size, 6));
        imgCircle5.Bitmap.Assign(ImageList1.Bitmap(imgCircle5.Size.Size, 7));

        lineCircle1.Stroke.Color := $FFC21046;            lineCircle1.Stroke.Dash := TStrokeDash.Solid;
        lineCircle2.Stroke.Color := TAlphaColors.Silver;  lineCircle2.Stroke.Dash := TStrokeDash.DashDot;
        lineCircle3.Stroke.Color := TAlphaColors.Silver;  lineCircle3.Stroke.Dash := TStrokeDash.DashDot;
        lineCircle4.Stroke.Color := TAlphaColors.Silver;  lineCircle4.Stroke.Dash := TStrokeDash.DashDot;
      end;

    2 :
      begin
        imgCircle1.Bitmap.Assign(ImageList1.Bitmap(imgCircle1.Size.Size, 0));
        imgCircle2.Bitmap.Assign(ImageList1.Bitmap(imgCircle2.Size.Size, 1));
        imgCircle3.Bitmap.Assign(ImageList1.Bitmap(imgCircle3.Size.Size, 2));
        imgCircle4.Bitmap.Assign(ImageList1.Bitmap(imgCircle4.Size.Size, 6));
        imgCircle5.Bitmap.Assign(ImageList1.Bitmap(imgCircle5.Size.Size, 7));

        lineCircle1.Stroke.Color := $FFC21046;            lineCircle1.Stroke.Dash := TStrokeDash.Solid;
        lineCircle2.Stroke.Color := $FFC21046;            lineCircle2.Stroke.Dash := TStrokeDash.Solid;
        lineCircle3.Stroke.Color := TAlphaColors.Silver;  lineCircle3.Stroke.Dash := TStrokeDash.DashDot;
        lineCircle4.Stroke.Color := TAlphaColors.Silver;  lineCircle4.Stroke.Dash := TStrokeDash.DashDot;
      end;

    3 :
      begin
        imgCircle1.Bitmap.Assign(ImageList1.Bitmap(imgCircle1.Size.Size, 0));
        imgCircle2.Bitmap.Assign(ImageList1.Bitmap(imgCircle2.Size.Size, 1));
        imgCircle3.Bitmap.Assign(ImageList1.Bitmap(imgCircle3.Size.Size, 2));
        imgCircle4.Bitmap.Assign(ImageList1.Bitmap(imgCircle4.Size.Size, 6));
        imgCircle5.Bitmap.Assign(ImageList1.Bitmap(imgCircle5.Size.Size, 7));

        lineCircle1.Stroke.Color := $FFC21046;            lineCircle1.Stroke.Dash := TStrokeDash.Solid;
        lineCircle2.Stroke.Color := $FFC21046;            lineCircle2.Stroke.Dash := TStrokeDash.Solid;
        lineCircle3.Stroke.Color := TAlphaColors.Silver;  lineCircle3.Stroke.Dash := TStrokeDash.DashDot;
        lineCircle4.Stroke.Color := TAlphaColors.Silver;  lineCircle4.Stroke.Dash := TStrokeDash.DashDot;
      end;

    4 :
      begin
        imgCircle1.Bitmap.Assign(ImageList1.Bitmap(imgCircle1.Size.Size, 0));
        imgCircle2.Bitmap.Assign(ImageList1.Bitmap(imgCircle2.Size.Size, 1));
        imgCircle3.Bitmap.Assign(ImageList1.Bitmap(imgCircle3.Size.Size, 2));
        imgCircle4.Bitmap.Assign(ImageList1.Bitmap(imgCircle4.Size.Size, 3));
        imgCircle5.Bitmap.Assign(ImageList1.Bitmap(imgCircle5.Size.Size, 7));

        lineCircle1.Stroke.Color := $FFC21046;            lineCircle1.Stroke.Dash := TStrokeDash.Solid;
        lineCircle2.Stroke.Color := $FFC21046;            lineCircle2.Stroke.Dash := TStrokeDash.Solid;
        lineCircle3.Stroke.Color := $FFC21046;            lineCircle3.Stroke.Dash := TStrokeDash.Solid;
        lineCircle4.Stroke.Color := TAlphaColors.Silver;  lineCircle4.Stroke.Dash := TStrokeDash.DashDot;
      end;

    5 :
      begin
        imgCircle1.Bitmap.Assign(ImageList1.Bitmap(imgCircle1.Size.Size, 0));
        imgCircle2.Bitmap.Assign(ImageList1.Bitmap(imgCircle2.Size.Size, 1));
        imgCircle3.Bitmap.Assign(ImageList1.Bitmap(imgCircle3.Size.Size, 2));
        imgCircle4.Bitmap.Assign(ImageList1.Bitmap(imgCircle4.Size.Size, 3));
        imgCircle5.Bitmap.Assign(ImageList1.Bitmap(imgCircle5.Size.Size, 4));

        lineCircle1.Stroke.Color := $FFC21046;            lineCircle1.Stroke.Dash := TStrokeDash.Solid;
        lineCircle2.Stroke.Color := $FFC21046;            lineCircle2.Stroke.Dash := TStrokeDash.Solid;
        lineCircle3.Stroke.Color := $FFC21046;            lineCircle3.Stroke.Dash := TStrokeDash.Solid;
        lineCircle4.Stroke.Color := $FFC21046;            lineCircle4.Stroke.Dash := TStrokeDash.Solid;
      end;
  end;
end;

procedure TfrmUserRegister.swtPasswordShowClick(Sender: TObject);
begin
  edtPassword.Password := not swtPasswordShow.IsChecked;
end;

procedure TfrmUserRegister.tabCadastroChange(Sender: TObject);
begin
  case tabCadastro.TabIndex of
    0:
      begin
        edtNome.SetFocus;
      end;
  end;
end;

procedure TfrmUserRegister.Thread1_Terminated(Sender: TObject);
begin
  {Solicita a digitação desse código de acesso}
  tabCadastro.ActiveTab := tab2_ValidaEmail;
end;

procedure TfrmUserRegister.Thread2_Terminated(Sender: TObject);
begin
  lblTitulo.Text := Title;

  lblTexto1.Text := Txt1;
  lblTexto2.Text := Txt2;
  lblTexto3.Text := Txt3;
end;

end.
