describe 'App: Configuration', ->
  beforeEach module 'meetAppConfig'

  it 'should have CELLS_PER_DAY divisible by 24', inject (CELLS_PER_DAY) ->
    expect(CELLS_PER_DAY % 24).toBe 0
