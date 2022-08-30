unit UniLoginUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, acPNG, jpeg, ExtCtrls, XPman, Buttons, ACBrBase, ACBrDFe,
  ACBrMDFe;

type
  TFrmLoginUsuario = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Image3: TImage;
    Panel4: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure limpatexto();
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLoginUsuario: TFrmLoginUsuario;

implementation

uses UniCadastroUsuario, UniCadastroCidade, UniDashboard;

{$R *.dfm}



procedure TFrmLoginUsuario.Button1Click(Sender: TObject);
begin
     
if ((Edit1.Text = '') and (Edit2.text = '')) then
begin
     ShowMessage('Os campos estão vazios!');
end;

if ((Edit1.Text = 'admin') and (Edit2.text = '1234')) then
begin
     FrmDashboard.Showmodal;
     FrmDashboard.Close;
end;

if ((Edit1.Text <> 'admin') and (Edit2.Text <> '1234')) then
begin
     ShowMessage('Usuário ou Senha inválida');
end;
if ((Edit1.Text <> 'admin') and (Edit2.Text = '1234')) then
begin
     ShowMessage('Usuário ou Senha inválida');
end;
if ((Edit1.Text = 'admin') and (Edit2.Text <> '1234')) then
begin
     ShowMessage('Senha incorreta!');
end;
    limpatexto();
     
     
end;

procedure TFrmloginUsuario.limpatexto();
var
n:integer;

begin

for n := 0 to ComponentCount -1 do begin

if Components[n] is Tedit then

Tedit(Components[n]).Text := '';

end;
end;
end.
