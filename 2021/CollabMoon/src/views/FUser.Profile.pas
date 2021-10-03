unit FUser.Profile;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Math,
  System.MaskUtils,
  System.StrUtils,
  System.Threading,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.DialogService,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Edit,
  FMX.Controls.Presentation,
  FMX.TabControl,
  FMX.Layouts,
  FMX.ListBox,
  FMX.MultiView,
  System.ImageList,
  FMX.ImgList,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView,
  FMX.Ani,
  FMX.Effects,
  Interfaces.Avatar.Selection,
  Storage.Chronos,
  Service.Users,
  Frame.Avatar, gtClasses, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.ActnList, FMX.ISEdit, FMX.ISLabel, FMX.ISSearchEdit, FMX.ISNumericEdit, FMX.ISAlcinoe, FMX.ISBase, FMX.ISCards, FMX.ISCardList,
  System.Rtti,
  FMX.DateTimeCtrls,
  System.Actions,
//  FMX.ActnList,
  Interfaces.SimulateTransparency,
  System.Math.Vectors,
  FMX.Controls3D,
  FMX.Layers3D,
//  FireDAC.Stan.Intf,
//  FireDAC.Stan.Option,
//  FireDAC.Stan.Param,
//  FireDAC.Stan.Error,
//  FireDAC.DatS,
//  FireDAC.Phys.Intf,
//  FireDAC.DApt.Intf,
//  Data.DB,
//  FireDAC.Comp.DataSet,
//  FireDAC.Comp.Client,
  System.JSON,
  Service.Laboratory,
  REST.Types
//  FMX.ISBase,
//  FMX.ISCards,
//  FMX.ISCardList,
//  FMX.ISEdit,
//  FMX.ISLabel,
//  FMX.ISSearchEdit
{$IFDEF ANDROID},
  FMX.Platform.Android,
  FMX.ISBaseButtons,
  FMX.ISButtons,
//  FMX.ISNumericEdit,
  REST.Client
{$ENDIF},
  Service.BuscaCEP, FMX.ISPath, FMX.ISObjects, FMX.ISControls;
