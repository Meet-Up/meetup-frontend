describe 'Controller: CreateEventCtrl', ->
  beforeEach ->
    browser().navigateTo '#/create-event'

  formatDate = (date) -> date.toString 'MM/yy'

  getDatePromise = ->
    promise = element('.calendar span.current-month').query (month, done) ->
      date = Date.parse month.text()
      done null, formatDate(date)

  checkCurrentDate = ->
    currentDate = Date.today()
    date = getDatePromise()
    expect(date).toBe formatDate(currentDate)
    currentDate

  testDateTransition = (selector, expected) ->
    element(".calendar button.#{selector}").click()
    date = getDatePromise()
    expect(date).toBe formatDate(expected)

  it 'should display title', ->
    title = element '.event-name'
    expect(title.text()).toBe ''
    input('event.name').enter 'foobar'
    expect(title.text()).toBe 'foobar'

  it 'should react on calendar click', ->
    firstCell = element '.calendar-body tbody td:first'
    expect(firstCell.attr('class')).not().toContain 'selected'
    firstCell.click()
    expect(firstCell.attr('class')).toContain 'selected'

  it 'should go to previous month when previous is pressed', ->
    currentDate = checkCurrentDate()
    testDateTransition 'previous', currentDate.last().month()

  it 'should go to next month when next is pressed', ->
    browser().reload()
    currentDate = checkCurrentDate()
    testDateTransition 'next', currentDate.next().month()
