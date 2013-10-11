angular.module('meetupServices')
  .factory 'TimeCell',  ->
    class TimeCell
      @OPENED:     0x01
      @AVAILABLE:  0x02

      status: 0

      constructor: (opened, available) ->
        @setOpened opened ? false
        @setAvailable available ? false

      updateStatus: (active, type) ->
        if active then @status |= type else @status &= ~type
      getStatus: (type) -> (@status & type) != 0

      isOpened: -> @getStatus TimeCell.OPENED
      isAvailable: -> @getStatus TimeCell.AVAILABLE
      setOpened: (b) -> @updateStatus b, TimeCell.OPENED
      setAvailable: (b) -> @updateStatus b, TimeCell.AVAILABLE

      @getStatusFromName: (name) -> switch name
        when 'possibilities' then TimeCell.OPENED
        when 'availabilities' then TimeCell.AVAILABLE
        else 0

