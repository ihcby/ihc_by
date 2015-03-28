jQuery ->
  $('select#order_doctor_id.selectized').selectize({})
  $('select#order_trial_type_id.selectized').selectize({})

  $('.datetimepicker').datetimepicker({format: 'yyyy-mm-dd'});
  $('.wysihtml5').wysihtml5({toolbar: {"image": false, "color": true}});
