/**
 * Antiquarium Controller
 * Events
 */
Antiquarium.Controller["events"] = {

  new: function() {
    
    // Unknown
    $("#actor_primary_unknown").change(function() {
      if ($(this).is(":checked")) {
        $("#actor_primary").select2('enable', false);
      }
      if (!$(this).is(":checked")) {
        $("#actor_primary").select2('enable', true);
      }
    });
    
    $("#actor_secondary_unknown").change(function() {
      if ($(this).is(":checked")) {
        $("#actor_secondary").select2('enable', false);
      }
      if (!$(this).is(":checked")) {
        $("#actor_secondary").select2('enable', true);
      }
    });
    
    $("#location_unknown").change(function() {
      if ($(this).is(":checked")) {
        $("#location").prop('disabled', true);
      }
      if (!$(this).is(":checked")) {
        $("#location").prop('disabled', false);
      }
    });
    
    
    // Actor Select2
    $("input:text.actor").select2({
      id: function(e) { return JSON.stringify(e) },
      placeholder: "Start typing a name...",
      minimumInputLength: 3,
      allowClear: true,
      ajax: {
        url: '/events/actors.json',
        dataType: 'json',
        quietMillis: 400,
        data: function(term, page) {
          return {
            q: term,
            page_limit: 10
          };
        },
        results: function(data, page) {
          return {results: data}
        },
        initSelection: function(element, callback) {
          var data = JSON.parse(element.val());
          callback(data);
        }
      },
      formatResult: function(actor) {
        var icon = (actor.type === 'Person') ? 'user' : 'map-marker';
        return '<span class="glyphicon glyphicon-'+ icon +'"></span> '+actor.text;
      },
      formatSelection: function(actor) {
        var icon = (actor.type === 'Person') ? 'user' : 'map-marker';
        return '<span class="glyphicon glyphicon-'+ icon +'"></span> '+actor.text;
      }
    });
    
  },
  
  
  
  show: function() {
    // Clickable rows
    Antiquarium.Common.clickable();
  }
  
};