unit mkch_prm;
{
Auteur: Premartin Patrick
Date: 09/09/1991. (1.0)
Langage: Turbo Pascal 6.0

But: Gestion des paramŠtres de MkChar.
}
interface
procedure traite_param;

implementation
uses
    mkch_fnt,
    u_m_util,
    u_parametre;

procedure traite_param;
var
   i : integer;
begin
     if param_del ('/H')
     then
         begin
              writeln ('Syntax:');
              writeln ('        mkchar [/h] [/ffile_name]');
              writeln;
              writeln ('/h for this short help text');
              writeln ('/f to load (or create) File_Name.FNT');
              alert ('Please press a key...', al_nothing);
         end;
     {endif}
     for i := 1 to paramcount do
         if ((copy (paramstr (i), 1, 2) = '/f') or (copy (paramstr (i), 1, 2) = '/F'))
         then
             begin
                  fnt_fich_name := copy (paramstr (i), 3, length (paramstr (i)));
                  load_fnt;
             end;
         {endif}
     {endfor}
end; { Traite_Param }

end. { Fin de l'unit‚ 'Mkch_Prm'. }
