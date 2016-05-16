// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
// $ ->
//   $messages = $('#messages')
//   $messages.scrollTop $messages.prop('scrollHeight')
//   $('#message_input').focus()

// $(document).on 'keypress', '#message_input', (e) ->
//   if e.keyCode == 13 and e.target.value
//     App.room.speak(e.target.value)
//     e.target.value = ''
//     e.preventDefault()


$(function() {
  var $messages;
  $messages = $('#messages');
  $messages.scrollTop($messages.prop('scrollHeight'));
  return $('#message_input').focus();
});

$(document).on('keypress', '#message_input', function(e) {
  if (e.keyCode === 13 && e.target.value) {
    App.room.speak(e.target.value);
    e.target.value = '';
    return e.preventDefault();
  }

  

});
