$(document).ready(function(){
  $(".plan-fixed").on("click", function(){
    $(this).toggleClass("toggled");

    if ($('#chevron-identifier').attr('class') == "fa fa-chevron-up"){
        $('#chevron-identifier').removeClass("fa-chevron-up");
        $('#chevron-identifier').addClass("fa-chevron-down");
    } else {
        $('#chevron-identifier').removeClass("fa-chevron-down");
        $('#chevron-identifier').addClass("fa-chevron-up");
    }
  })
});


