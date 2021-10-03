﻿unit Service2.Laboratory;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Threading,
  System.UITypes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Classes.AdvJSONObjectWriter,
  REST.Backend.ServiceTypes,
  System.JSON,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  REST.Types,
  REST.Backend.EndPoint,
  USharedConsts,
  USharedProperties,
  UAppSharedUtils,
  UAppSharedTypes,
  FMX.Dialogs,
  FMX.DialogService,
  FMX.Graphics,
  Storage.Chronos,
  UDM, FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys.SQLiteVDataSet,
  FireDAC.DApt,
  Posix.Unistd, FireDAC.Phys.SQLiteWrapper.Stat;

type
  Tsrv2Laboratory = class(TDataModule)
    BackEndpointPostItem: TBackendEndpoint;
    rRespPostItem: TRESTResponse;
    mTblScheduleRequestDocument: TFDMemTable;
    connMemory: TFDConnection;
    mTblScheduleRequestDocumentDocType: TStringField;
    mTblScheduleRequestDocumentImageFileName: TStringField;
    LSQLMemory: TFDLocalSQL;
    sqlDeleteDocumentByType: TFDCommand;
    qrySelectDocumentByType: TFDQuery;
    BackEndpointPutItem: TBackendEndpoint;
    rRespPutItem: TRESTResponse;
    BackEndpointPostImage: TBackendEndpoint;
    rRespPostImage: TRESTResponse;
    mTblScheduleRequestDocumentLog_DateTime: TDateTimeField;
    sqlDeleteDocument: TFDCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FDM: TDM;
    procedure ResetBackEndpoint(ABackEndpoint: TBackendEndpoint);
    procedure DoRecordDocumentImage(ARequestDocumentType: TRequestDocumentType);
    procedure DoDeleteDocumentImage(ARequestDocumentType: TRequestDocumentType);

    function DoOpenScheduleRequest(var ADataSet: TFDMemTable): Boolean;
    function DoSendDocuments(const AScheduleID: Integer): Boolean;
    function DoCloseScheduleRequest(const AScheduleID: Integer): Boolean;
  public
    { Public declarations }
    procedure RecordDocumentImage(ARequestDocumentType: TRequestDocumentType);
    procedure DeleteDocumentImage(ARequestDocumentType: TRequestDocumentType);
    function DeleteDocument(AImageFileName: string): Boolean;
    function RequestDocumentsOk(APaymentType: TPaymentType): Boolean;
    procedure ClearRequestDocuments;
    procedure SendScheduleRequest(var ADataSet: TFDMemTable);
    function DocumentListIsEmpty(ARequestDocumentType: TRequestDocumentType): Boolean;
  end;

const
  EMS_POST_ITEM_PARAM_NAME_DATATYPE = 'datatype';
  EMS_POST_ITEM_PARAM_VALUE_SCHEDULE_REQUEST = 'ScheduleRequest';
  EMS_PUT_ITEM_PARAM_NAME_UPDATE_ACTION = 'UpdateAction';
  EMS_PUT_ITEM_PARAM_VALUE_UPDATE_ACTION_CLOSE_SCHEDULE_REQUEST = 'CloseScheduleRequest';
  EMS_PARAM_NAME_SCHEDULE_ID = 'schedule_id';
  EMS_PARAM_NAME_DOCTYPE = 'doctype';
  EMS_PARAM_NAME_FILENAME = 'filename';
var
  srv2Laboratory: Tsrv2Laboratory;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  FLaboratory.Main,
  UAppPhotoTaker;

{ Tsrv2Laboratory }

procedure Tsrv2Laboratory.DataModuleCreate(Sender: TObject);
begin
  FDM := TDM.Create(nil);

  TAppSharedUtils.SetProvider(TDataModule(Self), FDM.emsLAPProvider);

  LSQLMemory.Active := True;
end;

procedure Tsrv2Laboratory.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FDM) then
  begin
    FDM.DisposeOf;
  end;
end;

function Tsrv2Laboratory.DeleteDocument(AImageFileName: string): Boolean;
begin
  Result := False;
  if DeleteFile(AImageFileName) then
  begin
    sqlDeleteDocument.ParamByName('pImageFileName').AsString := AImageFileName;
    sqlDeleteDocument.Execute;

    Result := (sqlDeleteDocument.RowsAffected > 0);
  end;
end;

procedure Tsrv2Laboratory.DeleteDocumentImage(ARequestDocumentType: TRequestDocumentType);
{var
  LConfirmMessageText: string;
  LTask: ITask;
  LRequestDocumentType: TRequestDocumentType;}
