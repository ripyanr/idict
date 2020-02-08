unit UQuiz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls, ComCtrls, acPNG;

type
  TFQuiz = class(TForm)
    Qtest: TADOQuery;
    GTop: TImage;
    Edit1: TEdit;
    Button2: TButton;
    GroupBox1: TGroupBox;
    L1: TLabel;
    L2: TLabel;
    L3: TLabel;
    L4: TLabel;
    Label1: TLabel;
    L5: TLabel;
    status: TLabel;
    T_SOAL: TRichEdit;
    A: TRadioButton;
    B: TRadioButton;
    C: TRadioButton;
    D: TRadioButton;
    E: TRadioButton;
    Panel1: TPanel;
    Shape1: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    Q_salah: TADOQuery;
    Qacak: TADOQuery;
    Label2: TLabel;
    Image4: TImage;
    Image5: TImage;
    jbsalah: TLabel;
    Label4: TLabel;
    jbbenar: TLabel;
    Label5: TLabel;
    nilai: TLabel;
    Label3: TLabel;
    GButton: TImage;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AClick(Sender: TObject);
    procedure BClick(Sender: TObject);
    procedure CClick(Sender: TObject);
    procedure DClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EClick(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure L2Click(Sender: TObject);
    procedure L3Click(Sender: TObject);
    procedure L4Click(Sender: TObject);
    procedure L5Click(Sender: TObject);
    procedure Ca(Sender: TObject);
  private
    { Private declarations }
    procedure acak_soal();
    procedure isi_aktif();
    procedure isi_nonaktif();
    procedure itung_benar();
    procedure itung_salah();
    procedure level();
  
  public
    { Public declarations }
  end;

var
  FQuiz: TFQuiz;
  bnr,jbnr,slh,jslh:integer;
  skr:integer;
implementation
 uses UIDICT, Math,Uabout;
{$R *.dfm}
procedure TFQuiz.level();
begin
if StrToInt(nilai.Caption) <-100 then status.Caption:=Edit1.Text+' Sangat Bodoh sekali'
  else if (StrToInt(nilai.Caption) <(-50))and (jbbenar.Caption='0')then status.Caption:=Edit1.Text+' Bodoh sekali'
  else if StrToInt(nilai.Caption) <(-20) then status.Caption:=Edit1.Text+' Bodoh'
  else if StrToInt(nilai.Caption) = 0 then status.Caption:=Edit1.Text+' Pemula'
  else if StrToInt(nilai.Caption) >=50 then status.Caption:=Edit1.Text+' Standar'
  else if StrToInt(nilai.Caption) >=100 then status.Caption:=Edit1.Text+' Pintar'
  else if (StrToInt(nilai.Caption) >=100) and (jbsalah.Caption='0') then status.Caption:=Edit1.Text+' Ahli'
  else if StrToInt(nilai.Caption) >=1000 then status.Caption:=Edit1.Text+' Genius'
end;
procedure TFQuiz.itung_benar();

begin
  bnr:=10;
  skr:=StrToInt(nilai.Caption);
  skr:=skr+bnr;
  jbnr:=StrToInt(jbbenar.Caption);
  jbnr:=jbnr+1;
  Panel1.Visible:=true;
  Shape1.Brush.Color:=clGreen;
  label7.Caption:='BENAR !';
  label8.Caption:='Poin bertambah 10+ !!!';
   

end;
procedure TFQuiz.itung_salah();
begin
  slh:=10;
  skr:=StrToInt(nilai.Caption);
  skr:=skr-slh;
  jslh:=StrToInt(jbsalah.Caption);
  jslh:=jslh+1;
  Panel1.Visible:=true;
  Shape1.Brush.Color:=clRed;
  label7.Caption:='SALAH !';
  label8.Caption:='Poin dikurangi -10 !!!';
  
end;
procedure TFQuiz.isi_aktif();
begin
  A.Enabled:=true;
  B.Enabled:=true;
  C.Enabled:=true;
  D.Enabled:=true;
  E.Enabled:=true;

  A.Checked:=false;
  B.Checked:=false;
  C.Checked:=false;
  D.Checked:=false;
  E.Checked:=false;

  l1.Font.Color:=clBlack;
  l2.Font.Color:=clBlack;
  l3.Font.Color:=clBlack;
  l4.Font.Color:=clBlack;
  l5.Font.Color:=clBlack;

end;
procedure TFQuiz.isi_Nonaktif();
begin
  A.Enabled:=false;
  B.Enabled:=false;
  C.Enabled:=false;
  D.Enabled:=false;
  E.Enabled:=false;
end;

procedure TFQuiz.acak_soal();
Var ja,jb,jc,jd,je:string;
begin
  level;
  Qtest.SQL.Clear;
  Qtest.SQL.Add('Select * from informatika');
  Qtest.Open;

  Randomize;
  Qtest.First;
  Qtest.MoveBy(Random(Qtest.RecordCount));
  T_SOAL.Text:='Soal :'+#13+Qtest.FieldValues['arti']+' adalah ?';
  JA:=Qtest.FieldValues['ISTILAH'];

  Q_salah.SQL.Clear;
  Q_salah.SQL.Add('Select * from informatika Where istilah<>"'+JA+'"');
  Q_salah.Open;

  Randomize;
  Q_salah.First;
  Q_salah.MoveBy(Random(Q_salah.RecordCount));
  JB:=Q_salah.FieldValues['ISTILAH'];

  Q_salah.SQL.Clear;
  Q_salah.SQL.Add('Select * from informatika Where istilah<>"'+JA+'" and istilah<>"'+JB+'"');
  Q_salah.Open;

  Randomize;
  Q_salah.First;
  Q_salah.MoveBy(Random(Q_salah.RecordCount));
  JC:=Q_salah.FieldValues['ISTILAH'];

  Q_salah.SQL.Clear;
  Q_salah.SQL.Add('Select * from informatika Where istilah<>"'+JA+'" and istilah<>"'+JB+'" and istilah<>"'+JC+'" ');
  Q_salah.Open;

  Randomize;
  Q_salah.First;
  Q_salah.MoveBy(Random(Q_salah.RecordCount));
  JD:=Q_salah.FieldValues['ISTILAH'];

  Q_salah.SQL.Clear;
  Q_salah.SQL.Add('Select * from informatika Where istilah<>"'+JA+'" and istilah<>"'+JB+'" and istilah<>"'+JC+'" and istilah<>"'+JD+'"');
  Q_salah.Open;

  Randomize;
  Q_salah.First;
  Q_salah.MoveBy(Random(Q_salah.RecordCount));
  JE:=Q_salah.FieldValues['ISTILAH'];

  Qacak.SQL.Clear;
  Qacak.SQL.Add('Select * from informatika Where istilah="'+JA+'" or istilah="'+JB+'" or istilah="'+JC+'" or istilah="'+JD+'" or istilah="'+JE+'" order by arti');
  Qacak.Open;

  Randomize;
  Qacak.First;
  l1.Caption:=Qacak.FieldValues['ISTILAH'];
  Qacak.Next;
  l2.Caption:=Qacak.FieldValues['ISTILAH'];
  Qacak.Next;
  l3.Caption:=Qacak.FieldValues['ISTILAH'];
  Qacak.Next;
  l4.Caption:=Qacak.FieldValues['ISTILAH'];
  Qacak.Next;
  l5.Caption:=Qacak.FieldValues['ISTILAH'];
end;



procedure TFQuiz.FormCreate(Sender: TObject);
begin
  GTop.Picture:=FIDICT.GBlue.Picture;
  GButton.Picture:=FIDICT.Gyellow.Picture;
  panel1.Visible:=false;
  GroupBox1.Visible:=false;

  FQuiz.Color:=FIDICT.Color;
  T_SOAL.Font.Name:=FIDICT.t_deskripsi.Font.Name;
  T_SOAL.Color:=FIDICT.t_deskripsi.Color;
  T_SOAL.Font.Size:=FIDICT.t_deskripsi.Font.Size;
  T_SOAL.Font.Color:=FIDICT.t_deskripsi.Font.Color;
  T_SOAL.Font.Style:=FIDICT.t_deskripsi.Font.Style;

    if FIDICT.StayOnTop1.Checked=true then
        SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,
        SWP_NOACTIVATE OR SWP_NOSIZE  OR SWP_NOMOVE);

