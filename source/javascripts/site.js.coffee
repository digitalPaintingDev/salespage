#= require jquery
#= require jquery.fullpage.min
#= require plugins/ajax_form

$ ->

  $('.nav-link').click  ->
    $('html, body').animate({
      scrollTop: $("#{$(@).data('target')}").offset().top - $('ul.nav').height()
    , 2000})


  $('.selling-point a').click  ->
    $('html, body').animate({
      scrollTop: $("#{$(@).data('target')}").offset().top - $('ul.nav').height()
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
    frameLabel: 'Digital Painting',
    currency: 'thb',
    submitLabel: 'Pay',
    otherPaymentMethods: ['internet_banking']

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