begin

  {case ARequestDocumentType of
    rdID:
      begin
        LConfirmMessageText := 'Deseja excluir o documento de identifica��o da solicita��o?';
      end;
    rdDocument:
      begin
        LConfirmMessageText := 'Deseja excluir o(s) documento(s) m�dicos da solicita��o?';
      end;
    rdHICard:
      begin
        LConfirmMessageText := 'Deseja excluir o documento do conv�nio da solicita��o?';
      end;
  end;


  LTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(
      TThread.CurrentThread,
      procedure()
      begin
        TDialogService.MessageDialog(
          LConfirmMessageText,
          TMsgDlgType.mtConfirmation,
          FMX.Dialogs.mbYesNo,
          TMsgDlgBtn.mbNo,
          0,
          procedure(const AResult: TModalResult)
          begin
            if AResult = mrYes then
            begin
              DoDeleteDocumentImage(LRequestDocumentType);
            end
            else
            begin
              TAppSharedUtils.HideActivityIndicator;
            end;
          end)
      end);
    end);

  LRequestDocumentType := ARequestDocumentType;
  TAppSharedUtils.ShowActivityIndicator(frmLaboratoryMain);
  LTask.Start;}

  TAppSharedUtils.ShowActivityIndicator(frmLaboratoryMain);
  DoDeleteDocumentImage(ARequestDocumentType);
end;

procedure Tsrv2Laboratory.ClearRequestDocuments;
begin
  if (mTblScheduleRequestDocument <> nil) then
  begin
    mTblScheduleRequestDocument.Close;
    mTblScheduleRequestDocument.Open;
  end;
end;

function Tsrv2Laboratory.DoCloseScheduleRequest(const AScheduleID: Integer): Boolean;
begin
  ResetBackEndpoint(BackEndpointPutItem);

  BackEndpointPutItem.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.Any;

  BackEndpointPutItem.AddParameter(
    EMS_PUT_ITEM_PARAM_NAME_UPDATE_ACTION,
    EMS_PUT_ITEM_PARAM_VALUE_UPDATE_ACTION_CLOSE_SCHEDULE_REQUEST,
    TRESTRequestParameterKind.pkHTTPHEADER);

  BackEndpointPutItem.AddParameter(
    EMS_PARAM_NAME_SCHEDULE_ID,
    AScheduleID.ToString,
    TRESTRequestParameterKind.pkHTTPHEADER);

  try
    BackEndpointPutItem.Execute;
  finally
    if rRespPutItem.StatusCode <> HTTP_SUCCESSFUL_REQUEST then
    begin
      Result := False;
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          TDialogService.MessageDialog(
            'Não foi possível finalizar a solicitação de agendamento.',
            TMsgDlgType.mtError,
            [TMsgDlgBtn.mbOk],
            TMsgDlgBtn.mbOk,
            0,
            procedure(const AResult: TModalResult)
            begin
              TAppSharedUtils.HideActivityIndicator;
            end);
        end);
    end
    else
    begin
      Result := True;
    end;
  end;
end;

function Tsrv2Laboratory.DocumentListIsEmpty(ARequestDocumentType: TRequestDocumentType): Boolean;
begin
  qrySelectDocumentByType.Close;
  qrySelectDocumentByType.ParamByName('pDocType').AsString := ARequestDocumentType.ToString;
  qrySelectDocumentByType.Open;

  Result := qrySelectDocumentByType.IsEmpty;
end;

function Tsrv2Laboratory.DoOpenScheduleRequest(var ADataSet: TFDMemTable): Boolean;
var
  LAdvJSONObjectWriter: IAdvJSONObjectWriter;
  LJSONResponse: TJSONObject;
  LSchdID: Integer;

  p1, p2, p3, p4, p5 : string;
