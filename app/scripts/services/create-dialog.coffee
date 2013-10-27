angular.module('MeetAppServices')
  .factory 'createDialog', ($compile, $document) ->
    body = $document.find 'body'

    onClose = null

    createTemplate = (templateUrl, options) ->
      template = $('<div />')
      template.addClass 'modal' if options.modal
      template.append $('<div />').addClass('modal-header')
      innerTemplate = $('<div />')
      innerTemplate.addClass 'modal-body'
      innerTemplate.attr 'ng-include', ""
      innerTemplate.attr 'src', "'#{templateUrl}'"
      template.append innerTemplate

    ($scope, templateUrl, options={}) ->
      template = createTemplate templateUrl, options

      dialogScope = $scope.$new()
      dialogElement = $compile(template)(dialogScope)

      onClose = options.onClose

      $(body).append dialogElement

      $scope.close = ->
        onClose() if onClose?
        dialogScope.$destroy()
        dialogElement.remove()

      if options.modal
        dialogElement.easyModal({
          onOpen: (modal) ->
            options.onOpen(modal) if options.onOpen?
          onClose: ->
            $(body).css 'overflow', 'auto'
            $scope.close()
          overlayClose: false
        })

        dialogElement.trigger 'openModal'
        $(body).css 'overflow', 'hidden'

        setOnClose: (callback) ->
          onClose = callback
        close: ->
          dialogElement.trigger 'closeModal'
        element: dialogElement
      else
        close: $scope.close
        element: dialogElement
