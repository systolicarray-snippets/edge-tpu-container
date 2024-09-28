#!/bin/bash

# Run Docker container with USB device
docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb edgetpudev:latest /bin/bash

