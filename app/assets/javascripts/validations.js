$(document).ready(function(){
  jQuery.validator.addMethod("lettersonly", function(value, element) {
    return this.optional(element) || /^[a-z\-]+$/i.test(value);
  }, "Letters only please");

  $('#movie_form').validate({
    rules: {
      "movie[title]": "required",
      "movie[description]": "required",
      "movie[genre]": {
        required: true,
        lettersonly: true
      },
      "movie[release_date]": "required",
    },

    messages: {
      "movie[title]": "Please provide movie title",
    }
  }),

  $('#admin_user_form').validate({
    rules: {
      "user[name]": "required",
      "user[password]": {
        minlength: 6
      },
      "user[email]": {
        required: true,
        email: true
      },
    },

    messages: {
      "user[name]": "Please provide User name",
      "user[email]": "Email address should be of format 'abc@domain.com' "
    }
  }),

  /* valdiations for sign in form */
  $('#new_user[action="/users/sign_in"]').validate({
    rules: {
      "user[password]": {
        minlength: 6,
        required: true
      },
      "user[email]": {
        required: true,
        email: true
      },
    },

    messages: {
      "user[email]": "Email address should be of format 'abc@domain.com' "
    }
  }),

  /* Validations for sign up form */
  $('#new_user[action="/users"]').validate({
    rules: {
      "user[name]": "required",
      "user[password]": {
        minlength: 6,
        required: true
      },
      "user[password_confirmation]": {
        minlength: 6,
        required: true
      },
      "user[email]": {
        required: true,
        email: true
      },
      "user[avatar]": "required",
    },

    messages: {
      "user[name]": "Please provide your name.",
      "user[email]": "Email address should be of format 'abc@domain.com'",
      "user[avatar]": "Please select a profile picture."
    }
  })

  /* Validations for actor form */
  $('#actor_form').validate({
    rules: {
      "actor[name]": "required"
    },

    messages: {
      "actor[name]": "Please provide actor name.",
    }
  })

  /* Validations for editing profile */
  $('#edit_user').validate({
    rules: {
      "user[name]": "required",
      "user[email]": {
        required: true,
        email: true
      },
      "user[password]": {
        minlength: 6,
      },
      "user[password_confirmation]": {
        minlength: 6,
      },
      "user[current_password]": {
        minlength: 6,
        required: true
      },
    },

    messages: {
      "actor[name]": "Please provide your name.",
      "user[current_password]": "Current Password cannot be blank."
    }
  })

  /* Vallidations for forget password */
  $('#new_user[action="/users/password"]').validate({
    rules: {
      "user[email]": {
        required: true,
        email: true
      }
    },

    messages: {
      "user[email]": "Email address should be of format 'abc@domain.com'",
    }
  })

  /* Validations for resend confirmation */
   $('#new_user[action="/users/confirmation"]').validate({
    rules: {
      "user[email]": {
        email: true,
        required: true
      }
    },

    messages: {
      "user[email]": "Email address should be of format 'abc@domain.com'",
    }
  })

});
