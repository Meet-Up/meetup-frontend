describe 'meetupApp', ->

  generateTitleBarLinks = (links) ->
    ("#title-bar #{st}" for st in links)

  logoSelector = 'a[href="#/"]'

  linkCases = [
    path: '/#/'
    visibleLinks: generateTitleBarLinks [logoSelector, 'a.create-event']
    hiddenLinks: generateTitleBarLinks ['a.next', 'a.previous']
  ,
    path: '/#/create-event'
    visibleLinks: generateTitleBarLinks [logoSelector, 'a.next']
    hiddenLinks: generateTitleBarLinks ['a.create-event', 'a.previous']
  ,
    path: '/#/create-event/select-time'
    visibleLinks: generateTitleBarLinks [logoSelector, 'a.previous']
    hiddenLinks: generateTitleBarLinks ['a.create-event', 'a.next']
  ]

  it 'should display visible links in titlebar', ->
    for c in linkCases
      browser().navigateTo c.path
      for s in c.visibleLinks
        expect(element("#{s}:visible").count()).toBe 1

  it 'should not display hidden links in titlebar', ->
    for c in linkCases
      browser().navigateTo c.path
      for s in c.hiddenLinks
        expect(element("#{s}:visible").count()).toBe 0
