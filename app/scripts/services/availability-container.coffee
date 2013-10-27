angular.module('MeetAppServices')
  .factory 'AvailabilityContainer',  ->
    class AvailabilityContainer

      constructor: (users, @timeContainer, @neededTime) ->
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
        @updateRecommendations()

      clearWantedUsers: ->
        @wantedUsers = []

      setWantedUsers: (users) ->
        @clearWantedUsers()
        users = [users] unless _.isArray users
        for user in users
          id = if _.isNumber user then user else user.id
          @wantedUsers.push id

      updateAvailabilities: (users) ->
        _.each users, ((u) -> @updateUserAvailability(u, false)), this

      updateUserAvailability: (user, updateRecommendations=true) ->
        @users[user.id] = user
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
        @updateRecommendations() if updateRecommendations

      updateRecommendations: ->
        recommendations = @_computeRecommendations()
        @recommendations = _.chain(recommendations).first(6).filter((r) ->
          r.ranking <= 3).groupBy('ranking').value()

      _setRecommendationRanking: (recommendations) ->
        currentRanking = 0
        usersAvailable = 0
        for recommendation in recommendations
          if recommendation.participantsNumber != usersAvailable
            currentRanking += 1
            usersAvailable = recommendation.participantsNumber
          recommendation.ranking = currentRanking

      _computeRecommendations: ->
        recommendations = []
        neededCells = Math.ceil(@neededTime * 2)
        for eventDate, i in @timeContainer.dates
          currentAvailabilitiesNumber = 0
          recommendation = {}
          for j in [0..@availabilities[i].length - neededCells] by 1
            totalAvailabilities = 0
            unavailable = false
            for k in [j..j+neededCells-1]
              totalAvailabilities += @availabilities[i][k].length
            if totalAvailabilities != currentAvailabilitiesNumber
              if currentAvailabilitiesNumber > 0
                recommendation.end = k + @timeContainer.minRow - 1
                recommendations.push recommendation
              currentAvailabilitiesNumber = totalAvailabilities
              recommendation =
                start: j + @timeContainer.minRow
                date: eventDate.date
                participantsNumber: currentAvailabilitiesNumber

        recommendations = _.sortBy recommendations, (recommendation) ->
          -recommendation.participantsNumber
        @_setRecommendationRanking recommendations
        recommendations

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
