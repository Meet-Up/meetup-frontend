angular.module('MeetAppDirectives')
  .directive 'selectableInput', ($parse) ->
    resctrict: 'AC'
    link: ($scope, element, attr) ->
      element.on 'click', (e) ->
        element.select()
