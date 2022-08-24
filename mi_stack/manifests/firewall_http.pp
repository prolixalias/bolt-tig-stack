#

#
class mi::firewall_http {
  ferm::rule { 'allow_http':
    chain  => 'INPUT',
    action => 'ACCEPT',
    proto  => 'tcp',
    dport  => 80,
  }
}
