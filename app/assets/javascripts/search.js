$(document).ready(function(){
  $('.container').on('keyup', '#search_text', search_ajax)
  $('.container').on('change', '#genre', search_ajax)
  $('body').on('click', function(){
    $('div#search_suggestion').empty()
  })
});

var search_ajax = function(){
  var token = $("input[name='authenticity_token']").val();
  var utf = $("input[name='utf8']").val();
  var search_text = $('#search_text').val();
  $.ajax({
    url: '/movie/search_movie',
    type: 'POST',
    data: { utf: utf, authenticity_token: token, search_text: search_text, genre: $('#genre').find(":selected").text() }
  })
}

/* Js for flash messages */
$(document).ready(function(){
  $(".alert").delay(3000).fadeOut("slow");
});
