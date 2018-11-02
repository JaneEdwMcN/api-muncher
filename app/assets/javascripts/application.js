// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

function attr() {
  var tag, attr = document.getElementById("edamam-badge"),
  elem = attr.getAttribute("data-color"),
  url = "https://developer.edamam.com/images/";
  switch (elem) {
    case "light":
    tag = "light.png";
    break;
    case "badge":
    tag = "badge.png";
    break;
    case "dark":
    tag = "dark.png";
    break;
    case "white":
    tag = "white.png";
    break;
    case "transparent":
    tag = "transparent.png";
    break;
    default:
    tag = "transparent.png";
  }
  tag = '<a href="https://www.edamam.com" title="Powered by Edamam" target="_blank"><img alt="Powered by Edamam" src="' + url + tag + '" height="40" width="200" /></a>', attr.innerHTML = tag;
}

document.addEventListener("turbolinks:load", function() {
  attr();
})
