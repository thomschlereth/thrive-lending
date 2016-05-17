class User::ContractsController < User::BaseController

  def index
        binding.pry

    @l_contracts = current_user.lent
    @b_contracts = current_user.borrowed
  end

end