end;

procedure TFQuiz.Button1Click(Sender: TObject);
begin

T_SOAL.Enabled:=true;
Panel1.Visible:=false;
  isi_aktif;
  acak_soal;

end;

procedure TFQuiz.AClick(Sender: TObject);
begin
  if l1.Caption=Qtest.FieldValues['Istilah'] then
    begin
      l1.Font.Color:=clBlue;
      itung_benar;
      nilai.Caption:=IntToStr(skr);
      jbbenar.Caption:=IntToStr(jbnr);
    end
  else
    begin
      l1.Font.Color:=clRed;
      itung_salah;
      nilai.Caption:=IntToStr(skr);
      jbsalah.Caption:=IntToStr(jslh);
    end;
  isi_nonaktif;
  T_SOAL.Enabled:=false;
end;

procedure TFQuiz.BClick(Sender: TObject);
begin
  if l2.Caption=Qtest.FieldValues['Istilah'] then
    begin
      l2.Font.Color:=clBlue;
      itung_benar;
      nilai.Caption:=IntToStr(skr);
      jbbenar.Caption:=IntToStr(jbnr);
    end
  else
    begin
      l2.Font.Color:=clRed;
      itung_salah;
      nilai.Caption:=IntToStr(skr);
      jbsalah.Caption:=IntToStr(jslh);
    end;
  isi_nonaktif;
  T_SOAL.Enabled:=false;