begin
  Result := False;
  p1 := ADataSet.FieldByName('schd_epaymenttype').AsString;
  p2 := ADataSet.FieldByName('unit_nid').AsString;
  p3 := ADataSet.FieldByName('user_nid').AsString;
  p4 := ADataSet.FieldByName('schd_esamplecollectiontype').AsString;
  p5 := ADataSet.FieldByName('schd_csamplecollectioninfo').AsString;

  LAdvJSONObjectWriter := TAdvJSONObjectWriter.Create;

  LAdvJSONObjectWriter.AddStringPair('schd_epaymenttype', ADataSet.FieldByName('schd_epaymenttype').AsString);
  LAdvJSONObjectWriter.AddIntegerPair('unit_nid', ADataSet.FieldByName('unit_nid').AsInteger);
  LAdvJSONObjectWriter.AddIntegerPair('user_nid', ADataSet.FieldByName('user_nid').AsInteger);
  LAdvJSONObjectWriter.AddStringPair('schd_esamplecollectiontype', ADataSet.FieldByName('schd_esamplecollectiontype').AsString);
  LAdvJSONObjectWriter.AddStringPair('schd_csamplecollectioninfo', ADataSet.FieldByName('schd_csamplecollectioninfo').AsString);

  ResetBackEndpoint(BackEndpointPostItem);

  BackEndpointPostItem.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.Any;
  BackEndpointPostItem.Accept := EMS_APPLICATION_JSON;

  BackEndpointPostItem.AddParameter(
    EMS_POST_ITEM_PARAM_NAME_DATATYPE,
    EMS_POST_ITEM_PARAM_VALUE_SCHEDULE_REQUEST,
    TRESTRequestParameterKind.pkHTTPHEADER);

  BackEndpointPostItem.Body.Add(LAdvJSONObjectWriter.AsJSONObject);

  try
    BackEndpointPostItem.Execute;
  finally
    if rRespPostItem.StatusCode <> HTTP_SUCCESSFUL_REQUEST then
    begin
      Result := False;
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          TDialogService.MessageDialog(
            'Não foi possível abrir a solicitação de agendamento.',
            TMsgDlgType.mtError,
            [TMsgDlgBtn.mbOk],
            TMsgDlgBtn.mbOk,
            0,
            procedure(const AResult: TModalResult)
            begin
              TAppSharedUtils.HideActivityIndicator;
            end);
        end);
    end
    else
    begin
      LJSONResponse := TJSONObject.ParseJSONValue(rRespPostItem.JSONText) as TJSONObject;
      try
        if TryStrToInt(LJSONResponse.GetValue('SchdID').Value, LSchdID) then
        begin
          Chronos.SetItem<Integer>(APP_SCHEDULE_REQUEST_ID, LSchdID);
          Result := True;
        end;
      finally
        LJSONResponse.DisposeOf;
      end;
    end;
  end;
end;

procedure Tsrv2Laboratory.DoDeleteDocumentImage(ARequestDocumentType: TRequestDocumentType);
begin
  try
    qrySelectDocumentByType.Close;
    qrySelectDocumentByType.ParamByName('pDocType').AsString := ARequestDocumentType.ToString;
    qrySelectDocumentByType.Open;

    if not qrySelectDocumentByType.IsEmpty then
    begin
      qrySelectDocumentByType.First;
      while not qrySelectDocumentByType.Eof do
      begin
        DeleteFile(qrySelectDocumentByType.FieldByName('ImageFileName').AsString);
        qrySelectDocumentByType.Next;
      end;
    end;

    sqlDeleteDocumentByType.ParamByName('pDocType').AsString := ARequestDocumentType.ToString;
    sqlDeleteDocumentByType.Execute;

    case ARequestDocumentType of
      rdID:
        begin
          frmLaboratoryMain.IDPhotoTaken := False;
        end;
      rdDocument:
        begin
          frmLaboratoryMain.DocPhotoTaken := False;
        end;
      rdHICard:
        begin
          frmLaboratoryMain.HIPhotoTaken := False;
        end;
    end;
  finally
    TAppSharedUtils.HideActivityIndicator;
  end;
end;

procedure Tsrv2Laboratory.DoRecordDocumentImage(ARequestDocumentType: TRequestDocumentType);
var
  LImageFileName: string;
  LSaveParams: TBitmapCodecSaveParams;
begin
  try
    if Assigned(TAppPhotoTaker.Photo) then
    begin
      LImageFileName := TSharedProperties.NewImageName;
      LSaveParams.Quality := 50;
      TAppPhotoTaker.Photo.SaveToFile(LImageFileName, @LSaveParams);

      if not mTblScheduleRequestDocument.Active then
      begin
        mTblScheduleRequestDocument.Open;
      end;

      mTblScheduleRequestDocument.Append;
      mTblScheduleRequestDocumentDocType.AsString := ARequestDocumentType.ToString;
      mTblScheduleRequestDocumentImageFileName.AsString := LImageFileName;
      mTblScheduleRequestDocumentLog_DateTime.AsDateTime := Now;
      mTblScheduleRequestDocument.Post;

      frmLaboratoryMain.AddImageCard(ARequestDocumentType, LImageFileName);
    end;
  finally
    TAppSharedUtils.HideActivityIndicator;
  end;
end;

function Tsrv2Laboratory.DoSendDocuments(const AScheduleID: Integer): Boolean;
var
  LImageFile: TFileStream;
  LStream: TMemoryStream;
  LContinue: Boolean;
