class profiles::puppet::master {
  @@haproxy::balancermember { $::fqdn:
    listening_service => 'puppet00',
    ports             => '8140',
    server_names      => $::hostname,
    ipaddresses       => $::ipaddress,
    options           => 'check',
  }
}
