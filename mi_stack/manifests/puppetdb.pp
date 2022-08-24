#

#
class mi::puppetdb {
  # package { 'pgdg-redhat-repo':
  #   ensure   => absent,
  #   source   => 'https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm',
  #   provider => 'rpm',
  #   before   => Class['puppetdb'],
  # }

  class { 'puppetdb':
  #   # java_args              => {
  #   #   '-Xmx' => '8192m',
  #   #   '-Xms' => '2048m',
  #   #      },
    node_ttl                => '14d',
    node_purge_ttl          => '14d',
    report_ttl              => '999d',
    manage_firewall         => false,
    manage_package_repo     => true,
    manage_dbserver         => true,
    postgres_version        => '10',
    ssl_set_cert_paths      => true,
    disable_update_checking => true,
    ssl_key                 => "/etc/puppetlabs/puppet/ssl/private_keys/${facts['networking']['fqdn']}.pem",
    ssl_cert                => "/etc/puppetlabs/puppet/ssl/certs/${facts['networking']['fqdn']}.pem",
    ssl_ca_cert             => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
  }

  # Configure the Puppet master to use puppetdb
  class { 'puppetdb::master::config': }
}
