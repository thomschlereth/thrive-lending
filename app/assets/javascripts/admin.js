$(document).ready( function(){
  $('#show-admin-user-nav').on('click', function() {
    if ($('.admin-user-nav').hasClass("hidden")) {
      $('.admin-user-nav').removeClass("hidden");
      $('.full-site-nav').addClass("hidden");
    }
  });
  $('#show-admin-sitewide-nav').on('click', function() {
    if ($('.full-site-nav').hasClass("hidden")) {
      $('.admin-user-nav').addClass("hidden");
      $('.full-site-nav').removeClass("hidden");
    }
  });
});
