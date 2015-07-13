
var LandingPages = {

  formValidation: function(){
    $("#qol-page form").validate({
      rules: {
        "user[first_name]":{
          required: true,
          minlength: 2
        },
        "user[last_name]":{
          required: true,
          minlength: 2
        },
        "user[email]":{
          email: true,
          required: true,
        }
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
      }
    });
    $("#qol-sign-in-page form").validate({
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
    
  }
}
