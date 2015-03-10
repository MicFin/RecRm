// http://stackoverflow.com/questions/18632644/google-analytics-with-rails-4
// allows tracker to work around rails turbolinks
$(document).on('page:change', function() {
 if (window._gaq != null) {
  return _gaq.push(['_trackPageview']);
 } else if (window.pageTracker != null) {
  return pageTracker._trackPageview();
 }
});