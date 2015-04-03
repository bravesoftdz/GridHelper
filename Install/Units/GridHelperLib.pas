unit GridHelperLib;
{- Unit Info -------------------------------------------------------------------
 Unit Name : GridHelperLib
 Created By: Barış Atalay, 03/04/2015,14:00
 Changed By:

 -------------------------------------------------------------------------------}

interface


Uses
  System.Classes, System.Rtti, System.SysUtils,
  FMX.Dialogs, FMX.Grid, FMX.TextLayout;

Type
  TArrayColumn= Array of String;

  TGridHelper = class(TGrid)
  private
    FRows: Array of TArrayColumn;
    FRecNo: Integer;
    function iif(B: Boolean; T,F: Variant): Variant;
    function GetCell(const Row, Col: Integer): String;
    procedure SetCell(const Row, Col: Integer; const Value: String);
    procedure SelfGetValue(Sender: TObject; const Col, Row: Integer; var Value: TValue);
    procedure SelfSetValue(Sender: TObject; const Col, Row: Integer; const Value: TValue);
    function GetAdd(const Col: Integer): String;
    procedure SetAdd(const Col: Integer; const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RecNo: Integer;
    procedure IncRow(Value: Integer = 1);
    property Cell[const Row, Col: Integer]: String read GetCell write SetCell; default;
    property AddValue[const Col:Integer]: String read GetAdd write SetAdd;
    procedure ClearItems;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Android', [TGridHelper]);
end;

{ TGridHelper }

procedure TGridHelper.ClearItems;
begin
  if RowCount = 0 then Exit;

  RowCount := 0;
  FRecNo := RowCount;
  SetLength(FRows, 0);
end;

constructor TGridHelper.Create(AOwner: TComponent);
begin
  inherited;
  RowCount := 0;
  FRecNo := RowCount;
  inherited OnGetValue := SelfGetValue;
  inherited OnSetValue := SelfSetValue;
end;

destructor TGridHelper.Destroy;
begin
  inherited;
end;

function TGridHelper.GetAdd(const Col: Integer): String;
begin

end;

function TGridHelper.GetCell(const Row, Col: Integer): String;
begin
  Result := FRows[Row][Col];
end;

function TGridHelper.iif(B: Boolean; T, F: Variant): Variant;
begin
  if B then
    Result := T
  else
    Result := F;
end;

procedure TGridHelper.IncRow(Value: Integer);
begin
  RowCount := RowCount + Value;
  SetLength(FRows, RowCount);
  SetLength(FRows[RowCount - 1], ColumnCount);
  FRecNo := RowCount;
end;

function TGridHelper.RecNo: Integer;
begin
  Result := FRecNo;
end;

procedure TGridHelper.SelfGetValue(Sender: TObject; const Col, Row: Integer;
  var Value: TValue);
begin
  if (Row <= RowCount) and (Col < ColumnCount) then
  begin
    Value := TValue.FromVariant(
                                 iif((Cell[Row, Col] = 'N'),
                                     False,
                                     iif(Cell[Row, Col] = 'Y', True, Cell[Row, Col])
                                    )
                               );
  end;
end;

procedure TGridHelper.SelfSetValue(Sender: TObject; const Col, Row: Integer;
  const Value: TValue);
begin
  if (Row <= RowCount) and (Col < ColumnCount) then
  begin
    Cell[Row, Col] := iif(UpperCase(Value.ToString) = 'TRUE', 'Y', iif(UpperCase(Value.ToString) = 'FALSE', 'N', Value.ToString));
  end;
end;

procedure TGridHelper.SetAdd(const Col: Integer; const Value: String);
begin
  SetCell(FRecNo - 1, Col, Value);
end;

procedure TGridHelper.SetCell(const Row, Col: Integer; const Value: String);
begin
  try
    if Length(FRows[Row]) = 0 then
      SetLength(FRows[Row], ColumnCount);

    FRows[Row][Col]:= Value;
  except
    ShowMessage('This cell not found!');
  end;
end;

end.
