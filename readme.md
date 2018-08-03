# Current Status:

- Pending: Stop using _command_ or _shell_: They do not ensure idempotency


# Status: Environment

## Networking
- Write less hardcoded plays and templates

## NTP
- Conditionals used inside the template to separate controller/compute

## OpenStack Packages
- Fixed non working repository

## mariadb
- MariaDB installed in controller machine
- root users: Password modified (vagrant)

## RabbitMQ
- Create user acount: Checks in user_list. If the user is there, don't create
- Password: Ansible-vault can encript files... Currently vagrant password

## Memcached
- __CHECK__: Only Controller node?

# Status: OpenStack
To be done...
