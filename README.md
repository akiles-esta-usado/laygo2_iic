# Reduced Laygo2 Workspace

DEPRECATED.
Use this instead.

https://gitlab.com/mosaic_group/mosaic_os/laygo2_iic

---

The idea of this repo is to have the minimum requirements to run laygo2 with sky130 support inside the iic-osic-tools docker container.


## Usage and Configuration

### 1. Using container initialization scripts kept in this repo

This is for people that only want to use laygo2 without previous work.


#### Repo configuration

Clone the repo anywhere.
Laygo2 is a submodule of the repo, so we have to bring it.

~~~
$ git submodule init
$ git submodule update
~~~


#### Usage

Execute ``start_x.sh`` (Unix/Mac) or ``start_x.bat`` (Windows).
You will need an X server, read the iic-osic-tools readme for instructions.


#### Directory Structure

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


### 2. Using other container initialization scripts

This is for people who is already using ``iic-osic-tools`` container with a mapped directory.


#### Repo configuration

Clone the repo in the directory.
Laygo2 is a submodule of the repo, so we have to bring it.

~~~
$ git submodule init
$ git submodule update
~~~


#### Modify paths

Inside a container terminal, go to ``laygo2_iic/laygo2_reduced_workspace/`` and run

~~~
$ ./route_modifier.sh
~~~

Thit script modifies paths in:

- .maginit
- compile_tcl.sh
- laygo2_example/paths.py

The "sky130.magicrc" path shoudn't have changed, since is based in "iic-osic-tools", but if that's the case, see item 3.


#### Run container

Everything should work in the same way.


#### Directory Structure

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


### 3. Using laygo2 and the workspace without a container.

This is for people who has magic and openpdk installed on their systems, or in a linux vm, or wsl with an X server, you name it.


#### Repo configuration

Clone the repo anywhere.
Laygo2 is a submodule of the repo, so we have to bring it.

~~~
$ git submodule init
$ git submodule update
~~~


#### Modify Paths

**UNTIL NOW, THIS IS NOT SUPPORTED, you had to replace the path in .maginit manually**

First, you have to find the file "sky130.magicrc". Then go to ``laygo2_iic/laygo2_reduced_workspace/`` and run

~~~bash
$ ./route_modifier.sh /path/to/sky130A.magicrc
~~~

Thit script modifies paths in:

- .maginit
- compile_tcl.sh
- laygo2_example/paths.py


## Operating System Configuration

Basically, you need to have docker and a X11 server.

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



### Decouple sky130_microtemplates from workspace

Maybe we should save that templates into another repo, and when we download them when is required.

