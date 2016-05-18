class UserPresenter < ::BasePresenter
  include ActionView::Helpers::NumberHelper

  def approved_offers
    @model.lent.size
  end
end
