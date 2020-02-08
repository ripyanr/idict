unit Usetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,INIFiles;

type
  TFSetting = class(TForm)
    Image1: TImage;
    Image2: TImage;
    lstname: TListBox;
    tname: TEdit;
    tsize: TEdit;
    lstsize: TListBox;
    lststyle: TListBox;
    tstyle: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    cb1: TComboBox;
    cb2: TComboBox;
    cb3: TComboBox;
    WARNA: TLabel;
    Shape1: TShape;
    cbowarna: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lstnameClick(Sender: TObject);
    procedure lstsizeClick(Sender: TObject);
    procedure lststyleClick(Sender: TObject);
    procedure cbowarnaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb1Click(Sender: TObject);
    procedure cb3Click(Sender: TObject);
    procedure cb2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSetting: TFSetting;

implementation
uses UIDICT;
{$R *.dfm}

procedure TFSetting.FormCreate(Sender: TObject);
var ynr:byte;
    buatINI: TIniFile;
    fn,fs,fc,st:string;
    c1,c2,c3:String;
begin

  Image2.Picture:=FIDICT.GBlue.Picture;
  Image1.Picture:=FIDICT.Gyellow.Picture;
  Color:=FIDICT.Color;
  
  lstname.Items.Add('Arial');
  lstname.Items.Add('Calibri');
  lstname.Items.Add('Comic Sans');
  lstname.Items.Add('MS Sans Serif');
  lstname.Items.Add('Tahoma');
  lstname.Items.Add('Times New Roman');
  lstname.Items.Add('Verdana');

  for ynr:= 2 to 66 do
  lstsize.Items.Add(inttostr(ynr));

  lststyle.Items.Add('Reguler');
  lststyle.Items.Add('Bold');
  lststyle.Items.Add('Italic');
  lststyle.Items.Add('Bold Italic');

  cbowarna.Items.Add('Black');
  cbowarna.Items.Add('Red');
  cbowarna.Items.Add('Yellow');
  cbowarna.Items.Add('Green');
  cbowarna.Items.Add('Sky Blue');
  cbowarna.Items.Add('White');

  cb1.Items.Add('Black');
  cb1.Items.Add('Silver');
  cb1.Items.Add('Yellow');
  cb1.Items.Add('MoneyGreen');
  cb1.Items.Add('Sky Blue');
  cb1.Items.Add('White');

  cb3.Items.Add('Black');
  cb3.Items.Add('Silver');
  cb3.Items.Add('Yellow');
  cb3.Items.Add('MoneyGreen');
  cb3.Items.Add('Sky Blue');
  cb3.Items.Add('White');

  cb2.Items.Add('Silver');
  cb2.Items.Add('Yellow');
  cb2.Items.Add('MoneyGreen');
  cb2.Items.Add('Sky Blue');
  cb2.Items.Add('White');

    buatINI:=TiniFile.Create(GetCurrentDir + '\setting.ini');
    try
      tsize.Text:=buatINI.ReadString('setting','fontsize',fs);
      tname.Text:=buatINI.ReadString('setting','fontname',fn);
      tstyle.Text:=buatINI.ReadString('setting','fontstyle',st);
      cbowarna.Text:=buatINI.ReadString('setting','fontcolor',fc);
      cb1.Text:=buatINI.ReadString('setting','bgtextcolor',c1);
      cb3.Text:=buatINI.ReadString('setting','bgsidecolor',c2);
      cb2.Text:=buatINI.ReadString('setting','bgquizcolor',c3);
      finally
      buatINI.Free
    end;

end;

procedure TFSetting.lstnameClick(Sender: TObject);
begin
  tname.Text:=lstname.Items[lstname.Itemindex];
  FIDICT.t_deskripsi.Font.Name:=lstname.Items[lstname.Itemindex];
  FIDICT.l_istilah.Font.Name:=lstname.Items[lstname.Itemindex];
end;

procedure TFSetting.lstsizeClick(Sender: TObject);
begin
  tsize.Text:=lstsize.Items[lstsize.Itemindex];
  FIDICT.t_deskripsi.Font.Size:= strtoint(lstsize.Items[lstsize.Itemindex]);
  FIDICT.l_istilah.Font.Size:= strtoint(lstsize.Items[lstsize.Itemindex]);
end;

