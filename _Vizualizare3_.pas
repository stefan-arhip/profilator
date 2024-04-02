unit _Vizualizare3_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm8 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListBox1: TListBox;
    Button1: TButton;
    Label6: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Edit4: TEdit;
    Label8: TLabel;
    Edit5: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

uses _Patrat_;

{$R *.DFM}

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.enabled:=true;
end;

procedure TForm8.FormShow(Sender: TObject);
var i:integer;
begin
edit1.text:=floattostr (canelura_re);
edit2.text:=floattostr (canelura_ri);
edit3.text:=floattostr (canelura_bb);
edit4.text:=inttostr (canelura_nr);
edit5.text:=floattostr (canelura_eps);
listbox1.clear;
for i:=1 to canelura_nr do
  listbox1.items.Add (inttostr (i)+'        '+floattostr (canelura_eta [i])+'        '+floattostr (canelura_csi [i]));
end;

procedure TForm8.Button1Click(Sender: TObject);
begin
form8.close;
end;

end.
