program ProcSample;

uses
  QForms,
  procSample1 in 'procSample1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
