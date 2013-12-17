# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
    
  input_open_focus = $( '.datepicker' ).pickadate()
  picker_open_focus = input_open_focus.pickadate( 'picker' )
  $(  '.datepicker' ).on( 'click', (event)->
      picker_open_focus.open( false )
      event.stopPropagation()
      $(document).on( 'click.open_focus', ->
          picker_open_focus.close()
          $(document).off( '.open_focus' )
      )
  )