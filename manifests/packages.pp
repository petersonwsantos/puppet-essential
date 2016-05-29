# Class: essential
# ===========================
#
# Full description of class essential here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'essential':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#

# versioncmp(a, b)  This function returns: 1 a > b  /  0 a = b / -1 a < b
class essential::packages {
  $package_ensure = 'present'
  case $::osfamily {
    'RedHat': {
      if versioncmp($::operatingsystemrelease, '7.0') >= 0 {
        $debug = 'centos7'
        $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
      } else {
        $package_name = 'centos5ou6'
      }
    }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          if versioncmp($::operatingsystemrelease, '8.0') >= 0 {
            $debug = 'debian8'
            $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
          } else {
            $debug = 'debian7ou6'
            $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
          }

        }
        'Ubuntu': {
          if versioncmp($::operatingsystemrelease, '14.10') >= 0 {
            $debug = 'ubuntu'
            $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
          } else {
            $debug = 'ubuntu'
            $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
          }

        }
        default: {
          $debug = 'ubuntu'
          $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
        }
      }
    }

    default: {
      case $::operatingsystem {
        'Archlinux': {
          $debug = 'Archlinux'
          $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
        }
        'Gentoo': {
          $debug = 'Archlinux'
          $package_name  = [ 'tree', 'nmap', 'tcpdump' ]
        }
        default: {
          $package_name = undef
         fail("${title}: Kernel '${::kernel}' is not currently supported")
        }
      }
    }
  }

  notify { "O SO reconhecido é => $debug ": }
  package { $package_name: ensure => 'installed' }
}
