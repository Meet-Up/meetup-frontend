angular.module('MeetAppDirectives')
  .directive 'scrollPane', ($parse) ->

    restrict: 'AC'
    link: (scope, element, attrs) ->
      initScrollPane = ->
        element.jScrollPane(
          showArrows: true
          autoReinitialize: true
          mouseWheelSpeed: 50
        )

      scope.$on 'initScrollPane', ->
        initScrollPane()
