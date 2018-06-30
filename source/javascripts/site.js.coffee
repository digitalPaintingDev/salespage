#= require jquery
#= require jquery.fullpage.min

$ ->

  $('.nav-link').click  ->
    $('html, body').animate({
      scrollTop: $("#{$(@).data('target')}").offset().top - $('ul.nav').height()
    , 2000})


  $('.selling-point a').click  ->
    $('html, body').animate({
      scrollTop: $("#{$(@).data('target')}").offset().top - $('ul.nav').height()
    , 2000})
