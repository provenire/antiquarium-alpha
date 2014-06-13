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
  
    Antiquarium.Common.cloudinaryUpload();
  }

};