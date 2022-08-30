program Project3;





uses
  Forms,
  UniCadastroUsuario in 'UniCadastroUsuario.pas' {FrmCadastroUsuario},
  UniRelListagemUsusarios in 'UniRelListagemUsusarios.pas' {FRelListagemUsuarios},
  UniCadastroCidade in 'UniCadastroCidade.pas' {FrmCadastroCidade},
  UniCadastroInstrumentos in 'UniCadastroInstrumentos.pas' {FrmCadastroInstrumentos},
  UniLoginUsuarios in 'UniLoginUsuarios.pas' {FrmLoginUsuario},
  UniDashboard in 'UniDashboard.pas' {FrmDashboard};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmLoginUsuario, FrmLoginUsuario);
  Application.CreateForm(TFrmCadastroUsuario, FrmCadastroUsuario);
  Application.CreateForm(TFrmCadastroCidade, FrmCadastroCidade);
  Application.CreateForm(TFrmCadastroInstrumentos, FrmCadastroInstrumentos);
  Application.CreateForm(TFrmDashboard, FrmDashboard);
  Application.Run;
end.
