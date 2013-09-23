describe 'meetupApp', ->
  beforeEach ->
    browser().navigateTo '/'

  it 'should be true', ->
    expect(browser().location().url()).toBe("/");
    expect(element('#title-bar a[href="#/create-event"]').count()).toBe 1

