$(document).ready(function() {

  //hover for feedback and help
  $('.always-hover').tooltip({trigger: 'manual'}).tooltip('show');
  $('.always-hover').on('click',function(){$(this).tooltip('destroy');});

});