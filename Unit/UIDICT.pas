unit UIDICT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, XPMan, DB, ADODB, Menus,
  ComCtrls, ToolWin, Buttons, DBCtrls,INIFiles, acPNG,
  CoolTrayIcon;

type
  TFIDICT = class(TForm)
    Conn: TADOConnection;
    Q: TADOQuery;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Ds: TDataSource;
    Panel1: TPanel;
    t_cari: TEdit;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    Gyellow: TImage;
    GBlue: TImage;
    GButton: TImage;
    Baru1: TMenuItem;
    Edit1: TMenuItem;
    Hapus1: TMenuItem;
    N1: TMenuItem;
    Keluar1: TMenuItem;
    Setting1: TMenuItem;
    View1: TMenuItem;
    f_KamusIT: TMenuItem;
    PopupMenu1: TPopupMenu;
    SHow1: TMenuItem;
    Show2: TMenuItem;
    HideNavigasi1: TMenuItem;
    Navigasi1: TMenuItem;
    Pencarian1: TMenuItem;
    AkeZZtoA1: TMenuItem;
    N3: TMenuItem;
    QuizIT1: TMenuItem;
    GC: TImage;
    N2: TMenuItem;
    About1: TMenuItem;
    QuizIT2: TMenuItem;
    StayOnTop2: TMenuItem;
    N4: TMenuItem;
    StayOnTop1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Copy1: TMenuItem;
    SelectAll1: TMenuItem;
    N5: TMenuItem;
    tray: TCoolTrayIcon;
    Label6: TLabel;
    Panel2: TPanel;
    l_istilah: TDBGrid;
    t_deskripsi: TRichEdit;
    split: TSplitter;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    nav: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure t_cariChange(Sender: TObject);
    procedure Baru1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Keluar1Click(Sender: TObject);
    procedure Hapus1Click(Sender: TObject);
    procedure Show2Click(Sender: TObject);
    procedure SHow1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure l_istilahDblClick(Sender: TObject);
    procedure navClick(Sender: TObject; Button: TNavigateBtn);
    procedure View1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Navigasi1Click(Sender: TObject);
    procedure Pencarian1Click(Sender: TObject);
    procedure AkeZZtoA1Click(Sender: TObject);
    procedure GCClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure QuizIT2Click(Sender: TObject);
    procedure StayOnTop1Click(Sender: TObject);
    procedure StayOnTop2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure l_istilahCellClick(Column: TColumn);
    procedure DsDataChange(Sender: TObject; Field: TField);
    procedure Copy1Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure t_deskripsiMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    procedure refresh_data();
    procedure tampil_data();
    procedure simpan_setting();
  public
    { Public declarations }
  end;

var
  FIDICT: TFIDICT;

implementation

uses Math, UApdate,UQuiz, UAbout, USetting;

{$R *.dfm}


procedure TFIDICT.simpan_setting;
var buatINI:TIniFile;
begin
  Conn.Connected:=false;
  buatINI:=TiniFile.Create(GetCurrentDir + '\setting.ini');
  SetFileAttributes(pchar('setting.ini'),FILE_ATTRIBUTE_HIDDEN);
  try
    if WindowState=wsNormal then
      begin
        buatINI.WriteInteger('Form','top',Top);
        buatINI.WriteInteger('Form','left',Left);
        buatINI.WriteInteger('Form','width',Width);
        buatINI.WriteInteger('Form','height',height);
      end;
      buatINI.WriteBool('Form','state',WindowState=wsMaximized);
    
    if Navigasi1.Checked=true then buatINI.WriteInteger('view','data1',1) else buatINI.WriteInteger('view','data1',0);
    if Pencarian1.Checked=true then buatINI.WriteInteger('view','data2',1) else buatINI.WriteInteger('view','data2',0);
    if AkeZZtoA1.Checked=true then buatINI.WriteInteger('view','data3',1) else buatINI.WriteInteger('view','data3',0);
    if N3.Checked=true then buatINI.WriteInteger('view','data4',1) else buatINI.WriteInteger('view','data4',0);
    if StayOnTop1.Checked=true then buatINI.WriteInteger('view','data5',1) else buatINI.WriteInteger('view','data5',0);
  Finally
    buatINI.Free;
 end;
  Application.Terminate;
