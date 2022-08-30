unit UniDashboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, acPNG;

type
  TFrmDashboard = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Shape1: TShape;
    BTN_USU: TButton;
    Image1: TImage;
    Image2: TImage;
    Shape2: TShape;
    BTN_CID: TButton;
    Image3: TImage;
    Shape3: TShape;
    BTN_INS: TButton;
    Image5: TImage;
    Label2: TLabel;
    procedure BTN_USUClick(Sender: TObject);
    procedure BTN_CIDClick(Sender: TObject);
    procedure BTN_INSClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDashboard: TFrmDashboard;

implementation

uses UniCadastroUsuario, UniCadastroCidade, UniCadastroInstrumentos, UniLoginUsuarios;

{$R *.dfm}



procedure TFrmDashboard.BTN_INSClick(Sender: TObject);
begin
     FrmCadastroInstrumentos.Showmodal;
     FrmCadastroInstrumentos.Close;
end;

procedure TFrmDashboard.BTN_USUClick(Sender: TObject);
begin
     FrmCadastroUsuario.Showmodal;
     FrmCadastroUsuario.Close;
end;

procedure TFrmDashboard.Label2Click(Sender: TObject);
begin
     FrmDashboard.Close;
end;

procedure TFrmDashboard.BTN_CIDClick(Sender: TObject);
begin
     FrmCadastroCidade.Showmodal;
     FrmCadastroCidade.Close;
end;

end.
