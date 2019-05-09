#!/bin/bash
SCRIPT="${1:-info}"
Rscript "/${SCRIPT}.R" "${@:2}"
