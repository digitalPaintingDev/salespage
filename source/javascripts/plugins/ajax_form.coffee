$ ->
  $('.ajax-form').each ->
    $form = $(@)
    $form.on 'submit', (e) ->
      e.preventDefault()

      ua = navigator.userAgent.toLowerCase()
      form = e.target

      if !form.checkValidity()
        $(form).find('.has-error').removeClass('has-error')
        $element = $(form).find('input:invalid, select:invalid, textarea:invalid').first()
        $element.parents('.form-group').addClass('has-error')
        if /iphone/.test(ua) || /ipad/.test(ua)
          window.scrollTo(0, $element.offset().top - 30)
        $element.focus()

        return

      $submit = $form.find('button[type="submit"]')
      $submit.addClass('disabled').prop('disabled', true)
      $submit.prepend('<i class="fa fa-spin fa-circle-o-notch" styple="magin-left: 8px"></i>')

      formData = new FormData($form[0])
      url = $form.attr('action')
      $modal = $("#modalResult")
      $modal.find('.loading').show()
      $modal.modal('show')
      clearForm($form)

      $.ajax
        type: 'POST'
        url: url
        data: formData
        cache: false
        contentType: false
        processData: false

        complete: (data) ->
          $submit.removeClass('disabled').prop('disabled', null)
          $submit.find('i').remove()

        success : (data) ->
          $modal.find('.submit-result span').hide()
          $modal.modal('hide')
          response = JSON.parse(data)
          switch response.result
            when 'success'
              $modal.find('.loading').hide()
              $modal.find('.submit-result span.submit-success').show()
              @clearForm($form)
            when 'validationFailed'
              $modal.find('.loading').hide()
              $modal.find('.submit-result span.validation-failed').show()
            when 'error'
              $modal.find('.loading').hide()
              $modal.find('.submit-result span.submit-error').show()

        error: (data) ->
          $modal.find('.loading').hide()
          $modal.find('.submit-result span.submit-error').show()

  clearForm = ($form) ->
    $form.find(':input').each  ->
      type = this.type
      tag = this.tagName.toLowerCase()

      return if type == 'hidden'
      if (type == 'checkbox' || type == 'radio')
        $(@).prop('checked', false)
      else
        $(@).val('')
