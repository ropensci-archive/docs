#!/bin/bash
SCRIPT="$1"
Rscript "/${SCRIPT}.R" "${@:2}"
