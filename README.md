# px4-raspi-docker
Docker files needed to build images for px4_sitl simulation in ROS2 and Gazebo

The `./work` directory setup 

run `./get_src.sh` to clone each repo
```
work/
┣ px4/
┣ ros2_ws/
┃ ┗ src/
┃   ┣ px4_msgs/
┃   ┣ px4-offboard/
┗ .gitignore
```
Please build ros_gz from source. [see ros-gz](https://github.com/gazebosim/ros_gz)


### Build and run
To build the image

`docker compose build`

To run multiple drones

`./run_dev.sh`

To access the shell of each service, in two different terminals run

Terminal 1: `docker exec -u user -it {NAME_OF_CONTAINER} bash`

To start px4_sitl and ros2 offboard control, split each terminator into 3 panels and run

////1. `cd px4 && make px4_sitl gazebo-classic` to build px4_sitl first. (This only need to be built once in one of the container shells)

////comment(`PX4_SYS_AUTOSTART=4001 PX4_GZ_MODEL=x500 ./build/px4_sitl_default/bin/px4 -i 1` to start px4_sitl instance 1 with x500 in gz-garden.)

2. `sudo MicroXRCEAgent serial --dev /dev/AMA0 -b 921600` to start DDS agent for communication with ROS2
NOTE; higher baud rate required for serial connection over TELEM port. AGENT Disconnects and reconnects over lower baud rate.
https://docs.px4.io/main/en/middleware/uxrce_dds.html


1. ssh vibsin@raspberrypi-vrs.local #*4 Terminals
2. cd ws/ROS2/raspi_docker/
3. ./run_dev.sh container starts
4. docker exec -u user -it raspi_docker-px4_gazebo-1 bash
5. export ROS_DOMAIN_ID=0 #if cannot see topics published from MicroXRCEDDS
5. sudo MicroXRCEAgent serial --dev /dev/serial0 -b 921600 #start agent
6. ros2 topic list
7. ros2 launch px4_offboard offboard_hardware_position_control.launch.py

### MAVLINK
https://forums.raspberrypi.com/viewtopic.php?t=244827
sudo dtoverlay uart4 additional UART on RASPI -- MAVLINK FORWORDING SIMULATNIOUSLY

sudo nano /boot/config.txt
in the config.txt in the last add
enable_uart=1
dtoverlay = disable-bt
dtoverlay=uart4,txd1_pin=7,rxd1_pin=29
raspi-gpio funcs
pinctrl funcs


comment(
### Environment Variables
- `PX4_GZ_MODEL` Name of the px4 vehicle model to spawn in gz
- `PX4_GZ_MODEL_POSE` Spawn pose of the vehicle model, must used with `PX4_GZ_MODEL`
- `PX4_MICRODDS_NS` Namespace assigned to the sitl vehicle, normally associated with px4 instances, but can be set mannually
- `ROS_DOMAIN_ID` Separate each container into its own domain (Is it still necessary since each SITL instance has a unique namespace?)
)
