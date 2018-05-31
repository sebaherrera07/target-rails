function showCreateTargetSection() {
  if ($('#sidebar_compatible_targets')) {
    $('#sidebar_compatible_targets').hide();
    $('#sidebar_new_target').show();
  }
}

function showTargetMatchesSection() {
  hideSelectedMarker();
  $('#sidebar_new_target').hide();
  $('#sidebar_compatible_targets').show();
}

function fillTargetModalData(clickedMarker) {
  $('#targetTitle').text(clickedMarker.targetTitle);
  $('#targetTopic').text(clickedMarker.targetTopic);
  $('#targetSize').text(clickedMarker.targetSize);
}

function generateIconObject(iconUrl) {
  var icon = {
    url: iconUrl,
    scaledSize: new google.maps.Size(25, 25),
    origin: new google.maps.Point(0, 0),
    anchor: new google.maps.Point(13, 13)
  };
  return icon;
}
