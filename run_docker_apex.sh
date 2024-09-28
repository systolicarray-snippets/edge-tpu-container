#!/bin/bash

# Run Docker container with APEX device
docker run -it --rm --device /dev/apex_0:/dev/apex_0 edgetpudev:latest /bin/bash
