# Reduced Laygo2 Workspace

The idea of this repo is to have the minimum requirements to run laygo2 in the iic-osic-tools docker container.


## Usage

Someone using this repo will have two different use cases.

### 1. Using just laygo2 for running examples.

This is for people that only want to use laygo2.
Clone the repo anywhere, do de setup and execute ``start_x.sh`` or ``start_x.bat`` if using windows. You will need an X server, read the iic-osic-tools readme for instructions.

Inside the container you will see

~~~
/foss/
    designs/
        laygo2/
        laygo2_reduced_workspace/
        README.md
        start_x.bat
        start_x.sh
        ...
~~~

The mapping is

~~~
[Host]       /path/to/laygo2_iic
[Container] ~/foss/designs/<laygo2_repo_content>
~~~


### 2. Setting it along other tools and previous designs.

**THIS DON'T WORK, MAYBE IF CHANGED SOME .maginit PATHS AND laygo2_examples.**

This is for people who is already using ``iic-osic-tools`` with their ``~/eda/designs`` workspace.

Clone this repo into the working directory and run the container as usual.


Inside the container you will see

~~~
/foss/
    designs/
        laygo2_iic/
            laygo2/
            laygo2_reduced_workspace/
            README.md
            start_x.bat
            start_x.sh
            ...
~~~

The mapping is

~~~
[Host]      ~/eda/designs/laygo2_iic
[Container] ~/foss/designs/laygo2_iic
~~~


## Operating System Configuration

### Linux Users

1. Install Docker https://docs.docker.com/engine/install/ubuntu/

### Mac Users

1. Install Docker Desktop
2. Install XQuartz
    - XQuartz preference -> secure tap -> enable two options.


### Window Users

1. Install Docker Desktop
2. Install Vcxsvr
3. Start XLaunch with:
    - Multiple Windows
    - Display Number 0
    - Start no client
    - Clipboard + Primary Selection
    - Native OpenGL
    - Disable access control
4. Use Powershell, not cmd

## Repo Setup

Some configuration in the cloned repository is needed.

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
$ ./compile_tcl.sh laygo2_example/tinv_small_1x.py
$ ./compile_tcl.sh laygo2_example/dff.py
~~~


2. Compile the layouts with magic.

~~~

$ ./start_mag.sh
% source logic_generated_inv_2x.tcl
% exit

// OR

$ ./start_mag_console.sh logic_generated_inv_2x.tcl
% exit

~~~

## Troubleshoot

Windows and Linux has a subtle but annoying difference: The line termination.
Git internally uses the linux termination, if you are using windows the workspace files will use the windows format. When a commit is made, all the stagged files will translate into unix format before being stored into git's internal database.

The problem with this arise when using iic-osic-tools on windows and some bash scripts will raise this error:

~~~
-bash: ./start_x.sh: /bin/bash^M: bad interpreter: No such file or directory
~~~

The simple fix is changing the format with vim.

Note: ``<ESC>`` and ``<ENTER>`` means the keys, don't write them.

~~~
vim <file>
<ESC>:set ff=unix<ENTER>
<ESC>:wq<ENTER>
~~~


We are working in resolve this with local git configuration, and avoid file format modifications.

https://stackoverflow.com/questions/2517190/how-do-i-force-git-to-use-lf-instead-of-crlf-under-windows



## TODO list

### Remove start_mag.sh

It only exists because we need ``-rcfile .maginit`` as parameter to set the PATH to laygo2 microtemplates and generated logic.
If we update the path in some system ``.magicrc`` file, this script will become unnecesary.

Another problem that we had to consider: Decouple from sky130 technology.


### Add laygo2 as python package

Pip has an option to install packages from git, but we have never done it before.


### Remove some BAG environment variables

Why we have so many variables?
Which ones are necesary by laygo2?
Do we need bag support?

*If you can generate the layout withouth them, feel free to remove them for now*.
And they will, take it for sure.


### Bash can't run scripts.

In the troubleshoot is explained this problem and a workaround.


### Create an .fossrc file for user-supplied init script.

It is in /headless/.bashrc
We can add the following code

~~~
if [ -f /foss/designs/.fossrc ]; then
    . /foss/designs/.fossrc ]
fi
~~~

With this script, any user can customize his container.
This will serve as a roundabout until laygo2 is integrated into the container.


### Create an intermediate .magicrc file

We can have a file in ``/foss/tools/.magicrc`` or something like that, it will reference the pdk (not fixed to sky130).

