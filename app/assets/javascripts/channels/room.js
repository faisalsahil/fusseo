// App.room = App.cable.subscriptions.create "RoomChannel",
//   connected: (data) ->
//     # Called when the subscription is ready for use on the server

//   disconnected: ->
//     # Called when the subscription has been terminated by the server

//   received: (data) ->
//     # Called when there's incoming data on the websocket for this channel
//     $messages = $('#messages')
//     $messages.append data
//     $messages.scrollTop $messages.prop('scrollHeight')

//   speak: (message) ->
//     @perform 'speak', message: message

//   just_follow: (data) ->
//     @perform 'follow', message_id: data

//   create_post: (data) ->
//     @perform 'create_post', data: data


// App.room = App.cable.subscriptions.create("RoomChannel", {
//   connected: function(data) {console.log(data)},
//   disconnected: function() {},
//   received: function(data) {
//     var $messages;
//     $messages = $('#messages');
//     $messages.append(data);
//     return $messages.scrollTop($messages.prop('scrollHeight'));
//   },
//   speak: function(message) {
//     return this.perform('speak', {
//       message: message
//     });
//   },
//   just_follow: function(data) {
//     this.perform('follow', {
//       message_id: data
//     });

//     data = this.perform('speak', {message: "message"});
//     console.log(data)
//     return 
//   },
//   create_post: function(data) {
//     return this.perform('create_post', {
//       data: data
//     });
//   }
// });