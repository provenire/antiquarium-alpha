/**
 * Antiquarium Controller
 * Sources
 */
Antiquarium.Controller["workflows"] = {
  
  website: function() {
    $('#url-form').on('submit', function(e) {
      e.preventDefault();
      var params = $('#url-form').serialize();
      
      $('#url-form input').attr('disabled', true);
      $('#url-form button').attr('disabled', true);
      $('#url-form button').text('Loading...');
      
      $.get('/workflows/extract', params)
      .done(function(results) {
        $('#url-form input').attr('disabled', false);
        $('#url-form button').attr('disabled', false);
        $('#url-form button').text('Submit');
        
        var site = results.site;
        var entities = results.entities;
        
        console.log(entities);
        
        if (site.authors) {
          site.authors = site.authors.map(function(n) { return n.name; });
        }
        web = new Ractive({
          el: '#iframe',
          template: '#iframe-template',
          data: site
        });
      })
      .fail(function() {
        console.log('FAILURE');
      });
    });
  }
  
};