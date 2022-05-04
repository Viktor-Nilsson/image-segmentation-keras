XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH

xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it --rm \
--gpus all \
-u $(id -u):$(id -g) \
-v /etc/passwd:/etc/passwd:ro \
-v /etc/group:/etc/group:ro \
-v /etc/sudoers:/etc/sudoers:ro \
-v /etc/sudoers.d/admins:/etc/sudoers.d/admins:ro \
-v /dev/bus/usb:/dev/bus/usb \
-v $XSOCK:$XSOCK:ro \
-v $XAUTH:$XAUTH \
-e LOGNAME=$USER \
-e DISPLAY=$DISPLAY \
-e LANG=C.UTF-8 \
-e XAUTHORITY=$XAUTH \
-e QT_X11_NO_MITSHM=1 \
-t \
--network=host \
-e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
-v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
--env SIB_MODEL_STORE=/home/viktor/temp/models \
--env SIB_DATASET_STORE=/home/viktor/temp/dataset \
--env PYTHONPATH=/app \
-v /home/${USER}/dev:/home/${USER}/dev \
-v /home/${USER}/datasets:/home/${USER}/datasets \
-v /home/${USER}/ml:/home/${USER}/ml \
-v /home/${USER}/sib_models:/app/sib_models \
-v /home/${USER}/temp/:/home/${USER}/temp \
-v /home/${USER}/temp/:/home/${USER}/temp \
-v /mnt/data1/DATASETS:/mnt/data1/DATASETS \
-v /mnt/data1/MODELS:/mnt/data1/MODELS \
-e HOME=$HOME \
-e USER=$USER \
cud114py38tf2.4.1:latest \


