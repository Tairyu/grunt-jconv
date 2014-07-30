'use strict';

module.exports = function(grunt) {

  grunt.registerMultiTask('jconv', '', function() {
    var jconv = require('jconv');
    var config = grunt.config('jconv_sjis');
    var buf = grunt.file.read(config.dist.src);
    grunt.file.write(config.dist.dest, jconv(buf, 'UTF8', 'SHIFT_JIS'));
  });
};