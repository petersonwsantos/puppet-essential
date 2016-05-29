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

  $package_ensure = 'present'

  # -----------------------------------------------------------------
  # 1.PACKAGES : Definition what essential packages must be installad
  #
    # ----------------------------------------> RedHat´s flavor
    $package_name_centos       = [ 'tree', 'nmap', 'tcpdump' ]
    $package_name_xenserverver = [ 'tree', 'nmap', 'tcpdump' ]
    # ----------------------------------------> Debian´s flavors
    $package_name_debian       = [ 'tree', 'nmap', 'tcpdump' ]
    $package_name_ubuntu       = [ 'tree', 'nmap', 'tcpdump' ]
    # ----------------------------------------> Others
    $package_name_gentoo       = [ 'tree', 'nmap', 'tcpdump' ]
    $package_name_archlinux    = [ 'tree', 'nmap', 'tcpdump' ]
  #
  # -----------------------------------------------------------------

  case $::osfamily {
    'RedHat': {
      if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        $debug = 'centos7'
        $package_name = $package_name_centos
      } else {
        if ($::operatingsystem == 'XenServer'){
          $debug = 'xenserver'
          $package_name = $package_name_centos
        } else {
          $package_name = $package_name_centos
          $debug = 'centos6'
        }
      }
    }
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
        'Archlinux': {
          $debug = 'Archlinux'
          $package_name = $package_name_archlinux
        }
        'Gentoo': {
          $debug = 'Gentoo'
          $package_name  = $package_name_gentoo
        }
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
