
Kindrdfood = Kindrdfood || {};


Kindrdfood.dietitians = Kindrdfood.dietitians || {};

Kindrdfood.dietitians.edit = {

	init: function(){

		this.set_button();
		this.set_image_preview();

	},

  set_button: function(){
    $("#edit-profile-container #change-password-button").on("click", function(e){
      e.preventDefault();
      $("#edit-profile-container #change-password-container").toggleClass("hidden");
    })
  },
  set_image_preview: function(){
    function readURL(input) {

      if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#edit-profile-container #image-preview').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
      }
    }
    $("#edit-profile-container .upload").change(function(){
      $("#image-preview").removeClass("hidden");
      readURL(this);
    });
  }
}