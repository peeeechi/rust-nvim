#!/bin/bash -eu

dirs=(.rustup .cargo .bashrc)

for dir in ${dirs[@]}; do
    echo -e "copy /root/${dir} ...\n"
    cp -r /root/${dir} /home/${USER_NAME} \
        && chmod -R 774 /home/${USER_NAME}/${dir} \
        && chown -R ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}/${dir}
done

# echo "source /home/${USER_NAME}/.cargo/env" >> /home/${USER_NAME}/.bashrc
# cd /home/${USER_NAME}/ws

chown -R ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}
