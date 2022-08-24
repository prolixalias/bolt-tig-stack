#

# @param [String] grafana_password
#   xxx
# @param [String] grafana_user
#   xxx
# @param [String] grafana_url
#   xxx
# @param [Sensitive[String]] influxdb_password
#   xxx
# @param [String] influxdb_database
#   xxx
# @param [String] influxdb_username
#   xxx

#
class mi::dashboards (
  Sensitive[String[1]] $influxdb_password,
  String $grafana_password,
  String $grafana_url,
  String $grafana_user,
  String $influxdb_database,
  String $influxdb_username,
) {
  #
  grafana_datasource { 'influxdb':
    access_mode      => 'proxy',
    database         => $influxdb_database,
    grafana_password => $grafana_password,
    grafana_url      => $grafana_url,
    grafana_user     => $grafana_user,
    is_default       => true,
    password         => $influxdb_password,
    type             => 'influxdb',
    url              => 'http://localhost:8086',
    user             => $influxdb_username,
    require          => Class['influxdb'],
  }

  #
  grafana_dashboard { 'telegraf':
    grafana_url      => $grafana_url,
    grafana_user     => $grafana_user,
    grafana_password => $grafana_password,
    content          => template('tig/dashboards/telegraf.json'),
  }
}
