describe 'meetupApp', ->

  generateTitleBarLinks = (links) ->
    ("#title-bar #{st}" for st in links)

  logoSelector = 'a[href="#/"]'

  linkCases = [
    gotoPath: ->
      browser().navigateTo '/#/'
    visibleLinks: generateTitleBarLinks [logoSelector, 'a.create-event']
    hiddenLinks: generateTitleBarLinks ['a.next', 'a.previous']
  ,
    gotoPath: ->
      browser().navigateTo '/#/create-event'
    visibleLinks: generateTitleBarLinks [logoSelector, 'a.next']
    hiddenLinks: generateTitleBarLinks ['a.create-event', 'a.previous']
  # ,
  #   gotoPath: ->
  #     browser().navigateTo '/#/create-event'
  #     element('.calendar-body tbody td:first').click()
  #     element('a.next').click()
  #   visibleLinks: generateTitleBarLinks [logoSelector, 'a.previous']
  #   hiddenLinks: generateTitleBarLinks ['a.create-event', 'a.next']
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
