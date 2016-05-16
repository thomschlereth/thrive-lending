module ApplicationHelper
  def present(model, presenter_class=nil)
    klass = presenter_class || "User::#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end
end
