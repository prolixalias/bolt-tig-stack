#

# @param [Array] bucket_labels
#   xxx
# @param [Boolean] manage_repo
#   xxx
# @param [Boolean] manage_setup
#   xxx
# @param [Boolean] manage_ssl
#   xxx
# @param [Boolean] use_ssl
#   xxx
# @param [Integer] port
#   xxx
# @param [Sensitive[String[1]]] password
#   xxx
# @param [Sensitive[String[1]]] token
#   xxx
# @param [String] bucket
#   xxx
# @param [String] domain
#   xxx
# @param [String] host
#   xxx
# @param [String] org
#   xxx
# @param [String] package_repo_name
#   xxx
# @param [String] package_version
#   xxx
# @param [String] ssl_ca_file
#   xxx
# @param [String] ssl_cert_file
#   xxx
# @param [String] ssl_key_file
#   xxx
# @param [String] token_file
#   xxx
# @param [String] username
#   xxx

#
class mi::influxdb (
  Array $bucket_labels,
  Boolean $manage_repo,
  Boolean $manage_setup,
  Boolean $manage_ssl,
  Boolean $use_ssl,
  Integer $port,
  Sensitive[String[1]] $password,
  Sensitive[String[1]] $token,
  String $bucket,
  String $domain,
  String $host,
  String $org,
  # String $package_archive_source,
  String $package_repo_name,
  String $package_version,
  String $ssl_ca_file,
  String $ssl_cert_file,
  String $ssl_key_file,
  String $token_file,
  String $username,
) {
  # # file
  # file { '/etc/influxdb/ca.pem':
  #   ensure  => file,
  #   source  => "/etc/letsencrypt/config/live/${facts['networking']['hostname']}.${domain}/fullchain.pem",
  #   links   => 'follow',
  #   replace => true,
  #   owner   => 'influxdb',
  #   group   => 'influxdb',
  #   before  => Class['influxdb'],
  # }

  # # file
  # file { '/etc/influxdb/cert.pem':
  #   ensure  => file,
  #   source  => "/etc/letsencrypt/config/live/${facts['networking']['hostname']}.${domain}/cert.pem",
  #   links   => 'follow',
  #   replace => true,
  #   owner   => 'influxdb',
  #   group   => 'influxdb',
  #   before  => Class['influxdb'],
  # }

  # # file
  # file { '/etc/influxdb/key.pem':
  #   ensure  => file,
  #   source  => "/etc/letsencrypt/config/live/${facts['networking']['hostname']}.${domain}/privkey.pem",
  #   links   => 'follow',
  #   replace => true,
  #   owner   => 'influxdb',
  #   group   => 'influxdb',
  #   before  => Class['influxdb'],
  # }

  # class { 'trusted_ca': }
  # trusted_ca::ca { 'letsencrypt':
  #   source => '/etc/influxdb/ca.pem',
  # }

  class { 'hostname':
    hostname => $facts['networking']['hostname'],
    domain   => $domain,
    before   => Class['influxdb'],
  }

  # 
  class { 'influxdb':
    admin_pass     => $password,
    admin_user     => $username,
    # archive_source => $package_archive_source,
    initial_bucket => $bucket,
    host           => $host,
    initial_org    => $org,
    manage_repo    => $manage_repo,
    manage_setup   => $manage_setup,
    manage_ssl     => $manage_ssl,
    port           => $port,
    repo_name      => $package_repo_name,
    ssl_ca_file    => $ssl_ca_file,
    ssl_cert_file  => $ssl_cert_file,
    ssl_key_file   => $ssl_key_file,
    token_file     => $token_file,
    use_ssl        => $use_ssl,
    version        => $package_version,
    before         => [Influxdb_org[$org], Influxdb_bucket[$bucket]],
  }

  influxdb_org { $org:
    ensure  => present,
    token   => $token,
    port    => $port,
    use_ssl => $use_ssl,
  }

  influxdb_bucket { $bucket:
    ensure  => present,
    org     => $org,
    labels  => $bucket_labels,
    token   => $token,
    port    => $port,
    use_ssl => $use_ssl,
  }
}
