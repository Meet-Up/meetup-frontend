describe 'Service: Event', ->
  beforeEach module 'meetupServices'

  Evt = {}
  EvtDate = {}

  beforeEach inject (Event, EventDate) ->
    Evt = Event
    EvtDate = EventDate

   dates = [
      start: new Date(2013, 9, 24, 12, 30)
      end: new Date(2013, 9, 24, 18, 0)
    ,
      start: new Date(2013, 9, 25, 11, 30)
      end: new Date(2013, 9, 25, 17, 30)
    ]

  getEvent = ->
    evt = new Evt()
    evt.dates = []
    for dateInfo in dates
      eventDate = new EvtDate()
      eventDate.start = dateInfo.start
      eventDate.end = dateInfo.end
      evt.dates.push eventDate
    evt


  it 'should add dates correctly', () ->
    evt = getEvent()
    expect(evt.dates.length).toBe dates.length


  it 'should compute the right number of rows needed', inject (DateHelper) ->
    evt = getEvent()
    minTime = new Date(1970, 1, 1, 11, 30)
    maxTime = new Date(1970, 1, 1, 18, 0)
    expectedNumber = DateHelper.getCellsNumberInInterval(minTime, maxTime)
    expect(evt.neededRowsNumber()).toBe expectedNumber





