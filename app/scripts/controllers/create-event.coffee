angular.module('meetupControllers')
  .controller 'CreateEventCtrl', ($scope, $filter, $state, Event, eventContainer, TimeContainer, CalendarModel, createDialog) ->

    $scope.foo = (e) ->
      createDialog($scope, 'partials/desktop/create-event/success-modal.html')


    $scope.event = new Event({ datesIndexes: {}})
    $scope.calendar = new CalendarModel()

    $scope.timeContainer = new TimeContainer(true)

    $scope.hasSelectedDates = ->
      !$filter('isEmpty')($scope.calendar.selectedDates)

    $scope.$watch 'calendar.selectedDates', ->
      dates = (date for k, date of $scope.calendar.selectedDates)
      $scope.timeContainer.updateDates dates
      $scope.$emit 'titleBar.update', { nextDisabled: !$scope.hasSelectedDates() }
    , true

    $scope.saveEvent = ->
      $scope.event.setDates $scope.timeContainer
      $scope.event.save().then (evt) ->
        createDialog($scope, 'partials/desktop/create-event/success-modal.html', {
          onOpen: (modal) ->
            $(modal).find('.btn-copy').zclip({
              path:'bower_components/jquery-zclip/ZeroClipboard.swf',
              copy: evt.$url()
              afterCopy: ->
            })
        })

    $scope.gotoEdit = ->
      eventContainer.addEvent $scope.event
      $state.go 'events', {
        token: $scope.event.token
      }

