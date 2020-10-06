unit FQuiz;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types, FMX.StdCtrls, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.Layouts, FMX.Edit, Data.Bind.Components, Data.Bind.DBScope, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, gtClasses,
  UDM, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors;

type
  TfrmQuiz = class(TForm)
    Layout1: TLayout;
    lblYourName: TLabel;
    lblQuizName: TLabel;
    Layout2: TLayout;
    memQuestion: TMemo;
    Layout3: TLayout;
    GroupBox1: TGroupBox;
    rbOP1: TRadioButton;
    rbOP4: TRadioButton;
    rbOP3: TRadioButton;
    rbOP2: TRadioButton;
    Layout4: TLayout;
    edtScore: TEdit;
    btnAnswer: TButton;
    btnByPass: TButton;
    Layout5: TLayout;
    btnPrior: TButton;
    btnNext: TButton;
    btnBackMain: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldLinesText: TLinkPropertyToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    lblLink: TLabel;
    LinkPropertyToFieldText5: TLinkPropertyToField;
    lblRO: TLabel;
    LinkPropertyToFieldText6: TLinkPropertyToField;
    procedure btnByPassClick(Sender: TObject);
    procedure btnAnswerClick(Sender: TObject);
    procedure btnBackMainClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iCQ, iTQ : Word;
  end;

var
  frmQuiz: TfrmQuiz;

implementation

{$R *.fmx}

uses FPlayer;

procedure TfrmQuiz.btnAnswerClick(Sender: TObject);
var
  iCA : Integer;
begin
  if rbOP1.IsChecked then iCA := 1 else
  if rbOP2.IsChecked then iCA := 2 else
  if rbOP3.IsChecked then iCA := 3 else
  if rbOP4.IsChecked then iCA := 4 else iCA := 0;

  if (iCA = 0) then
  begin
    ShowMessage('please, answer the question or return to main menu');
    Exit;
  end;

  if (iCA = lblRO.Text.ToInteger) then
  begin
    ShowMessage('correct');
  end
    else begin
      ShowMessage('incorrect');
    end;

  frmPlayer.webBrowser.Navigate(lblLink.Text);
  frmPlayer.Show;

  btnNextClick(nil);
end;

procedure TfrmQuiz.btnBackMainClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmQuiz.btnByPassClick(Sender: TObject);
begin
  ShowMessage('Vai para o próximo');
end;

procedure TfrmQuiz.btnNextClick(Sender: TObject);
begin
  dm.mtabQuestions.Next;

  rbOP1.IsChecked := False;
  rbOP2.IsChecked := False;
  rbOP3.IsChecked := False;
  rbOP4.IsChecked := False;

  iCQ := iCQ + 1;
  edtScore.Text := iCQ.ToString + '/' + iTQ.ToString;

  btnNext.Enabled  := iCQ < iTQ;
  btnPrior.Enabled := iCQ > 1;
end;

procedure TfrmQuiz.btnPriorClick(Sender: TObject);
begin
  dm.mtabQuestions.Prior;

  rbOP1.IsChecked := False;
  rbOP2.IsChecked := False;
  rbOP3.IsChecked := False;
  rbOP4.IsChecked := False;

  iCQ := iCQ - 1;
  edtScore.Text := iCQ.ToString + '/' + iTQ.ToString;

  btnNext.Enabled  := iCQ < iTQ;
  btnPrior.Enabled := iCQ > 1;
end;

end.
