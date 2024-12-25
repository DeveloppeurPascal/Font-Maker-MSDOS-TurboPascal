unit mkch_var;
{
Auteur: Premartin Patrick
Date: 09/09/1991.
      14/11/1991.
      15/11/1991.
      20/11/1991.
      21/11/1991. (1.0)
      26/11/1991. (1.1)
Langage: Turbo Pascal 6.0

But: Variables globales de MkChar.
}
interface
uses
    u_fnt;

const
     num_vers : string [3] = '1.1';
     dat_vers : string [10] = '26/11/1991';
     dx_c0 = 2;dy_c0 = 13; lx_c0 = 32; ly_c0 = 8;
     dx_c1 = 20; dy_c1 = 2; lx_c1 = 8; ly_c1 = 8;

type
    t_char = array [1..lx_c1, 1..ly_c1] of boolean;

var
   cadre : byte;
   num_ch : integer;
   fnt : p_fnt;
   x_c0, y_c0 : integer;
   x_c1, y_c1 : integer;
   touche : char;
   xm, ym : integer;
   carac : t_char;

implementation
procedure mkchar_var_init;
begin
     cadre := 0;
     num_ch := 0;
     fnt := nil;
     x_c0 := 1;
     y_c0 := 1;
     x_c1 := 1;
     y_c1 := 1;
     touche := #0;
     xm := 0;
     ym := 0;
end; { Mkchar_Var_Init }

var
   old_exitproc : pointer;

{$f+}
procedure mkchar_var_exit;
{$f-}
begin
     exitproc := old_exitproc;
end; { Mkchar_Var_Exit }

begin
     mkchar_var_init;
     old_exitproc := exitproc;
     exitproc := @mkchar_var_exit;
end. { Fin de l'unit‚ 'Mkch_Var'. }
