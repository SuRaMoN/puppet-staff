define staff::member (
	$email = undef,
	$uid = undef,
	$password = '*',
	$groups = undef,
	$ensure = present,
	$ssh_key = undef,
	$mysql_password = undef,
	$authorize_ssh_to_users = [],
	$enable_mysql_user = false,
) {

	$username = $title

	user { $username:
		ensure => $ensure,
		comment => $email,
		home => "/home/$username",
		managehome => true,
		shell => "/bin/bash",
		uid => $uid,
		password => $password,
		groups => $groups,
	} ->
	group { $username:
		gid => $uid,
		ensure => $ensure,
	} ->
	ssh_authorized_key { "${username}_${username}":
		ensure  => $ensure,
		key     => $ssh_key,
		type    => 'ssh-rsa',
		user    => $username,
	}

	$authorize_ssh_to_users.each |$authorize_ssh_user| {
		ssh_authorized_key { "${authorize_ssh_user}_${username}":
			ensure  => $ensure,
			key     => $ssh_key,
			type    => 'ssh-rsa',
			user    => $authorize_ssh_user,
			require => User[$authorize_ssh_user]
		}
	}

	if $enable_mysql_user {
		mysql_user { "${username}@%":
			ensure => $ensure,
			password_hash => $mysql_password,
			require => Class['credico::mysqld'],
		}
		if $ensure == present {
			mysql_grant { "${username}@%/*.*":
				user => "${username}@%",
				privileges => ['ALL'],
				table => '*.*',
				require => Mysql_user["${username}@%"],
			}
		}
	}
}

