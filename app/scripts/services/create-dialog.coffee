angular.module('meetupServices')
  .factory 'createDialog', ($compile, $document) ->
    body = $document.find 'body'

    createTemplate = (templateUrl) ->
      template = $('<div />')
      template.attr 'id', 'modal'
      template.addClass 'modal'
      template.append $('<div />').addClass('modal-header')
      innerTemplate = $('<div />')
      innerTemplate.addClass 'modal-body'
      innerTemplate.attr 'ng-include', ""
      innerTemplate.attr 'src', "'#{templateUrl}'"
      template.append innerTemplate

    ($scope, templateUrl, options={}) ->
      template = createTemplate(templateUrl)

      dialogScope = $scope.$new()
      dialogElement = $compile(template)(dialogScope)

      $(body).append dialogElement

      dialogElement.easyModal({
        onClose: () ->
          dialogScope.$destroy()
          dialogElement.remove()
      })

      dialogElement.css 'left', ("#{options.left ? '40'}%")
      dialogElement.trigger 'openModal'