type
  TUserFormActiveTab = (atUnassigned, atProfile, atAddress, atSearchLaboratory, atServiceEvaluation, atSearchLabUnit);

  TfrmUserProfile = class(TForm, ISimulateTransparency)
    vsBoxMain: TVertScrollBox;
    layUsuario: TLayout;
    tabUsuario: TTabControl;
    tabiUnassigned: TTabItem;
    layTab1: TLayout;
    tabChooseLaboratory: TTabItem;
    tab3: TTabItem;
    tabListLaboratory: TTabItem;
    tabServiceEvaluation: TTabItem;
    tabiAddress: TTabItem;
    layCabecalho: TLayout;
    recCabecalho: TRectangle;
    lblMenuPrincipal: TLabel;
    btnVoltarUsuario: TButton;
    btnMenuUsuario: TButton;
    StyleBook1: TStyleBook;
    ImageList1: TImageList;
    layTab3: TLayout;
    layTabiAddressBody: TLayout;
    imgMenuUsuario: TImage;
    tabProfile: TTabItem;
    layTabProfileBody: TLayout;
    layTabProfileData: TLayout;
    edtTabProfileFullName: TEdit;
    Line1: TLine;
    layTabProfileGender: TLayout;
    layTabProfileGenderOptions: TLayout;
    rbtTabProfileNonBinary: TRadioButton;
    rbtTabProfileFemale: TRadioButton;
    rbtTabProfileMale: TRadioButton;
    lblTabProfileGender: TLabel;
    Line2: TLine;
    layTabProfileBirthdate: TLayout;
    imgTabProfileBirthdateCalendar: TImage;
    edtTabProfilePhoneNumber: TEdit;
    layTabProfileAction: TLayout;
    btnTabProfileSubmit: TButton;
    layTabProfileTop: TLayout;
    layTabProfileEmail: TLayout;
    lblTabProfileEmail: TLabel;
    BlurEffect1: TBlurEffect;
    layMain: TLayout;
    layMenuPrincipalUsuarios: TLayout;
    rctMenuBackground: TRectangle;
    FloatAnimation1: TFloatAnimation;
    layMenuAgendamentoDeExames: TLayout;
    btnMenuAgendamentoDeExames: TButton;
    btnMenuAgendamentoDeExames2: TButton;
    imgMenuAgendamentoDeExames: TImage;
    Line19: TLine;
    Line20: TLine;
    layMenuExamesRealizados: TLayout;
    Line21: TLine;
    btnMenuExamesRealizados2: TButton;
    imgMenuExamesRealizados: TImage;
    Line22: TLine;
    btnMenuExamesRealizados: TButton;
    layMenuHome: TLayout;
    Line5: TLine;
    btnMenuHome2: TButton;
    imgMenuHome: TImage;
    Line6: TLine;
    btnMenuHome: TButton;
    layMenuMeuLaboratorio: TLayout;
    Line23: TLine;
    btnMenuMeuLaboratorio2: TButton;
    imgMenuMeuLaboratorio: TImage;
    Line24: TLine;
    btnMenuMeuLaboratorio: TButton;
    layMeuPerfil: TLayout;
    Line17: TLine;
    btnMeuPerfil2: TButton;
    imgMeuPerfil: TImage;
    Line18: TLine;
    btnMeuPerfil: TButton;
    layMeusDependentes: TLayout;
    Line15: TLine;
    btnMeusDependentes2: TButton;
    imgMeusDependentes: TImage;
    Line16: TLine;
    btnMeusDependentes: TButton;
    layNoticias: TLayout;
    Line13: TLine;
    btnNoticias2: TButton;
    imbNoticias: TImage;
    Line14: TLine;
    btnNoticias: TButton;
    laySair: TLayout;
    Line11: TLine;
    btnSair2: TButton;
    imgSair: TImage;
    Line12: TLine;
    btnSair: TButton;
    laySobreApp: TLayout;
    Line9: TLine;
    btnSobreApp2: TButton;
    btnSobreApp: TButton;
    layTermosServicos: TLayout;
    Line7: TLine;
    btnTermosServicos2: TButton;
    btnTermosServicos: TButton;
    Line4: TLine;
    btnTabProfileAddress: TButton;
    Line3: TLine;
    layTabiAddressTop: TLayout;
    layTabiAddressEmail: TLayout;
    lblTabiAddressEmail: TLabel;
    edtTabiAddressPublicPlace: TEdit;
    edtTabiAddressCity: TEdit;
    edtTabiAddressNumber: TEdit;
    edtTabiAddressUnit: TEdit;
    btnTabiAddressSubmit: TButton;
    layTabiAddressData: TLayout;
    layTabiAddressAction: TLayout;
    fmTabProfileAvatar: TfmeAvatar;
    fmTabiAddressAvatar: TfmeAvatar;
    ActionList1: TActionList;
    Action1: TAction;
    layTabProfilePhoneNumber: TLayout;
    edtTabProfileFocusHelper: TEdit;
    edtTabiAddressDistrict: TEdit;
    edtTabiAddressState: TEdit;
    lblFullAddress: TLabel;
    layTabiAddressState: TLayout;
    edtTabiAddressFocusHelper: TEdit;
    mTblUserAddress: TFDMemTable;
    mTblUserAddressaddr_nid: TIntegerField;
    mTblUserAddressuser_nid: TIntegerField;
    mTblUserAddressaddr_etype: TStringField;
    mTblUserAddressaddr_cpublicplace: TStringField;
    mTblUserAddressaddr_nnumber: TIntegerField;
    mTblUserAddressaddr_cunit: TStringField;
    mTblUserAddressaddr_cdistrict: TStringField;
    mTblUserAddressaddr_ccity: TStringField;
    mTblUserAddressaddr_cstate: TStringField;
    mTblUserAddressaddr_cpostalcode: TStringField;
    mTblUserAddressFullAddress: TStringField;
    layTabChoseLaboratory: TLayout;
    edtSearchLaboratory: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Line25: TLine;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtNameLaboratory: TEdit;
    edtDDD: TEdit;
    btnSendSuggestion: TButton;
    Layout1: TLayout;
    btnSearchLab: TButton;
    layServiceEvaluation: TLayout;
    Layout2: TLayout;
    Label6: TLabel;
    Label7: TLabel;
    rec1: TRectangle;
    rb1_1: TRadioButton;
    rb1_5: TRadioButton;
    rb1_7: TRadioButton;
    rb1_3: TRadioButton;
    rb1_9: TRadioButton;
    rb1_10: TRadioButton;
    rb1_8: TRadioButton;
    rb1_6: TRadioButton;
    rb1_4: TRadioButton;
    rb1_2: TRadioButton;
    Layout3: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    rec2: TRectangle;
    rb2_1: TRadioButton;
    rb2_5: TRadioButton;
    rb2_7: TRadioButton;
    rb2_3: TRadioButton;
    rb2_9: TRadioButton;
    rb2_10: TRadioButton;
    rb2_8: TRadioButton;
    rb2_6: TRadioButton;
    rb2_4: TRadioButton;
    rb2_2: TRadioButton;
    Layout4: TLayout;
    rec3: TRectangle;
    Label10: TLabel;
    Label11: TLabel;
    rb3_1: TRadioButton;
    rb3_3: TRadioButton;
    rb3_2: TRadioButton;
    rb3_5: TRadioButton;
    rb3_4: TRadioButton;
    btnAvaliar: TButton;
    Layout5: TLayout;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Layout6: TLayout;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    listLaboratory: TISCardList;
    cardLaboratory: TISCard;
    txtLabName: TText;
    txtIdLab: TText;
    tabiLaboratory: TTabItem;
    layTabiLaboratoryBody: TLayout;
    layTabiLaboratorySelection: TLayout;
    RoundRect1: TRoundRect;
    ISLabel1: TISLabel;
    Layout7: TLayout;
    layTabiLaboratoryPhrase01: TLayout;
    Label32: TLabel;
    ISLabel2: TISLabel;
    Line8: TLine;
    layTabiLaboratorySuggestion: TLayout;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    edtTabiLaboratoryName: TISEdit;
    layTabiLaboratoryPhoneNumber: TLayout;
    edtTabiLaboratoryPhoneNumber: TISEdit;
    edtTabiLaboratoryFocusHelper: TEdit;
    layTabiLaboratoryAction: TLayout;
    btnTabiLaboratorySubmit: TButton;
    edtSearchLab: TISSearchEdit;
    CardLabsList: TISCardList;
    cardLabs: TISCard;
    edtNome: TEdit;
    edtID: TEdit;
    sclayMain: TScaledLayout;
    edtTabProfileDocNumber: TISNumericEdit;
    edtTabProfileBirthdate: TISNumericEdit;
    edtTabiAddressPostalCode: TISNumericEdit;
    procedure btnMenuUsuarioClick(Sender: TObject);
    procedure btnMenuHomeClick(Sender: TObject);
    procedure btnMenuMeuLaboratorioClick(Sender: TObject);
    procedure btnMenuExamesRealizadosClick(Sender: TObject);
    procedure btnMenuAgendamentoDeExamesClick(Sender: TObject);
    procedure btnMeuPerfilClick(Sender: TObject);
    procedure btnMeusDependentesClick(Sender: TObject);
    procedure btnNoticiasClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure vsBoxMainCalcContentBounds(Sender: TObject; var ContentBounds: TRectF);
    procedure FormShow(Sender: TObject);
    procedure btnTabProfileAddressClick(Sender: TObject);
    procedure btnTabiAddressSubmitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DoChangeGenderRadioButton(Sender: TObject);
    procedure btnTabProfileSubmitClick(Sender: TObject);
    procedure btnVoltarUsuarioClick(Sender: TObject);
    procedure DoFormatEditText(Sender: TObject; var ACanFocus: Boolean);
    procedure edtTabProfilePhoneNumberCanFocus(Sender: TObject; var ACanFocus: Boolean);
    procedure edtTabProfilePhoneNumberExit(Sender: TObject);
    procedure btnSair2Click(Sender: TObject);
    procedure mTblUserAddressCalcFields(DataSet: TDataSet);
    procedure btnSendSuggestionClick(Sender: TObject);
    procedure btnAvaliarClick(Sender: TObject);
    procedure btnSearchLabClick(Sender: TObject);
    procedure txtLabNameClick(Sender: TObject);
    procedure fmTabProfileAvatarcrcAvatarClick(Sender: TObject);
    procedure edtSearchLabTyping(Sender: TObject);
    procedure edtSearchLabOpen(Sender: TObject);
    procedure edtSearchLabClickSearch(Sender: TObject);
    procedure edtSearchLabClose(Sender: TObject);
    procedure cardLabsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnSobreAppClick(Sender: TObject);
    procedure edtTabiLaboratoryNameEnter(Sender: TObject);
    procedure edtTabiLaboratoryPhoneNumberEnter(Sender: TObject);
    procedure btnTabiLaboratorySubmitClick(Sender: TObject);
    procedure mTblUserAddressaddr_cpostalcodeChange(Sender: TField);
    procedure edtTabiAddressPostalCodeExit(Sender: TObject);
  private
    { Private declarations }
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    FActiveTab: TUserFormActiveTab;
    FsrvUsers: TsrvUsers;
    FsrvBuscaCEP: TsrvBuscaCEP;
    procedure RestorePosition;
    procedure UpdateKBBounds;
    procedure SetActiveTab(aActiveTab: TUserFormActiveTab);
    procedure DoMenuUsuarioClick;
    procedure CreateLabs;
    procedure CarregaLabs;
    procedure DoSubmitUserProfile;
    procedure PostPostalCode;
  public
    { Public declarations }
    CallFromUser : Boolean;
    procedure SetBlurredBackground(out ABitmap: TBitmap);
    property NeedOffSet: Boolean read FNeedOffset write FNeedOffset;
    property ActiveTab: TUserFormActiveTab read FActiveTab write FActiveTab;
  end;

