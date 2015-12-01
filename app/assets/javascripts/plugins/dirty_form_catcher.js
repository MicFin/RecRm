// checks if inputs have been motified and warns if users leaves browser
var DirtyFormCatcher = {

  start: function(){
    var _isDirty = false;
    $(":input").change(function(){
      _isDirty = true;
    });  
    // creates a function to override the close window prompt
    function closeEditorWarning(event){
      if (_isDirty === true) {
        return 'It looks like you have been editing something -- if you leave before submitting your changes will be lost.'
      };
    };
    // on before unload chßeck if forms are dirty.
    window.onbeforeunload = closeEditorWarning; 
    // disable onbeforeunlaod for submits
    $('form').submit(function () {
      window.onbeforeunload = null;
    });
  }

}
    