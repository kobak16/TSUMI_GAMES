$(function() {
  $('.slider').slick({
    arrows: true,
	  speed: 800,
    dots: true,
    infinite: true,
    centerMode: true,
    centerPadding: "30%",
    prevArrow: '<i class="fa fa-angle-left" aria-hidden="true"></i>',
    nextArrow: '<i class="fa fa-angle-right" aria-hidden="true"></i>'
  });
});