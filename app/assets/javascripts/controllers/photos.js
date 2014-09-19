/**
 * Antiquarium Controller
 * Photos
 */
Antiquarium.Controller["photos"] = {

  show: function() {
    // Edit Details
    $('#comments').editable({
      type:   'textarea',
      pk:      gon.entity_id,
      url:    '/photos/'+gon.entity_id,
      title:  'Comments',
      toggle: 'manual',
      showbuttons: 'bottom',
      inputclass: 'textarea-expand'
    });
    $('#comments').on('shown', function(e, editable) {
      $('#edit_comments').hide();
    });
    $('#comments').on('hidden', function(e, editable) {
      $('#edit_comments').show();
    });
    $('#edit_comments').click(function(e) {
      e.stopPropagation();
      $('#comments').editable('show');
    });
  }
  
};