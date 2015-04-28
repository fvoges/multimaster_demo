class profiles::puppet::lb {
  include haproxy
  haproxy::listen { 'puppet00':
    ipaddress => $::ipaddress,
    ports     => '8140',
    mode      => 'tcp',
    options   => {
      'option'  => [
        'tcplog',
        'ssl-hello-chk',
        ],
        'balance' => 'roundrobin',
    },
  }
}
