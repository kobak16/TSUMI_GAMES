$(function() {
  $('.slider1').slick({
    autoplay: false,
    arrows: true,
    slidesToShow: 1, 
    slidesToScroll: 1, 
    prevArrow: '<i class="fa fa-angle-left" aria-hidden="true"></i>',
    nextArrow: '<i class="fa fa-angle-right" aria-hidden="true"></i>'
  });
});
$(function() {
  $('.slider2').slick({
    autoplay: false,
    arrows: true,
    slidesToShow: 2,
    slidesToScroll: 2, 
    prevArrow: '<i class="fa fa-angle-left" aria-hidden="true"></i>',
    nextArrow: '<i class="fa fa-angle-right" aria-hidden="true"></i>'
  });
});
$(function() {
  $('.slider3').slick({
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