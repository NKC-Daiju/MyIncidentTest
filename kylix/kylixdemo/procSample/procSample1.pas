unit procSample1;

interface

uses
  SysUtils, Types, Classes, Variants, QGraphics, QControls, QForms, QDialogs,
  DBXpress, FMTBcd, QButtons, QStdCtrls, DB, SqlExpr;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    SQLStoredProc1: TSQLStoredProc;
    ComboBox1: TComboBox;
    execBtn: TButton;
    GroupBox1: TGroupBox;
    TOT_BUDGETEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    AVG_BUDGETEdit: TEdit;
    Label3: TLabel;
    MIN_BUDGETEdit: TEdit;
    Label4: TLabel;
    MAX_BUDGETEdit: TEdit;
    BitBtn1: TBitBtn;
    procedure execBtnClick(Sender: TObject);
  private
    { Private АлёА }
  public
    { Public АлёА }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.execBtnClick(Sender: TObject);
begin
  with SQLStoredProc1 do
  begin
    Params.ParamByName('HEAD_DEPT').AsString
       :=ComboBox1.text;
    try
      ExecProc;
      TOT_BUDGETEdit.Text:=paramByName('TOT_BUDGET').AsString;
      AVG_BUDGETEdit.Text:=paramByName('AVG_BUDGET').AsString;
      MIN_BUDGETEdit.Text:=paramByName('MIN_BUDGET').AsString;
      MAX_BUDGETEdit.Text:=paramByName('MAX_BUDGET').AsString;
    except on E:Exception do
      begin
         ShowMessage(E.Message);
      end;
    end;
  end;
end;

end.
