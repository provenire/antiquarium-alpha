/**
 * Antiquarium Controller
 * People
 */
Antiquarium.Controller["people"] = {

  show: function() {
    
    // Gender
    $('#gender').editable({
      source: [
        { value: 'unknown', text: 'unknown' },
        { value: 'male',    text: 'male' },
        { value: 'female',  text: 'female' }
      ]
    });
    
    // Nationality
    $('#nationality').editable({
      mode: 'popup',
      source: Antiquarium.Nationalities
    });
    
    // DOB
    $('#date_of_birth').editable({
      mode: 'popup',
      placement: 'left',
      combodate: {
        minYear: 1700
      }
    });
  
    // DOD
    $('#date_of_death').editable({
      mode: 'popup',
      placement: 'left',
      combodate: {
        minYear: 1700
      }
    });
    
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
    
    // Initialize Cloudinary
    Antiquarium.Common.cloudinaryUpload();
  }
  
};