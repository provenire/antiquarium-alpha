/**
Currency input - dropdown currency picker with text input.  
   
Allows to input:

* only value
* only currency 
* both currency and value  

@class currency
@extends abstractinput
@final
@since 1.4.0
*/

(function ($) {
  "use strict";
  
  var Constructor = function (options) {
    this.init('currency', options, Constructor.defaults);
    
    //by default viewformat equals to format
    if(!this.options.viewformat) {
      this.options.viewformat = this.options.format;
    }    
    
    //try parse currency config defined as json string in data-currency
    options.currency = $.fn.editableutils.tryParseJson(options.currency, true);

    //overriding currency config (as by default jQuery extend() is not recursive)
    this.options.currency = $.extend({}, Constructor.defaults.currency, options.currency, {
      format: this.options.format,
      template: this.options.template
    });
  };

  $.fn.editableutils.inherit(Constructor, $.fn.editabletypes.abstractinput);  
  
  $.extend(Constructor.prototype, {
    render: function () {
      this.$input.currency(this.options.currency);
          
      if($.fn.editableform.engine === 'bs3') {
        this.$input.siblings().find('select').addClass('form-control');
      }
      
      if(this.options.inputclass) {
        this.$input.siblings().find('select').addClass(this.options.inputclass);
      }             
    },
    
    value2html: function(value, element) {
      var text = value ? value.format(this.options.viewformat) : '';
      //$(element).text(text);
      Constructor.superclass.value2html.call(this, text, element);  
    },

    html2value: function(html) {
      return null;
    },   
    
    value2str: function(value) {
      return value ? value.fractional : '';
     }, 
     
     str2value: function(str) {
       return str;
     }, 
     
     value2submit: function(value) {
       return this.value2str(value);
     },          

     value2input: function(value) {
       this.$input.combodate('setValue', value);
     },
    
     input2value: function() { 
       return this.$input.combodate('getValue', null);
     },     
     
     activate: function() {
       this.$input.siblings('.combodate').find('select').eq(0).focus();
     },
     
     /*
     clear:  function() {
      this.$input.data('datepicker').date = null;
      this.$input.find('.active').removeClass('active');
     },
     */
     
     autosubmit: function() {
       
     }

  });
  
  Constructor.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
    /**
    @property tpl 
    @default <input type="text">
    **/     
    tpl:'<input type="text">',
    /**
    @property inputclass 
    @default null
    **/     
    inputclass: null,
    /**
    Format used for sending value to server. Also applied when converting date from <code>data-value</code> attribute.<br>
    See list of tokens in [momentjs docs](http://momentjs.com/docs/#/parsing/string-format)  
    
    @property format 
    @type string
    @default YYYY-MM-DD
    **/     
    format:'YYYY-MM-DD',
    /**
    Format used for displaying date. Also applied when converting date from element's text on init.   
    If not specified equals to `format`.
    
    @property viewformat 
    @type string
    @default null
    **/      
    viewformat: null,    
    /**
    Template used for displaying dropdowns.
    
    @property template 
    @type string
    @default D / MMM / YYYY
    **/      
    template: 'D / MMM / YYYY',  
    /**
    Configuration of combodate.
    Full list of options: http://vitalets.github.com/combodate/#docs
    
    @property combodate 
    @type object
    @default null
    **/
    combodate: null
    
    /*
    (not implemented yet)
    Text shown as clear date button. 
    If <code>false</code> clear button will not be rendered.
    
    @property clear 
    @type boolean|string
    @default 'x clear'     
    */
    //clear: '&times; clear'
  });   

  $.fn.editabletypes.currency = Constructor;

}(window.jQuery));