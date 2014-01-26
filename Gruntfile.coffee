module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		coffee:
			test:
				files: 
					"target/tests.js": ['src/main/coffee/{,*/}*.coffee', 'src/test/coffee/{,*/}*.coffee']
			dist:
				files: 
					"target/app.js": ['src/main/coffee/{,*/}*.coffee']
			options:
				join: true

		karma:
			unit:
				options:
					configFile: 'karma.conf.js'
					frameworks: ['mocha', 'chai-sinon']
					files: ['target/zepto*.js', 'target/riot*.js', 'target/tests.js']
					singleRun: true
					reporters: ['spec', 'progress', 'junit', 'html']
					junitReporter: 
						outputFile: 'target/karma-results.xml'
					htmlReporter:
						outputDir: 'target/karma_html'

		less:
			dist:
				files:
					'target/app.css': 'src/main/less/app.less'

		copy:
			test:
				files:[
					{
						expand: true, dot: true
						dest: 'target/'
						cwd: 'bower_components/zepto-full/'
						src: '*.min.js'
					}, {
						expand: true, dot: true
						dest: 'target/'
						cwd: 'bower_components/riotjs/'
						src:' *.min.js'
					}
				]
			dist:
				files:[
					{
						expand: true, dot: true
						dest: 'src/main/webapp/lib/css/'
						cwd: 'bower_components/todc-bootstrap/dist/'
						src: 'todc-bootstrap.css'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/lib/css/'
						cwd: 'bower_components/bootstrap/dist/css'
						src:' *.min.css'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/lib/js/'
						cwd: 'bower_components/bootstrap/dist/js'
						src:' *.min.js'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/lib/'
						cwd: 'bower_components/bootstrap/dist'
						src: 'fonts/{,*/}*.*'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/lib/'
						cwd: 'bower_components/todc-bootstrap/'
						src: 'img/{,*/}*.*'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/lib/js/'
						cwd: 'bower_components/riotjs/'
						src:' *.min.js'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/lib/js/'
						cwd: 'bower_components/zepto-full/'
						src: '*.min.js'
					}, {
						expand: true, dot: true
						dest: 'src/main/webapp/'
						cwd: 'target'
						src: 'app.*'
					}
				]

		clean:
			###
			bower:
				files: [
					dot: true
					src: ['bower_components/']
				]
			npm:
				files: [
					dot: true
					src: ['node_modules/']
				]
			eclipse:
				files: [
					dot: true
					src: ['.factorypath', '.project', '.classpath', '.apt_generated/', '.settings/']
				]
			###
			output:
				files: [
					dot: true
					src: [
						'target/{,*/}*.css', 'target/*.js', 
						'src/main/webapp/app*.*', 'src/main/webapp/lib'
						'target/karma_html/', 'target/karma-results.xml'
					]
				]

		watch:
			coffee:
				files: [
					'src/main/coffee/{,*/}*.coffee'
					'src/test/coffee/{,*/}*.coffee'
				]
				tasks: ['coffee', 'copy:test', 'karma']
			less:
				files: 'src/main/less/{,*/}*.less'
				tasks: ['less']

	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-karma'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	# grunt.loadNpmTasks 'grunt-contrib-connect'
	# grunt.loadNpmTasks 'grunt-contrib-commands'
	# grunt.loadNpmTasks 'grunt-mocha-webdriver'

	grunt.registerTask 'default', ['clean:output', 'coffee', 'copy:test', 'karma', 'less', 'copy:dist']
	grunt.registerTask 'test', ['coffee:test', 'copy:test', 'karma']
