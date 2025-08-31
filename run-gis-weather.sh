#!/usr/bin/env bash

# put this to gis-weather git-cloned folder

exec nix-shell ~/gis-weather/shell.nix --run "python3 ~/gis-weather/gis-weather.py"
