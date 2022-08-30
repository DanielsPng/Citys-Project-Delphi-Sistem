unit UniCadastroUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, acPNG, ExtCtrls, DB, IBDatabase, Grids, DBGrids,
  IBCustomDataSet, IBQuery, IBStoredProc, Menus, ComCtrls, DBCtrls;

type
  TFrmCadastroUsuario = class(TForm)
    Panel1: TPanel;
    Label9: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Edit6: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    BtnGravar: TButton;
    IBDatabase1: TIBDatabase;
    TR_CADASTRO: TIBTransaction;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    QRY_BUSCAID: TIBQuery;
    Excluir: TButton;
    QRY_EXCLUIR: TIBQuery;
    IntegerField1: TIntegerField;
    IBStringField1: TIBStringField;
    IBStringField2: TIBStringField;
    IBStringField3: TIBStringField;
    IBStringField4: TIBStringField;
    IBStringField5: TIBStringField;
    MenuGrid: TPopupMenu;
    Panel3: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Edit10: TEdit;
    Label12: TLabel;
    Edit11: TEdit;
    Label13: TLabel;
    USU_DATA_NASCIMENTO: TDateTimePicker;
    N1: TMenuItem;
    CID_CODIGO: TDBLookupComboBox;
    Query_CIDADES: TIBQuery;
    DTS_CIDADE: TDataSource;
    Query_CIDADESCID_DESCRICAO: TIBStringField;
    Query_CIDADESCID_CODIGO: TIntegerField;
    Query_CIDADESCID_COD_IBGE: TIntegerField;
    Query_CIDADESCID_UF: TIBStringField;
    Query_CIDADESCID_PAIS: TIBStringField;
    IBQuery1: TIBQuery;
    SP_CADASTRO: TIBStoredProc;
    IBQuery1USUARIO_ID: TIntegerField;
    IBQuery1NOME: TIBStringField;
    IBQuery1ESTADO: TIBStringField;
    IBQuery1CELULAR: TIBStringField;
    IBQuery1SENHA: TIBStringField;
    IBQuery1EMAIL: TIBStringField;
    IBQuery1ENDERECO: TIBStringField;
    IBQuery1CID_CODIGO: TIntegerField;
    IBQuery1CID_DESCRICAO: TIBStringField;
    procedure BtnGravarClick(Sender: TObject);
    procedure GravaCadastro();
    procedure ATUALIZA_QRY();
    procedure FormShow(Sender: TObject);
    procedure BUSCA_ID_USUARIO();
    procedure ExcluirClick(Sender: TObject);
    procedure excluirRegistro(codigoUsuario:Integer);
    procedure limpatexto();
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure abrecadastrocidade();
    procedure abrecadastroInstrumentos();
    procedure N1Click(Sender: TObject);

  
   
    
  private
    codUsuario : Integer;
  public
    { Public declarations }
  end;

var
  FrmCadastroUsuario: TFrmCadastroUsuario;

implementation

Uses
    UniRelListagemUsusarios, UniCadastroCidade, UniCadastroInstrumentos,
  UniLoginUsuarios;

{$R *.dfm}

procedure TFrmCadastroUsuario.BtnGravarClick(Sender: TObject);
begin
  BUSCA_ID_USUARIO();
  GravaCadastro();
  limpatexto();
end;

procedure TFrmCadastroUsuario.limpatexto();
var
n:integer;

begin

for n := 0 to ComponentCount -1 do begin

if Components[n] is Tedit then

Tedit(Components[n]).Text := '';

end;
end;

procedure TFrmCadastroUsuario.N1Click(Sender: TObject);
begin
   Application.CreateForm(TFRelListagemUsuarios, FRelListagemUsuarios);
   Try
      FRelListagemUsuarios.QuickRep1.PreviewModal;
   Finally
      FreeAndnil(FRelListagemUsuarios);
   End;
end;


procedure TFrmCadastroUsuario.ExcluirClick(Sender: TObject);
begin
  excluirRegistro(DBGrid1.DataSource.DataSet.FieldByName('USUARIO_ID').AsInteger);
end;

procedure TFrmCadastroUsuario.excluirRegistro(codigoUsuario:Integer);
begin
if NOT(TR_CADASTRO.Active) then
   TR_CADASTRO.Active := TRUE;
