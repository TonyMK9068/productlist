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



$(document).ready(function(){
  $('li.list-group-item').each(function(){

    var outerdiv = $(this);
    var itemId = $(outerdiv).data('item');
    var initialButton = $('#js-item-delete-' + itemId);
    var confirmationButton = $('#js-btn-confirm-delete-' + itemId);
    var $marginLefty = $(outerdiv);
    
    $(initialButton).click(function(){  
      $marginLefty.animate({
        marginLeft: parseInt($marginLefty.css('marginLeft'),10) == 0 ? 
          $marginLefty.outerWidth() * 0.40 : 
          0
      });
      $(confirmationButton).show('slide', 'right', 100);
      $(document).on("click", initialButton, function(){
        $("div").click(function(){
          $marginLefty.animate({
            marginLeft: '0px'
          });
          $(confirmationButton).show('slide', 'left', 100);
        });
      });
    });
  });
});