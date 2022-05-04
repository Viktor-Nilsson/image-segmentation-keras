from nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

RUN echo $DEBIAN_FRONTEND



RUN apt-get update;\
        apt-get install --no-install-recommends -y git python3 python3-pip python3-setuptools python3-wheel python3-pil python3-lxml python3-tk python3-dev protobuf-compiler curl unzip build-essential cmake unzip pkg-config libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libgtk-3-dev libatlas-base-dev gfortran libfreetype6 libharfbuzz0b;\
	apt-get autoremove -y ;\
        rm -rf /var/lib/apt/lists/*


RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg & install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN rm -f packages.microsoft.gpg

RUN     apt-get update;\
        apt-get install --no-install-recommends -y apt-transport-https code;\
	apt-get autoremove -y ;\
        rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip setuptools 
RUN pip3 install tensorflow-gpu==2.8.0 sklearn numpy opencv-python matplotlib pycocotools imgaug Keras==2.8.0

COPY . .
RUN pip3 install -r requirements.txt
RUN python3 setup.py install



# Install the coral compiler
#RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
#RUN apt-get update
#RUN apt-get install -y edgetpu-compiler
