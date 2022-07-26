#!/usr/bin/env bash


# set BAG working directory
#export BAG_WORK_DIR="$PWD"
export BAG_WORK_DIR="/foss/designs/laygo2_reduced_workspace"
# set BAG framework directory
export BAG_FRAMEWORK="$BAG_WORK_DIR/BAG_framework"
# set BAG python executable
#export BAG_PYTHON="/usr/bin/python"
# We must try to use the default python.

# set jupyter notebook path
#export BAG_JUPYTER="/usr/anaconda3/bin/jupyter-notebook"

# set technology/project configuration directory 
# -> not implemented yet but there's no problem with generating magic tcl script
export BAG_TECH_CONFIG_DIR="$BAG_WORK_DIR/sky130"

# set where BAG saves temporary files
#export BAG_TEMP_DIR="${BAG_WORK_DIR}/BAGTMP"
# Do we need this BAG variable?

# set location of BAG configuration file
#export BAG_CONFIG_PATH="${BAG_WORK_DIR}/bag_config.yaml"
# Do we need this BAG variable?

# set IPython configuration directory
#export IPYTHONDIR="$BAG_WORK_DIR/.ipython"
# When is this used?


export PYTHONPATH=""

#export PYTHONPATH=$BAG_FRAMEWORK
#export PYTHONPATH=$BAG_TECH_CONFIG_DIR:$PYTHONPATH
#export PYTHONPATH=$BAG_WORK_DIR"/laygo2":$PYTHONPATH
export PYTHONPATH="/foss/designs/laygo2":$PYTHONPATH
export PYTHONPATH="/foss/designs/laygo2_reduced_workspace":$PYTHONPATH

#echo $PYTHONPATH

# disable QT session manager warnings
unset SESSION_MANAGER

#exec ${BAG_PYTHON} -m IPython $@
#exec python -m pip install ipython
#exec python #-i bag_startup.py

exec python $@


## Falta laygo2_tech
