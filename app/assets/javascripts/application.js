//
// Antiquarium JS
//
//= require jquery-1.11.1.min.js
//= require jquery_ujs
//= require bootstrap.js
//= require cloudinary
//= require holder.js
//= require select2.min.js
//= require bootstrap-editable.js
//= require moment.js
//= require ractive.js
// require pdf.js
//
// require misc/currency.js
//
//= require antiquarium.js


/***************************
 *** START CONFIGURATION ***
 ***************************/

// X-Editable
$.fn.editable.defaults.mode        = 'inline';
$.fn.editable.defaults.ajaxOptions = { type: "PUT" };
$.fn.editable.defaults.error = function(response, newValue) {
  switch(response.status) {
  case 500:
    return 'Service unavailable. Please try later.';
    break;
  case 0:
    return 'Server currently unreachable. Please try later.';
    break;
  default:
    return 'There was an error. Please try later.';
    break;
  }
}


/*************************
 *** END CONFIGURATION ***
 *************************/