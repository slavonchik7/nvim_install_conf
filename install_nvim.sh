


STD_ERR_OUT_FREE=1> /dev/null 2>&1


NVIM_CONF_PATH=/home/$SUDO_USER/.config
NVIM_CONF_FILE_NAME=init.vim

UID_ROOT=0
E_NOTROOT=67

## checking the user permissions 
if [ "$UID" -ne "$UID_ROOT" ]
then
	echo "Permission denied"
	echo "Failed install"
	exit $E_NOTROOT
fi



###
## checking the network connection ##

STATUS=$(ping 8.8.8.8 -c 1 -w 1 | grep "1 received")

if [ -z "$STATUS" ]
then
	echo "No internet connection"
	exit 0
fi

###




# update all packets
echo "Updating packages..."
apt update
echo "succeeced!"




###
## checking the wget util ##

WGET_DEFAULT_PATH=/usr/bin/wget
echo "Checking the wget utility..."
if [ ! -e  "$WGET_DEFAULT_PATH" ]
then
	echo "Directory $WGET_DEFAULT_PATH was not found"
	echo "Installing unzip..."
	apt install wget -y #$STD_ERR_OUT_FREE
	echo "Installed successfully!"
else 
	echo "Utility found!"
fi

###





###
## checking the unzip util ##

UNZIP_DEFAULT_PATH=/usr/bin/unzip
echo "Checking the unzip utility..."
if [ ! -e  "$UNZIP_DEFAULT_PATH" ]
then
	echo "Directory $UNZIP_DEFAULT_PATH was not found"
	echo "Installing unzip..."
	apt install unzip -y #$STD_ERR_OUT_FREE
	echo "Installed successfully!"
else 
	echo "Utility found!"
fi
###










# flags for notification of installed packages

TTF_ANCIENT_FONTS_INSTALLED=0
CLANG_12_INSTALLED=0
NPM_INSTALLED=0
N_NPM_INSTALLED=0
EXUBERANT_CTAGS_INSTALLED=0
FONTS_POWERLINE_INSTALLED=0
NVIM_INSTALLED=0
INSTALLED=0
INSTALLED=0
GIT_INSTALLED=0





# install neovim

NVIM_DEFAULT_APT_PATH=/usr/bin/nvim
NVIM_DEFAULT_SNAP_PATH=/snap/bin/nvim

echo "Checking the nvim utility..."
if [ ! -e  "$NVIM_DEFAULT_APT_PATH" ] || [ ! -e "$NVIM_DEFAULT_SNAP_PATH" ]
then
	echo "Directory "$NVIM_DEFAULT_APT_PATH" or "$NVIM_DEFAULT_SNAP_PATH" was not found"
	echo "Installing neovim 0.7.0..."
	NVIM_INSTALLED=1
	snap install nvim --classic 
	echo "Installed successfully!"
else
	echo "Utility found!"
fi



CURL_DEFAULT_PATH=/usr/bin/curl
echo "Checking the curl utility..."
if [ ! -e  "$NVIM_DEFAULT_APT_PATH" ]
then
	echo "Directory "$NVIM_DEFAULT_APT_PATH" was not found"
	echo "Installing curl..."
	NVIM_INSTALLED=1
	apt install curl -y 
	echo "Installed successfully!"
else
	echo "Utility found!"
fi




# install git fot installing plugs from repos

GIT_DEFAULT_PATH=/usr/bin/git
echo "Checking the git utility..."
if [ ! -e  "$GIT_DEFAULT_PATH" ]
then
	echo "Directory $GIT_DEFAULT_PATH was not found"
	echo "Installing git..."
	GIT_INSTALLED=1
	snap install git -y
	echo "Installed successfully!"
else
	echo "Utility found!"
fi



# creat and copy config file to him save directory

echo "Make nvim config dir..."

if [ ! -e "$NVIM_CONF_PATH" ]
then
mkdir "$NVIM_CONF_PATH"
fi

if [ ! -e "$NVIM_CONF_PATH"/nvim ]
then
mkdir "$NVIM_CONF_PATH"/nvim
fi

cp "$NVIM_CONF_FILE_NAME" "$NVIM_CONF_PATH"/nvim/
echo "$NVIM_CONF_FILE_NAME" "$NVIM_CONF_PATH"/nvim/
chmod -R ugo+rwx "$NVIM_CONF_PATH"
chown -hR $SUDO_USER "$NVIM_CONF_PATH"

echo "Succeeced!"




# install and NERD font HACK for NERDTree icons
./install_fonts.sh
echo "Installed successfully!"



# install vim-plug util fot installing other plugins
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
echo "Installed successfully!"




# install server clangd
echo "Installing server clangd (clangd-12)..."
CLANG_12_INSTALLED=1
apt install clangd-12 -y 
echo "Installed successfully!"



# init server clangd
echo "Initing server clangd..."
update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100 






#  install depends for coc-clangd
echo "Installing depends for coc-clangd..."



echo "Installing npm..."
NPM_INSTALLED=1
apt install npm -y 

echo "Installing nodejs..."
N_NPM_INSTALLED=1
npm install -g n 

echo "Configurating nodejs..."
n stable 

curl -sL install-node.vercel.app/lts | bash



# CTAGS for tagbar
echo "Installing CTAGS for tagbar..."
EXUBERANT_CTAGS_INSTALLED=1
apt install exuberant-ctags -y 






# install depends for air-line
echo "|--- install depends for air-line ---|"

echo "|--- install ttf-ancient-fonts ---|"
TTF_ANCIENT_FONTS_INSTALLED=1
apt install ttf-ancient-fonts -y 

FONTS_POWERLINE_INSTALLED=1
echo "|--- install fonts-powerline ---|"
apt install fonts-powerline -y 







#deleting all auxiliary folders and files

