# Current Status:

- OSkeystone.yml & MariaDB.yml: Problems with user/password.
Sometimes works, sometimes doesn't.
Main issue: root default user starts with no password. If it's changed
(It is), idempotency has to be ensured. Something fails over there.

# Status: Environment

## Networking
- Write less hardcoded plays and templates

## NTP
- Conditionals used inside the template to separate controller/compute

## OpenStack Packages
- Fixed non working repository

## mariadb
- controller role created.
- MariaDB installed in controller machine

## RabbitMQ
- Create user acount: Checks in user_list. If the user is there, don't create
- Password: Ansible-vault can encript files... Currently vagrant password

## Memcached
- __CHECK__: Only Controller node?

# Status: OpenStack
To be done...
