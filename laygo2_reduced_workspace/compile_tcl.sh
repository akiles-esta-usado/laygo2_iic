#!/usr/bin/env bash

export PYTHONPATH=""
export PYTHONPATH="/foss/designs/laygo2":$PYTHONPATH
export PYTHONPATH="/foss/designs/laygo2_reduced_workspace":$PYTHONPATH

#echo $PYTHONPATH

# disable QT session manager warnings
unset SESSION_MANAGER

exec python $@
