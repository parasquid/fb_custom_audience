$(document).ready(function() {
  $("tr[data-href]").on("click", function(event) {
    window.location = $(this).data("href");
  });
});