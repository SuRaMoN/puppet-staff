class staff::members (
	$current_members = {},
	$former_members = [],
	$authorize_ssh_to_users = [],
	$enable_mysql_user = false,
) {
	create_resources(staff::member, $current_members, {
		authorize_ssh_to_users => $authorize_ssh_to_users,
		enable_mysql_user => $enable_mysql_user,
	})

	staff::member { $former_members:
		ensure => 'absent',
		authorize_ssh_to_users => $authorize_ssh_to_users,
		enable_mysql_user => $enable_mysql_user,
	}
}
