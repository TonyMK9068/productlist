//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require pickadate.js/lib/picker.js
//= require pickadate.js/lib/picker.date.js
//= require_tree .
// 




$(document).ready(function(){
  $('ul.nav.navbar-nav.pull-right li a').hover(
    function() {
      $(this).css('color', '#db3c14');
    }, function(){
      $(this).css('color', '#22262f');
    }
  );
});



$(document).ready(function() {
  $('li.list-group-item').each(function() {
    var listItem = $(this);
    var itemId = $(this).data("item");
    $('#js-item-delete-' + itemId).click(function() {
      $(this).hide();
      $('#js-btn-confirm-delete-' + itemId).show("slide", "right");

    });
  });
});

  
  


