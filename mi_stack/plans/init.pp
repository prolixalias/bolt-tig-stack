#

#
plan mi() {
  apply_prep('localhost')
  apply_prep('all')

  apply('server') {
    # foreman plugins depends on puppetdb
    # foreman_proxy depends on foreman (which can be installed on a different node, that's why this is a single profile)
    # puppetserver depends on puppetdb
    # foreman wants to setup postgres from centos if it gets included before puppetdb

    include mi::basics
    include mi::puppetserver
    include mi::puppetdb
    # include mi::foreman
    # include mi::puppetserverproxy

    # include mi::choriaclient
    # include mi::choriaserver
    # include mi::node_exporter
    # include mi::consulserver
    # include mi::prometheus

    Class['mi::basics']
    -> Class['mi::puppetserver']
    -> Class['mi::puppetdb']
    # -> Class['mi::foreman']
    # -> Class['mi::puppetserverproxy']
    # -> Class['mi::consulserver']
    # -> Class['mi::prometheus']

    # include mi::influxdb
    # include mi::grafana
    # include mi::dashboards
    # include tig::telegraf

    # Class['mi::influxdb']
    # -> Class['mi::grafana']
    # -> Class['mi::dashboards']
  }

  $dashboard_host = get_target('server').name

  # apply('agents') {
  #   class { 'mi::telegraf':
  #     influx_host => $dashboard_host,
  #   }
  # }

  return("Dashboard is live on ${dashboard_host}. Go to http://10.1.0.100:8080 to access your dashboard")
}
