# Reduced Laygo2 Workspace

The idea of this repo is to have the minimum requirements to run laygo2 in the iic-osic-tools docker container.


## Setup

### Install Laygo2

~~~
$ git submodule init
$ git submodule update
~~~


## Run examples

The workflow is:

1. Generate the \*.tcl files with ipython and examples

~~~
$ ./compile_tcl.sh laygo2_example/inv.py
$ ./compile_tcl.sh laygo2_example/tinv.py
$ ./compile_tcl.sh laygo2_example/tinv_small_2x.py
$ ./compile_tcl.sh laygo2_example/dff.py
~~~


2. Compile the layouts with magic.

~~~

$ ./start_mag.sh
% logic_generated_inv_2x.tcl
% exit

// OR

$ ./start_mag_console.sh logic_generated_inv_2x.tcl
% exit

~~~


## TODO list

### Remove start_mag.sh

It only exists because we need ``-rcfile .maginit`` as parameter to set the PATH to laygo2 microtemplates and generated logic.
If we update the path in some system ``.magicrc`` file, this script will become unnecesary.


### Add laygo2 as python package

Pip has an option to install a package from git?
Yes, I've never do it before.


### Remove some BAG environment variables

Why we have so many variables?
Which ones are necesary by laygo2?
Do we need bag support?
