$(function() {
$customAudiencesElement = $("#custom-audiences")
  customAudiencesPath = $customAudiencesElement.data("path")
  $.get(customAudiencesPath, function(data) {
    $customAudiencesElement.html(data);
  });
});