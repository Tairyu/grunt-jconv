'use strict';

var path = require('path');
var fs = require('fs-extra');
var jconv = require('jconv');
var fast = require('fast.js');

var curDest = function(dest, srcPath){
  if(!dest) return srcPath;

  if(path.extname(dest) === ''){
    fs.mkdirpSync(dest);
    return path.join(dest, path.basename(srcPath));
  }
  else {
    return dest;
  }
};

module.exports = function(grunt) {

  grunt.registerMultiTask('jconv', 'Convert files with jconv.', function() {

    var options = this.options({fromEncode: 'UTF8', toEncode: 'UTF8'});

    fast.forEach(this.files, function(file){

      fast
        .filter(file.src, function(srcPath){
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