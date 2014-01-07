//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require pickadate.js/lib/picker.js
//= require pickadate.js/lib/picker.date.js
//= require_tree .
// 

$(document).ready(function() {
  $('ul.nav.navbar-nav.pull-right li a').hover(
    function() {
      $(this).css('color', '#db3c14');
    }, function(){
      $(this).css('color', '#22262f');
    }
  );
});

function showConfirm(initializer) {
  $(initializer).click(function() {

    var initialButton = this;
    var itemId = $(initialButton).data('item');
    var confirmationButton = $('.js-btn-confirm-delete-' + itemId);
    var $marginLefty = $('li.list-group-item#product-' + itemId);
    
    $marginLefty.animate({
      marginLeft: parseInt($marginLefty.css("margin-left" ),10) == 0 ? 
        $marginLefty.outerWidth() * 0.40 : 
        0
    });
    $(confirmationButton).show('slide', 'right', 100).promise().done(function(){
      $("div").click(function() {
        console.log( parseInt( $marginLefty.css( "margin-left" ),10 ) );
        if(parseInt($marginLefty.css("margin-left" ),10) > 0) {
          $marginLefty.animate({
            marginLeft: 0
          });
          $(confirmationButton).show('slide', 'left', 100);
        }
      });
    });
  });
}

$(document).ready(function() {
  $('li.list-group-item').each(function() {
    showConfirm('.js-item-delete');
  });
});

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-46903772-1', 'giftshare.io');
ga('send', 'pageview');