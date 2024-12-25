program Character_Maker;
{
Auteur: Pr‚martin Patrick.
Date: 09/09/1991.
      14/11/1991.
      15/11/1991. (1.0)
      26/11/1991.
      27/11/1991. (1.1)
Langage: Turbo Pascal 6.0

But: Cr‚ation de nouvelles fontes de caractŠres.
}
uses
    crt,
    mkch_aff,
    mkch_fnt,
    mkch_mod,
    mkch_prm,
    mkch_var,
    olf_software,
    u_clic,
    u_code_clavier,
    u_couleur,
    u_curseur,
    u_m_util,
    u_mouse;

var
   fin : boolean;
   xc,
   yc : integer;
   old_cadre : byte;

procedure mode_texte;
begin { Mode_Texte }
      directvideo := true;
      asm
         push ax
         mov ah, 0
         mov al, 3
         int 10h
         pop ax
      end;
end; { Mode_Texte }

procedure mode_graphique;
begin { Mode_Graphique }
      directvideo := false;
      asm
         push ax
         mov ah, 0
         mov al, 0eh
         int 10h
         pop ax
      end;
end; { Mode_Graphique }

begin
     init_olf_message (mess_careware);
     init_licence ('MKFNT');
     init_olf_software ('Character Maker '+num_vers, '(c) Premartin Patrick '+dat_vers);
     traite_param;
     fin := false;
     hide_mouse;
     mode_graphique;
     aff_decor;
     new_carac (0);
     repeat
           old_cadre := cadre;
           case cadre of
                0 : begin
                         clic_init (dx_c0, dy_c0, lx_c0, ly_c0);
                         xc := x_c0;
                         yc := y_c0;
                end;
                1 : begin
                         clic_init (dx_c1, dy_c1, lx_c1, ly_c1);
                         xc := x_c1;
                         yc := y_c1;
                end;
           end;
           clic_clavier (xc, yc, touche);
           clic_mouse (xc, yc, xm, ym);
           case cadre of
                0 : gotoxy (pred (xc+dx_c0), pred (yc+dy_c0));
                1 : gotoxy (pred (xc+dx_c1), pred (yc+dy_c1));
           end;
           if ((xm >= dx_c0) and (xm < dx_c0+lx_c0) and (ym >= dy_c0) and (ym < dy_c0+ly_c0) and (cadre = 1))
           then
               cadre := 0
           else
               if ((xm >= dx_c1) and (xm < dx_c1+lx_c1) and (ym >= dy_c1) and (ym < dy_c1+ly_c1) and (cadre = 0))
               then
                   cadre := 1
               else
                   if ((touche = ' ') or ((xm > 0) and (ym > 0)))
                   then
                       begin
                            hide_mouse;
                            case cadre of
                                 0 : new_carac (pred (xc)+ pred (yc)*32);
                                 1 : set_point (xc, yc);
                            end;
                            show_mouse;
                       end;
                   {endif}
               {endif}
           {endif}
           if ((xm > 41) and (xm < 66))
           then
               case ym of
                    1 : touche := touche_f1;
                    2 : touche := touche_f2;
                    3 : touche := touche_f3;
                    4 : touche := touche_f4;
                    5 : touche := touche_f5;
                    6 : touche := touche_f6;
                    7 : touche := touche_f7;
               end;
           {endif}
           if (touche <> carac_nul)
           then
               case touche of
                    touche_f1 : if confirm ('Do you want to Erase all characters ?')
                                then
                                    begin
                                         hide_mouse;
                                         for num_ch := 0 to 255 do
                                             clear_char (num_ch);
                                         {endfor}
                                         new_carac (0);
                                         show_mouse;
                                    end;
                                {endif}
                    touche_f2 : save_fnt;
                    touche_f3 : load_fnt;
                    touche_f4 : if confirm ('Clear this character ?')
                                then
                                    begin
                                         hide_mouse;
                                         clear_char (num_ch);
                                         new_carac (num_ch);
                                         show_mouse;
                                    end;
                                {endif}
                    touche_f5 : begin
                                     dec (x_c0);
                                     if (x_c0 < 1)
                                     then
                                         begin
                                              x_c0 := lx_c0;
                                              dec (y_c0);
                                              if (y_c0 < 1)
                                              then
                                                  y_c0 := ly_c0;
                                              {endif}
                                         end;
                                     {endif}
                                     new_carac (pred (num_ch));
                    end;
                    touche_f6 : begin
                                     inc (x_c0);
                                     if (x_c0 > lx_c0)
                                     then
                                         begin
                                              x_c0 := 1;
                                              inc (y_c0);
                                              if (y_c0 > ly_c0)
                                              then
                                                  y_c0 := 1;
                                              {endif}
                                         end;
                                     {endif}
                                     new_carac (succ (num_ch));
                    end;
                    touche_escape,
                    touche_f7 : fin := confirm ('Do you want to quit this program ?');
                    touche_tab : begin
                                      hide_mouse;
                                      cadre := 1-cadre;
                                      case cadre of
                                           0 : aff_cadre_0;
                                           1 : aff_cadre_1;
                                      end;
                                      show_mouse;
                    end;
               end;
           {endif}
           case old_cadre of
                0 : begin
                         x_c0 := xc;
                         y_c0 := yc;
                end;
                1 : begin
                         x_c1 := xc;
                         y_c1 := yc;
                end;
           end;
     until fin;
     mode_texte;
     clrscr;
     textcolor (gris_clair);
     textbackground (noir);
     writeln ('Thanks for using Character Maker...');
end.
