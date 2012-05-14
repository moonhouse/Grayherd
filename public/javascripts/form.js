$(document).ready(function() {
    $('#registration_ssn').bind('hastext', function () {
  $('#exhibitaButton').removeClass('disabled').attr('disabled', false);
});

$('#registration_ssn').bind('notext', function () {
  $('#exhibitaButton').addClass('disabled').attr('disabled', true);
});

$('#registration_ssn').bind('textchange', function (event, previousText) {


});

    $('#registration_ssn').focus(function() {
    $('#ssn_info').show(100);
    });
     $('#registration_ssn').blur(function() {
    $('#ssn_info').hide(200);
    });

});
