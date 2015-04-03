program Demos;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Units\Main.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
