/**
 * Antiquarium Controller
 * Events
 */
Antiquarium.Controller["citations"] = {

  new: function() {  
    
    // Book Select2
    $("input:text.book#source_id").select2({
      id: function(e) { return JSON.stringify(e) },
      placeholder: "Start typing a name...",
      minimumInputLength: 3,
      allowClear: true,
      ajax: {
        url: '/sources/find_book.json',
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
      id: function(book) {
        return book.id;
      },
      formatResult: function(book) {
        var img = (book.thumbnail) ? "<img width='33' height='50' src='"+book.thumbnail+"' class='img-responsive' />" : "<img data-src='holder.js/50x33/text:?' />";
        return "<div class='row'><div class='col-sm-2'>"+img+"</div><div class='col-sm-10'>"+book.name+"<br><em><small>Authors: "+book.authors+"</small></em></div></div>";
      },
      formatSelection: function(book) {
        return book.name;
      }
    });
    
  }
  
};