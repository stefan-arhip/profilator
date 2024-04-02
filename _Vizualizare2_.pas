unit _Vizualizare2_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm7 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Button1: TButton;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses _Patrat_;

{$R *.DFM}

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.enabled:=true;
end;

procedure TForm7.FormShow(Sender: TObject);
var i:integer;
begin
edit1.text:=floattostr (hexa_re);
edit2.text:=inttostr (hexa_nr);
listbox1.clear;
for i:=1 to hexa_nr do
  listbox1.items.Add (inttostr (i)+'        '+floattostr (hexa_eta [i])+'        '+floattostr (hexa_csi [i]));
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
form7.close;
end;


end.
