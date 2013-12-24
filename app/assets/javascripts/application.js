//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require pickadate.js/lib/picker.js
//= require pickadate.js/lib/picker.date.js
//= require pickadate.js/lib/legacy.js
//= jquery-ui.js
//= require_tree .
// 

$(document).ready(function(){
  $('li a').hover(
    function() {
      $(this).css('color', '#db3c14');
    }, function(){
      $(this).css('color', '#22262f');
    }
  );
});

