$(document).ready(function(){
  $('#new_review').on('ajax:beforeSend',function(e){
    if ($('.star:checked').length == 0)
    {
      alert("You cannot post a review without giving rating");
      return false;
    }
  });
});

$(document).ready(function(){
  $('.review-edit-button').on('click',function(e){
    alert("hello")
    var review_id = $(this).attr('id')
    var review_comment = $('#review_'+review_id).text()
    review_comment = $.trim(review_comment)
    var action = $('.modal').find('#new_review').attr('action')
    action = action.replace('-1', review_id)
    $('.modal').find('#new_review').attr('action', action)
    $('.modal').find('#review_comment').text(  review_comment)
  });
});
