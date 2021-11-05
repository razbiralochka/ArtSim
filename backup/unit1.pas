unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  TAGraph, TASeries, TARadialSeries, TAFuncSeries, TAExpressionSeries,Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Series1: TLineSeries;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;
  y0, x0,t0, b, h, g, q, p, c, r, s, m, U, Uk, V0, l, z: extended;
  iter: integer ;
   implementation

{$R *.lfm}

{ TForm1 }
   function fx(x,y: extended): extended;
   begin
   fx:=-l*x*sqrt(sqr(x)+sqr(y));

   end;

   function fy(x,y: extended): extended;
   begin
   fy:=-g-l*y*sqrt(sqr(x)+sqr(y));
   end;

procedure TForm1.FormCreate(Sender: TObject);
begin
end;

procedure TForm1.Button1Click(Sender: TObject);

var
  x,y,t, e, f, q: extended;
  k1, y1, k2, y2,
  k3, y3, k4, dy ,

  m1, x1, m2, x2,
  m3, x3,  m4, dx : extended;


begin
  z:=StrToFloat(Edit9.Text);
  c:=0.4;
  g:=9.81;
  p:=1.29;
  t0:=0;
  b:=StrToFloat(Edit3.Text);
  h:=StrToFloat(Edit4.Text);
  r:=StrToFloat(Edit5.Text);
  m:=StrToFloat(Edit6.Text);
  s:=pi*sqr(r);
  q:=0.5*c*s*p;
  l:=q/m;
  V0:=StrToFloat(Edit7.Text);


//начальные условия

 //if U<=90 then

  U:=(pi()-arcsin((z*g)/sqr(v0)))/2;


  U:=U*180/pi();{начальное значение}
  e:=0;
  iter:=1;
  Edit8.Text:=FloatToStr(U);
  Edit8.refresh();
  Chart1.Extent.YMax:=1.0 * sqr(V0*sin(U*pi/180))/(2*g);
  Chart1.Extent.XMax:=z;

  if(CheckBox1.Checked=false) then
     U:=arcsin((z*g)/sqr(v0))/2
  else
     U:=(pi()-arcsin((z*g)/sqr(v0)))/2;

  U:=U*180/pi();


  while (abs(e-z)>0.25) do begin

  Edit10.Text:=IntToStr(iter);
  Edit10.refresh();


  y0:=V0*sin(U*pi/180);
  x0:=V0*cos(U*pi/180);


  memo1.Lines.Clear;
  memo1.Lines.Add('Метод Рунге-Кутта');
  e:=0;
  f:=0;
  memo1.Lines.Add('x='+floattostr(e)+'; y='+floattostr(f));
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.AddXY (e,f, ' ', clred);


 //начало расчета
  x:=x0;
  y:=y0;
  t:=t0;
  e:=e+x0*h;
  f:=f+y0*h;
  memo1.Lines.Add('x='+floattostr(e)+'; y='+floattostr(f)+'; U='+floattostr(U));
  Chart1LineSeries1.AddXY (e,f, ' ', clred);



  while f>=0 do
  begin
    k1:=h*fy(x,y);
    m1:=h*fx(x,y);

    y1:=y+k1/2;
    x1:=x+m1/2;

    k2:=h*fy(x1,y1);
    m2:=h*fx(x1,y1);
    y2:=y+k2/2;
    x2:=x+m2/2;

    k3:=h*fy(x2,y2);
    m3:=h*fx(x2,y2);

    y3:=y+k3;
    x3:=x+m3;

    k4:=h*fy(x3,y3);
    m4:=h*fx(x3,y3);

    dy:=(k1+2*k2+2*k3+k4)/6;
    dx:=(m1+2*m2+2*m3+m4)/6;

    y:=y+dy;
    x:=x+dx;
    t:=t+h;

    e:=e+x*h;
    f:=f+y*h;

    if f>=0 then
       begin
       memo1.Lines.Add('x='+floattostr(e)+'; y='+floattostr(f));
       Chart1LineSeries1.AddXY (e,f, ' ', clred);
       Edit1.Clear;
       //Edit1.Text:=FloatToStr(e);
       //Edit2.Clear;
       Edit2.Text:=FloatToStr(t);
       end;


end;

   Chart1.refresh();
  //Uk:= 0.2/(1+exp(-(e-z)))-0.1 ;
  if(CheckBox1.Checked=false) then
     U:=U-0.05*(e-z)
  else
     U:=U+0.05*(e-z);


  Edit1.Text:=FloatToStr(e);
  Edit1.refresh();
  Edit2.refresh();
  Edit8.Text:=FloatToStr(U);
  Edit8.refresh();
  iter:=iter+1;
  end;


end;


//конец расчета


   procedure TForm1.Button2Click(Sender: TObject);
begin
 close
end;



end.

