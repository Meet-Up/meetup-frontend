angular.module('MeetAppServices')
  .factory 'AvailabilityContainer',  ->
    class AvailabilityContainer

      constructor: (users, @timeContainer) ->
        @availabilitiesMap = {}
        @maxAvailabilities = 0
        @wantedUsers = []
        @users = {}
        for user in users
          @users[user.id] = user
        for date, i in @timeContainer.dates
          @availabilitiesMap[date.id] = i
        @availabilities = ([] for _ in @timeContainer.rows() for _ in @timeContainer.dates)
        @updateAvailabilities @users

      clearWantedUsers: ->
        @wantedUsers = []

      setWantedUsers: (users) ->
        @clearWantedUsers()
        users = [users] unless _.isArray users
        for user in users
          id = if _.isNumber user then user else user.id
          @wantedUsers.push id

      updateAvailabilities: (users) ->
        _.each users, @updateUserAvailability, this

      updateUserAvailability: (user) ->
        for availability in user.availabilities
          for j in @timeContainer.rows()
            i = @availabilitiesMap[availability.eventDateId]
            time = j - @timeContainer.minRow
            index = _.indexOf @availabilities[i][time], user.id
            if availability.times[j] == '1'
              if index == -1
                @availabilities[i][time].push user.id
              if @availabilities[i][time].length > @maxAvailabilities
                @maxAvailabilities = @availabilities[i][time].length
            else
              if index > -1
                delete @availabilities[i][time][index]
                @availabilities[i][time] = _.compact @availabilities[i][time]

      availableUsers: (dateIndex, timeIndex) ->
        timeIndex -= @timeContainer.minRow
        (@users[i] for i in @availabilities[dateIndex][timeIndex])

      availableUsersNumber: (dateIndex, timeIndex) ->
        availabilities = @availabilities[dateIndex][timeIndex]
        if @wantedUsers.length > 0
          availabilities = availabilities.filter (u) => _.contains @wantedUsers, u
        availabilities.length

      availabilityRate: (dateIndex, timeIndex) ->
        timeIndex -= @timeContainer.minRow
        return 0 if @maxAvailabilities == 0 || dateIndex >= @availabilities.length
        max = if @wantedUsers.length > 0 then @wantedUsers.length else @maxAvailabilities
        @availableUsersNumber(dateIndex, timeIndex) / max
