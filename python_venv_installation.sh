#################################
# ON MAC-OSX
#################################

#source: https://docs.python-guide.org/starting/install3/osx/
#source: https://docs.python-guide.org/dev/virtualenvs/#virtualenvironments-ref

#NOTE: 
#If you already have Xcode installed, do not install OSX-GCC-Installer. In combination, the software can cause issues that are difficult to diagnose.
#If you perform a fresh install of Xcode, you will also need to add the commandline tools by running xcode-select --install on the terminal.

#install Homebrew as package manager
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
#If you have OS X 10.12 (Sierra) or older use this line instead
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#install python 3 (Homebrew installs pip pointing to the Homebrew’d Python 3 for you.)
brew install python

#At this point, you have 
#1.the system Python 2.7 available, 
#2.potentially the Homebrew version of Python 2 installed, and 
#3.the Homebrew version of Python 3 as well.

# to launch the default python installed on MAC OSX, forcing linking it to the brew python 3
brew link --overwrite python
python

# to launch the Homebrew-installed Python 2 interpreter (if any).
$ python2

# to launch the Homebrew-installed Python 3 interpreter.
$ python3

# If the Homebrew version of Python 2 is installed then pip2 will point to Python 2. 
# If the Homebrew version of Python 3 is installed then pip will point to Python 3.

# Do I have a Python 3 installed?
$ python --version
# >>> Python 3.7.1 # Success!

#######################################################
####### Pipenv & Virtual Environments ####### 

#The next step is to install Pipenv, so you can install dependencies and manage virtual environments.
#A Virtual Environment is a tool to keep the dependencies required by different projects in separate places, by creating virtual Python environments for them. It solves the "Project X depends on version 1.x but, Project Y needs 4.x" dilemma, and keeps your global site-packages directory clean and manageable.
#For example, you can work on a project which requires Django 1.10 while also maintaining a project which requires Django 1.8.

pip --version

#Pipenv is a dependency manager for Python projects. If you’re familiar with Node.js’ npm or Ruby’s bundler, it is similar in spirit to those tools. While pip can install Python packages, Pipenv is recommended as it’s a higher-level tool that simplifies dependency management for common use cases.
pip install --user pipenv

#This does a user installation to prevent breaking any system-wide packages. If pipenv isn’t available in your shell after installation, you’ll need to add the user base’s binary directory to your PATH.
#On Linux and macOS you can find the user base binary directory by running python -m site --user-base and adding bin to the end. For example, this will typically print ~/.local (with ~ expanded to the absolute path to your home directory) so you’ll need to add ~/.local/bin to your PATH. You can set your PATH permanently by modifying ~/.profile.
#On Windows you can find the user base binary directory by running py -m site --user-site and replacing site-packages with Scripts. For example, this could return C:\Users\Username\AppData\Roaming\Python36\site-packages so you would need to set your PATH to include C:\Users\Username\AppData\Roaming\Python36\Scripts. You can set your user PATH permanently in the Control Panel. You may need to log out for the PATH changes to take effect.

#Pipenv manages dependencies on a per-project basis. To install packages, change into your project’s directory (or just an empty directory for this tutorial) and run:
cd myproject
pipenv install requests
echo \
'import requests \
response = requests.get('https://httpbin.org/ip') \
print('Your IP is {0}'.format(response.json()['origin']))' > main.py

#Using $ pipenv run ensures that your installed packages are available to your script. It's also possible to spawn a new shell that ensures all commands have access to your installed packages with $ pipenv shell.
pipenv run python main.py
#>>>>> Your IP is 8.8.8.8

#######################################################
####### Lower level: virtualenv ####### 

#virtualenv is a tool to create isolated Python environments. 
#virtualenv creates a folder which contains all the necessary executables to use the packages that a Python project would need.
#It can be used standalone, in place of Pipenv.
pip install virtualenv
virtualenv --version

#1. Create a virtual environment for a project:
cd my_project_folder
#virtualenv venv will create a folder in the current directory which will contain 
#- the Python executable files
#- a copy of the pip library which you can use to install other packages. 
#The name of the virtual environment (in this case, it was venv) can be anything; omitting the name will place the files in the current directory instead.
#NOTE: "venv" is the general convention used globally. As it is readily available in ignore files (eg: .gitignore)
virtualenv venv

#to use python 2.7
virtualenv -p /usr/bin/python2.7 venv
#OR 
echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7' >> ~/.bashrc

#2. To begin using the virtual environment, it needs to be activated:
source venv/bin/activate

#The name of the current virtual environment will now appear on the left of the prompt 
#(e.g. (venv)Your-Computer:your_project UserName$) to let you know that it’s active. 
#From now on, any package that you install using pip will be placed in the venv folder, isolated from the global Python installation.
pip install requests

#3. If you are done working in the virtual environment for the moment, you can deactivate it:
deactivate

#This puts you back to the system’s default Python interpreter with all its installed libraries.
#To delete a virtual environment, just delete its folder. (In this case, it would be rm -rf my_project.)
#After a while, though, you might end up with a lot of virtual environments littered across your system, and it’s possible you’ll forget their names or where they were placed.
#Python has included venv module from version 3.3. For more details: venv.

#######################################################
#Running virtualenv with the option --no-site-packages will not include the packages that are installed globally. This can be useful for keeping the package list clean in case it needs to be accessed later. [This is the default behavior for virtualenv 1.7 and later.]
virtualenv --no-site-packages venv

#######################################################
#In order to keep your environment consistent, it’s a good idea to “freeze” the current state of the environment packages. 
pip freeze > requirements.txt

#This will create a requirements.txt file, which contains a simple list of all the packages in the current environment, and their respective versions. 
#You can see the list of installed packages without the requirements format using pip list. Later it will be easier for a different developer (or you, if you need to re-create the environment) to install the same packages using the same versions:
pip install -r requirements.txt

#######################################################
# virtualenvwrapper
# BEGIN WARNING !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# virtualenv lets you create many different Python environments. 
# You should only ever install virtualenv and virtualenvwrapper on your base Python installation 
# (i.e. NOT while a virtualenv is active) so that the same release is shared by all Python environments that depend on it.
# END WARNING   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# virtualenvwrapper provides a set of commands which makes working with virtual environments much more pleasant. It also places all your virtual environments in one place.
# To install (make sure virtualenv is already installed):
pip install virtualenvwrapper
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh

#1. Create a virtual environment: (This creates the my_project folder inside ~/Envs)
mkvirtualenv my_project
#2. Work on a virtual environment:
workon my_project

#1+2. Alternatively, you can make a project, which creates the virtual environment, and also a project directory inside $WORKON_HOME, which is cd-ed into when you workon myproject.
mkproject myproject

#3. Deactivating is still the same:
deactivate

#4. Delete the env
rmvirtualenv venv

# More commands
https://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html



