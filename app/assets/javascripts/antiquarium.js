//= require antiquarium/namespace.js
//= require antiquarium/common.js
//= require antiquarium/nationalities.js
//= require antiquarium/controller.js
//= require_tree ./controllers

Antiquarium.run = function(controller, action) {
  if (typeof Antiquarium.Controller[controller][action] === 'function') {
    Antiquarium.Controller[controller][action]();
  }
};