class profiles::puppet::r10k {
  $control_repo    = hiera('profiles::puppet::r10k::control_repo')
  $environmentpath = hiera('profiles::puppet::r10k::environmentpath', "${::settings::confdir}/environments")

  validate_string($control_repo)
  validate_absolute_path($environmentpath)

  class { '::r10k':
    version => '1.5.1',
    sources => {
      'puppet' => {
        'remote'  => $control_repo,
        'basedir' => $environmentpath,
        'prefix'  => false,
      }
    },
  }

  exec {'r10k deploy environment -p':
    creates => "${environmentpath}/production/Puppetfile",
    command => '/opt/puppet/bin/r10k deploy environment -p',
    require => Class['::r10k'],
  }

  file { "${::settings::confdir}/hiera.yaml":
    ensure => link,
    target => "${environmentpath}/production/hiera.yaml",
    notify => Service['pe-puppetserver'],
  }

  include ::r10k::mcollective
  class { '::r10k::webhook::config':
    certname         => $certname,
    enable_ssl       => false,
    protected        => false,
  }

  class {'::r10k::webhook':
    require => Class['r10k::webhook::config'],
  }
}