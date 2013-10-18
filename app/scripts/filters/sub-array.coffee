angular.module('MeetAppFilters')
  .filter 'subArray',  ->
    (input, from, to) ->
      to ?= input.length - 1
      input[from..to]
