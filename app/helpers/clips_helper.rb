module ClipsHelper

  def my_datepicker form, field
    form.text_field field, :data => {provide: 'datepicker', 'date-format' => 'dd-mm-yyyy', 'date-autoclose' => 'true', 'date-today-btn' => 'true', 'date-today-highlight' => 'true'}, class: 'form-control field-datepicker'
  end

end
