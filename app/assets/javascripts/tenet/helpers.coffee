window.blank  = (s) -> !s or String(s).match(/^\s*$/)
window.filled = (s) -> !blank(s)
window.email  = (s) -> filled(s) and s.match(/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i)
window.url    = (s) -> filled(s) and s.match(/^https?:\/\/[A-Z0-9.-]+\.[A-Z]{2,4}$/i)
window.phone  = (s) -> filled(s) and s.replace(/[^0-9]/g, '').match(/^[0-9]{10}$/)

window.t = (key) -> gon.l[key]

window.formSubmitButton = (submitBtn, form) ->
  submitBtn = $(submitBtn)

  updateSubmitBtn = ->
    submitBtn.popover "destroy"
    if form.canSubmit()
      submitBtn.removeClass('grey')
    else
      submitBtn.addClass('grey')
      submitBtn.popover
        html:    true
        content: form.errors().join("<br/>")
        trigger: "hover"

  form.errors.subscribe -> updateSubmitBtn()
  updateSubmitBtn()

window.bindForm = (form) ->
  # see if we can submit the form
  form.canSubmit = ko.computed ->
    form.errors().length == 0

  # disable form if we can't submit
  $("form").on "submit", (e) ->
    e.preventDefault() unless form.canSubmit()

  # update class and popup of submit button
  formSubmitButton "input[type='submit']", form

  ko.applyBindings form

# Value handler that respects the existing value
ko.bindingHandlers.valueWithInit = {
  init: (element, valueAccessor, allBindingsAccessor, context) ->
    property = valueAccessor()
    value = $(element).val()

    ko.bindingHandlers.value.init(element, valueAccessor, allBindingsAccessor, context)
    property(value)

  update: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->
    ko.bindingHandlers.value.update(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext)
}

ko.bindingHandlers.checkedWithInit = {
  init: (element, valueAccessor, allBindingsAccessor, context) ->
    property = valueAccessor()
    el = $(element)
    checked = el.is(':checked')
    value   = el.val()

    ko.bindingHandlers.checked.init(element, valueAccessor, allBindingsAccessor, context)
    if checked
      if el.is(":checkbox")
        property(checked)
      else
        property(value)

  update: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->
    ko.bindingHandlers.checked.update(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext)
}
