program IDICT;

uses
  Forms,Windows,Messages,
  UIDICT in 'Unit\UIDICT.pas' {FIDICT},
  UApdate in 'Unit\UApdate.pas' {FApdate},
  UQuiz in 'Unit\UQuiz.pas' {FQuiz},
  USetting in 'Unit\USetting.pas' {FSetting},
  UAbout in 'Unit\UAbout.pas' {FAbout};

{$R *.res}
var mutex:THandle;
begin
  mutex:=CreateMutex(nil,True,'My_Unique_Application_Mutex_Namae');
  if (mutex=0) or (GetLastError=ERROR_ALREADY_EXISTS) then
  begin
  Application.Terminate;
  end
  else
begin
  Application.Initialize;
  Application.Title := 'IDICT';
  Application.CreateForm(TFIDICT, FIDICT);
  Application.Run;
end;
end.
