#!/bin/bash
set -o errexit -o nounset
TOP_DIR=$(cd "$(dirname "$0")/.." && pwd)
source "$TOP_DIR/config/localrc"
source "$TOP_DIR/config/paths"
source "$CONFIG_DIR/localrc"
source "$CONFIG_DIR/deploy.osbash"
source "$CONFIG_DIR/openstack"
source "$OSBASH_LIB_DIR/functions-host.sh"
source "$OSBASH_LIB_DIR/$PROVIDER-functions.sh"

if [ $# -eq 0 ]; then
    echo "Purpose: Copy one script to target node and execute it via ssh."
    echo "Usage: $0 <script>"
    exit 1
fi

SCRIPT_SRC=$1

if [ ! -f "$SCRIPT_SRC" ]; then
    echo "File not found: $SCRIPT_SRC"
    exit 1
fi
SCRIPT=$(basename "$SCRIPT_SRC")

# Set VM_SSH_PORT (and wait for node sshd to respond)
ssh_env_for_node controller
wait_for_ssh "$VM_SSH_PORT"

function get_remote_top_dir {
    if vm_ssh "$VM_SSH_PORT" "test -d /osbash"; then
        # The installation uses a VirtualBox shared folder.
        local remote_top_dir=/osbash
        echo >&2 -n "Waiting for shared folder."
        # Just to be on the safe side -- the shared folder should be there
        # before ssh comes up.
        until vm_ssh "$VM_SSH_PORT" "test -e $remote_top_dir/lib"; do
            sleep 1
            echo >&2 -n .
        done
        echo >&2
        echo $remote_top_dir
    else
        # Copy and execute the script with scp/ssh.
        echo /home/osbash
    fi
}

REMOTE_TOP_DIR=$(get_remote_top_dir)

EXE_DIR_NAME=test_tmp
mkdir -p "$TOP_DIR/$EXE_DIR_NAME"
cp -f "$SCRIPT_SRC" "$TOP_DIR/$EXE_DIR_NAME"

if [[ "$REMOTE_TOP_DIR" = "/home/osbash" ]]; then
    # Not using a shared folder, we need to scp the script to the target node
    vm_scp_to_vm "$VM_SSH_PORT" "$TOP_DIR/$EXE_DIR_NAME/$SCRIPT"
    # The script may need access to extra files in the scripts directory, so
    # copy that over.
    vm_scp_to_vm "$VM_SSH_PORT" "$TOP_DIR/scripts"
fi

vm_ssh "$VM_SSH_PORT" "bash -c $REMOTE_TOP_DIR/$EXE_DIR_NAME/$SCRIPT" || \
    rc=$?
echo "$SCRIPT returned status: ${rc:-0}"
exit ${rc:-0}
