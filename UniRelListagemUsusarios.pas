unit UniRelListagemUsusarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, QRCtrls, QuickRpt, ExtCtrls, StdCtrls,
  jpeg;

type
  TFRelListagemUsuarios = class(TForm)
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRSysData4: TQRSysData;
    QRSysData5: TQRSysData;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRLabel9: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel2: TQRLabel;
    QRDBText6: TQRDBText;
    QRLabel6: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel7: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel8: TQRLabel;
    QryUsuarios: TIBQuery;
    QryUsuariosUSUARIO_ID: TIntegerField;
    QryUsuariosNOME: TIBStringField;
    QryUsuariosESTADO: TIBStringField;
    QryUsuariosCELULAR: TIBStringField;
    QryUsuariosSENHA: TIBStringField;
    QryUsuariosEMAIL: TIBStringField;
    QryUsuariosENDERECO: TIBStringField;
    QryUsuariosCID_CODIGO: TIntegerField;
    QryUsuariosCID_DESCRICAO: TIBStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRelListagemUsuarios: TFRelListagemUsuarios;

implementation

Uses
    UniCadastroUsuario;

{$R *.dfm}

procedure TFRelListagemUsuarios.FormCreate(Sender: TObject);
begin
     QryUsuarios.Open;
end;

end.