var
  frmUserProfile   : TfrmUserProfile;
  FsrvLaboratories : TsrvServiceLaboratory;

implementation

{$R *.fmx}

uses
  USharedConsts,
  USharedUtils,
  UAppSharedUtils,
  FLaboratory.Main,
  FLaboratory.Menu,
  FUser.Menu,
  FMX.TextEditHandler;

procedure TfrmUserProfile.DoChangeGenderRadioButton(Sender: TObject);
var
  LRadioButton: TRadioButton;
  sGender: string;
  LDoChangeGender: Boolean;
begin
  LDoChangeGender := Chronos.GetItem<Boolean>(USER_PROFILE_CHANGE_GENDER);

  if LDoChangeGender then
  begin
    if (Sender is TRadioButton) then
    begin
      LRadioButton := (Sender as TRadioButton);
      if LRadioButton.IsChecked then
      begin        
        Chronos.SetItem<Boolean>(USER_PROFILE_CHANGE_GENDER, False);
        case AnsiIndexStr(LRadioButton.Text, ['Masculino', 'Feminino', 'N�o bin�rio']) of
          0:
            begin
              sGender := 'M';
            end;
          1:
            begin
              sGender := 'F';
            end;
          2:
            begin
              sGender := 'N';
            end;
          else
            begin
              sGender := EmptyStr;
            end;
        end;

        if sGender <> EmptyStr then
        begin
          FsrvUsers.DoChangeUserGender(sGender);
        end;
        
        Chronos.SetItem<Boolean>(USER_PROFILE_CHANGE_GENDER, True);
      end;
    end;
  end;
