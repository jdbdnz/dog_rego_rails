function init(){
  $('.dropdown-toggle').dropdown();
}

// turbolinks requires special bindings
$(document).ready(init);
$(document).on('page:load', init);