  $a = undef
  class { 'stdlib': };include ::stdlib;include ::stdlib
  if $a and downcase($a) {
    validate_legacy(String, 'validate_re', $a, ["^b$", "^c$"])
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx0${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx1${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx2${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx3${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx4${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx5${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx6${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx7${index}-${value}": 
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx8${index}-${value}":
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx9${index}-${value}":
      ensure =>  present
    }
  }
  [1,2,3,4,5,6,7,8,9,10].each |Integer $index, Integer $value| {
    file { "/tmp/xxx10${index}-${value}":
      ensure =>  present
    }
  }
