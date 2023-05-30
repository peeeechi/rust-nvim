#!/bin/bash -eu

#create user
echo "USER_NAME: ${USER_NAME}"
echo "GROUP_NAME: ${GROUP_NAME}"
echo "UID: ${UID}"
echo "GID: ${GID}"

groupadd -g ${GID} ${GROUP_NAME}
useradd -s /bin/bash -u ${UID} -g ${GID} ${USER_NAME}
# echo "${USER_NAME}:${USER_NAME}" | chpasswd

if [ ! -d /home/${USER_NAME}/ws ]; then
    mkdir -p /home/${USER_NAME}/ws
fi

chown -R ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}
chmod 774 -R /home/${USER_NAME}/ws
