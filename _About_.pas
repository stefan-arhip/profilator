unit _About_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Timer2: TTimer;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    Iesire1: TMenuItem;
    procedure Panel1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses _Profilator_, _Patrat_;

{$R *.DFM}


procedure TForm5.Panel1Click(Sender: TObject);
begin
form5.close;
form1.enabled:=true;
end;


procedure TForm5.Timer1Timer(Sender: TObject);
const px:integer=3;py:integer=1;
begin
image1.left:=image1.left+px;
if (image1.left+image1.width+px>panel1.width-2) or (image1.left+px<2) then px:=-px;
image1.top:=image1.top+py;
if (image1.top+image1.height+py>panel1.height-2) or (image1.top+py<2) then py:=-py;
end;

procedure TForm5.Timer2Timer(Sender: TObject);
const px:integer=1;py:integer=3;
begin
label1.left:=label1.left+px;
if (label1.left+label1.width+px>panel1.width-2) or (label1.left+px<2) then px:=-px;
label1.top:=label1.top+py;
if (label1.top+label1.height+py>panel1.height-2) or (label1.top+py<2) then py:=-py;
end;

end.
