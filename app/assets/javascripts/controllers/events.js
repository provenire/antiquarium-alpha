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
    // Editable
    $('#date').editable({
      type:  'combodate',
      pk:     gon.entity_id,
      url:   '/events/'+gon.entity_id,
      title: 'Date'
    });
    
    $('#location').editable({
      type:  'text',
      pk:     gon.entity_id,
      url:   '/events/'+gon.entity_id,
      title: 'Location'
    });
    
    $('#price_currency').editable({
      type:  'select',
      pk:     gon.entity_id,
      url:   '/events/'+gon.entity_id,
      title: 'Currency',
      source: gon.currency,
      value:  gon.price.iso,
      display: function(value, sourceData) {
        var vals = $.fn.editableutils.itemsByValue(value, sourceData);
        if (vals.length) {
          $(this).html(gon.iso_to_symbol[vals[0].text]);
        } else {
          $(this).empty();
        }
      }
    });
    
    $('#price').editable({
      type:  'text',
      pk:     gon.entity_id,
      url:   '/events/'+gon.entity_id,
      title: 'Price',
      value:  gon.price.value
    });
    
    $('#failed').editable({
      type:  'select',
      pk:     gon.entity_id,
      url:   '/events/'+gon.entity_id,
      title: 'Failed',
      source: [
        { value: 'false', text: 'false' },
        { value: 'true',  text: 'true' }
      ]
    });
    
    // Edit Details
    $('#details').editable({
      type:   'textarea',
      pk:      gon.entity_id,
      url:    '/events/'+gon.entity_id,
      title:  'Details',
      toggle: 'manual',
      showbuttons: 'bottom'
    });
    $('#details').on('shown', function(e, editable) {
      $('#edit_details').hide();
    });
    $('#details').on('hidden', function(e, editable) {
      $('#edit_details').show();
    });
    $('#edit_details').click(function(e) {
      e.stopPropagation();
      $('#details').editable('show');
    });
    
    
    // Clickable rows
    Antiquarium.Common.clickable();
  }
  
};