end;

procedure TfrmUserProfile.DoFormatEditText(Sender: TObject; var ACanFocus: Boolean);
begin
  (Sender as TEdit).Text := TSharedUtils.ExtractNumbers((Sender as TEdit).Text);
end;

procedure TfrmUserProfile.DoMenuUsuarioClick;
begin
  if layMenuPrincipalUsuarios.Visible then
    imgMenuUsuario.Bitmap.Assign(ImageList1.Bitmap(imgMenuUsuario.Size.Size, 8))
  else
    imgMenuUsuario.Bitmap.Assign(ImageList1.Bitmap(imgMenuUsuario.Size.Size, 9));

  layMenuPrincipalUsuarios.Visible := not layMenuPrincipalUsuarios.Visible;
end;

procedure TfrmUserProfile.DoSubmitUserProfile;
var
  LUserProfileData: TUserProfileData;
begin
  LUserProfileData.DocNumber := edtTabProfileDocNumber.Text;
  LUserProfileData.Birthdate := edtTabProfileBirthdate.Text;

  if FsrvUsers.DoPushUserProfileData(LUserProfileData) then
  begin
    FsrvUsers.DoPostUserProfile(True);
  end;
end;

procedure TfrmUserProfile.btnAvaliarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUserProfile.btnMenuAgendamentoDeExamesClick(Sender: TObject);
begin
  frmUserMenu.btnScheduledExamsClick(nil);
end;

procedure TfrmUserProfile.btnMenuExamesRealizadosClick(Sender: TObject);
begin
  ShowMessage('Exames realizados');
end;

procedure TfrmUserProfile.btnMenuHomeClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUserProfile.btnMenuMeuLaboratorioClick(Sender: TObject);
begin
  frmUserMenu.btnMyLaboratoryClick(nil);
end;

procedure TfrmUserProfile.btnMenuUsuarioClick(Sender: TObject);
begin
  DoMenuUsuarioClick;
end;

procedure TfrmUserProfile.btnMeuPerfilClick(Sender: TObject);
begin
  SetActiveTab(atProfile);
end;

procedure TfrmUserProfile.btnMeusDependentesClick(Sender: TObject);
begin
  ShowMessage('Meus dependentes');
end;

procedure TfrmUserProfile.btnNoticiasClick(Sender: TObject);
begin
  ShowMessage('Not�cias');
end;

procedure TfrmUserProfile.btnSair2Click(Sender: TObject);
begin
  DoMenuUsuarioClick;
end;

procedure TfrmUserProfile.btnSairClick(Sender: TObject);
begin
  TThread.Synchronize(nil,
    procedure()
    begin
      TDialogService.MessageDialog(
        CONFIRMATION_CLOSE_APPLICATION,
        TMsgDlgType.mtConfirmation,
        FMX.Dialogs.mbYesNo,
        TMsgDlgBtn.mbNo,
        0,
        procedure(const AResult: TModalResult)
        begin
          if AResult = mrYes then
          begin
            {$IFDef ANDROID}
              MainActivity.finish;
            {$ELSE}
              Close;
            {$ENDIF}
          end
          else
          begin
            DoMenuUsuarioClick;
          end;
        end);
    end);
end;

procedure TfrmUserProfile.btnSearchLabClick(Sender: TObject);
var
  sLab : string;

  iStatusCode : Integer;
  sStatusText : string;
  jParametro  : TJSONObject;
