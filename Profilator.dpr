program Profilator;

uses
  Forms,
  _Patrat_ in '_Patrat_.pas' {Form1},
  _Profilator_ in '_Profilator_.pas' {Form2},
  _Hexagonal_ in '_Hexagonal_.pas' {Form3},
  _Canelura_ in '_Canelura_.pas' {Form4},
  _About_ in '_About_.pas' {Form5},
  _Vizualizare_ in '_Vizualizare_.pas' {Form6},
  _Vizualizare2_ in '_Vizualizare2_.pas' {Form7},
  _Vizualizare3_ in '_Vizualizare3_.pas' {Form8};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