begin
  Result := False;

  LContinue := True;

  mTblScheduleRequestDocument.First;

  while LContinue and (not mTblScheduleRequestDocument.Eof) do
  begin
    ResetBackEndpoint(BackEndpointPostImage);

    BackEndpointPostImage.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.Any;
    BackEndpointPostImage.Accept := EMS_IMAGE_JPEG;

    BackEndpointPostImage.AddParameter(
      EMS_PARAM_NAME_SCHEDULE_ID,
      AScheduleID.ToString,
      TRESTRequestParameterKind.pkHTTPHEADER);

    BackEndpointPostImage.AddParameter(
      EMS_PARAM_NAME_DOCTYPE,
      mTblScheduleRequestDocumentDocType.AsString,
      TRESTRequestParameterKind.pkHTTPHEADER);

    BackEndpointPostImage.AddParameter(
      EMS_PARAM_NAME_FILENAME,
      ExtractFileName(mTblScheduleRequestDocumentImageFileName.AsString),
      TRESTRequestParameterKind.pkHTTPHEADER);

    LImageFile := TFileStream.Create(mTblScheduleRequestDocumentImageFileName.AsString, fmOpenRead);
    try
      LStream := TMemoryStream.Create;
      try
        LStream.CopyFrom(LImageFile, 0);
        BackEndpointPostImage.AddBody(LStream, TRESTContentType.ctIMAGE_JPEG);
        try
          BackEndpointPostImage.Execute;
        finally
          if rRespPostImage.StatusCode <> HTTP_SUCCESSFUL_REQUEST then
          begin
            Result := False;
            TThread.Synchronize(
              TThread.CurrentThread,
              procedure()
              begin
                TDialogService.MessageDialog(
                  'Não foi possível enviar os documentos necessários.',
                  TMsgDlgType.mtError,
                  [TMsgDlgBtn.mbOk],
                  TMsgDlgBtn.mbOk,
                  0,
                  procedure(const AResult: TModalResult)
                  begin
                    TAppSharedUtils.HideActivityIndicator;
                  end);
              end);
          end
          else
          begin
            Result := True;
          end;
        end;
      finally
        LStream.DisposeOf;
      end;
    finally
      LImageFile.DisposeOf
    end;

    LContinue := Result;

    mTblScheduleRequestDocument.Next;
  end;
end;

procedure Tsrv2Laboratory.RecordDocumentImage(ARequestDocumentType: TRequestDocumentType);
var
  LTask: ITask;
  LRequestDocumentType: TRequestDocumentType;
begin
  LTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        begin
          DoRecordDocumentImage(LRequestDocumentType);
        end);
    end);

  LRequestDocumentType := ARequestDocumentType;
  TAppSharedUtils.ShowActivityIndicator(frmLaboratoryMain);
  LTask.Start;
end;

function Tsrv2Laboratory.RequestDocumentsOk(APaymentType: TPaymentType): Boolean;
{$REGION 'Inner methods'}
 function _DocumentTypeExists(ARequestDocumentType: TRequestDocumentType): Boolean;
 begin
   qrySelectDocumentByType.Close;
   qrySelectDocumentByType.ParamByName('pDocType').AsString := ARequestDocumentType.ToString;
   qrySelectDocumentByType.Open;

   Result := not qrySelectDocumentByType.IsEmpty;
 end;
{$ENDREGION}
begin
  Result := _DocumentTypeExists(rdID);

  if Result then
  begin
    Result := _DocumentTypeExists(rdDocument);
  end;

  if Result and (APaymentType = ptHealthInsurance) then
  begin
    Result := _DocumentTypeExists(rdHICard);
  end;
end;

procedure Tsrv2Laboratory.ResetBackEndpoint(ABackEndpoint: TBackendEndpoint);
begin
  ABackEndpoint.AllowHTTPErrors := TCustomBackendEndpoint.TAllowHTTPErrors.None;
  ABackEndpoint.Params.Clear;
  ABackEndpoint.ResourceSuffix := EmptyStr;
  ABackEndpoint.Accept := EmptyStr;
end;

procedure Tsrv2Laboratory.SendScheduleRequest(var ADataSet: TFDMemTable);
var
  LTask: ITask;
  LDataSet: TFDMemTable;
begin
  LTask := TTask.Create(
    procedure()
    var
      LScheduleRequestID: Integer;
    begin
      try
        if DoOpenScheduleRequest(LDataSet) then
        begin
          LScheduleRequestID := Chronos.GetItem<Integer>(APP_SCHEDULE_REQUEST_ID);
          if DoSendDocuments(LScheduleRequestID) then
          begin
            if DoCloseScheduleRequest(LScheduleRequestID) then
            begin
              frmLaboratoryMain.FinishScheduleRequest;
            end;
          end;
        end;
      finally
        TAppSharedUtils.HideActivityIndicator;
      end;
    end);

  TAppSharedUtils.ShowActivityIndicator(frmLaboratoryMain);
  LDataSet := ADataSet;
  LTask.Start;
end;

end.