begin
  jParametro  := nil;
  sLab := edtSearchLaboratory.Text;

  try
    if (FsrvLaboratories = nil) then
    begin
      FsrvLaboratories := TsrvServiceLaboratory.Create(nil);
    end;

    jParametro := TJSONObject.Create;
    jParametro.AddPair('laboratory', sLab);

    FsrvLaboratories.backEndPointLabs.Method := TRESTRequestMethod.rmPOST;
    FsrvLaboratories.backEndPointLabs.Body.Add(jParametro);
    FsrvLaboratories.backEndPointLabs.Resource := 'resLaboratories';

    try
      FsrvLaboratories.backEndPointLabs.Execute;
    except
    end;

    iStatusCode := FsrvLaboratories.rRespLabs.StatusCode;
    sStatusText := FsrvLaboratories.rRespLabs.StatusText;

    if (iStatusCode <> HTTP_SUCCESSFUL_REQUEST) then
    begin
      ShowMessage(sStatusText);
      Exit;
    end
  finally
    jParametro.Free;
//    FsrvLaboratories.Free;
  end;

  try
    // iCodLab := StrToInt((TJSONObject.ParseJSONValue(FsrvLaboratories.rRespLaboratoryItem.JSONText) as TJSONObject).GetValue('lab_nid').Value);
    CreateLabs;
  finally
  end;
end;

procedure TfrmUserProfile.CreateLabs;
begin
  tabUsuario.ActiveTab := tabListLaboratory;

  listLaboratory.BeginUpdate;

  TThread.CreateAnonymousThread(
    procedure
    begin
      FsrvLaboratories.tblLabs.First;

      cardLaboratory.Clear;

      while not FsrvLaboratories.tblLabs.Eof do
      begin
        cardLaboratory.FieldByName('FName').AsText         := FsrvLaboratories.tblLabslab_cname.AsString;
        cardLaboratory.FieldByName('IdLabCard').AsText    := FsrvLaboratories.tblLabslab_nid.AsString;
//        cardLaboratory.FieldByName('FAddress').AsText      := FsrvLaboratory.tblLabslab_cname.AsString;
//        cardLaboratory.FieldByName('FNeighborhood').AsText := FsrvLaboratory.tblLabslab_cname.AsString;
//        cardLaboratory.FieldByName('FCityStateZip').AsText := FsrvLaboratory.tblLaboratoryItemunit_ccodcity.AsString;

        listLaboratory.AddCard(cardLaboratory);

        FsrvLaboratories.tblLabs.Next;
      end;

      listlaboratory.EndUpdate;
    end).Start;
end;

procedure TfrmUserProfile.btnSendSuggestionClick(Sender: TObject);
begin
  {Sugest�o enviada}
  //
  //
  //
  Close;
end;

procedure TfrmUserProfile.btnSobreAppClick(Sender: TObject);
begin
  ShowMessage('Sair');
end;

procedure TfrmUserProfile.btnTabiAddressSubmitClick(Sender: TObject);
begin
  if edtTabiAddressPostalCode.Text <> EmptyStr then
  begin
    PostPostalCode;
  end;

  FsrvUsers.DoPostUserAddress(mTblUserAddress);
end;

procedure TfrmUserProfile.btnTabiLaboratorySubmitClick(Sender: TObject);
begin
  Showmessage('Sugest�o enviada');
end;

procedure TfrmUserProfile.btnTabProfileAddressClick(Sender: TObject);
begin
  SetActiveTab(atAddress);
end;

procedure TfrmUserProfile.btnTabProfileSubmitClick(Sender: TObject);
begin
  DoSubmitUserProfile;
end;

procedure TfrmUserProfile.btnVoltarUsuarioClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUserProfile.cardLabsClick(Sender: TObject);
var
  Card : TISCard;
  sName, sID : String;
begin
  Card  := (Sender as TControl) as TISCard;
  sName := (Card.ByName('LabName') as TEdit).Text;
  sID   := (Card.ByName('LabID') as TEdit).Text;

  Chronos.SetItem<Integer>(APP_LAB_ID, StrToInt(sID));
  Chronos.SetItem<Integer>(APP_LAB_UNIT_ID, StrToInt(sID));

  edtSearchLab.Close;

  frmLaboratoryMenu.Show;
end;

procedure TfrmUserProfile.FormActivate(Sender: TObject);
begin
  layMenuPrincipalUsuarios.Visible := False;

  if (tabUsuario.ActiveTab = tabiLaboratory) then
  begin
    edtSearchLabClickSearch(nil);
  end;
end;

procedure TfrmUserProfile.FormCreate(Sender: TObject);
begin
  imgTabProfileBirthdateCalendar.Visible := False;

  SetActiveTab(TUserFormActiveTab.atUnassigned);

  if (TOSVersion.Platform = pfAndroid) or (TOSVersion.Platform = pfiOS) then
  begin
    VKAutoShowMode := TVKAutoShowMode.Always;
  end
  else
  begin
    VKAutoShowMode := TVKAutoShowMode.DefinedBySystem;
  end;

  FsrvUsers := TsrvUsers.Create(nil);
  fmTabProfileAvatar.FService := FsrvUsers;
  fmTabiAddressAvatar.FService := FsrvUsers;

  Chronos.SetItem<Boolean>(USER_PROFILE_CHANGE_GENDER, False);
