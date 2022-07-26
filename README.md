# Reduced Laygo2 Workspace

The idea of this repo is to have the minimum requirements to run laygo2 in the iic-osic-tools docker container.


## Setup

Laygo2 only requires to install ipython, the other packages and programs are already in if you're using iic-osic-tools container.


~~~bash
$ python -m pip install --user ipython
~~~


## Run examples

The workflow is:

1. Generate the \*.tcl files with ipython and examples

~~~
$ ./start_ipython.sh

> run laygo2_example/inv.py
> run laygo2_example/tinv.py
> run laygo2_example/tinv_small_1x.py
> run laygo2_example/dff.py
~~~


2. Compile the layouts with magic.

~~~
$ ./start_mag.sh logic_generated_inv_2x.tcl
% exit

$ ./start_mag.sh logic_generated_inv_4x.tcl
% exit

...
~~~


## TODO list

### Remove start_mag.sh

It only exists because we need ``-rcfile .maginit`` as parameter to set the PATH to laygo2 microtemplates and generated logic.
If we update the path in some system ``.magicrc`` file, this script will become unnecesary.


### Remove ipython

With a python script that execute the examples and generates the tcl files, we can remove the ipython dependency.

If we turn laygo2 into a python library, we can run the scripts without ``bag_startup.py`` file.

**Pip has an option to install a package from git?**


### Remove some BAG environment variables

Why we have so many variables? Which ones are used internally by laygo2?


### Remove start_ipython.sh

When we put the enviroment variables into python's path by default, we won't need this script.


