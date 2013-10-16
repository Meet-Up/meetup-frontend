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

      dialogScope.close = ->
        dialogElement.trigger 'closeModal'

      dialogElement.easyModal({
        onOpen: (modal) ->
          options.onOpen(modal) if options.onOpen?
        onClose: () ->
          dialogScope.$destroy()
          dialogElement.remove()
      })

      dialogElement.trigger 'openModal'
