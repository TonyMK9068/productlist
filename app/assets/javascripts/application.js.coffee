# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
# Loads all Bootstrap javascripts
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require rondell/dist/jquery.rondell.min.js
#= require rondell/libs/modernizr-2.0.6.min.js
#= require rondell/libs/jquery.mousewheel-3.0.6.min.js
#= require pickadate.js/lib/picker.js
#= require pickadate.js/lib/picker.date.js
#= require pickadate.js/lib/legacy.js
#= require_tree .
#

$ ->

  $("div#rondellPages").rondell({
    preset: "pages"
  })