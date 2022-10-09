





###
## checking the wget util ##

WGET_DEFAULT_PATH=/usr/bin/wget

if [ ! -e  "$WGET_DEFAULT_PATH" ]
then
	echo "Directory $WGET_DEFAULT_PATH was not found"
	echo "You need install wget \"sudo apt install wget -y\""
	exit $ERR_ENOTDIR
fi

###




###
## checking the unzip util ##

UNZIP_DEFAULT_PATH=/usr/bin/unzip

if [ ! -e  "$UNZIP_DEFAULT_PATH" ]
then
	echo "Directory $UNZIP_DEFAULT_PATH was not found"
	echo "You need install unzip \"sudo apt install unzip -y\""
	exit $ERR_ENOTDIR
fi

###




###
## checking the network connection ##

STATUS=`ping 8.8.8.8 -c 1 -w 1 | grep "1 received"`

if [ "$STATUS" == "" ]
then
	echo "No internet connection"
	exit 0
fi

###



# update all packets
apt update



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



# install neovim
NVIM_INSTALLED=1
apt install neovim -y


# install and set NERD fonts for NERDTree icons



# for new fonts
#sudo apt install ttf-ancient-fonts -y




#install server clangd
echo "|--- installing install server clangd (clangd-12) ---|"
CLANG_12_INSTALLED=1
apt install clangd-12 -y




# init server clangd
echo "|--- init server clangd ---|"
update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100






#  install depends for coc-clangd
echo "|--- install depends for coc-clangd ---|"

echo "|--- install npm ---|"

NPM_INSTALLED=1
apt install npm -y

N_NPM_INSTALLED=1
npm install -g n

n stable





# CTAGS for tagbar
echo "|--- install CTAGS for tagbar ---|"
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

function remove_all() {

	if []

}