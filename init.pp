class apache {
	package {"apache2":
	ensure => "installed" ,
	allowcdrom => "true" ,
	}

	service {"apache2":
	 ensure => "running" ,
	 enable => "true" ,
	 require => Package ["apache2"] ,
	}

	file {'/etc/apache2/mods-enabled/userdir.load':
	ensure => "link",
	target => "etc/apache2/mods-available/userdir.load" ,
	notify =>  Service ["apache2"] ,
	require => Package ["apache2"] ,
	}

	file {'/etc/apache2/mods-enabled/userdir.cong':
	ensure => "link" ,
	target => "etc/apache2/mods-available/userdir.conf",
	notify => Service["apache2"] ,
	require => Package["apache2"] ,
	}
		
}

		
