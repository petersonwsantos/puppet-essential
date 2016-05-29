# Class: essential
# ===========================
#
# Install Essential packages 
#
# Parameters
# ----------
#
#
# Variables
# ----------
#
#
# Examples
# --------
#    include essential
#
# Authors
# -------
#
# Author Peterson W. Santos  < opeterson()hotmail@.com >
#
# Copyright
# ---------
#
# Copyright 2016 Peterson W Santos
#

class essential::packages(
      $ensure       = running,
      $package_ensure = 'present',
      $package_name = $::essential::params::package_name,
) inherits ::essential::params {
    notify { "O SO reconhecido é     => $debug ": }
      package { $package_name: ensure => 'installed' }
}
