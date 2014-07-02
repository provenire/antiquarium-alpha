/**
 * Antiquarium Controller
 * Employments
 */
Antiquarium.Controller["employments"] = {
  
  new: function() {
    
    $("#employment_person").select2({
      id: function(e) { return JSON.stringify(e) },
      placeholder: "Start typing a name...",
      minimumInputLength: 3,
      allowClear: true,
      ajax: {
        url: '/people/find.json',
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
        },
        formatResult: function(actor) {
          return '<span class="glyphicon glyphicon-user"></span> '+actor.name;
        },
        formatSelection: function(actor) {
          return actor.name;
        }
      }
    });
    
  }
  
};