#

# @param [Array] inputs
#   xxx
# @param [Sensitive[String[1]]] influxdb_password
#   xxx
# @param [String] influx_host
#   xxx
# @param [String] influxdb_database
#   xxx
# @param [String] influxdb_username
#   xxx

#
class tig::telegraf (
  Array $inputs,
  Sensitive[String[1]] $influxdb_password,
  String $influx_host,
  String $influxdb_database,
  String $influxdb_username,
) {
  $influxdb_url = "http://${influx_host}:8086"

  class { 'telegraf':
    hostname => $facts['networking']['hostname'],
    outputs  => {
      'influxdb' => [
        {
          'urls'     => [$influxdb_url],
          'database' => $influxdb_database,
          'username' => $influxdb_username,
          'password' => $influxdb_password,
        }
      ],
    },
  }

  # telegraf::input { 'cpu':
  #   options => [{ 'percpu' => true, 'totalcpu' => true, }],
  # }

  $inputs.each | String $input, Hash $options | {
    telegraf::input { $input:
      options => [$options],
    }
  }
}
