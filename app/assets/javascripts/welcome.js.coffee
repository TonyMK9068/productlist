$ ->
  $('.btn-welcome').mouseenter ->
    $(this).css('background-color', '#008cba')
    $(this).css('color', 'white')
  $('.btn-welcome').mouseout ->
    $(this).css('background-color', 'white')
    $(this).css('color', 'black')

  $('i.fa.fa-3x').mouseenter ->
    subject = $(this)
    $(subject).addClass('fa-5x').removeClass('fa-3x').delay(2500).queue ->
      $(subject).addClass('fa-3x').removeClass('fa-5x').dequeue()