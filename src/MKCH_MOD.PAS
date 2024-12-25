unit mkch_mod;
{
Auteur: Premartin Patrick.
Date: 09/09/1991.
      14/11/1991. (1.0)
Langage: Turbo PAscal 6.0

But: Modification du caractŠre courant.
}
interface
procedure set_point (x, y : byte);
procedure clear_char (num : byte);
procedure new_carac (num : integer);

implementation
uses
    u_couleur,
    u_fnt,
    mkch_aff,
    mkch_var;

procedure set_point (x, y : byte);
begin
     carac [x, y] := not carac [x, y];
     if (carac [x, y])
     then
         fnt^ [num_ch] [y] := (fnt^ [num_ch] [y] or (1 shl (8-x)))
     else
         fnt^ [num_ch] [y] := (fnt^ [num_ch] [y] xor (1 shl (8-x)));
     {endif}
     cadre := 1;
     aff_cadre_1;
     aff_ascii_code;
     ecr_color (noir, blanc);
     ecr_xy ((num_ch mod 32)+dx_c0, (num_ch div 32)+dy_c0);
     ecr_char (chr (num_ch));
end; { Set_Point }

procedure clear_char (num : byte);
var
   j : byte;
begin
     for j := 1 to 8 do
         fnt^ [num] [j] := 0;
     {endfor}
end; { Clear_Char }

procedure new_carac (num : integer);
var
   i,
   j : byte;
begin
     ecr_color (blanc, noir);
     ecr_xy ((num_ch mod 32)+dx_c0, (num_ch div 32)+dy_c0);
     ecr_char (chr (num_ch));
     if (num < 0)
     then
         num := 255
     else
         if (num > 255)
         then
             num := 0;
         {endif}
     {endif}
     num_ch := num;
     for i := 1 to 8 do
         for j := 1 to 8 do
             carac [i, j] := (((fnt^ [num_ch] [j]) and (1 shl (8-i))) <> 0);
         {endfor}
     {endfor}
     ecr_color (noir, blanc);
     ecr_xy ((num_ch mod 32)+dx_c0, (num_ch div 32)+dy_c0);
     ecr_char (chr (num_ch));
     aff_cadre_1;
     aff_ascii_code;
end; { Aff_Carac }

end. { Fin de l'unit‚ 'Mkch_Mod'. }
