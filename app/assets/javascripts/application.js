//  This is a manifest file that'll be compiled into application.js, which will include all the files
//  listed below.
// 
//  Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
//  or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
// 
//  It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
//  the compiled file.
// 
//  WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
//  GO AFTER THE REQUIRES BELOW.
//  Loads all Bootstrap javascripts
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require pickadate.js/lib/picker.js
//= require pickadate.js/lib/picker.date.js
//= require pickadate.js/lib/legacy.js
//= require typewriter-0.2/build/typewriter-bundle-sa.min.js
//= require typewriter-0.2/build/typewriter-bundle.min.js
//= require musclesoft-jquery-connections-7f76e46/jquery.connections.js
//= jquery-ui.js
//= require_tree .
// 

var typewriter = require('typewriter');
var twInput = document.getElementById('typewriter');
var tw = typewriter(twInput).withAccuracy(95)
                             .withMinimumSpeed(3)
                             .withMaximumSpeed(12)
                             .build();

// 
// });  
  // $('.form-group').show(function() {
  //     $(this).css('height', '400px');
  //     $(this).css('width', '300px');
  //   });

  // tw.waitRange(600, 1000).type('Miley Cyrus');
  // $(document).ready(function() {
  //   $(".thumbnail-box").show("slide", "left", function() {
  //     $(".connection").show(5000, "swing");
  //   });
    // $(".thumbnail-box").connections({ to: "#search-box"});
    
