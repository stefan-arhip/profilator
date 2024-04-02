unit _Profilator_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
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
  Form2: TForm2;
  
implementation

uses _Patrat_, _Canelura_;

{$R *.DFM}

procedure TForm2.Button2Click(Sender: TObject);
begin
form2.close;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if not patrat_b then form1.checkbox1.checked:=false;
form1.enabled:=true;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
patrat_b:=false;
if deschis_fisier
  then
    begin
      edit1.text:=floattostr (patrat_ro);
      edit2.text:=inttostr (patrat_nr);
    end;
end;

procedure TForm2.Button1Click(Sender: TObject);
  CONST
    i1=4/4;
  VAR
    a,umin,umax,fi,u,a12,etamin,etamax,csimin,csimax:REAL;
    i:INTEGER;
begin
patrat_b:=true;
deschis_fisier:=false;
patrat_ro:=strtofloat (edit1.text);
patrat_nr:=round (strtofloat (edit2.text));
a12:=(1+1/i1)*patrat_ro;
a:=SQRT (2)*patrat_ro/2;
umin:=-SQRT (2)*patrat_ro/2;
umax:=SQRT (2)*patrat_ro/2;
FOR i:=1 TO patrat_nr DO
  BEGIN
    u:=umin+PRED (i)*(umax-umin)/PRED (patrat_nr);
    fi:=arcsin (u/patrat_ro);
    patrat_csi [i]:=-a*COS ((i1+1)*fi)-u*SIN ((i1+1)*fi)+a12*COS (i1*fi);
    patrat_eta [i]:=-a*SIN ((i1+1)*fi)+u*COS ((i1+1)*fi)+a12*SIN (i1*fi);
    if form1.radiobutton1.checked
      then
        form1.series1.AddXY (patrat_eta [i],-patrat_csi [i],'',clred);
  END;
if form1.radiobutton2.checked
  then
    begin
      etamin:=patrat_eta [1];
      etamax:=patrat_eta [1];
      csimin:=patrat_csi [1];
      csimax:=patrat_csi [1];
      FOR i:=1 TO patrat_nr DO
        BEGIN
          IF patrat_eta [i]<etamin
            THEN
              etamin:=patrat_eta [i];
          IF patrat_eta [i]>etamax
            THEN
              etamax:=patrat_eta [i];
          IF patrat_csi [i]<csimin
            THEN
              csimin:=patrat_csi [i];
          IF patrat_csi [i]>csimax
            THEN
              csimax:=patrat_csi [i];
        end;
      for i:=1 to patrat_nr do
        form1.series1.AddXY ((etamax-patrat_eta [i])*100/(etamax-etamin),(csimax-patrat_csi [i])*100/(csimax-csimin),'',clred);
    end;
form1.Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2.checked:=true;
form2.close;
end;

end.
