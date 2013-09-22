describe 'Service: DateHelper', () ->
  beforeEach module 'meetupServices'

  dateHelper = {}

  # Initialize the controller and a mock scope
  beforeEach inject (DateHelper) ->
    dateHelper = DateHelper

  it 'should count the right number of days in month', ->
    days = dateHelper.getDaysForMonth new Date(2013, 8, 21)
    expect(days.length).toBe 42
    days = dateHelper.getDaysForMonth new Date(2013, 7, 10)
    expect(days.length).toBe 35
    days = dateHelper.getDaysForMonth new Date(2013, 1, 10)
    expect(days.length).toBe 35
    days = dateHelper.getDaysForMonth new Date(2010, 1, 10)
    expect(days.length).toBe 28
