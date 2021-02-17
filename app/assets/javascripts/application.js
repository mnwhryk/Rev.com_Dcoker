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
//
//= require jquery
//= require jquery.raty.js
//= require rails-ujs
//= require turbolinks
//= require activestorage

//コミック
/* global $document */
$(document).on('turbolinks:load', function() {
  /* global $ */
  $('#slider').slick({
    slidesToShow: 5,
    slidesToScroll: 1,
    autoplay: true,
    dots: true,
    adaptiveHeight: false,
    speed: 700,
    pauseOnHover: true,
    prevArrow:'<div class="prev"><i class="fas fa-caret-square-left"></i></div>',
	  nextArrow:'<div class="next"><i class="fas fa-caret-square-right"></i></div>',
  });
});

//レビュー
/* global $document */
$(document).on('turbolinks:load', function() {
  /* global $ */
  $('#review-slider').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    dots: true,
    adaptiveHeight: false,
    speed: 1200,
    pauseOnHover: true,
    prevArrow:'<div class="prev"><i class="fas fa-caret-square-left"></i></div>',
	  nextArrow:'<div class="next"><i class="fas fa-caret-square-right"></i></div>',
  });
});