end;

procedure TfrmUserProfile.FormDestroy(Sender: TObject);
begin
  if Assigned(FsrvUsers) then
  begin
    FsrvUsers.DisposeOf;
  end;
end;

procedure TfrmUserProfile.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TfrmUserProfile.FormShow(Sender: TObject);
begin
  SetActiveTab(ActiveTab);
end;

procedure TfrmUserProfile.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  NeedOffSet := False;
  RestorePosition;
end;

procedure TfrmUserProfile.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TfrmUserProfile.mTblUserAddressaddr_cpostalcodeChange(Sender: TField);
begin
  if mTblUserAddress.Tag = 0 then
  begin
    FsrvBuscaCEP.GetAddress(mTblUserAddressaddr_cpostalcode.AsString, mTblUserAddress);
  end;
end;

procedure TfrmUserProfile.mTblUserAddressCalcFields(DataSet: TDataSet);
const
  COMMA_SEPARATOR = ', ';
  UNIT_SEPARATOR = '/';
  CITY_STATE_SEPARATOR = '-';
  DEFAULT_COUNTRY = ', Brasil';

var
  sFullAddress: string;
begin

  sFullAddress := mTblUserAddressaddr_cpublicplace.AsString;

  if mTblUserAddressaddr_nnumber.AsString <> EmptyStr then
  begin
    sFullAddress :=
      Concat(sFullAddress, IfThen(sFullAddress <> EmptyStr, COMMA_SEPARATOR, ''), mTblUserAddressaddr_nnumber.AsString);
  end;

  if mTblUserAddressaddr_cunit.AsString <> EmptyStr then
  begin
    if mTblUserAddressaddr_nnumber.AsString <> EmptyStr then
    begin
      sFullAddress := Concat(sFullAddress, UNIT_SEPARATOR, mTblUserAddressaddr_cunit.AsString);
    end
    else
    begin
      sFullAddress :=
        Concat(sFullAddress, IfThen(sFullAddress <> EmptyStr, COMMA_SEPARATOR, ''), mTblUserAddressaddr_cunit.AsString);
    end;
  end;

  if mTblUserAddressaddr_cdistrict.AsString <> EmptyStr then
  begin
    sFullAddress :=
      Concat(sFullAddress,
      IfThen(sFullAddress <> EmptyStr, COMMA_SEPARATOR, ''),
      mTblUserAddressaddr_cdistrict.AsString);
  end;

  if mTblUserAddressaddr_ccity.AsString <> EmptyStr then
  begin
    sFullAddress :=
      Concat(sFullAddress,
      IfThen(sFullAddress <> EmptyStr, COMMA_SEPARATOR, ''),
      mTblUserAddressaddr_ccity.AsString);
  end;

  if mTblUserAddressaddr_cstate.AsString <> EmptyStr then
  begin
    if sFullAddress <> EmptyStr then
    begin
      if mTblUserAddressaddr_ccity.AsString <> EmptyStr then
      begin
        sFullAddress := Concat(sFullAddress, CITY_STATE_SEPARATOR, mTblUserAddressaddr_cstate.AsString);
      end
      else
      begin
        sFullAddress := Concat(sFullAddress, COMMA_SEPARATOR, mTblUserAddressaddr_cstate.AsString);
      end;
    end
    else
    begin
      sFullAddress := mTblUserAddressaddr_cstate.AsString;
    end;
  end;

  if mTblUserAddressaddr_cpostalcode.AsString <> EmptyStr then
  begin
    sFullAddress :=
      Concat(sFullAddress,
      IfThen(sFullAddress <> EmptyStr, COMMA_SEPARATOR, ''),
      FormatMaskText('00000-000;0;*', mTblUserAddressaddr_cpostalcode.AsString));
  end;

  if sFullAddress <> EmptyStr then
  begin
    sFullAddress := Concat(sFullAddress, DEFAULT_COUNTRY);
  end;

  mTblUserAddressFullAddress.AsString := sFullAddress;

end;

procedure TfrmUserProfile.PostPostalCode;
var
  LPostalCode: string;
begin
  if not (mTblUserAddress.State in dsEditModes) then
  begin
    mTblUserAddress.Edit;
  end;
  LPostalCode := TSharedUtils.ExtractNumbers(edtTabiAddressPostalCode.Text);
  if mTblUserAddressaddr_cpostalcode.AsString <> LPostalCode then
  begin
    mTblUserAddressaddr_cpostalcode.AsString := LPostalCode;
  end;
end;

