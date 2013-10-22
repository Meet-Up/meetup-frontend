angular.module('MeetAppServices')
  .factory 'createDialog', ($compile, $document) ->
    body = $document.find 'body'

    onClose = null

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
        onOpen: (modal) ->
          options.onOpen(modal) if options.onOpen?
        onClose: ->
          onClose() if onClose?
          dialogScope.$destroy()
          dialogElement.remove()
        overlayClose: false
      })

      dialogElement.trigger 'openModal'

      setOnClose: (callback) ->
        onClose = callback
      close: ->
        dialogElement.trigger 'closeModal'
