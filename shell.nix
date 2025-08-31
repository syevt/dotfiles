# put this to gis-weather git-cloned folder

{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  packages = with pkgs; [
    (python3.withPackages (ps: [ ps.pygobject3 ]))
    gtk3
    gobject-introspection
  ];

  # ensures GI finds typelibs
  GI_TYPELIB_PATH = pkgs.lib.makeSearchPath "lib/girepository-1.0" [
    pkgs.gtk3
    pkgs.glib.out
    pkgs.gobject-introspection
  ];
}