procedure TfrmUserProfile.RestorePosition;
begin
  vsBoxMain.ViewportPosition := PointF(vsBoxMain.ViewportPosition.X, 0);
  layUsuario.Align := TAlignLayout.Client;
  vsBoxMain.RealignContent;
end;

procedure TfrmUserProfile.SetActiveTab(aActiveTab: TUserFormActiveTab);
var
  LAdvTextEditHandler: TAdvTextEditHandler;
begin
  ActiveTab := aActiveTab;

  case aActiveTab of
    atUnassigned:
      begin
        tabUsuario.ActiveTab := tabiUnassigned;
      end;

    atProfile:
      begin
        TThread.Synchronize(nil,
          procedure()
          var
            iUserID: Integer;
            bResult: Boolean;
          begin
            bResult := False;

            if Chronos.TryGetItem<Integer>(APP_USER_ID, iUserID) then
            begin
              bResult := FsrvUsers.GetUserProfile(iUserID);
            end;

            if bResult then
            begin
              lblTabProfileEmail.Text := Chronos.GetItem<string>(APP_USER_EMAIL);
              tabUsuario.ActiveTab := tabProfile;
              fmTabProfileAvatar.LoadAvatar;
              //DateEdit1.DateTime := FsrvUsers.mTblUserProfileuser_dbirthdate.AsDateTime;

              LAdvTextEditHandler.Handle(edtTabProfileFullName, tfNoEmoji);

              edtTabProfileFocusHelper.SetFocus;
            end
            else
            begin
              ShowMessage('Erro ao carregar dados do usu�rio.');
            end;
          end);
      end;

    atAddress:
      begin
        tabUsuario.ActiveTab := tabiAddress;

        TAppSharedUtils.ShowActivityIndicator(frmUserProfile);

        TThread.Synchronize(nil,
          procedure()
          var
            iUserID: Integer;
          begin
            try
              if Chronos.TryGetItem<Integer>(APP_USER_ID, iUserID) then
              begin
                FsrvUsers.GetUserAddress(iUserID, mTblUserAddress);
              end;

              lblTabiAddressEmail.Text := Chronos.GetItem<string>(APP_USER_EMAIL);
            finally
              TAppSharedUtils.HideActivityIndicator;
            end;
          end);

        fmTabiAddressAvatar.LoadAvatar;

        LAdvTextEditHandler.Handle(edtTabiAddressPublicPlace, tfNoEmoji);
        LAdvTextEditHandler.Handle(edtTabiAddressUnit, tfNoEmoji);
        LAdvTextEditHandler.Handle(edtTabiAddressDistrict, tfNoEmoji);
        LAdvTextEditHandler.Handle(edtTabiAddressCity, tfNoEmoji);
        LAdvTextEditHandler.Handle(edtTabiAddressState, tfNoEmoji);

        edtTabiAddressPostalCode.SetFocus;
      end;

    atSearchLaboratory:
      begin
        tabUsuario.ActiveTab := tabiLaboratory;

        TAppSharedUtils.ShowActivityIndicator(frmUserProfile);

        TThread.Synchronize(nil,
          procedure()
          var
            iUserID: Integer;
          begin
            try
              if Chronos.TryGetItem<Integer>(APP_USER_ID, iUserID) then
              begin
                FsrvUsers.GetUserAddress(iUserID, mTblUserAddress);
              end;

              lblTabiAddressEmail.Text := Chronos.GetItem<string>(APP_USER_EMAIL);
            finally
              TAppSharedUtils.HideActivityIndicator;
            end;
          end);

        edtSearchLab.IsOpen := True;
        edtSearchLab.SetFocus;
        edtSearchLaboratory.SetFocus;
      end;

    atServiceEvaluation:
      begin
        tabUsuario.ActiveTab := tabServiceEvaluation;

        TAppSharedUtils.ShowActivityIndicator(frmUserProfile);

        TThread.Synchronize(nil,
          procedure()
          var
            iUserID: Integer;
          begin
            try
              if Chronos.TryGetItem<Integer>(APP_USER_ID, iUserID) then
              begin
                FsrvUsers.GetUserAddress(iUserID, mTblUserAddress);
              end;

              lblTabiAddressEmail.Text := Chronos.GetItem<string>(APP_USER_EMAIL);
            finally
              TAppSharedUtils.HideActivityIndicator;
            end;
          end);

        // edtSearchLaboratory.SetFocus;
      end;
  end;

  if layMenuPrincipalUsuarios.Visible then
  begin
    DoMenuUsuarioClick;
  end;
end;

procedure TfrmUserProfile.SetBlurredBackground(out ABitmap: TBitmap);
begin
  BlurEffect1.Enabled := True;
  ABitmap := layMain.MakeScreenshot;
  BlurEffect1.Enabled := False;
end;

procedure TfrmUserProfile.txtLabNameClick(Sender: TObject);
var
  Card : TISCard;
  sName, sID : String;
  iId : Integer;
