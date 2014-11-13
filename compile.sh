#!/bin/bash


f=./Configuration.scpt
plaintext=$(osadecompile "$f")
echo "$plaintext" | osacompile -o "$f"

echo 'Recompiled scripts!'