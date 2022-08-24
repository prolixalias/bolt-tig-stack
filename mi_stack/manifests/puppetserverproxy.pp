#

#
class mi::puppetserverproxy {
  class { 'foreman_proxy':
    puppet           => true,
    puppetca         => true,
    tftp             => false,
    dhcp             => false,
    dns              => false,
    bmc              => false,
    realm            => false,
    foreman_base_url => "https://${facts['networking']['fqdn']}",
    trusted_hosts    => ['puppet', $facts['networking']['fqdn']],
  }
}
