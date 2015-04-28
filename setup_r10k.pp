
$remote          = 'https://github.com/fvoges/multimaster_demo.git'
$environmentpath = '/etc/puppetlabs/puppet/environments'

class { '::r10k':
  version => '1.5.1',
  sources => {
    'puppet' => {
      'remote'  => $remote,
      'basedir' => $environmentpath,
      'prefix'  => false,
    }
  },
}

exec {'r10k deploy environment -p':
  creates => "${environmentpath}/production/Puppetfile",
  command => '/opt/puppet/bin/r10k deploy environment -p',
  require => Class['r10k'],
}

file { "${::settings::confdir}/hiera.yaml":
  ensure => link,
  target => "${environmentpath}/production/hiera.yaml",
  notify => Service['pe-puppetserver'],
}

service { 'pe-puppetserver': }

