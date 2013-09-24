describe 'Service: Event', ->
  beforeEach module 'meetupServices'

  Evt = {}
  EvtDate = {}

  beforeEach inject (Event, EventDate) ->
    Evt = Event
    EvtDate = EventDate

  describe 'attributes', ->
    it 'should add events correctly', ->
      evt = new Evt()
      date = new Date()
      evt.addDate date
      expect(evt.hasDate date).toBe true
      expect(evt.dates.length).toBe 1

    it 'should remove events correctly', ->
      evt = new Evt()
      date = new Date()
      evt.addDate date
      evt.removeDate date
      expect(evt.dates.length).toBe 0


  describe 'event dates methods', ->
    getEvent = ->
      evt = new Evt()
      evt.dates = []
      for dateInfo in dates
        eventDate = new EvtDate()
        eventDate.start = dateInfo.start
        eventDate.end = dateInfo.end
        evt.dates.push eventDate
      evt

    evt = {}

    beforeEach inject ->
      evt = getEvent()

    minTime = new Date(2013, 9, 24, 11, 30)
    maxTime = new Date(2013, 9, 24, 18, 0)

    dates = [
      start: new Date(2013, 9, 24, 12, 30)
      end: maxTime
    ,
      start: minTime
      end: new Date(2013, 9, 25, 17, 30)
    ]


    it 'should add dates correctly', ->
      expect(evt.dates.length).toBe dates.length

    it 'should compute the right min time', ->
      expect(evt.minTime().getHours()).toBe minTime.getHours()
      expect(evt.minTime().getMinutes()).toBe minTime.getMinutes()

    it 'should compute the right max time', ->
      expect(evt.maxTime().getHours()).toBe maxTime.getHours()
      expect(evt.maxTime().getMinutes()).toBe maxTime.getMinutes()

    it 'should compute the right number of rows needed', inject (DateHelper) ->
      evt = getEvent()
      min = minTime.clone().set({ year: 1970, month: 1, day: 1 })
      max = maxTime.clone().set({ year: 1970, month: 1, day: 1 })
      expectedNumber = DateHelper.getCellsNumberInInterval(min, max)
      expect(evt.neededRowsNumber()).toBe expectedNumber