end;
procedure TFIDICT.refresh_data();
begin
  q.Active:=False;
  q.SQL.Clear;
  q.SQL.Add('Select * from informatika order by istilah');
  q.Open;
  q.Active:=true;
end;
procedure TFIDICT.tampil_data();
begin
  If not q.IsEmpty then
    if not Q.Eof then
    begin
      Edit1.Enabled:=true;
      Hapus1.Enabled:=true;

      Q.ActivE:=True;
      t_deskripsi.Text:=#13+#13
                      +Q.FieldValues['Istilah']+#13+#13
                      +'    Adalah '
                      +Q.FieldValues['Arti']+#13+#13+#13
                      +'Penjelasan : '+#13+'  '+
                      +Q.FieldValues['Deskripsi']+#13+#13+#13;
                      l_istilah.Hint:=Q.FieldValues['Istilah'];
      end;
  if q.IsEmpty then
    begin
      Edit1.Enabled:=false;
      Hapus1.Enabled:=false;
    end;
end;
procedure TFIDICT.FormCreate(Sender: TObject);
var buatINI:TIniFile;
    fs,fn,fc,st:String;
    c1,c2,c3:string;
    vw:Boolean;
begin
 if not FileExists('DBIDICT.db') then
    begin
      MessageDlg('Database IDICT (DBIDICT.db) tidak ada' ,mtError,[mbOK],0);
      Application.Terminate;
    end;
  
    Conn.Connected:=true;
    SetFileAttributes(pchar('DBIDICT.ldb'),FILE_ATTRIBUTE_HIDDEN);
    t_deskripsi.Clear;
    refresh_data;
    tampil_data;

    GButton.Picture:=GBlue.Picture;
    buatINI:=TiniFile.Create(GetCurrentDir + '\setting.ini');
  
    try
      if not FileExists('setting.ini') then
        begin
          buatINI.WriteInteger('setting','fontsize',8);
        end;

      fn:=buatINI.ReadString('setting','fontname',fn);
      fs:=buatINI.ReadString('setting','fontsize',fs);
      fc:=buatINI.ReadString('setting','fontcolor',fc);
      st:=buatINI.ReadString('setting','fontstyle',st);
      c1:=buatINI.ReadString('setting','bgtextcolor',c1);
      c2:=buatINI.ReadString('setting','bgsidecolor',c2);
      c3:=buatINI.ReadString('setting','bgquizcolor',c3);

      t_deskripsi.Font.Name:=fn;
      t_deskripsi.Font.Size:=StrToInt(fs);
      l_istilah.Font.Name:=fn;
      l_istilah.Font.Size:=StrToInt(fs);

    if fc='Black'then l_istilah.Font.Color:=clBlack;
    if fc='Red'then l_istilah.Font.Color:=clRed;
    if fc='Yellow'then l_istilah.Font.Color:=clYellow;
    if fc='Sky Blue'then l_istilah.Font.Color:=clSkyBlue;
    if fc='Green'then l_istilah.Font.Color:=clGreen;
    if fc='White'then l_istilah.Font.Color:=clWhite;

    if c1='Black' then t_deskripsi.Color:=clBlack;
    if c1='Silver' then t_deskripsi.Color:=clSilver;
    if c1='Yellow' then t_deskripsi.Color:=clYellow;
    if c1='Sky Blue' then t_deskripsi.Color:=clSkyBlue;
    if c1='MoneyGreen' then t_deskripsi.Color:=clMoneyGreen;
    if c1='White' then t_deskripsi.Color:=clWhite;

    if c2='Black' then l_istilah.Color:=clBlack;
    if c2='Silver' then l_istilah.Color:=clSilver;
    if c2='Yellow' then l_istilah.Color:=clYellow;
    if c2='Sky Blue' then l_istilah.Color:=clSkyBlue;
    if c2='MoneyGreen' then l_istilah.Color:=clMoneyGreen;
    if c2='White' then l_istilah.Color:=clWhite;

    if c3='Sky Blue' then Color:=clSkyBlue;
    if c3='Silver' then Color:=clSilver;
    if c3='Yellow' then Color:=clYellow;
    if c3='Blue' then Color:=clBlue;
    if c3='MoneyGreen' then Color:=clMoneyGreen;
    if c3='White' then Color:=clWhite;
    t_deskripsi.Font.Color:=l_istilah.Font.Color;

    if st= 'Bold' then t_deskripsi.Font.Style:=[fsBold];
    if st= 'Italic' then t_deskripsi.Font.Style:=[fsItalic];
    if st= 'Bold Italic' then t_deskripsi.Font.Style:=[fsBold,fsItalic];
    l_istilah.Font.Style:=t_deskripsi.Font.Style;

    vw:=true;
    Navigasi1.Checked:=buatINI.ReadBool('view','data1',vw);
    Pencarian1.Checked:=buatINI.ReadBool('view','data2',vw);
    AkeZZtoA1.Checked:=buatINI.ReadBool('view','data3',vw);
    N3.Checked:=buatINI.ReadBool('view','data4',vw);
    StayOnTop1.Checked:=buatINI.ReadBool('view','data5',vw);

    if StayOnTop1.Checked=false then
      Begin
        StayOnTop2.Checked:=False ;
        SetWindowPos (Handle,HWND_NOTOPMOST,0,0,0,0,
        SWP_NOACTIVATE OR SWP_NOSIZE  OR SWP_NOMOVE);
      end
    else
      begin
        StayOnTop2.Checked:=True;
        SetWindowPos (Handle,HWND_TOPMOST,0,0,0,0,
        SWP_NOACTIVATE OR SWP_NOSIZE  OR SWP_NOMOVE);
      end;

  if Navigasi1.Checked=true then
    begin
      nav.Visible:=true;BitBtn1.Visible:=True;BitBtn2.Visible:=True;
    end
  else
    begin
      nav.Visible:=false;BitBtn1.Visible:=false;BitBtn2.Visible:=false;
    end;

  if Pencarian1.Checked=false then t_cari.Visible:=false else t_cari.Visible:=true;

  if AkeZZtoA1.Checked=false then
    begin
      RadioButton1.Visible:=false;
      RadioButton2.Visible:=false;
    end
  else
    begin
      RadioButton1.Visible:=true;
      RadioButton2.Visible:=true;
    end;
    
    Top:=buatINI.ReadInteger('Form','top',Top);
    Left:=buatINI.ReadInteger('Form','left',Left);
    Width:=buatINI.ReadInteger('Form','width',Height);
    Height:=buatINI.ReadInteger('Form','height',Height);
    if buatINI.ReadBool( 'Form', 'state', false ) then
        WindowState := wsMaximized
    else
        WindowState := wsNormal;
    if N3.Checked=false then
      begin
        l_istilah.Hide;
        split.Hide;
      end;
      
    finally
      buatINI.Free
  end;
