# h2

Kotitehtävänä oli konfiguroida jokin palvelin package-file-service tyyliin ja julkaista se sen jälkeen githubissa.

Linkki Github repositoryyn: https://github.com/KmPentikainen/harj2

Tein tehtävän kotona pöytäkoneella käyttäen tehtävän tekemiseen Live USB:ta.

Lähteinä käytin Tero Karvisen kotisivuja (http://terokarvinen.com/2013/ssh-server-puppet-module-for-ubuntu-12-04) sekä Lauri Soivin kotisivuja (https://soivi.net/2013/installing-apache-and-php-with-puppet-module/)

# Aloitus

Aloitetaan päivityksillä:

sudo apt-get update

# Puppetin asennus ja modulin luonti:

Päätin asentaa ja konfiguroida apachen.

sudo apt-get install puppet

Luodaan etc/puppet/modules kansioon tarvittavat kansiot sekä tiedosto johon koodi kirjoitetaan:

mkdir apache

mkdir manifests

nano init.pp

Koodi asentaa apachen ja aktivoi userdirit käyttöön jos näin ei vielä ole. Service varmistaa että apache on käynnissä.

Otin moduulin käyttöön komennolla: puppet apply -e 'class {apache:}'

Tästä raportista löytyy hieman kattavampi versio myös osoitteesta kape601.wordpress.com


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

		
