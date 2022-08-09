#

#
plan tig() {
  apply_prep('localhost')
  apply_prep('all')

  apply('dashboard') {
    include tig::influxdb
    include tig::grafana
    include tig::dashboards
    # include tig::telegraf

    Class['tig::influxdb']
    -> Class['tig::grafana']
    -> Class['tig::dashboards']
  }

  $dashboard_host = get_target('dashboard').name

  apply('agents') {
    class { 'tig::telegraf':
      influx_host => $dashboard_host,
    }
  }

  return("Dashboard is live on ${dashboard_host}. Go to http://10.1.0.100:8080 to access your dashboard")
}
