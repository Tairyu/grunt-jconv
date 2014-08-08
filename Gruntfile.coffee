module.exports = (grunt) ->
  require('time-grunt') grunt
  require('jit-grunt') grunt

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      dist: 'dist'

    jconv:
      options:
        fromEncode: 'UTF8'
        toEncode: 'UTF8'
      src:
        options:
          fromEncode: 'SJIS'
        src: ['*.txt', 'nothing.js']
        expand: true
        cwd: 'samples/src'
        dest: 'dist/src'
      src2:
        options:
          toEncode: 'SJIS'
        src: 'samples/src2/*.txt'
        dest: 'dist/src2/'
      src3:
        options:
          fromEncode: 'SJIS'
        src: ['samples/src3/*.txt', '!samples/src3/KOKORO.txt']
        dest: 'dist/src3'
      flip:
        options:
          toEncode: 'SJIS'
        src: 'dist/src3/*.txt' # dist path is own file.

    shell:
      jsfmt:
        command: 'jsfmt -w tasks/*.js'
      afterAdd:
        command: 'git add tasks/*.js'

    jscs:
      options:
        config: '.jscsrc'
        force: true
      src: 'tasks/*.js'

    jshint:
      options:
        jshintrc: '.jshintrc'
      src: 'tasks/*.js'


  grunt.loadTasks 'tasks'
  grunt.registerTask 'default', ['jconv']
  grunt.registerTask 'lint', ['jshint', 'jscs']
  grunt.registerTask 'pre-git', ['shell:jsfmt', 'lint', 'shell:afterAdd']