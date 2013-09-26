describe 'Controller: CreateEventCtrl', ->
  beforeEach ->
    browser().navigateTo '#/create-event'

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