end;

procedure TFIDICT.RadioButton1Click(Sender: TObject);
begin
  refresh_data;
end;

procedure TFIDICT.RadioButton2Click(Sender: TObject);
begin
  q.SQL.Clear;
  q.SQL.Add('Select * from informatika order by istilah desc');
  q.Open;
end;

procedure TFIDICT.t_cariChange(Sender: TObject);
var s,k,l,k2:string;
begin
  k:=copy(t_cari.Text,1,3);
  l:= copy(t_cari.Text,4,MaxLongint);
  k2:=copy(t_cari.Text,1,2);


  if k2='s/' then s:='Select * from informatika where istilah like "'+copy(t_cari.Text,3,MaxLongint)+'"'
  else if k='sd/' then s:='Select * from informatika where istilah like "'+l+'%"'
  else if k='pj/' then s:='Select * from informatika where deskripsi like "%'+l+'%"'
  else if k='ar/' then s:='Select * from informatika where arti like "%'+l+'%"'
  else s:='Select * from informatika where istilah like "%'+t_cari.Text+'%"';

  
  t_deskripsi.Clear;
  q.SQL.Clear;
  q.SQL.Add(s);
  q.Open;
end;

procedure TFIDICT.Baru1Click(Sender: TObject);
begin
  Application.CreateForm(TFApdate,FApdate);
  FApdate.Width:=FIDICT.Width;
  FApdate.Height:=FIDICT.Height;
  FApdate.Left:=FIDICT.Left;
  FApdate.Top:=FIDICT.Top;
  FApdate.BitBtn1.Caption:='Simpan';
  FApdate.ShowModal;
