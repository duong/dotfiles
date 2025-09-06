# Usage

## setup
❯ sudo pacman -Syu linux-headers
❯ sudo pacman -Syu v4l2loopback-dkms

## remove

❯  sudo modprobe -r v4l2loopback
[sudo] password for duong:

## Create a modprobe with v4l2loopback that can be detected by apps

❯ sudo modprobe v4l2loopback exclusive_caps=1 card_label="Virtual Webcam"

## Check the device number

❯ v4l2-ctl --list-devices                                                                                                    

Virtual Webcam (platform:v4l2loopback-000):
	/dev/video0

## Start the video using the same device number /dev/video0

scrcpy --video-source=camera --camera-size=1920x1080 --camera-facing=front --v4l2-sink=/dev/video0 --no-playback --no-audio
