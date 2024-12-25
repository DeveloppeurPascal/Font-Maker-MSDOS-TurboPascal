unit mkch_aff;
{
Auteur: Premartin Patrick
Date: 09/09/1991.
      14/11/1991.
      15/11/1991.
      20/11/1991.
      21/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Gestion des diff‚rents affichages de MkChar.
}
interface
procedure aff_decor;
procedure aff_cadre_0;
procedure aff_cadre_1;
procedure aff_ascii_code;

implementation
uses
    crt,
    u_couleur,
    u_fnt,
    mkch_var;

procedure writexy (x, y : byte; ch : string);
begin
     gotoxy (x, y);
     write (ch);
end; { Writexy }

procedure encadre (x, y, larg, haut, color : byte);
var
   ota, ox, oy, i : byte;
begin
     if ((x > 1) and (y > 1) and (x+larg < 80) and (y+haut < 24))
     then
         begin
              ota := textattr;
              ox := wherex;
              oy := wherey;
              textcolor (color);
              textbackground (noir);
              for i := pred (x) to x+larg do
                  begin
                       writexy (i, pred (y), #178);
                       writexy (i, y+haut, #178);
                  end;
              {endfor}
              for i := y to pred (y+haut) do
                  begin
                       writexy (pred (x), i, #178);
                       writexy (x+larg, i, #178);
                  end;
              {endfor}
              gotoxy (ox, oy);
              textattr := ota;
         end;
     {endif}
end; { Encadre }

procedure aff_decor;
begin
     textcolor (blanc);
     textbackground (noir);
     encadre (2, 2, 15, 5, gris_clair);
     encadre (2, 8, 15, 1, gris_clair);
     writexy (3, 2, 'Olf  Software');
     writexy (5, 3, 'presents');
     writexy (2, 5, 'Character Maker');
     writexy (8, 6, num_vers);
     writexy (2, 8, #155'  PREPAT  1991');
     case cadre of
          0 : begin
                   aff_cadre_1;
                   aff_cadre_0;
          end;
          1 : begin
                   aff_cadre_0;
                   aff_cadre_1;
          end;
     end;
     writexy (42, 1, 'F1 New FNT');
     writexy (42, 2, 'F2 Save FNT');
     writexy (42, 3, 'F3 Load FNT');
     writexy (42, 4, 'F4 Clear this character');
     writexy (42, 5, 'F5 Previous character');
     writexy (42, 6, 'F6 Next character');
     writexy (42, 7, 'F7 Quit this program');
end; { Aff_Decor }

procedure aff_cadre_0;
var
   ox,
   oy,
   i,
   j : byte;
begin
     ecr_mode := normal;
     ox := wherex;
     oy := wherey;
     encadre (dx_c0, dy_c0, lx_c0, ly_c0, blanc);
     encadre (dx_c1, dy_c1, lx_c1, ly_c1, gris_clair);
     textbackground (noir);
     for i := 0 to 31 do
         for j := 0 to 7 do
             begin
                  if (num_ch = i+32*j)
                  then
                      ecr_color (noir, blanc)
                  else
                      ecr_color (blanc, noir);
                  {endif}
                  ecr_xy (i+dx_c0, j+dy_c0);
                  ecr_char (chr (i+32*j));
             end;
         {endfor}
     {endfor}
     gotoxy (ox, oy);
end; { Aff_Cadre_0 }

procedure aff_cadre_1;
var
   ox,
   oy,
   i,
   j : byte;
begin
     ox := wherex;
     oy := wherey;
     encadre (dx_c0, dy_c0, lx_c0, ly_c0, gris_clair);
     encadre (dx_c1, dy_c1, lx_c1, ly_c1, blanc);
     textcolor (gris_clair);
     textbackground (noir);
     for i := 1 to lx_c1 do
         for j := 1 to ly_c1 do
             if (carac [i, j])
             then
                 writexy (pred (dx_c1+i), pred (dy_c1+j), #176)
             else
                 writexy (pred (dx_c1+i), pred (dy_c1+j), #249);
             {endif}
         {endfor}
     {endfor}
     gotoxy (ox, oy);
end; { Aff_Cadre_1 }

procedure aff_ascii_code;
var ox, oy : byte;
begin
     ox := wherex;
     oy := wherey;
     textcolor (blanc);
     textbackground (noir);
     writexy (dx_c0, succ (dy_c0+ly_c0), 'ASCII Code: ');
     write (num_ch, '  ');
     writexy (dx_c0, succ (succ (dy_c0+ly_c0)), 'Character: ');
     ecr_color (blanc, noir);
     ecr_xy (dx_c0+13, succ (succ (dy_c0+ly_c0)));
     ecr_char (chr (num_ch));
     gotoxy (ox, oy);
end; { Aff_Ascii_Code }

end. { Fin de l'unit‚ 'Mkch_Aff'. }
