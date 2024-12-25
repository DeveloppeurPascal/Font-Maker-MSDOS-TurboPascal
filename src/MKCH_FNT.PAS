unit mkch_fnt;
{
Auteur: Premartin Patrick.
Date: 09/09/1991.
      14/11/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Gestion de la fonte courante.
}
interface
var
   fnt_fich_name : string;

procedure load_fnt;
procedure save_fnt;

implementation
uses
    mkch_aff,
    mkch_mod,
    mkch_var,
    u_fnt,
    u_m_util;

procedure new_carac;
var
   i,
   j : byte;
begin
     for i := 1 to 8 do
         for j := 1 to 8 do
             carac [i, j] := (((fnt^ [num_ch] [j]) and (1 shl (8-i))) <> 0);
         {endfor}
     {endfor}
     case cadre of
          0 : begin
                   aff_cadre_1;
                   aff_cadre_0;
          end;
          1 : aff_cadre_1;
     end;
end; { New_Carac }

procedure init_fnt;
var
   i : word;
   res : byte;
begin
     new (fnt);
     if (fnt = nil)
     then
         begin
              writeln ('Out of memory...');
              halt (1);
         end;
     {endif}
     for i := 0 to 255 do
         clear_char (i);
     {endfor}
     res := fnt_register (fnt, 1);
     res := fnt_select (1);
end;

procedure load_fnt;
var
   res : byte;
begin
     fnt_fich_name := get_fich_name (fnt_fich_name, 'FNT');
     if confirm ('Load '+fnt_fich_name+' ?')
     then
         begin
              if (fnt <> nil)
              then
                  res := fnt_erase (1);
              {endif}
              fnt := fnt_load (fnt_fich_name);
              if (fnt = nil)
              then
                  begin
                       alert ('Loading error !', al_error);
                       init_fnt;
                  end
              else
                  begin
                       res := fnt_register (fnt, 1);
                       res := fnt_select (1);
                  end;
              {endif}
              new_carac;
         end;
     {endif}
end; { Load_Fnt }

procedure save_fnt;
begin
     fnt_fich_name := get_fich_name (fnt_fich_name, 'FNT');
     if confirm ('Save '+fnt_fich_name+' ?')
     then
         begin
              if (fnt_save (fnt_fich_name, 1) <> 0)
              then
                  alert ('Saving error !', al_error);
              {endif}
         end;
     {endif}
end; { Save_Fnt }

begin
     init_fnt;
     fnt_fich_name := 'MKCHAR.FNT';
end. { Fin de l'unit‚ 'Mkch_Fnt'. }
