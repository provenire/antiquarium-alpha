/**
 * Antiquarium Controller
 * Home
 */
Antiquarium.Controller["home"] = {
  
  /**
   * #index
   */
  index: function() {
    // Edit Content
    $('#home_content').editable({
      toggle: 'manual',
      showbuttons: 'bottom',
			escape: false,
			success: function(response, newValue) {
				location.reload();
			}
    });
    $('#home_content').on('shown', function(e, editable) {
      $('#edit_content').hide();
    });
    $('#home_content').on('hidden', function(e, editable) {
      $('#edit_content').show();
    });
    $('#edit_content').click(function(e) {
      e.stopPropagation();
      $('#home_content').editable('show');
    });
  }
  
};