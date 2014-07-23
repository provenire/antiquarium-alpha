var system = require('system');
console.log(system.args[1]);
console.log(system.args[2]);
var page = require('webpage').create();
page.viewportSize = { width: 1200, height: 900 };
page.open(system.args[1], function() {
  page.render(system.args[2]);
  phantom.exit();
});