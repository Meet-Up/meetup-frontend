angular.module('meetupServices')
  .factory 'TimeStatus',  ->

    OPENED: 0x01
    AVAILABLE: 0x02

    getStatusFromName: (name) -> switch name
      when 'possibilities' then @OPENED
      when 'availabilities' then @AVAILABLE
      else 0
