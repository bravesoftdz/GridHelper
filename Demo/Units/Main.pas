unit Main;
{- Unit Info -------------------------------------------------------------------
 Unit Name : Main
 Created By: Barış Atalay, 03/04/2015,14:00
 Changed By:

 -------------------------------------------------------------------------------}
interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid, FMX.StdCtrls, FMX.Layouts, GridHelperLib;

type
  TForm8 = class(TForm)
    GridHelper1: TGridHelper;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    CheckColumn1: TCheckColumn;
    GridPanelLayout1: TGridPanelLayout;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GridHelper1DrawColumnCell(Sender: TObject; const Canvas: TCanvas;
      const Column: TColumn; const Bounds: TRectF; const Row: Integer;
      const Value: TValue; const State: TGridDrawStates);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.fmx}

procedure TForm8.Button1Click(Sender: TObject);
var I: Integer;
begin
  GridHelper1.ClearItems;
  for I := 0 to 5 do
  begin
    GridHelper1.IncRow;
    GridHelper1.Cell[I, 0]:= 'sayi ' + I.ToString;
    GridHelper1.Cell[I, 1]:= 'sayi ' + I.ToString;
    GridHelper1.Cell[I, 2]:= 'sayi ' + I.ToString;
    GridHelper1.Cell[I, 3]:= 'sayi ' + I.ToString;
    GridHelper1.Cell[I, 4]:= 'sayi ' + I.ToString;
    GridHelper1.Cell[I, 5]:= 'Y';
  end;
end;

procedure TForm8.Button2Click(Sender: TObject);
var I: Integer;
begin
  GridHelper1.ClearItems;
  for I := 0 to 5 do
  begin
    GridHelper1.IncRow;
    GridHelper1.AddValue[0]:= 'sayi ' + I.ToString;
    GridHelper1.AddValue[1]:= 'sayi ' + I.ToString;
    GridHelper1.AddValue[2]:= 'sayi ' + I.ToString;
    GridHelper1.AddValue[3]:= 'sayi ' + I.ToString;
    GridHelper1.AddValue[4]:= 'sayi ' + I.ToString;
    GridHelper1.AddValue[5]:= 'Y';
  end;
end;

procedure TForm8.GridHelper1DrawColumnCell(Sender: TObject;
  const Canvas: TCanvas; const Column: TColumn; const Bounds: TRectF;
  const Row: Integer; const Value: TValue; const State: TGridDrawStates);
var
  T, T2: TRectF;
begin
  if Row mod 2 = 1 then
  begin
    with Canvas do
    begin
      Fill.Kind := TBrushKind.Solid;
      Fill.Color := $FFF5802D;
    end;

    T := Bounds;

    if (Column is TCheckColumn) then
      T.Right := Self.Width;

    Canvas.FillRect(T, 0, 0, [], 0.5);
  end;

  if (Column is TCheckColumn) then
  begin
    T2 := Bounds;
    T2.Left := T2.Left + 17;
    Canvas.Fill.Color := TAlphaColorRec.Black;
    Canvas.FillText(T2, Value.ToString, True, 1,[], TTextAlign.Leading );
  end;
end;

end.
