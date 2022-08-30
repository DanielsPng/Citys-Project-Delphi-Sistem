unit UniCadastroCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, acPNG, ExtCtrls, StdCtrls, Grids, DBGrids, DB, IBDatabase,
  IBCustomDataSet, IBQuery, IBStoredProc;

type
  TFrmCadastroCidade = class(TForm)
    PAINEL_PRINCIPAL: TPanel;
    EDIT_CIDADE: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BTN_ENVIAR: TButton;
    TR_CADASTRO: TIBTransaction;
    DataSource1: TDataSource;
    IBQuery_CIDADE: TIBQuery;
    QRY_BUSCAID: TIBQuery;
    IBQuery_CIDADECID_CODIGO: TIntegerField;
    IBQuery_CIDADECID_DESCRICAO: TIBStringField;
    IBQuery_CIDADECID_COD_IBGE: TIntegerField;
    IBQuery_CIDADECID_UF: TIBStringField;
    IBQuery_CIDADECID_PAIS: TIBStringField;
    SP_CID_CADASTRO: TIBStoredProc;
    BTN_EXCLUIR: TButton;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    procedure BUSCA_ID_CIDADE();
    procedure BTN_ENVIARClick(Sender: TObject);
    procedure GravaCadastro();
    procedure FormShow(Sender: TObject);
    procedure BTN_EXCLUIRClick(Sender: TObject);
    procedure excluirRegistro(codigoCidade:Integer);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure limpatexto();
    procedure ATUALIZAQRY(NOME_QRY: TIBQuery);
   

    
    
  private
  codCidade : Integer;
  AUX_CODIGO_CIDADE : string;
  editar : Boolean;
  public
    { Public declarations }
  end;

var
  FrmCadastroCidade: TFrmCadastroCidade;

implementation

Uses
    UniCadastroUsuario;

{$R *.dfm}

procedure TFrmCadastroCidade.BTN_EXCLUIRClick(Sender: TObject);
begin
  excluirRegistro(DBGrid1.DataSource.DataSet.FieldByName('CID_CODIGO').AsInteger);
end;

procedure TFrmCadastroCidade.limpatexto();
var
n:integer;

begin

for n := 0 to ComponentCount -1 do begin

if Components[n] is Tedit then

Tedit(Components[n]).Text := '';

end;
end;

procedure TFrmCadastroCidade.excluirRegistro(codigoCidade:Integer);
begin
if NOT(TR_CADASTRO.Active) then
   TR_CADASTRO.Active := TRUE;
try
  SP_CID_CADASTRO.ParamByName('CID_CODIGO').AsInteger := codigoCidade;
  SP_CID_CADASTRO.ParamByName('CID_DESCRICAO').AsString := '-1';
  SP_CID_CADASTRO.ParamByName('CID_COD_IBGE').AsInteger := codigoCidade;
  SP_CID_CADASTRO.ParamByName('CID_UF').AsString := '';
  SP_CID_CADASTRO.ParamByName('CID_PAIS').AsString := '';
  SP_CID_CADASTRO.ExecProc;
except on ERRO:exception do
begin
  TR_CADASTRO.Rollback;
  ShowMessage('ERRO: '+Erro.Message + 'ERRO AO TENTAR EXCLUIR CADASTRO!"');
  Abort;
end;
end;
  TR_CADASTRO.Commit;
end;


procedure TFrmCadastroCidade.BUSCA_ID_CIDADE();
begin
  QRY_BUSCAID.CLOSE;
  QRY_BUSCAID.SQL.CLEAR;
  QRY_BUSCAID.SQL.ADD('SELECT FIRST 1 CID_CODIGO FROM CIDADE'); 
  QRY_BUSCAID.SQL.ADD('ORDER BY CID_CODIGO DESC');
  QRY_BUSCAID.OPEN;
  
  AUX_CODIGO_CIDADE := IntToStr(QRY_BUSCAID.FieldByName('CID_CODIGO').AsInteger + 1);
end;


procedure TFrmCadastroCidade.DBGrid1DblClick(Sender: TObject);
begin
     EDIT_CIDADE.Text :=  DBGrid1.DataSource.DataSet.FieldByName('CID_DESCRICAO').AsString;
     Edit1.Text :=  IntToStr(DBGrid1.DataSource.DataSet.FieldByName ('CID_COD_IBGE').AsInteger);
     Edit2.Text :=  DBGrid1.DataSource.DataSet.FieldByName ('CID_UF').AsString;
     Edit3.Text :=  DBGrid1.DataSource.DataSet.FieldByName ('CID_PAIS').AsString;
     
     AUX_CODIGO_CIDADE := IntToStr(DBGrid1.DataSource.DataSet.FieldByName ('CID_codigo').AsInteger);
     editar := True;
end;

Procedure TFrmCadastroCidade.GravaCadastro();
begin 
if NOT(TR_CADASTRO.Active) then
   TR_CADASTRO.Active := TRUE;
try
   SP_CID_CADASTRO.ParamByName('CID_CODIGO').AsInteger := StrToInt(AUX_CODIGO_CIDADE);
   SP_CID_CADASTRO.ParamByName('CID_DESCRICAO').AsString := Edit_CIDADE.text;
   SP_CID_CADASTRO.ParamByName('CID_COD_IBGE').AsInteger :=StrToInt(Edit1.text);
   SP_CID_CADASTRO.ParamByName('CID_UF').AsString := Edit2.text;
   SP_CID_CADASTRO.ParamByName('CID_PAIS').AsString := Edit3.text;
   SP_CID_CADASTRO.ExecProc;
   
except on ERRO:exception do
begin
   TR_CADASTRO.Rollback;
   ShowMessage('ERRO: '+Erro.Message + 'ERRO AO TENTAR GRAVAR CADASTRO!"');
   Abort;
end;
end;
  TR_CADASTRO.Commit;
  editar := False;
end;

procedure TFrmCadastroCidade.FormShow(Sender: TObject);
begin
    IBQuery_CIDADE.Close;
    IBQuery_CIDADE.Open; 
    AUX_CODIGO_CIDADE := '';
    editar := false 
end;

procedure TFrmCadastroCidade.ATUALIZAQRY(NOME_QRY: TIBQuery);
begin
     NOME_QRY.Close();
     NOME_QRY.OPEN();
end;

procedure TFrmCadastroCidade.BTN_ENVIARClick(Sender: TObject);
begin
  if NOT(editar) then
     BUSCA_ID_CIDADE();
     
  GravaCadastro();
  limpatexto();
  ATUALIZAQRY(IBQuery_CIDADE);
end;

end.
