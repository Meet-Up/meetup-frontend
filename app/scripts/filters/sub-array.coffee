angular.module('meetupFilters')
  .filter 'subArray',  ->
    (input, from, to) ->
      to ?= input.length - 1
      input[from..to]
