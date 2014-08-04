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
        src: ['samples/src/*.txt', 'sample/src/nothing.js']
        dest: 'dist/src1'
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


  grunt.loadTasks 'tasks'
  grunt.registerTask 'default', ['jconv']