function init(){
  $('.dropdown-toggle').dropdown();
  $('[data-toggle="popover"]').popover();
}

// turbolinks requires special bindings
$(document).ready(init);
$(document).on('page:load', init);