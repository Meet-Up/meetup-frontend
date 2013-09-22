describe 'Service: DateHelper', () ->
  beforeEach module 'meetupServices'

  dateHelper = {}

  cases = [
    # random case
    date: new Date(2013, 8, 21)
    totalDays: 42
  ,
    # starts monday, ends randomly
    date: new Date(2013, 6, 10)
    totalDays: 35
  ,
    # ends sunday, starts randomly
    date: new Date(2014, 7, 1)
    totalDays: 35
  ,
    # starts monday, ends sunday
    date: new Date(2010, 1, 10)
    totalDays: 28
  ]

  beforeEach inject (DateHelper) ->
    dateHelper = DateHelper

  it 'should count the right number of days in month', ->
    for c in cases
      days = dateHelper.getDaysForMonth(c.date)
      expect(days.length).toBe c.totalDays

  it 'should start on monday', ->
    for c in cases
      days = dateHelper.getDaysForMonth(c.date)
      expect(days[0].is().monday()).toBe true

  it 'should end on sunday', ->
    for c in cases
      days = dateHelper.getDaysForMonth(c.date)
      expect(days[days.length - 1].is().sunday()).toBe true
