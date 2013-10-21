describe 'meetAppApp', ->

  generateTitleBarLinks = (links) ->
    ("#title-bar #{st}" for st in links)

  logoSelector = 'a[href="#/"]'


  linkCases = [
    gotoPath: ->
      browser().navigateTo '/#/'
    visibleLinks: generateTitleBarLinks [logoSelector, '.create-event']
    hiddenLinks: generateTitleBarLinks ['.next', '.previous']
  ,
    gotoPath: ->
      browser().navigateTo '/#/create-event'
    visibleLinks: generateTitleBarLinks [logoSelector, '.next']
    hiddenLinks: generateTitleBarLinks ['.create-event', '.previous']
  ,
    gotoPath: ->
      browser().navigateTo '/#/create-event'
      element('.calendar-body tbody td:last').click()
      element('.next').click()
    visibleLinks: generateTitleBarLinks [logoSelector, '.previous']
    hiddenLinks: generateTitleBarLinks ['.create-event', '.next']
  ]

  it 'should display visible links in titlebar', ->
    for c in linkCases
      c.gotoPath()
      for s in c.visibleLinks
        expect(element("#{s}:visible").count()).toBe 1

  it 'should not display hidden links in titlebar', ->
    for c in linkCases
      c.gotoPath()
      for s in c.hiddenLinks
        expect(element("#{s}:visible").count()).toBe 0
