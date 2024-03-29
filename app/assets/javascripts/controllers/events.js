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
    
    
    
    // Actor Modal
    $('#find_actor_modal button[data-dismiss="modal"]').on('click', function(e) {
      $('#find_actor_form').trigger('reset');
      $('.add_primary_actor').show();
      $('#find_actor_form').unbind();
      $("#actor").select2('val', null);
      $("#actor").select2('enable', true);
    });
    
    $("#unknown_actor").change(function() {
      if ($(this).is(":checked")) {
        $("#actor").select2('enable', false);
      }
      if (!$(this).is(":checked")) {
        $("#actor").select2('enable', true);
      }
    });
    
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
    
    
    // Manage Actors
    function addActor(e) {
      var kind = e.data.kind;
      e.preventDefault();
      $(this).hide();
      $('#find_actor_modal').modal('show');
      $('#find_actor_form').submit(function(e) {
        e.preventDefault();
        var actor = { kind: kind };
        if ($('#unknown_actor').is(":checked")) {
          actor.unknown = true;
        } else {
          actor.info = $('#actor').val();
        }
        $.ajax({
          url: '/events/'+gon.entity_id,
          type: 'PUT',
          data: { actor: actor }
        })
        .done(function(response) {
          location.reload();
        });
      });
    }
    
    $('.remove_actor').on('click', function(e) {
      e.preventDefault();
      var info = $(this).attr('href').substring(1).split('_');
      var kind = ($(this).hasClass('primary')) ? 'primary' : 'secondary';
      var actor = {
        id:   info[1],
        type: info[0],
        kind: kind
      };
      $.ajax({
        url: '/events/'+gon.entity_id,
        type: 'PUT',
        data: { remove_actor: actor }
      })
      .done(function(response) {
        if (response.deleted) {
          location.reload();
        }
      });
    });
    
    $('.add_primary_actor').on('click', { kind: 'primary'}, addActor);
    $('.add_secondary_actor').on('click', { kind: 'secondary'}, addActor);
    
    
    
    // Actor Modal
    $('#find_artifact_modal button[data-dismiss="modal"]').on('click', function(e) {
      $('#find_artifact_form').trigger('reset');
      $('.add_artifact').show();
      $('#find_artifact_form').unbind();
      $("#artifact").select2('val', null);
      $("#artifact").select2('enable', true);
    });
    
    $("input:text.artifact").select2({
      id: function(e) { return JSON.stringify(e) },
      placeholder: "Start typing a name...",
      minimumInputLength: 3,
      allowClear: true,
      ajax: {
        url: '/events/artifacts.json',
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
      formatResult: function(artifact) {
        return '<span class="glyphicon glyphicon-glass"></span> '+artifact.text;
      },
      formatSelection: function(artifact) {
        return '<span class="glyphicon glyphicon-glass"></span> '+artifact.text;
      }
    });
    
    $('.add_artifact').on('click', addArtifact);
    
    // Manage Artifacts
    function addArtifact(e) {
      e.preventDefault();
      $(this).hide();
      $('#find_artifact_modal').modal('show');
      $('#find_artifact_form').submit(function(e) {
        e.preventDefault();
        $.ajax({
          url: '/events/'+gon.entity_id,
          type: 'PUT',
          data: { artifact: $('#artifact').val() }
        })
        .done(function(response) {
          location.reload();
        });
      });
      
      $('.remove_artifact').on('click', function(e) {
        e.preventDefault();
        var info = $(this).attr('href').substring(1).split('_');
        var kind = ($(this).hasClass('primary')) ? 'primary' : 'secondary';
        var artifact = {
          id:   info[1],
          type: info[0],
          kind: kind
        };
        $.ajax({
          url: '/events/'+gon.entity_id,
          type: 'PUT',
          data: { remove_actor: actor }
        })
        .done(function(response) {
          if (response.deleted) {
            location.reload();
          }
        });
      });
    }
    
    $('.remove_artifact').on('click', function(e) {
      e.preventDefault();
      var info = $(this).attr('href').substring(1).split('_');
      var artifact = { id: info[1] };
      $.ajax({
        url: '/events/'+gon.entity_id,
        type: 'PUT',
        data: { remove_artifact: artifact }
      })
      .done(function(response) {
        if (response.deleted) {
          location.reload();
        }
      });
    });
      
  }
  
};