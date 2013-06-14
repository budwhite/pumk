$('#loginModal').on 'shown', ->
    $(this).find('input:visible:first').focus().end().find('form').enableClientSideValidations()