try
  SP_CADASTRO.ParamByName('USUARIO_ID').AsInteger := codigoUsuario;
  SP_CADASTRO.ParamByName('NOME').AsString := '-1';
  SP_CADASTRO.ParamByName('SENHA').AsString := '';
  SP_CADASTRO.ParamByName('ENDERECO').AsString := '';
  SP_CADASTRO.ParamByName('ESTADO').AsString := '';
  SP_CADASTRO.ParamByName('CID_CODIGO').AsInteger := 0;
  SP_CADASTRO.ParamByName('CELULAR').AsString := '';
  SP_CADASTRO.ParamByName('EMAIL').AsString := '';
  SP_CADASTRO.ExecProc;
except on ERRO:exception do
begin
  TR_CADASTRO.Rollback;
  ShowMessage('ERRO: '+Erro.Message + 'ERRO AO TENTAR EXCLUIR CADASTRO!"');
  Abort;
end;
end;
  TR_CADASTRO.Commit;
  ATUALIZA_QRY();
end;

procedure TFrmCadastroUsuario.BUSCA_ID_USUARIO();
begin
  QRY_BUSCAID.CLOSE;
  QRY_BUSCAID.SQL.CLEAR;
  QRY_BUSCAID.SQL.ADD('SELECT FIRST 1 USUARIO_ID, NOME FROM USUARIO'); 
  QRY_BUSCAID.SQL.ADD('ORDER BY USUARIO_ID DESC');
  QRY_BUSCAID.OPEN;
  
  codUsuario := QRY_BUSCAID.FieldByName('usuario_ID').AsInteger;
end;



procedure TFrmCadastroUsuario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key = vk_f1) then
begin
  abrecadastrocidade();
end;
if (key = vk_f2) then
begin
  abrecadastroInstrumentos();
end;
end;


procedure TFrmCadastroUsuario.FormShow(Sender: TObject);
begin
  ATUALIZA_QRY();
  Query_CIDADES.OPEN;
  Query_CIDADES.FetchAll;
end;

Procedure TFrmCadastroUsuario.GravaCadastro();
begin 
if NOT(TR_CADASTRO.Active) then
   TR_CADASTRO.Active := TRUE;
try
   SP_CADASTRO.ParamByName('USUARIO_ID').AsInteger := codUsuario + 1;
   SP_CADASTRO.ParamByName('NOME').AsString := Edit1.text;
   SP_CADASTRO.ParamByName('SENHA').AsString := Edit2.text;
   SP_CADASTRO.ParamByName('ENDERECO').AsString := Edit3.text;
   SP_CADASTRO.ParamByName('ESTADO').AsString := Edit6.text;
   SP_CADASTRO.ParamByName('CID_CODIGO').AsInteger := CID_CODIGO.KeyValue;
   SP_CADASTRO.ParamByName('CELULAR').AsString := Edit8.text;
   SP_CADASTRO.ParamByName('EMAIL').AsString := Edit7.text;
   SP_CADASTRO.ExecProc;
   
except on ERRO:exception do
begin
   TR_CADASTRO.Rollback;
   ShowMessage('ERRO: '+Erro.Message + 'ERRO AO TENTAR GRAVAR CADASTRO!"');
   Abort;
end;
end;
  TR_CADASTRO.Commit;
  ATUALIZA_QRY();
end;

procedure TFrmCadastroUsuario.abrecadastrocidade;
begin
     Application.CreateForm(TFrmCadastroCidade, FrmCadastroCidade);
try
   FrmCadastroCidade.ShowModal;
finally
   FreeAndNil(FrmCadastroCidade);
end;
end;

procedure TFrmCadastroUsuario.abrecadastroInstrumentos;
begin
     Application.CreateForm(TFrmCadastroInstrumentos, FrmCadastroInstrumentos);
try
   FrmCadastroInstrumentos.ShowModal;
finally
   FreeAndNil(FrmCadastroInstrumentos);
end;
end;


procedure TFrmCadastroUsuario.ATUALIZA_QRY();
begin
  IBQuery1.Close;
  IBQuery1.Open;               
end;
end.
