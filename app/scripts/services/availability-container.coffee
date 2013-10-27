angular.module('MeetAppServices')
  .factory 'AvailabilityContainer',  ->
    class AvailabilityContainer

      constructor: (@users, @timeContainer) ->
        @availabilitiesMap = {}
        @maxAvailabilities = 0
        for date, i in @timeContainer.dates
          @availabilitiesMap[date.id] = i
        @availabilities = ([] for _ in @timeContainer.rows() for _ in @timeContainer.dates)
        @updateAvailabilities @users

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

      availableUsersNumber: (dateIndex, timeIndex) ->
        @availabilities[dateIndex][timeIndex].length

      availabilityPercentage: (dateIndex, timeIndex) ->
        timeIndex -= @timeContainer.minRow
        return 0 if @maxAvailabilities == 0 || dateIndex >= @availabilities.length
        @availableUsersNumber(dateIndex, timeIndex) / @maxAvailabilities

