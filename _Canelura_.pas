unit _Canelura_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
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
  Form4: TForm4;
  
implementation

uses _Patrat_;

{$R *.DFM}

procedure TForm4.Button2Click(Sender: TObject);
begin
form4.Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if not canelura_b then form1.checkbox3.checked:=false;
form1.enabled:=true;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
canelura_b:=false;
if deschis_fisier
  then
    begin
      edit1.text:=floattostr (canelura_re);
      edit2.text:=floattostr (canelura_ri);
      edit3.text:=floattostr (canelura_bb);
      edit5.text:=floattostr (canelura_nr);
      edit6.text:=floattostr (canelura_eps);
    end;
end;

procedure TForm4.Button1Click(Sender: TObject);
var
  (*z,*)i:INTEGER;
  rr,u,umin,umax,fi,eps0,delta,sol1,sol2,etamin,etamax,csimin,csimax:REAL;
begin
canelura_b:=true;
deschis_fisier:=false;
canelura_re:=strtofloat (edit1.text);
canelura_ri:=strtofloat (edit2.text);
canelura_bb:=strtofloat (edit3.text);
(*z:=round (stringtoreal (edit4.text));*)
canelura_nr:=round (strtofloat (edit5.text));
canelura_eps:=strtofloat (edit6.text);
umin:=0;
eps0:=arcsin (canelura_bb/canelura_re);
canelura_eps:=canelura_eps*PI/180;
canelura_eps:=canelura_eps*180/PI;
delta:=SQRT (SQR (canelura_ri)-SQR (canelura_re*SIN ((eps0+canelura_eps)*PI/180)));
sol1:=canelura_re*COS ((eps0+canelura_eps)*PI/180)+delta;
sol2:=canelura_re*COS ((eps0+canelura_eps)*PI/180)-delta;
umax:=0;
IF (sol1>0) AND (sol2>0)
  THEN
    BEGIN
      IF sol1<sol2
        THEN
          umax:=sol1
        ELSE
          umax:=sol2;
    END;
IF (sol1>0) AND (sol2<0)
  THEN
    umax:=sol1;
IF (sol1<0) AND (sol2>0)
  THEN
    umax:=sol2;
IF (sol1<0) AND (sol2<0)
  THEN
    umax:=sol1;
rr:=0;
FOR i:=1 TO canelura_nr DO
  BEGIN
    u:=umin+PRED (i)*(umax-umin)/PRED (canelura_nr);
    fi:=-canelura_eps*PI/180+arccos ((canelura_re*COS (eps0+canelura_eps)-u)/canelura_re);
    canelura_csi [i]:=-canelura_re*COS ((eps0-fi)*PI/180)+u*COS ((canelura_eps+fi)*PI/180)+rr;
    canelura_eta [i]:=canelura_re*SIN ((eps0-fi)*PI/180)+u*SIN ((canelura_eps+fi)*PI/180)+rr*fi*PI/180;
    if form1.radiobutton1.checked
      then
        form1.series3.AddXY (canelura_csi [i],canelura_eta [i],'',clblue);
  END;
if form1.radiobutton2.checked
  then
    begin
      etamin:=canelura_eta [1];
      etamax:=canelura_eta [1];
      csimin:=canelura_csi [1];
      csimax:=canelura_csi [1];
      FOR i:=1 TO canelura_nr DO
        BEGIN
          IF canelura_eta [i]<etamin
            THEN
              etamin:=canelura_eta [i];
          IF canelura_eta [i]>etamax
            THEN
              etamax:=canelura_eta [i];
          IF canelura_csi [i]<csimin
            THEN
              csimin:=canelura_csi [i];
          IF canelura_csi [i]>csimax
            THEN
              csimax:=canelura_csi [i];
        end;
      for i:=1 to canelura_nr do
        form1.series3.AddXY (100-(csimax-canelura_csi [i])*100/(csimax-csimin),100-(etamax-canelura_eta [i])*100/(etamax-etamin),'',clblue);  
    end;
form1.Profilulcutituluiroatapentrurealizareacaneluriiarborilor2.checked:=true;    
form4.close;
end;

end.
