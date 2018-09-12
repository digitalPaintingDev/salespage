#= require jquery
#= require jquery.fullpage.min
#= require plugins/ajax_form

$ ->
  navHeight = ->
    $('ul.nav').height()

  $('.nav-link').click  ->
    $('html, body').animate({
      scrollTop: $("#{$(@).data('target')}").offset().top - navHeight()
    , 2000})

  $('.selling-point a').click  ->
    $('html, body').animate({
      scrollTop: $("#{$(@).data('target')}").offset().top - navHeight()
    , 2000})

  calculateOmiseAmount = (price) ->
    priceSatangs = price * 100
    omisePercent = 3.66/100
    vat = 7/100
    amount = priceSatangs/(1-(omisePercent*(1+vat)))
    parseInt(amount)

  paymentDescription = (price) ->
    "Course #{price} + Payment Fees #{(calculateOmiseAmount(price) - price*100)/100}"

  OmiseCard.configure
    publicKey: 'pkey_test_5cfmob869aw9gujujmx',
    image: 'https://cdn.omise.co/assets/dashboard/images/omise-logo.png',
    frameLabel: 'Pandet Online Thailand',
    currency: 'thb',
    submitLabel: 'Pay'

  OmiseCard.configureButton '#checkout-course-3', {
    amount: calculateOmiseAmount(2500),
    frameDescription: paymentDescription(2500),
    submitFormTarget: null
  }

  OmiseCard.configureButton '#checkout-course-4', {
    amount: calculateOmiseAmount(2500),
    frameDescription: paymentDescription(2500),
    submitFormTarget: null
  }

  OmiseCard.configureButton '#checkout-course-5', {
    amount: calculateOmiseAmount(2500),
    frameDescription: paymentDescription(2500),
    submitFormTarget: null
  }

  OmiseCard.configureButton '#checkout-course-6', {
    amount: calculateOmiseAmount(2500),
    frameDescription: paymentDescription(2500),
    submitFormTarget: null
  }

  OmiseCard.attach()

  $("#courses .choose-course").on 'click', (e) ->
    e.preventDefault()
    id = $(@).attr('data-id')
    $(".choosed-course-purchase-button").hide()
    $("##{id}").show()

  $(".choosed-course-purchase-button").on 'click',  ->
    if $(@).data('course') && $(@).data('course').length
      $("input[type='hidden'][name='course_name']").val($(@).data('course'))
