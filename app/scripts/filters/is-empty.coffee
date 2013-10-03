angular.module('meetupFilters')
  .filter 'isEmpty', ->
    (input) ->
      return true if input == null
      return input.length == 0 if input instanceof String || input instanceof Array
      for key of input
        return false if input.hasOwnProperty(key)
      return true