end;

procedure TFQuiz.CClick(Sender: TObject);
begin
  if l3.Caption=Qtest.FieldValues['Istilah'] then
    begin
      l3.Font.Color:=clBlue;
      itung_benar;
      nilai.Caption:=IntToStr(skr);
      jbbenar.Caption:=IntToStr(jbnr);
    end
  else
    begin
      l3.Font.Color:=clRed;
      itung_salah;
      nilai.Caption:=IntToStr(skr);
      jbsalah.Caption:=IntToStr(jslh);
    end;
    isi_nonaktif;
    T_SOAL.Enabled:=false;
end;

procedure TFQuiz.DClick(Sender: TObject);
begin
  if l4.Caption=Qtest.FieldValues['Istilah'] then
    begin
      l4.Font.Color:=clBlue;
      itung_benar;
      nilai.Caption:=IntToStr(skr);
      jbbenar.Caption:=IntToStr(jbnr);
    end
  else
    begin
      l4.Font.Color:=clRed;
      itung_salah;
      nilai.Caption:=IntToStr(skr);
      jbsalah.Caption:=IntToStr(jslh);
    end;
  isi_nonaktif;
  T_SOAL.Enabled:=false;
end;

procedure TFQuiz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if WindowState=wsNormal then
    begin
      FIDICT.Width:=FQuiz.Width;
      FIDICT.Height:=FQuiz.Height;
      FIDICT.Left:=FQuiz.Left;
      FIDICT.Top:=FQuiz.Top;
    end;
  if WindowState=wsMaximized then FIDICT.WindowState:=wsMaximized;

  FIDICT.Show;
  Action:=caFree;
end;

procedure TFQuiz.EClick(Sender: TObject);
begin
  if l5.Caption=Qtest.FieldValues['Istilah'] then
    begin
      l5.Font.Color:=clBlue;
      itung_benar;
      nilai.Caption:=IntToStr(skr);
      jbbenar.Caption:=IntToStr(jbnr);
    end
  else
    begin
      l5.Font.Color:=clRed;
      itung_salah;
      nilai.Caption:=IntToStr(skr);
      jbsalah.Caption:=IntToStr(jslh);
    end;
  isi_nonaktif;
  T_SOAL.Enabled:=false;
end;

procedure TFQuiz.Image4Click(Sender: TObject);
begin
  Application.CreateForm(TFAbout,FAbout);
  FAbout.ShowModal;
end;

procedure TFQuiz.Edit1Click(Sender: TObject);
begin
edit1.Clear;
end;

procedure TFQuiz.Button2Click(Sender: TObject);
begin
if edit1.Text='' then
begin
MessageDlg('Masukan nama terlebih dahulu !',mtWarning,[mbOK],0);
Edit1.SetFocus;
end
else
begin
  GroupBox1.Visible:=True;
  Edit1.Visible:=False;
  Button2.Visible:=False;
  label2.Visible:=false;
  status.Caption:=Edit1.Text+' Pemula';
  T_SOAL.ScrollBars:=ssVertical;
  isi_aktif;
  acak_soal;
  T_SOAL.Enabled:=true;
  end;
end;

procedure TFQuiz.L1Click(Sender: TObject);
begin
AClick(Self);
end;

procedure TFQuiz.L2Click(Sender: TObject);
begin
BClick(Self);
end;

procedure TFQuiz.L3Click(Sender: TObject);
begin
CClick(Self);
end;

procedure TFQuiz.L4Click(Sender: TObject);
begin
DClick(Self);
end;

procedure TFQuiz.L5Click(Sender: TObject);
begin
EClick(Self);
end;

procedure TFQuiz.Ca(Sender: TObject);
begin
acak_soal;
end;

end.
