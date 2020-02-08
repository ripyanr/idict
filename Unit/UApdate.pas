unit UApdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TFApdate = class(TForm)
    t_ist: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    t_art: TMemo;
    t_penj: TMemo;
    Image1: TImage;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure tampil_data();
  end;

var
  FApdate: TFApdate;

implementation
uses UIDICT, ADODB, DB;
{$R *.dfm}
procedure TFApdate.tampil_data();
begin
  If not FIDICT.Q.IsEmpty then
    begin
      FIDICT.Q.ActivE:=True;
      t_ist.Text:=FIDICT.Q.FieldValues['Istilah'];
      t_art.Text:=FIDICT.Q.FieldValues['Arti'];
      t_penj.Text:=FIDICT.Q.FieldValues['Deskripsi'];
    end;
end;
procedure TFApdate.FormCreate(Sender: TObject);
begin
  Image1.Picture:=FIDICT.GBlue.Picture;
  Color:=FIDICT.Color;
  FApdate.t_art.Clear;
  FApdate.t_penj.Clear;
  
  if BitBtn1.Caption='Update' then tampil_data;
end;

procedure TFApdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFApdate.BitBtn1Click(Sender: TObject);
begin
  if t_ist.Text='' then
    begin
      ShowMessage('Istilah tidak boleh di kosongkan !!!');
      t_ist.SetFocus;
      exit;
    end;
  if t_art.Text='' then
    begin
      ShowMessage('Pengertian tidak boleh di kosongkan !!!');
      t_art.SetFocus;
      exit;
    end;

  if (t_ist.Text<>'') and (t_art.Text<>'') then
    begin
        if BitBtn1.Caption='Simpan' then
          begin
            if FIDICT.Q.Locate('istilah',t_ist.Text,[locaseinsensitive])then
            begin
            ShowMessage('Data Sudah ada !!!');
            t_ist.Clear;
            exit;
            end;
            FIDICT.Q.SQL.Clear;
            FIDICT.Q.SQL.Add('insert into informatika(istilah,arti,deskripsi) values("'+t_ist.Text+'","'+t_art.Text+'","'+t_penj.Text+'")');
            FIDICT.Q.ExecSQL;
            t_ist.Clear;
            t_art.Clear;
            t_penj.Clear;
          end
        else
          begin
            FIDICT.Q.SQL.Clear;
            FIDICT.Q.SQL.Add('update informatika set istilah="'+t_ist.Text+'",arti="'+t_art.Text+'",deskripsi="'+t_penj.Text+'" where istilah="'+t_ist.Text+'" ');
            FIDICT.Q.ExecSQL;
            Close;
          end;
      end;
      FIDICT.Q.SQL.Clear;
      FIDICT.Q.SQL.Add('select * from informatika');
      FIDICT.Q.Open;
end;

procedure TFApdate.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

end.
