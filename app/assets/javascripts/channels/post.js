$(document).ready(function(){
  $("#submit-button").click(function(){
    alert("dddd")
    App.profile = App.cable.subscriptions.create({channel: "ProfileChannel", email: $("#message_input").val(), password: $("#password_input").val()},{
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        console.log(data)
      },
      
      sign_up: function() {
        return this.perform('sign_up');
      },
      sign_out: function() {
        return this.perform('sign_out');
      },
      edit: function(data) {
        return this.perform('edit', data);
      } 
    });  
  })
})



// App.post = App.cable.subscriptions.create "PostChannel",
//   connected: ->
//     # Called when the subscription is ready for use on the server

//   disconnected: ->
//     # Called when the subscription has been terminated by the server

//   received: (data) ->
//     # Called when there's incoming data on the websocket for this channel

//   index: ->
//     @perform 'index'

//   create: ->
//     @perform 'create'

//   delete: ->
//     @perform 'delete'
