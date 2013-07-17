# == Class: kibana::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'kibana::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class kibana::package {

  #### Package management

  # set params: in operation
  if $kibana::ensure == 'present' {

    # Check if we want to install a specific version or not
    if $kibana::version == false {

      $package_ensure = $kibana::autoupgrade ? {
        true  => 'latest',
        false => 'present',
      }

    } else {

      # install specific version
      $package_ensure = $kibana::version

    }

  # set params: removal
  } else {
    $package_ensure = 'purged'
  }

  # action
  package { $kibana::package_name:
    ensure => $package_ensure,
  }

}