end;

procedure TFIDICT.Edit1Click(Sender: TObject);
begin
  Application.CreateForm(TFApdate,FApdate);
  FApdate.Width:=FIDICT.Width;
  FApdate.Height:=FIDICT.Height;
  FApdate.Left:=FIDICT.Left;
  FApdate.Top:=FIDICT.Top;
  FApdate.BitBtn1.Caption:='Update';
  FApdate.tampil_data;
  FApdate.t_ist.Enabled:=False;
  FApdate.ShowModal;
end;

procedure TFIDICT.Keluar1Click(Sender: TObject);
begin
  simpan_setting;
   SetFileAttributes(pchar('setting.ini'),FILE_ATTRIBUTE_READONLY+FILE_ATTRIBUTE_HIDDEN);
  Application.Terminate;
end;

procedure TFIDICT.Hapus1Click(Sender: TObject);
begin
  if not Q.IsEmpty then
    if MessageDlg('Kamu yakin hapus '+Q.FieldValues['istilah']+' ?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    Q.Delete;
end;

procedure TFIDICT.Show2Click(Sender: TObject);
begin
  tray.IconVisible:=false;
  Show;

end;

procedure TFIDICT.SHow1Click(Sender: TObject);
begin
Keluar1Click(self);
end;

procedure TFIDICT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Hide;
  Action:=caNone;
  tray.IconVisible:=true;
  tray.Hint:='IDICT'+#13+'Informatic Dictionary'+#13+'(C) YANWARS';
  tray.ShowBalloonHint('Information',
        'IDICT is minimize to system tray' + #13 +
        'Right click this icon for show IDICT',
        bitInfo, 10);
end;

procedure TFIDICT.l_istilahDblClick(Sender: TObject);
begin
  if not Q.IsEmpty then
  begin
  Application.CreateForm(TFApdate,FApdate);
  FApdate.Width:=FIDICT.Width;
  FApdate.Height:=FIDICT.Height;
  FApdate.Left:=FIDICT.Left;
  FApdate.Top:=FIDICT.Top;
  FApdate.BitBtn1.Caption:='Update';
  FApdate.tampil_data;
  FApdate.t_ist.Enabled:=False;
  FApdate.ShowModal;
end;
end;

procedure TFIDICT.navClick(Sender: TObject; Button: TNavigateBtn);
begin
      t_deskripsi.Text:=#13+#13
                      +Q.FieldValues['Istilah']+#13+#13
                      +'    Adalah '
                      +Q.FieldValues['Arti']+#13+#13+#13
                      +'Penjelasan : '+#13+'  '+
                      +Q.FieldValues['Deskripsi']+#13+#13+#13;
end;

procedure TFIDICT.View1Click(Sender: TObject);
begin
  Application.CreateForm(TfSetting,fSetting);
  fSetting.ShowModal;
end;

procedure TFIDICT.BitBtn2Click(Sender: TObject);
begin
  t_deskripsi.Font.Size:=t_deskripsi.Font.Size+1;
end;

procedure TFIDICT.BitBtn1Click(Sender: TObject);
begin
  t_deskripsi.Font.Size:=t_deskripsi.Font.Size-1;
end;

procedure TFIDICT.Navigasi1Click(Sender: TObject);
begin
  if Navigasi1.Checked=true then
    begin
      Navigasi1.Checked:=false;
      nav.Visible:=false;
      BitBtn1.Visible:=false;
      BitBtn2.Visible:=false;
    end
  else
    begin
      Navigasi1.Checked:=true ;
      nav.Visible:=true;
      BitBtn1.Visible:=true;
      BitBtn2.Visible:=true;
    end;
end;

procedure TFIDICT.Pencarian1Click(Sender: TObject);
begin
  if Pencarian1.Checked=true then
    begin
      Pencarian1.Checked:=false;
      t_cari.Visible:=false;
    end
  else
    begin
      Pencarian1.Checked:=true ;
      t_cari.Visible:=true;
    end;
end;

procedure TFIDICT.AkeZZtoA1Click(Sender: TObject);
begin
  if AkeZZtoA1.Checked=true then
    begin
      AkeZZtoA1.Checked:=false;
      RadioButton1.Visible:=false;
      RadioButton2.Visible:=false;
    end
  else
    begin
      AkeZZtoA1.Checked:=true;
      RadioButton1.Visible:=true;
      RadioButton2.Visible:=true;
      
    end;
end;

procedure TFIDICT.GCClick(Sender: TObject);
begin
  if (t_cari.Text='') and (t_cari.Visible=true) then
  begin
  t_cari.hide;
  Pencarian1.Checked:=false;
  end
  else
  begin
    Pencarian1.Checked:=true;
    t_cari.show;
    t_cari.Clear;
    t_cari.SetFocus;
    end;
end;

procedure TFIDICT.About1Click(Sender: TObject);
begin
  Application.CreateForm(TFAbout,FAbout);
  FAbout.ShowModal;
end;

procedure TFIDICT.QuizIT2Click(Sender: TObject);
begin
  Application.CreateForm(TFQuiz,FQuiz);
  FQuiz.Width:=FIDICT.Width;
  FQuiz.Height:=FIDICT.Height;
  FQuiz.Left:=FIDICT.Left;
  FQuiz.Top:=FIDICT.Top;
  FQuiz.Show;
  Hide;
end;

procedure TFIDICT.StayOnTop1Click(Sender: TObject);
begin
if StayOnTop1.Checked=true then
    begin
      StayOnTop1.Checked:=false;
      StayOnTop2.Checked:=false;
      SetWindowPos (Handle,HWND_NOTOPMOST,0,0,0,0,
      SWP_NOACTIVATE OR SWP_NOSIZE  OR SWP_NOMOVE);
    end
  else
    begin
      StayOnTop1.Checked:=true ;
      StayOnTop2.Checked:=true;
      SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,
      SWP_NOACTIVATE OR SWP_NOSIZE  OR SWP_NOMOVE);
    end;
