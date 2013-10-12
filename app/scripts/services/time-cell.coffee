angular.module('meetupServices')
  .factory 'TimeCell', (TimeStatus) ->
    class TimeCell

      constructor: (opened, available) ->
        @status = 0
        @setOpened opened ? false
        @setAvailable available ? false

      _canUpdateStatus: (active, type) ->
        return false if type == TimeStatus.AVAILABLE && !@isOpened()
        true

      updateStatus: (active, type) ->
        return unless @_canUpdateStatus(active, type)
        if active then @status |= type else @status &= ~type
      getStatus: (type) -> (@status & type) != 0

      isOpened: -> @getStatus TimeStatus.OPENED
      isAvailable: -> @getStatus TimeStatus.AVAILABLE
      setOpened: (b) -> @updateStatus b, TimeStatus.OPENED
      setAvailable: (b) ->
        @updateStatus b, TimeStatus.AVAILABLE


