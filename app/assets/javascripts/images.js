

var Images = {
	set_crop: function(){
		$('#cropbox').Jcrop({
			setSelect: [0, 0, 600, 600],
			aspectRatio: 1,
      onSelect: this.update,
      onChange: this.update
		});
	},
	update: function(coords){
		$('#image_crop_x').val(coords.x);
   	$('#image_crop_y').val(coords.y);
   	$('#image_crop_w').val(coords.w);
   	$('#image_crop_h').val(coords.h);
   	Images.updatePreview(coords)
	},
  updatePreview: function(coords) {
    $('#preview').css({
      width: Math.round(100 / coords.w * $('#cropbox').width()) + 'px',
      height: Math.round(100 / coords.h * $('#cropbox').height()) + 'px',
      marginLeft: '-' + Math.round(100 / coords.w * coords.x) + 'px',
      marginTop: '-' + Math.round(100 / coords.h * coords.y) + 'px'
    });
  },
  set_image_preview: function(){
    function readURL(input) {

      if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#image-preview').attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
      }
    }
    $(".upload").change(function(){
      $("#image-preview").removeClass("hidden");
      readURL(this);
      $(".temp-image").hide();
    });
  }
}
