#If you are using Ubuntu 16.10 or newer, then you can easily install Python 3.6 with the following commands:
sudo apt-get update
sudo apt-get install python3.6

#If you’re using another version of Ubuntu (e.g. the latest LTS release), we recommend using the deadsnakes PPA to install Python 3.6:
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6

#If you are using other Linux distribution, chances are you already have Python 3 pre-installed as well. 
#If not, use your distribution’s package manager. For example on Fedora, you would use dnf:
sudo dnf install python3

#install pip3
sudo apt install python3-pip

#verify
python3 --version

#To see if pip is installed, open a command prompt and run
command -v pip

#To install pip, follow the official pip installation guide - this will automatically install the latest version of setuptools.
#Note that on some Linux distributions including Ubuntu and Fedora the pip command is meant for Python 2, 
#while the pip3 command is meant for Python 3.
command -v pip3

#However, when using virtual environments (described below), you don’t need to care about that.

###################################
############ FOR DEBIAN ##########
###################################

sudo apt update

pip3 --version

sudo apt install python3-pip

