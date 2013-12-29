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
    var initialButton = ('#js-item-delete-' + itemId);
    var confimationButton = ('#js-btn-confirm-delete-' + itemId);
    $(initialButton).click(function() {
      $(this).hide();
      $(confimationButton).show("slide", "right");
    });
    $(document).on('click', '#js-item-delete-' + itemId, function() {
      $(document).click(function() {
        $(confimationButton).hide("slide", "left");
        $(initialButton).show();
      });
    });
  });
});

  
  


