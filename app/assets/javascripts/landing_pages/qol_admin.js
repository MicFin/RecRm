
Kindrdfood = Kindrdfood || {};

// create landing pages object if not already created
Kindrdfood.landingPages = Kindrdfood.landingPages || {};

Kindrdfood.landingPages.qolAdmin = {
    validateSignUpForm: function(){
      $("#qol-page form, .new-user-form").validate({
        rules: {
          "user[email]":{
            email: true,
            required: true,
          },
          "user[password]":{
            required: true,
            minlength: 8
          },
          "user[password_confirmation]":{
            required: true,
            minlength: 8,
            equalTo: "#user_password"
          },
        },
        messages: {
          "user[first_name]":{
            required: "Enter first name",
            minlength: "Must be at least 2 letter"
          },
          "user[last_name]":{
            required: "Enter last name",
            minlength: "Must be at least 2 letter"
          },
          "user[email]":{
            email: "Enter valid email",
            required: "Enter valid email"
          },
          "user[password]":{
            required: "Enter password",
            minlength: "Must be at least 8 characters"
          },
          "user[password_confirmation]":{
            required: "Confirm password",
            minlength: "Must be at least 8 characters",
            equalTo: "Confirmation and password do not match"
          },
        }
      });
    },
    validateSignInForm: function(){
      $("form.sign-in-form").validate({
        rules: {
          "user[password]":{
            required: true,
            minlength: 8
          },
          "user[password_confirmation]":{
            required: true,
            minlength: 8,
            equalTo: "#user_password"
          },
        },
        messages: {
          "user[password]":{
            required: "Enter password",
            minlength: "Must be at least 8 characters"
          },
          "user[password_confirmation]":{
            required: "Confirm password",
            minlength: "Must be at least 8 characters",
            equalTo: "Confirmation and password do not match"
          },
        }
      });
    },
    validateProviderForm: function(){
      $("#refer-landing-page form").validate({
        rules: {
          "user[first_name]":{
            required: true,
            minlength: 2
          },
          "user[last_name]":{
            required: true,
            minlength: 2
          },
          "user[last_name]":{
            required: true,
            minlength: 2
          },
          "user[hospitals_or_practices]":{
            minlength: 2,
            required: true,
          },
          "user[specialty]":{
            minlength: 2,
            required: true,
          },
          "user[password]":{
            required: true,
            minlength: 8
          },
          "user[password_confirmation]":{
            required: true,
            minlength: 8,
            equalTo: "#user_password"
          },
        },
        messages: {
          "user[first_name]":{
            required: "Enter first name",
            minlength: "Must be at least 2 letter"
          },
          "user[last_name]":{
            required: "Enter last name",
            minlength: "Must be at least 2 letter"
          },
          "user[hospitals_or_practices]":{
            minlength: "Must be at least 2 letters",
            required: "Enter hospital, practice or academic affiliation",
          },
          "user[specialty]":{
            minlength: "Must be at least 2 letters",
            required: "Enter specialty",
          },
          "user[email]":{
            email: "Enter valid email",
            required: "Enter valid email"
          },
          "user[password]":{
            required: "Enter password",
            minlength: "Must be at least 8 characters"
          },
          "user[password_confirmation]":{
            required: "Confirm password",
            minlength: "Must be at least 8 characters",
            equalTo: "Confirmation and password do not match"
          },
        }
      });
    },
  }

