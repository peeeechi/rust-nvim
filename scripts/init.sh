#!/bin/bash -eu

# echo "create user --------------"
# /tmp/create-user.sh

echo -e "\nafter create user --------------"
/tmp/after-create-user.sh

COMMAND="$@"

echo -e "\nexec command: $COMMAND --------------\n"
# cd /home/${USER_NAME}
gosu $USER_NAME:$GROUP_NAME $COMMAND
