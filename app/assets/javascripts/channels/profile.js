$(document).ready(function(){
  $("#submit-button").click(function(){
    App.profile = App.cable.subscriptions.create({channel: "ProfileChannel", email: $("#message_input").val(), password: $("#password_input").val()},{
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        alert("dfdffd")
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




// App.profile = App.cable.subscriptions.create "ProfileChannel", room: 'ssss'
//   connected: ->
//     # Called when the subscription is ready for use on the server

//   disconnected: ->
//     # Called when the subscription has been terminated by the server

//   received: (data) ->
//     # Called when there's incoming data on the websocket for this channel

//   sign_in: ->
//     @perform 'sign_in'

//   sign_up: ->
//     @perform 'sign_up'

//   sign_out: ->
//     @perform 'sign_out'

//   edit: ->
//     @perform 'edit'
