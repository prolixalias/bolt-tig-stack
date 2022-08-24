#

#
class mi::firewall_https {
  ferm::rule { 'allow_https':
    chain  => 'INPUT',
    action => 'ACCEPT',
    proto  => 'tcp',
    dport  => 443,
  }
}
