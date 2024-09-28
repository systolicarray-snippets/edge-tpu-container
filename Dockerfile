FROM debian:bullseye-20240926

#SHELL ["/bin/bash", "-c"]

# Update and install necessary packages
RUN apt-get update && \
    apt-get install --no-install-recommends -yq software-properties-common curl git python3.9 \
    python3-venv python3-pip gnupg wget apt-utils vim libzip-dev unzip fzf 

# Add Google's Coral EdgeTPU repository and key using best practices
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor > /usr/share/keyrings/coral-edgetpu-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/coral-edgetpu-archive-keyring.gpg] https://packages.cloud.google.com/apt coral-edgetpu-stable main" \
    | tee /etc/apt/sources.list.d/coral-edgetpu.list > /dev/null

# Update again and install EdgeTPU-related packages
RUN apt-get update && \
    apt-get install -yq libedgetpu1-std python3-pycoral

# Create directory for Coral and clone pycoral repository
RUN mkdir coral && \
    cd coral && \
    git clone https://github.com/google-coral/pycoral.git && \
    cd pycoral

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt

WORKDIR /coral/pycoral

COPY hello_world.ipynb /coral/pycoral/

# Command to run when the container starts
CMD ["/bin/bash"]

