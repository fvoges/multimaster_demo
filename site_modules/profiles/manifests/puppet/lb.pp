class profiles::puppet::lb {
  include haproxy
  haproxy::listen { 'puppet00':
    ipaddress => $::ipaddress,
    ports     => '8140',
    mode      => 'tcp',
    options   => {
      'option'  => [
        'tcplog',
        #'ssl-hello-chk',
        ],
        'balance' => 'roundrobin',
    },
  }

  haproxy::listen { 'stats':
    ipaddress => $::ipaddress,
    ports     => '9090',
    options   => {
      'mode'  => 'http',
      'stats' => ['uri /', 'auth admin:puppet']
    },
  }

}
