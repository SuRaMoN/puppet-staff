# Puppet staff module

Simple hiera-configurable module to add staff (devs/admins) to your system. It provides you wit a single place to configure all your staff settings (mysql access, ssh access, groups).


## Usage example
First you should include the staff class:

    include staff


Afterwards you can configure it through hiera.

### Current members

The current members variable is a puppet hash with all the current members. None op the parameters (like email/password) are required. It translates to a staff::member. Example hiera usage:

    staff::current_members:
      john:
        email: 'john@company'
        password: 'hash from /etc/shadow'
        mysql_password: 'hash from mysql.user'
        groups: ['admin', 'developer']
        ssh_key: 'ssh key from (usally) ~/.ssh/id_rsa.pub'

### Former members

When a staff member leaves your company you want to delete the user from your system. This can be done with the former_members parameter:

    staff::former_members: ['john']

### Ssh authorizing staff to extra users

Sometimes your staff needs ssh access to some users (eg root for admins, or application users). This can be done using the authorize_ssh_to_users parameter:

    staff::authorize_ssh_to_users: ['root']


### Enable mysql access

If you want the staff to have mysql access you can configure it as below:

    staff::enable_mysql_user: true
