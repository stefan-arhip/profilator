unit _Patrat_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Menus, ExtDlgs;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    GroupBox3: TGroupBox;
    CheckBox4: TCheckBox;
    GroupBox4: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    MainMenu1: TMainMenu;
    Fisier1: TMenuItem;
    Deschide1: TMenuItem;
    Salveaza1: TMenuItem;
    N1: TMenuItem;
    Iesire1: TMenuItem;
    Date1: TMenuItem;
    Grafic1: TMenuItem;
    Informatii1: TMenuItem;
    Despre1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SavePictureDialog1: TSavePictureDialog;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox2: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox3: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox5: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Vizualizaredate1: TMenuItem;
    Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata1: TMenuItem;
    Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala1: TMenuItem;
    Profilulcutituluiroatapentrurealizareacaneluriiarborilor1: TMenuItem;
    Comenzi1: TMenuItem;
    Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2: TMenuItem;
    Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2: TMenuItem;
    Profilulcutituluiroatapentrurealizareacaneluriiarborilor2: TMenuItem;
    Optiuni1: TMenuItem;
    Vederepanoramica1: TMenuItem;
    N2: TMenuItem;
    Grafice2: TMenuItem;
    Optiunidate1: TMenuItem;
    Nescalate1: TMenuItem;
    Scalate1: TMenuItem;
    Promptdate1: TMenuItem;
    Valoriintroduse1: TMenuItem;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Chart1Zoom(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Deschide1Click(Sender: TObject);
    procedure Grafic1Click(Sender: TObject);
    procedure Date1Click(Sender: TObject);
    procedure Iesire1Click(Sender: TObject);
    procedure Despre1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata1Click(
      Sender: TObject);
    procedure Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala1Click(
      Sender: TObject);
    procedure Profilulcutituluiroatapentrurealizareacaneluriiarborilor1Click(
      Sender: TObject);
    procedure Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2Click(
      Sender: TObject);
    procedure Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2Click(
      Sender: TObject);
    procedure Profilulcutituluiroatapentrurealizareacaneluriiarborilor2Click(
      Sender: TObject);
    procedure Vederepanoramica1Click(Sender: TObject);
    procedure Nescalate1Click(Sender: TObject);
    procedure Promptdate1Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  deschis_fisier:boolean=false;
  patrat_b:boolean=false;
  hexa_b:boolean=false;
  canelura_b:boolean=false;

var
  Form1: TForm1;
  patrat_ro:real;
  patrat_nr:integer;
  patrat_csi,patrat_eta:ARRAY [1..1000] OF REAL;
  hexa_re:real;
  hexa_nr:integer;
  hexa_eta,hexa_csi:ARRAY [1..1000] OF REAL;
  canelura_re,canelura_ri,canelura_bb,canelura_eps:extended;
  canelura_nr:integer;
  canelura_csi,canelura_eta:ARRAY [1..1000] OF REAL;

FUNCTION arcsin (x:REAL):REAL;

FUNCTION arccos (x:REAL):REAL;

implementation

uses _Profilator_, _Hexagonal_, _Canelura_, _About_, _Vizualizare_,
  _Vizualizare2_, _Vizualizare3_;

{$R *.DFM}

FUNCTION realtostring (x:EXTENDED):STRING;
    VAR
      t:^STRING;
      i:INTEGER;
      ex:^BOOLEAN;
    BEGIN
      NEW (t);
      NEW (ex);
      STR (x:0:20,t^);
      ex^:=FALSE;
      FOR i:=0 TO LENGTH (t^) DO
        BEGIN
          IF (t^ [i]='e') OR (t^ [i]='E')
            THEN
              ex^:=TRUE;
        END;
      IF NOT ex^
        THEN
          WHILE t^ [LENGTH (t^)]='0' DO
            DELETE (t^,LENGTH (t^),1);
      IF t^ [LENGTH (t^)]='.'
        THEN
          DELETE (t^,LENGTH (t^),1);
      realtostring:=t^;
      DISPOSE (t);
      DISPOSE (ex);
    END;

function stringtoreal(t:string):extended;
    var
      x:extended;
      c:integer;
    begin
      val(t,x,c);
      if t=''
        then
          stringtoreal:=0
        else
          if c=0
            then
              stringtoreal:=x
            else
              begin
                delete (t,c,length (t));
                stringtoreal:=stringtoreal (t);
              end;
    end;

  FUNCTION arcsin (x:REAL):REAL;
    BEGIN
      arcsin:=0;
      IF (x>-1) AND (x<1)
        THEN
          arcsin:=ARCTAN (x/SQRT (1-SQR (x)))
        ELSE
          Showmessage ('Eroare in calculul arcsin ('+realtostring (x)+')');
    END;

  FUNCTION arccos (x:REAL):REAL;
    BEGIN
      IF (x>-1) AND (x<1)
        THEN
          arccos:=PI+ARCTAN (SQRT (1-SQR (x))/x)
        ELSE
          arccos:=ARCTAN (SQRT (1-SQR (x))/x);
    END;

function cuvant (t:string;i,j:integer):string;
  begin
    if j>0
      then
        delete (t,succ (j),length (t));
    if i>2
      then
        delete (t,1,pred (i));
    cuvant:=t;
  end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.checked
  then
    begin
      if radiobutton3.checked
        then
          begin
            form1.enabled:=false;
            form2.show;
          end
        else
          form2.button1.click;      
    end
  else
    begin
      patrat_b:=false;
      series1.Clear;
      Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2.checked:=false;
    end;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  if checkbox2.checked
    then
      begin
        if radiobutton3.checked
        then
          begin
            form1.enabled:=false;
            form3.show;
          end
        else
          form3.button1.click;
      end
    else
      begin
        hexa_b:=false;
        series2.Clear;
        Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2.checked:=false;
      end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if checkbox3.checked
    then
      begin
        if radiobutton3.checked
          then
            begin
              form1.enabled:=false;
              form4.show;
            end
          else
            form4.button1.click;
      end
    else
      begin
        canelura_b:=false;
        series3.Clear;
        Profilulcutituluiroatapentrurealizareacaneluriiarborilor2.checked:=false;
      end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
if width<640 then width:=640;
if height<480 then height:=480; 
groupbox2.width:=width-207;
groupbox2.height:=height-63;
chart1.width:=width-223;
chart1.height:=height-87;
groupbox3.top:=height-290;
end;

procedure TForm1.Chart1Zoom(Sender: TObject);
begin
checkbox4.checked:=false;
checkbox4.enabled:=true;
Vederepanoramica1.checked:=checkbox4.checked;
Vederepanoramica1.enabled:=checkbox4.enabled;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
chart1.UndoZoom;
checkbox4.enabled:=false;
Vederepanoramica1.checked:=checkbox4.checked;
Vederepanoramica1.enabled:=checkbox4.enabled;
end;


procedure TForm1.RadioButton1Click(Sender: TObject);
begin
nescalate1.checked:=radiobutton1.checked;
scalate1.checked:=not nescalate1.checked;
if patrat_b
  then
    begin
      form1.series1.clear;
      form2.Button1Click (sender);
    end;
if hexa_b
  then
    begin
      form1.series2.clear;
      form3.Button1Click (sender);
    end;
if canelura_b
  then
    begin
      form1.series3.clear;
      form4.Button1Click (sender);
    end;
end;

procedure TForm1.Deschide1Click(Sender: TObject);
var f:textfile;
    t:string;
    i:integer;
begin
  if opendialog1.execute
    then
      begin
        assignfile (f,opendialog1.filename);
        reset (f);
        readln (f,t);//profilator
        if cuvant (t,1,12)='<profilator>'
          then
            begin
              readln (f,t);//patrata
              readln (f,t);//date
              readln (f,patrat_ro,patrat_nr);
              readln (f,t);//rezultate
              for i:=1 to patrat_nr do
                begin
                  {$R-}
                  readln (f,patrat_eta [i],patrat_csi [i]);
                  {$R+}
                  if ioresult<>0
                    then
                      begin
                        showmessage ('Eroare la citire!');
                        break;
                      end;
                end;
              readln (f,t);//hexagonala
              readln (f,t);//date
              readln (f,hexa_re,hexa_nr);
              readln (f,t);//rezultate
              for i:=1 to hexa_nr do
                begin
                  {$R-}
                  readln (f,hexa_eta [i],hexa_csi [i]);
                  {$R+}
                  if ioresult<>0
                    then
                      begin
                        showmessage ('Eroare la citire!');
                        break;
                      end;
                end;
              readln (f,t);//canelura
              readln (f,t);//date
              readln (f,canelura_re,canelura_ri,canelura_bb,canelura_nr,canelura_eps);
              readln (f,t);//rezultate
              for i:=1 to canelura_nr do
                begin
                  {$R-}
                  readln (f,canelura_eta [i],canelura_csi [i]);
                  {$R+}
                  if ioresult<>0
                    then
                      begin
                        showmessage ('Eroare la citire!');
                        break;
                      end;
                end;
              deschis_fisier:=true;  
            end
          else
            showmessage ('Formatul nu corespunde extensiei atasate!');
        closefile (f);
      end;
end;

procedure TForm1.Grafic1Click(Sender: TObject);
begin
  if savepicturedialog1.execute
    then
      chart1.SaveToBitmapFile (savepicturedialog1.filename+'.bmp');
end;

procedure TForm1.Date1Click(Sender: TObject);
var f:textfile;
    i:integer;
begin
  if savedialog1.execute
    then
      begin
        //showmessage ('Salvare date');
        assignfile (f,savedialog1.filename+'.txt');
        rewrite (f);
        writeln (f,'<profilator>');
        writeln (f,'<patrat>');
        writeln (f,'  <date>');
        writeln (f,'    ',patrat_ro:0:10,' ',patrat_nr:0);
        writeln (f,'  <rezultate>');
        for i:=1 to patrat_nr do
          writeln (f,'    ',patrat_eta [i]:0:10,' ',patrat_csi [i]:0:10);
        writeln (f,'<hexagonal>');
        writeln (f,'  <date>');
        writeln (f,'    ',hexa_re:0:10,' ',hexa_nr:0);
        writeln (f,'  <rezultate>');
        for i:=1 to hexa_nr do
          writeln (f,'    ',hexa_eta [i]:0:10,' ',hexa_csi [i]:0:10);
        writeln (f,'<canelat>');
        writeln (f,'  <date>');
        writeln (f,'    ',canelura_re:0:10,' ',canelura_ri:0:10,' ',canelura_bb:0:10,' ',canelura_nr:0,' ',canelura_eps:0:10);
        writeln (f,'  <rezultate>');
        for i:=1 to canelura_nr do
          writeln (f,'    ',canelura_eta [i]:0:10,' ',canelura_csi [i]:0:10);
        closefile (f);
      end;
end;

procedure TForm1.Iesire1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.Despre1Click(Sender: TObject);
begin
form1.enabled:=false;
form5.show;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if MessageDlg('Confirmi parasirea programului?',mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TForm2, Form2);
    Application.Run;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//form2.button1.click;
//form3.button1.click;
//form4.button1.click;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
checkbox1.checked:=not checkbox1.checked;
CheckBox1Click (sender);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
checkbox2.checked:=not checkbox2.checked;
CheckBox2Click (sender);
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
checkbox3.checked:=not checkbox3.checked;
CheckBox3Click (sender);
end;

procedure TForm1.Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata1Click(
  Sender: TObject);
begin
form1.enabled:=false;
form6.show;
end;

procedure TForm1.Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala1Click(
  Sender: TObject);
begin
form1.enabled:=false;
form7.show;
end;

procedure TForm1.Profilulcutituluiroatapentrurealizareacaneluriiarborilor1Click(
  Sender: TObject);
begin
form1.enabled:=false;
form8.show;
end;

procedure TForm1.Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2Click(
  Sender: TObject);
begin
Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2.checked:=not Profiluldinteluicremalierapentrurealizareaarborilorcusectiunepatrata2.checked;
checkbox1.checked:=not checkbox1.checked; 
end;

procedure TForm1.Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2Click(
  Sender: TObject);
begin
Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2.checked:=not Profiluldinteluicremaliereipentrurealizareaarborilorcusectiunehexagonala2.checked; 
checkbox2.checked:=not checkbox2.checked;
end;

procedure TForm1.Profilulcutituluiroatapentrurealizareacaneluriiarborilor2Click(
  Sender: TObject);
begin
Profilulcutituluiroatapentrurealizareacaneluriiarborilor2.checked:=not Profilulcutituluiroatapentrurealizareacaneluriiarborilor2.checked; 
checkbox3.checked:=not checkbox3.checked;
end;

procedure TForm1.Vederepanoramica1Click(Sender: TObject);
begin
chart1.UndoZoom;
checkbox4.enabled:=false;
Vederepanoramica1.checked:=checkbox4.checked;
Vederepanoramica1.enabled:=checkbox4.enabled;
end;

procedure TForm1.Nescalate1Click(Sender: TObject);
begin
nescalate1.checked:=not nescalate1.checked;
scalate1.checked:=not nescalate1.checked;
radiobutton1.checked:=nescalate1.checked;
radiobutton2.checked:=scalate1.checked;
end;

procedure TForm1.Promptdate1Click(Sender: TObject);
begin
promptdate1.checked:=not promptdate1.checked;
valoriintroduse1.checked:=not promptdate1.checked;
radiobutton3.checked:=promptdate1.checked;
radiobutton4.checked:=valoriintroduse1.checked;
end;

procedure TForm1.RadioButton3Click(Sender: TObject);
begin
promptdate1.checked:=radiobutton3.checked;
valoriintroduse1.checked:=not promptdate1.checked;
end;

end.
