#!/bin/sh

set -ex

. entrypoint-common.sh

entrypoint-hooks.sh

migrate_uid asterisk "$ASTERISK_USER_UID"
migrate_gid asterisk "$ASTERISK_GROUP_GID"

entrypoint-post-hooks.sh

exec "$@"
