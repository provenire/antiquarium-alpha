/**
 * Antiquarium Controller
 * Artifacts
 */
Antiquarium.Controller["artifacts"] = {
  
  /**
   * #new
   */
  new: function() {
    $('#materials').select2({tags:[]});
  },
  
  
  
  /**
   * #show
   */
  show: function() {
    
    // Edit Properties
    $('#materials_editable').editable({
      select2: {
        tags:[],
        tokenSeparators: [","]
      }
    });
    $('#alternate_names').editable();
    $('#date_created').editable();
    $('#artist').editable();
    $('#dimensions').editable();
    
    
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
  
  
    // Clickable rows
    Antiquarium.Common.clickable();
  
    // Initialize Cloudinary
    Antiquarium.Common.cloudinaryUpload();
  }

};