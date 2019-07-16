$(document).ready(function(){
  $('#search_text').on('keyup', function(){
    var token = $("input[name='authenticity_token']").val();
    var utf = $("input[name='utf8']").val();
    $.ajax({
      url: '/movie/search_movie',
      type: 'POST',
      data: {utf: utf, authenticity_token: token, search_text: $(this).val() }
    })
  })
});
