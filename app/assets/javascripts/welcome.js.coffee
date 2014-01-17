$ ->
  $('.btn-welcome').mouseenter ->
    $(this).css('background-color', 'white')
    $(this).css('color', '#00a997')
  $('.btn-welcome').mouseout ->
    $(this).css('background-color', '#00a997')
    $(this).css('color', 'white')

  $('i.fa.fa-3x').mouseenter ->
    subject = $(this)
    $(subject).addClass('fa-5x').removeClass('fa-3x').delay(2500).queue ->
      $(subject).addClass('fa-3x').removeClass('fa-5x').dequeue()
      
  $('.js-navy').mouseenter ->
    $(this).css('background-color', 'white')
    $(this).css('color', 'black')
  $('.js-navy').mouseout ->
    $(this).css('background-color', '#333333')
    $(this).css('color', '#008cba')
