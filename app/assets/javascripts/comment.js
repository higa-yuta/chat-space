// $(function() {
//   function buildHTML(message) {
//     var html = `
//     <ul class="mainbar__main-groupbox">
//       <il class="groupname">
//         ${message.user_name}
//       </il>
//       <il class="post-time">${message.time}</il>
//     </ul>`
//     return html;
//   }

//   $('.sentBtn').on('submit', function(e) {
//     e.preventDefault();
//     var formData = new FormData(this);
//     var href = window.location.href;
//     $.ajax({
//       url: href,
//       type: 'POST',
//       data: formData,
//       dataType: 'json',
//       processData: false,
//       contentTyep: false
//     })
//     .done(function(data) {
//       var html = buildHTML(data);
//       $('.mainbar__main').append(html);
//       $('#message_text').val('');
//     })
//     .fail(function() {
//       alert('error');
//     })
//   })
// })