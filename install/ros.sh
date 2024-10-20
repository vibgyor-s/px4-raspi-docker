#!/bin/bash
set -e
set -x

ROS_VERSION="noetic"

# sudo curl -y 1 -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -


sudo apt-get -y update
sudo apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	ros-${ROS_DISTRO}-mavros \
	ros-${ROS_DISTRO}-mavros-extras \
	ros-${ROS_DISTRO}-mavros-msgs \
	python3-rosdep \
	libgflags-dev \
	libgstreamer-plugins-base1.0-dev \
	gstreamer1.0-plugins-base \
	gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	libopencv-dev \
	libeigen3-dev \
	libimage-exiftool-perl \
	libxml2-utils \
	pkg-config \
	protobuf-compiler \
	python3-rosinstall \
	python3-rosinstall-generator \
	python3-wstool	


#Too big
# ros-${ROS_VERSION}-desktop \
#APT INSTALL 22.04?
#gazebo \
#libgazebo11\
#libgazebo-dev \
