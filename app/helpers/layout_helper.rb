module LayoutHelper
  def form_title(model)
    i18n_key = "simple_form.titles.#{model.persisted? ? 'update' : 'create'}"
    I18n.t(i18n_key, name: model.class.model_name.human)
  end

end