procedure TFSetting.lststyleClick(Sender: TObject);
begin
  tstyle.Text:=lststyle.Items[lststyle.Itemindex];
  if tstyle.Text= 'Bold' then FIDICT.t_deskripsi.Font.Style:=[fsBold];
  if tstyle.Text= 'Italic' then FIDICT.t_deskripsi.Font.Style:=[fsItalic];
  if tstyle.Text= 'Bold Italic' then FIDICT.t_deskripsi.Font.Style:=[fsBold,fsItalic];
  if (tstyle.Text<> 'Bold') and (tstyle.Text<> 'Italic') and (tstyle.Text<> 'Bold Italic') then  FIDICT.t_deskripsi.Font.Style:=[];
   FIDICT.l_istilah.Font.Style:=FIDICT.t_deskripsi.Font.Style;
end;

procedure TFSetting.cbowarnaClick(Sender: TObject);
begin
  if cbowarna.Text='Black' then  FIDICT.t_deskripsi.Font.Color:=clBlack;
  if cbowarna.Text='Silver' then FIDICT.t_deskripsi.Font.Color:=clSilver;
  if cbowarna.Text='Yellow' then FIDICT.t_deskripsi.Font.Color:=clYellow;
  if cbowarna.Text='Sky Blue' then FIDICT.t_deskripsi.Font.Color:=clSkyBlue;
  if cbowarna.Text='Green' then FIDICT.t_deskripsi.Font.Color:=clGreen;
  if cbowarna.Text='White' then FIDICT.t_deskripsi.Font.Color:=clWhite;
  FIDICT.l_istilah.Font.Color:=FIDICT.t_deskripsi.Font.Color;
end;

procedure TFSetting.FormClose(Sender: TObject; var Action: TCloseAction);
var buatINI:TIniFile;
begin
  SetFileAttributes(pchar('setting.ini'),FILE_ATTRIBUTE_NORMAL);
  buatINI:=TiniFile.Create(GetCurrentDir + '\setting.ini');
try

    buatINI.WriteString('setting','fontsize',tsize.Text);
    buatINI.WriteString('setting','fontname',tname.Text);
    buatINI.WriteString('setting','fontstyle',tstyle.Text);
    buatINI.WriteString('setting','fontcolor',cbowarna.Text);
    buatINI.WriteString('setting','bgtextcolor',cb1.Text);
    buatINI.WriteString('setting','bgsidecolor',cb3.Text);
    buatINI.WriteString('setting','bgquizcolor',cb2.Text);
 Finally

  buatINI.Free;
  end;
  Action:=caFree;
  end;
procedure TFSetting.cb1Click(Sender: TObject);
begin
  if cb1.Text='Black' then FIDICT.t_deskripsi.Color:=clBlack;
  if cb1.Text='Silver' then FIDICT.t_deskripsi.Color:=clSilver;
  if cb1.Text='Yellow' then FIDICT.t_deskripsi.Color:=clYellow;
  if cb1.Text='Sky Blue' then FIDICT.t_deskripsi.Color:=clSkyBlue;
  if cb1.Text='MoneyGreen' then FIDICT.t_deskripsi.Color:=clMoneyGreen;
  if cb1.Text='White' then FIDICT.t_deskripsi.Color:=clWhite;
end;

procedure TFSetting.cb3Click(Sender: TObject);
begin
  if cb3.Text='Black' then FIDICT.l_istilah.Color:=clBlack;
  if cb3.Text='Silver' then FIDICT.l_istilah.Color:=clSilver;
  if cb3.Text='Yellow' then FIDICT.l_istilah.Color:=clYellow;
  if cb3.Text='Sky Blue' then FIDICT.l_istilah.Color:=clSkyBlue;
  if cb3.Text='MoneyGreen' then FIDICT.l_istilah.Color:=clMoneyGreen;
  if cb3.Text='White' then FIDICT.l_istilah.Color:=clWhite;
end;

procedure TFSetting.cb2Click(Sender: TObject);
begin
  if cb2.Text='Silver' then FIDICT.Color:=clSilver;
  if cb2.Text='Yellow' then FIDICT.Color:=clYellow;
  if cb2.Text='Sky Blue' then FIDICT.Color:=clSkyBlue;
  if cb2.Text='MoneyGreen' then FIDICT.Color:=clMoneyGreen;
  if cb2.Text='White' then FIDICT.Color:=clWhite;
  Color:=FIDICT.Color;
end;

end.
