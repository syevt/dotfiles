#!/bin/bash
pgrep slurp && exit 0  # If slurp is already running, don't launch again

niri msg action screenshot
