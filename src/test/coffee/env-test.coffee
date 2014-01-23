describe 'dependency of ', ->
	exists = (obj) -> return expect(obj).to.exist

	it 'chaijs exists', ->
		exists chai

	it 'sinonjs exists', ->
		exists sinon

	it 'zeptojs exists', ->
		exists $
		exists $.ajax
		exists $.ajax().always

	it 'riotjs exists', ->
		exists $.observable
		exists $.route
