angular.module('meetupDirectives')
  .directive 'selectableTable', ($parse) ->
    restrict: 'A'
    link: ($scope, elem, attr) ->
      [childRow, childCell] = if elem.is 'table' then ['tr', 'td'] else ['.row', '.row']

      startRow = $parse(attr.startRow)() ? 0
      startColumn = $parse(attr.startColumn)() ? 0
