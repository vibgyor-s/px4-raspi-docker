#!/bin/bash
set -e
set -x

sudo DEBIAN_FRONTEND=noninteractive  apt-get install --no-install-recommends -y \
	ipe \
	iproute2 \
	lcov \
	menu \
	mesa-utils \
	openbox \
	python3-jinja2 \
	python3-numpy \
	python3-vcstool \
	python3-xdg \
	python3-xmltodict \
	qt5dxcb-plugin \
	terminator \
	vim \

	

sudo pip install pykwalify
sudo wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
#chmod +x install_geographiclib_datasets.sh
sudo bash install_geographiclib_datasets.sh && sudo rm install_geographiclib_datasets.sh
