#!/bin/bash

if [ ! -d "/usr/local/Cellar/glfw" ]
then
	echo "glfw is not found, installing via brew..."
	if ! brew -v &> /dev/null
	then
	echo "brew is not foud, installing..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	brew install glfw &> /dev/null
fi

if [ $# -eq 0 ]
then
	echo "You should specify filename!"
	exit
fi

echo "Creating project directory" \"$1\"
mkdir $1

cd $1

LOCATION=$(curl -s https://api.github.com/repos/ocornut/imgui/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/ocornut/imgui/archive/refs/tags/" substr($2, 2, length($2)-3) ".zip"}') \
;
#echo $LOCATION
curl -L -o imgui.zip $LOCATION

unzip imgui.zip

rm imgui.zip

git clone https://github.com/AlexChecker/Imgui-project-creator.git
mv Imgui-project-creator/Makefile ./Makefile
mv Imgui-project-creator/main.cpp ./main.cpp
echo -e "\033[1;31m Warning! Change version number of ImGui in your makefile to downloaded version! \033[0m"