end;

procedure TFIDICT.StayOnTop2Click(Sender: TObject);
begin
  StayOnTop1Click(self);
end;

procedure TFIDICT.N3Click(Sender: TObject);
begin
  if N3.Checked=true then
    begin
      N3.Checked:=false;
      l_istilah.Hide;
      split.Hide;
    end
  else
    begin
      N3.Checked:=true;
      l_istilah.Show;
      split.Show;
    end;
end;

procedure TFIDICT.l_istilahCellClick(Column: TColumn);
begin
tampil_data;
end;

procedure TFIDICT.DsDataChange(Sender: TObject; Field: TField);
begin
tampil_data;
end;

procedure TFIDICT.Copy1Click(Sender: TObject);
begin
if t_deskripsi.SelText<>'' then
t_deskripsi.CopyToClipboard;
end;

procedure TFIDICT.SelectAll1Click(Sender: TObject);
begin
t_deskripsi.SelectAll;
end;

procedure TFIDICT.t_deskripsiMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if t_deskripsi.SelText=''then
  Copy1.Enabled:=false
else
   Copy1.Enabled:=true;
end;

procedure TFIDICT.FormActivate(Sender: TObject);
begin
SetFileAttributes(pchar('setting.ini'),FILE_ATTRIBUTE_HIDDEN);

end;

end.
