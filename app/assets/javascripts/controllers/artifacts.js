/**
 * Antiquarium Controller
 * Artifacts
 */
Antiquarium.Controller["artifacts"] = {
  
  /**
   * #index
   */
  index: function() {},
  
  
  
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
    $('#materials_editable').editable({
      select2: {
        tags:[],
        tokenSeparators: [","]
      }
    });
    $('#alternate_names_editable').editable();
    $('#date_created').editable();
    $('#artist').editable();
  
    Antiquarium.Common.cloudinaryUpload();
  }

};