angular.module('meetupDirectives')
  .directive 'dateStatus', ($parse) ->

    ($scope, $elem, $attr) ->
      [cellDate, scopeDate] = $parse($attr.dateStatus)($scope)

      status = cellDate.getMonth() - scopeDate.getMonth()
      if status < 0 then $elem.addClass 'past'
      else if status == 0 then $elem.addClass 'current'
      else $elem.addClass 'future'