begin
  {
    O Sender, nesse caso, � o TImage, parent de TISCard, componente que foi clicado;
  }
  Card  := (Sender as TControl).Parent as TISCard;
  sName := (Card.ByName('FName') as TText).Text;
  sID   := (Card.ByName('IdLabCard') as TText).Text;

  iId := StrToInt(sID);
  Chronos.SetItem<Integer>(APP_LAB_ID, iID);
  frmLaboratoryMenu.Show;
end;

procedure TfrmUserProfile.UpdateKBBounds;
var
  LFocused: TControl;
  LFocusRect: TRectF;
begin
  NeedOffSet := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vsBoxMain.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
      (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      NeedOffSet := True;
      layUsuario.Align := TAlignLayout.Horizontal;
      vsBoxMain.RealignContent;
      Application.ProcessMessages;

      vsBoxMain.ViewportPosition := PointF(vsBoxMain.ViewportPosition.X,
        LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;

  if not NeedOffSet then
  begin
    RestorePosition;
  end;

end;

procedure TfrmUserProfile.vsBoxMainCalcContentBounds(Sender: TObject; var ContentBounds: TRectF);
begin
  if NeedOffSet and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
      2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfrmUserProfile.edtSearchLabClickSearch(Sender: TObject);
begin
  CardLabsList.TextSearch := edtSearchLab.Text;
end;

procedure TfrmUserProfile.edtSearchLabClose(Sender: TObject);
begin
  cardLabs.Visible     := False;
  CardLabsList.Visible := False;

  edtSearchLab.Text := '';

  CardLabsList.Clear;
end;

procedure TfrmUserProfile.edtSearchLabOpen(Sender: TObject);
begin
  CardLabsList.Visible := True;
  cardLabs.Visible     := True;

  CarregaLabs;
end;

procedure TfrmUserProfile.edtSearchLabTyping(Sender: TObject);
begin
  CardLabsList.TextSearch := edtSearchLab.Text;
end;

procedure TfrmUserProfile.edtTabiAddressPostalCodeExit(Sender: TObject);
begin
  PostPostalCode;
end;

procedure TfrmUserProfile.edtTabiLaboratoryNameEnter(Sender: TObject);
begin
  edtSearchLab.Close;
end;

procedure TfrmUserProfile.edtTabiLaboratoryPhoneNumberEnter(Sender: TObject);
begin
  edtSearchLab.Close;
end;

procedure TfrmUserProfile.edtTabProfilePhoneNumberCanFocus(Sender: TObject; var ACanFocus: Boolean);
begin
  (Sender as TEdit).Text := TSharedUtils.ExtractNumbers((Sender as TEdit).Text);
end;

procedure TfrmUserProfile.edtTabProfilePhoneNumberExit(Sender: TObject);
begin
  FsrvUsers.DoPostUserProfile(False);
end;

procedure TfrmUserProfile.fmTabProfileAvatarcrcAvatarClick(Sender: TObject);
begin
  fmTabProfileAvatar.crcAvatarClick(Sender);
end;

procedure TfrmUserProfile.CarregaLabs;
var
  iStatusCode : Integer;
  sStatusText : string;
  jParametro  : TJSONObject;
begin
  jParametro  := nil;

  try
    if (FsrvLaboratories = nil) then
    begin
      FsrvLaboratories := TsrvServiceLaboratory.Create(nil);
    end;

    FsrvLaboratories.backEndPointLabsGet.Method   := TRESTRequestMethod.rmGET;
    FsrvLaboratories.backEndPointLabsGet.Resource := 'resLaboratories';

    try
      FsrvLaboratories.backEndPointLabsGet.Execute;
    except
    end;

    iStatusCode := FsrvLaboratories.rRespLabsGet.StatusCode;
    sStatusText := FsrvLaboratories.rRespLabsGet.StatusText;

    if (iStatusCode <> HTTP_SUCCESSFUL_REQUEST) then
    begin
      ShowMessage(sStatusText);
      Exit;
    end
  finally
    jParametro.Free;
//    FsrvLaboratories.Free;
  end;

  CardLabsList.BeginUpdate;

  TThread.CreateAnonymousThread(
    procedure
    begin
      FsrvLaboratories.tblLabsGet.First;

      cardLabs.Clear;

      while not FsrvLaboratories.tblLabsGet.Eof do
      begin
        cardLabs.FieldByName('LabName').AsText := FsrvLaboratories.tblLabsGetlab_cname.AsString;
        cardLabs.FieldByName('LabID').AsText   := FsrvLaboratories.tblLabsGetlab_nid.AsString;
        CardLabsList.AddCard(cardLabs);

        FsrvLaboratories.tblLabsGet.Next;
      end;

      CardLabsList.EndUpdate;
    end).Start;  
end;

end.