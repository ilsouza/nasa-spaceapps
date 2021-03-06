unit FMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Edit, FMX.Layouts, FMX.wwDataGrid, FMX.wwLayouts, FMX.wwBaseGrid,
  System.JSON, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, gtClasses, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmMain = class(TForm)
    Layout1: TLayout;
    edtYourName: TEdit;
    Label1: TLabel;
    cmbAvailableQuiz: TComboBox;
    Label2: TLabel;
    Layout2: TLayout;
    gridScore: TwwDataGrid;
    Label3: TLabel;
    Layout3: TLayout;
    btnStart: TButton;
    btnYourName: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    StyleBook1: TStyleBook;
    procedure btnStartClick(Sender: TObject);
    procedure btnYourNameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses FQuiz, UDM;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  frmQuiz.lblYourName.Text := edtYourName.Text;
  frmQuiz.lblQuizName.Text := cmbAvailableQuiz.Selected.Text;

  dm.getQuestions.Execute;

  frmQuiz.iTQ := dm.mtabQuestions.RecordCount;

  if (dm.mtabQuestions.RecordCount > 0) then frmQuiz.iCQ := 1 else frmQuiz.iCQ := 0;

  frmQuiz.iTQ := dm.mtabQuestions.RecordCount;

  frmQuiz.btnNext.Enabled  := frmQuiz.iCQ < frmQuiz.iTQ;
  frmQuiz.btnPrior.Enabled := frmQuiz.iCQ > 1;

  frmQuiz.edtScore.Text := frmQuiz.iCQ.ToString + '/' + frmQuiz.iTQ.ToString;

  frmQuiz.Show;
end;

procedure TfrmMain.btnYourNameClick(Sender: TObject);
var
  sName, sResult : String;
  jParametro : TJSONObject;
begin
  if (edtYourName.Text = '') then
  begin
    exit;
  end;

  dm.getUsers.ResourceSuffix := edtYourName.Text;
  dm.getUsers.Execute;

  sName := (TJSONObject.ParseJSONValue(dm.respUsers.JSONText) as TJSONObject).GetValue('result').Value;

  if (sName = 'user name not found') then
  begin
    MessageDlg('I didn''t find that user. Shall we register it ?',
      System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,

      procedure(const BotaoPressionado: TModalResult)
      begin
        case BotaoPressionado of
          mrYes:
            begin
              jParametro := TJSONObject.Create;
              jParametro.AddPair('usr_name', edtYourName.Text);

              dm.postUser.Body.Add(jParametro);
              dm.postUser.Execute;

              sName := (TJSONObject.ParseJSONValue(dm.respUsers.JSONText) as TJSONObject).GetValue('result').Value;

              if (sName = 'error') then
              begin
                ShowMessage(sName + ' - ' + 'try again');
                Exit;
              end;

              cmbAvailableQuiz.SetFocus;
            end;

          mrNo:
            begin
              cmbAvailableQuiz.SetFocus;
            end;
          end;
        end
      );
  end;

  dm.getQuiz.Execute;

  sName := (TJSONObject.ParseJSONValue(dm.respUsers.JSONText) as TJSONObject).GetValue('result').Value;


  cmbAvailableQuiz.SetFocus;
end;

end.
