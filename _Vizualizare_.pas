unit _Vizualizare_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm6 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Button1: TButton;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses _Patrat_;

{$R *.DFM}

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.enabled:=true;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
form6.close;
end;

procedure TForm6.FormShow(Sender: TObject);
var i:integer;
begin
edit1.text:=floattostr (patrat_ro);
edit2.text:=inttostr (patrat_nr);
listbox1.clear;
for i:=1 to patrat_nr do
  listbox1.items.Add (inttostr (i)+'        '+floattostr (patrat_eta [i])+'        '+floattostr (patrat_csi [i]));
end;


end.
