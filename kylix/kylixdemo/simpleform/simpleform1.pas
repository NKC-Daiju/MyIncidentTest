unit simpleform1;

interface

uses
  SysUtils, Types, Classes, Variants, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls, DBXpress, FMTBcd, DB, SqlExpr;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    addBtn: TButton;
    ItemNoEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ItemNameEdit: TEdit;
    ItemPriceEdit: TEdit;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    firstBtn: TButton;
    lastBtn: TButton;
    nextBtn: TButton;
    EditBtn: TButton;
    DelBtn: TButton;
    procedure addBtnClick(Sender: TObject);
    procedure firstBtnClick(Sender: TObject);
    procedure lastBtnClick(Sender: TObject);
    procedure nextBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
  private
    { Private АлёА }
  public
    { Public АлёА }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.addBtnClick(Sender: TObject);
var sql:String;
    TD:TTransactionDesc;
begin
   sql := 'INSERT INTO ITEMS '
       + '( ITEMNAME, PRICE )'
       + ' VALUES '
       + '("'+ItemNameEdit.text+'","'
       + ItemPriceEdit.Text+'")';
   SQLQuery1.SQL.clear;
   SQLQuery1.SQL.Add(sql);
   try
      TD.TransactionID:=1;
      TD.IsolationLevel:=xilREADCOMMITTED;
      SQLConnection1.StartTransaction(TD);
      SQLQuery1.ExecSQL();
      SQLConnection1.Commit(TD);
   except
      on E:Exception do
      begin
         SQLConnection1.Rollback(TD);
         showmessage(E.Message);
      end;
   end;

end;

procedure TForm1.firstBtnClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('select * from items');
    try
       open;
       first;
       ItemNoEdit.Text:=FieldByName('ITEMNO').AsString;
       ItemNameEdit.Text:=FieldByName('ITEMNAME').AsString;
       ItemPriceEdit.Text:=FieldByName('PRICE').asString;
    except
      on E:Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end;
    NextBtn.Enabled:=True;
    LastBtn.Enabled:=True;
end;

procedure TForm1.lastBtnClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('select * from items order by itemno desc');
    try
       open;
       ItemNoEdit.Text:=FieldByName('ITEMNO').AsString;
       ItemNameEdit.Text:=FieldByName('ITEMNAME').AsString;
       ItemPriceEdit.Text:=FieldByName('PRICE').asString;
    except
       on E:Exception do
       begin
         ShowMessage(E.message);
       end;
    end;
  end;
  lastBtn.Enabled:=True;
  FirstBtn.Enabled:=True;
end;

procedure TForm1.nextBtnClick(Sender: TObject);
begin
  if not (SQLQuery1.Eof) then
  begin
    with SQLQuery1 do
    begin
    next;
    ItemNoEdit.Text:=FieldByName('ITEMNO').AsString;
    ItemNameEdit.Text:=FieldByName('ITEMNAME').AsString;
    ItemPriceEdit.Text:=FieldByName('PRICE').asString;
    end;
  end
  else begin
     LastBtn.Enabled:=False;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FirstBtn.Click;
end;

procedure TForm1.EditBtnClick(Sender: TObject);
var sql, curNo:String;
    TD:TTransactionDesc;
begin
   curNo:=ItemNoEdit.Text;
   sql := 'UPDATE ITEMS '
       + 'SET ITEMNAME="'
       + ItemNameEdit.text+'",Price='
       + ItemPriceEdit.text
       + 'Where ItemNo="'+curNo+'"';
   SQLQuery1.Close;
   SQLQuery1.SQL.clear;
   SQLQuery1.SQL.Add(sql);
   TD.TransactionID:=1;
   TD.IsolationLevel:=xilREADCOMMITTED;
   try
      SQLConnection1.StartTransaction(TD);
      SQLQuery1.ExecSQL();
      SQLConnection1.Commit(TD);
   except
      on E:Exception do
      begin
        showmessage(E.Message);
        SQLConnection1.Rollback(TD);
      end;
   end;
   FirstBtn.Click;
end;

procedure TForm1.DelBtnClick(Sender: TObject);
var curNo,str:String;
    TD:TTransactionDesc;
begin
  curNo:=trim(ItemNoEdit.Text);
  str := 'DELETE FROM ITEMS WHERE '
       + 'ITEMNO = "'+curNO+'"';
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add(str);
    TD.TransactionID:=1;
    TD.IsolationLevel:=xilREADCOMMITTED;
    try
      SQLConnection1.StartTransaction(TD);
      ExecSQL();
      SQLConnection1.commit(TD);
    except
      on E:Exception do
      begin
         showMessage(E.Message);
         SQLConnection1.Rollback(TD);
      end;
    end;
    FirstBtn.Click;
  end;
end;

end.
