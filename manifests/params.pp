# Class: essential
# ===========================
#
# Parameters of essential petersonwsantos-essential
#
#
# Authors
# -------
#
# Author Peetrson W Santos  <opeterson()hotmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Peterson W Santos
#

# versioncmp(a, b)  This function returns: 1 a > b  /  0 a = b / -1 a < b


class essential::params {


  # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
  # 1.PACKAGES : Definition what essential packages must be installad
  # .          .          .          .          .          .        .
  $package_name_centos       = [ 'tree', 'nmap', 'tcpdump' ]
  $package_name_xenserverver = [ 'tree', 'nmap', 'tcpdump' ]
  $package_name_debian       = [ 'tree', 'nmap', 'tcpdump' ]
  $package_name_ubuntu       = [ 'tree', 'nmap', 'tcpdump' ]
  $package_name_gentoo       = [ 'tree', 'nmap', 'tcpdump' ]
  $package_name_archlinux    = [ 'tree', 'nmap', 'tcpdump' ]


  # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
  # 2.CONFIG : Definition what default configs must be apllied
  # .          .          .          .          .          .        .
  $selinux = "disabledn"





  # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

  case $::osfamily {
    # ----------------------------------------> RedHat / CentOS
    'RedHat': {
      if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        $debug = 'centos7'
        $package_name = $package_name_centos
      } else {
        if ($::operatingsystem == 'XenServer'){
          $debug = 'xenserver'
          $package_name = $package_name_xenserverver
        } else {
          $package_name = $package_name_centos
          $debug = 'centos6'
        }
      }
    }
    # ----------------------------------------> Debian
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          if versioncmp($::operatingsystemrelease, '8.0') >= 0 {
            $debug = 'debian8'
            $package_name = $package_name_debian
          } else {
            $debug = 'debian7ou6'
            $package_name = $package_name_debian
          }
        }

    # ----------------------------------------> Ubuntu
        'Ubuntu': {
          if versioncmp($::operatingsystemrelease, '14.10') >= 0 {
            $debug = 'ubuntu'
            $package_name = $package_name_ubuntu
          } else {
            $debug = 'ubuntu'
            $package_name = $package_name_ubuntu
          }

        }
        default: {
          $debug = 'ubuntu'
          $package_name = $package_name_ubuntu
        }
      }
    }

    default: {
      case $::operatingsystem {
    # ----------------------------------------> Archlinux
        'Archlinux': {
          $debug = 'Archlinux'
          $package_name = $package_name_archlinux
        }
    # ----------------------------------------> Gentoo
        'Gentoo': {
          $debug = 'Gentoo'
          $package_name  = $package_name_gentoo
        }
    # ---------------------------------------->  not currently supported
        default: {
          $package_name = undef
          fail("${title}: Kernel '${::kernel}' is not currently supported")
        }
      }
    }
  }

  #notify { "O SO reconhecido é   => $debug ": }
  #package { $package_name: ensure => 'installed' }
}
