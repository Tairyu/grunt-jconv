'use strict';

var path = require('path');
var fs = require('fs');
var jconv = require('jconv');

module.exports = function(grunt) {

  var curDest = function(dest, srcPath){
    if(!dest) return srcPath;

    if(path.extname(dest) === ''){
      grunt.file.mkdir(dest);
      return path.join(dest, path.basename(srcPath));
    }
    else {
      return dest;
    }
  };

  grunt.registerMultiTask('jconv', 'Convert files with jconv.', function() {

    var options = this.options({fromEncode: 'UTF8', toEncode: 'UTF8'});

    this.files.forEach(function(file){

      file.src
        .filter(function(srcPath){
          if(!grunt.file.exists(srcPath)) {
            grunt.log.warn('src file "' + srcPath + '" not found.');

            return false;
          }

          return true;
        })
        .map(function(srcPath){
          grunt.file.write(
            curDest(file.dest, srcPath),
            jconv(fs.readFileSync(srcPath), options.fromEncode, options.toEncode));
      });
    });
  });
};