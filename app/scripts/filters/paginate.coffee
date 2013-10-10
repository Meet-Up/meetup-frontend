angular.module('meetupFilters')
  .filter 'paginate',  ->
    (input, number, elementsPerPage) ->
      start = (number - 1) * elementsPerPage
      end = start + elementsPerPage - 1
      input[start..end]
