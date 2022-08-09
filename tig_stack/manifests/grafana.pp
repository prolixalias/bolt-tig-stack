#

# @param [Integer] cfg_server_http_port
#   xxx
# @param [String] cfg_app_mode
#   xxx
# @param [String] cfg_database_name
#   xxx
# @param [String] cfg_database_type
#   xxx
# @param [String] password
#   xxx
# @param [String] user
#   xxx
#
class tig::grafana (
  Integer $cfg_server_http_port,
  String $cfg_app_mode,
  String $cfg_database_name,
  String $cfg_database_type,
  String $password,
  String $user,
) {
  #
  class { 'grafana':
    cfg => {
      app_mode => $cfg_app_mode,
      server   => {
        http_port => $cfg_server_http_port,
      },
      security => {
        admin_user     => $user,
        admin_password => $password,
      },
      database => {
        type => 'sqlite3',
        host => '127.0.0.1:3306',
        name => $cfg_database_name,
      },
    },
  }
}
