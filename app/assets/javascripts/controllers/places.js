/**
 * Antiquarium Controller
 * Places
 */
Antiquarium.Controller["places"] = {

  show: function() {
    // Edit Name
    $('#name').editable({
      toggle: 'manual'
    });
    $('#name').on('shown', function(e, editable) {
      $('#edit_name').hide();
    });
    $('#name').on('hidden', function(e, editable) {
      $('#edit_name').show();
    });
    $('#edit_name').click(function(e) {
      e.stopPropagation();
      $('#name').editable('show');
    });
    $('#name').on('save', function(e, editable) {
      $('#breadcrumb_name').text(editable.newValue);
    });
    
    // Edit Description
    $('#description').editable({
      toggle: 'manual',
      showbuttons: 'bottom'
    });
    $('#description').on('shown', function(e, editable) {
      $('#edit_description').hide();
    });
    $('#description').on('hidden', function(e, editable) {
      $('#edit_description').show();
    });
    $('#edit_description').click(function(e) {
      e.stopPropagation();
      $('#description').editable('show');
    });
    
    // Photo Upload
    Antiquarium.Common.cloudinaryUpload();
  }
  
};