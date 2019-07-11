$(document).ready(function(){
  $('#new_review').on('ajax:beforeSend',function(e){
    if ($('.star:checked').length == 0)
    {
      alert("You cannot post a review without giving rating");
      return false;
    }
  });
});

