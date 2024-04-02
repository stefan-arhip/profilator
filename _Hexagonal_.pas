unit _Hexagonal_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  
implementation

uses _Patrat_;

{$R *.DFM}


procedure TForm3.Button2Click(Sender: TObject);
begin
form3.close;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if not hexa_b then form1.checkbox2.checked:=false;
form1.enabled:=true;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
hexa_b:=false;
if deschis_fisier
  then
    begin
      edit1.text:=floattostr (hexa_re);
      edit2.text:=inttostr (hexa_nr);
    end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  a,umin,umax,u,fi,csimin,csimax,etamin,etamax:REAL;
  i:INTEGER;
begin
hexa_b:=true;
deschis_fisier:=false;
hexa_re:=strtofloat (edit1.text);
hexa_nr:=round (strtofloat (edit2.text));
umin:=-hexa_re*SQRT (3)/2;
umax:=hexa_re*SQRT (3)/2;
a:=hexa_re*SQRT (3)/2;
FOR i:=1 TO hexa_nr DO
  BEGIN
    u:=umin+PRED (i)*(umax-umin)/PRED (hexa_nr);
    fi:=arcsin (u/hexa_re);
    hexa_csi [i]:=-a*COS (fi)-u*SIN (fi)+hexa_re;
    hexa_eta [i]:=-a*SIN (fi)+u*COS (fi)+hexa_re*fi;
    if form1.radiobutton1.checked
      then
        form1.series2.AddXY (hexa_eta [i],-hexa_csi [i],'',clgreen);
  END;
if form1.radiobutton2.checked
  then
    begin
      etamin:=hexa_eta [1];
      etamax:=hexa_eta [1];
      csimin:=hexa_csi [1];
      csimax:=hexa_csi [1];
      FOR i:=1 TO hexa_nr DO
        BEGIN
          IF hexa_eta [i]<etamin
            THEN
              etamin:=hexa_eta [i];
          IF hexa_eta [i]>etamax
            THEN
              etamax:=hexa_eta [i];
          IF hexa_csi [i]<csimin
            THEN
              csimin:=hexa_csi [i];
          IF hexa_csi [i]>csimax
            THEN
              csimax:=hexa_csi [i];
        end;
      for i:=1 to hexa_nr do
        form1.series2.AddXY ((etamax-hexa_eta [i])*100/(etamax-etamin),(csimax-hexa_csi [i])*100/(csimax-csimin),'',clgreen);  
    end;
form1.Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2.checked:=true;    
form3.close;
end;

end.
