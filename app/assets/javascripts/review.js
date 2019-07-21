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
  $('.reviews').on('click', '.review-edit-button', function(e){
    var review_id = $(this).attr('id')
    var review_rating = $('#'+review_id).parent().siblings('.golden-star').length
    var reviewer_id = $(this).parent().siblings('.reviewer_id').val()
    var review_comment = $('#review_'+review_id).text()
    review_comment = $.trim(review_comment)
    var action = $('.modal').find('#new_review').attr('action')
    action = action.replace('-1', review_id)
    $('#editReview').find('#new_review').attr('action', action)
    $('#editReview').find('#review_comment').text(review_comment)
    $('#editReview').find('.form-group').append('<input type="hidden" class="reviewer_id" name="reviewer_id" value='+reviewer_id+'>')
    $('.modal').find('fieldset').find('input[value='+review_rating+']').attr('checked','checked')
  });
});
