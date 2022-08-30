unit UniCadastroInstrumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, acPNG, ExtCtrls, StdCtrls, DB, IBCustomDataSet, IBStoredProc,
  IBDatabase, IBQuery, Grids, DBGrids;

type
  TFrmCadastroInstrumentos = class(TForm)
    Pincipal_Panel: TPanel;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image2: TImage;
    Image6: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TR_CADASTRO: TIBTransaction;
    SP_INS_CADASTRO: TIBStoredProc;
    QRY_BUSCAID: TIBQuery;
    QRY_INS: TIBQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    QRY_INSINS_CODIGO: TIntegerField;
    QRY_INSINS_DESCRICAO: TIBStringField;
    QRY_INSINS_TIPO: TIBStringField;
    QRY_INSINS_AFINACAO: TIBStringField;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BTN_EXCLUIR: TButton;
    procedure Button1Click(Sender: TObject);
    procedure GravaCadastro();
    procedure BUSCA_ID_INSTRUMENTO();
    procedure FormShow(Sender: TObject);
    procedure ATUALIZAQRY(NOME_QRY: TIBQuery);
    procedure limpatexto();
    procedure excluirRegistro(codigoIns:Integer);
    procedure BTN_EXCLUIRClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);

  private
    codInstrumento : integer;
    AUX_CODIGO_INS : string;
    editar  : Boolean;
  public
    { Public declarations }
  end;

var
  FrmCadastroInstrumentos: TFrmCadastroInstrumentos;

implementation

Uses
    UniCadastroUsuario;

{$R *.dfm}



procedure TFrmCadastroInstrumentos.Button1Click(Sender: TObject);
begin
if NOT(editar) then
   BUSCA_ID_INSTRUMENTO();
   
   GravaCadastro();
   limpatexto();
   ATUALIZAQRY(QRY_INS);
end;

procedure TFrmCadastroInstrumentos.DBGrid1DblClick(Sender: TObject);
begin
     Edit1.Text :=  DBGrid1.DataSource.DataSet.FieldByName('INS_DESCRICAO').AsString;
     Edit2.Text :=  DBGrid1.DataSource.DataSet.FieldByName ('INS_TIPO').AsString;
     Edit3.Text :=  DBGrid1.DataSource.DataSet.FieldByName ('INS_AFINACAO').AsString;
     
     AUX_CODIGO_INS:= IntToStr(DBGrid1.DataSource.DataSet.FieldByName ('ins_codigo').AsInteger);
     editar := True
end;

procedure TFrmCadastroInstrumentos.limpatexto();
var
n:integer;

begin

for n := 0 to ComponentCount -1 do begin

if Components[n] is Tedit then

Tedit(Components[n]).Text := '';

end;
end;

procedure TFrmCadastroInstrumentos.FormShow(Sender: TObject);
begin
     QRY_INS.close;
     QRY_INS.open;
     AUX_CODIGO_INS := '';
     editar := false 
end;

procedure TFrmCadastroInstrumentos.ATUALIZAQRY(NOME_QRY: TIBQuery);
begin
     NOME_QRY.Close();
     NOME_QRY.OPEN();
end;

procedure TFrmCadastroInstrumentos.BTN_EXCLUIRClick(Sender: TObject);
begin
     excluirRegistro(DBGrid1.DataSource.DataSet.FieldByName('INS_CODIGO').AsInteger);
end;

procedure TFrmCadastroInstrumentos.BUSCA_ID_INSTRUMENTO();
begin
  QRY_BUSCAID.CLOSE;
  QRY_BUSCAID.SQL.CLEAR;
  QRY_BUSCAID.SQL.ADD('SELECT FIRST 1 INS_CODIGO FROM INSTRUMENTOS'); 
  QRY_BUSCAID.SQL.ADD('ORDER BY INS_CODIGO DESC');
  QRY_BUSCAID.OPEN;
  
  AUX_CODIGO_INS := IntToStr(QRY_BUSCAID.FieldByName('INS_CODIGO').AsInteger + 1);
end;

Procedure TFrmCadastroInstrumentos.GravaCadastro();
begin 
if NOT(TR_CADASTRO.Active) then
   TR_CADASTRO.Active := TRUE;
try
   SP_INS_CADASTRO.ParamByName('INS_CODIGO').AsInteger := StrToInt(AUX_CODIGO_INS);
   SP_INS_CADASTRO.ParamByName('INS_DESCRICAO').AsString := Edit1.text;
   SP_INS_CADASTRO.ParamByName('INS_TIPO').AsString := Edit2.text;
   SP_INS_CADASTRO.ParamByName('INS_AFINACAO').AsString := Edit3.text;
   SP_INS_CADASTRO.ExecProc;
   
except on ERRO:exception do
begin
   TR_CADASTRO.Rollback;
   ShowMessage('ERRO: '+Erro.Message + 'ERRO AO TENTAR GRAVAR CADASTRO!"');
   Abort;
end;
end;
  TR_CADASTRO.Commit;
  editar  := False;
end;

procedure TFrmCadastroInstrumentos.excluirRegistro(codigoIns:Integer);
begin
if NOT(TR_CADASTRO.Active) then
   TR_CADASTRO.Active := TRUE;
try
  SP_INS_CADASTRO.ParamByName('INS_CODIGO').AsInteger := codigoIns;
  SP_INS_CADASTRO.ParamByName('INS_DESCRICAO').AsString := '-1';
  SP_INS_CADASTRO.ParamByName('INS_TIPO').AsString := '';
  SP_INS_CADASTRO.ParamByName('INS_AFINACAO').AsString := '';
  SP_INS_CADASTRO.ExecProc;
except on ERRO:exception do
begin
  TR_CADASTRO.Rollback;
  ShowMessage('ERRO: '+Erro.Message + 'ERRO AO TENTAR EXCLUIR CADASTRO!"');
  Abort;
end;
end;
  TR_CADASTRO.Commit;
end;

end.
