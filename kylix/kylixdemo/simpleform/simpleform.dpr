program simpleform;

uses
  QForms,
  simpleform1 in 'simpleform1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
