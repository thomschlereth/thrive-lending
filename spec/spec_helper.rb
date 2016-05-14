RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end


  def create_categories(num = 1)
    num.times do
      Category.create(name: Faker::Commerce.department(1))
    end
  end

  def create_orders(num = 1, user_id = nil, status = nil)
    @statuses = ["ordered", "paid", "completed", "cancelled"]
    num.times do
      Order.create(
      user_id: user_id || User.all.sample.id,
      status: status || @statuses.sample
      )
    end
  end

  def create_user(num = 1, role = 0)
    num.times do
      first_name = Faker::Name.first_name
      User.create(first_name: first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.safe_email,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zipcode: Faker::Address.zip_code,
      password: "password",
      username: first_name.downcase,
      role: role)
    end
    User.all
  end

  def create_loan_request(num=1, user_id=nil)
    num.times do
      LoanRequest.create(amount: rand(100..10000), rate: rand(1.0..20.0), term: rand(6..72), user_id: user_id)
    end
  end

    def create_loan_offer(num=1, user_id=nil)
    num.times do
      LoanOffer.create(amount: rand(100..10000), rate: rand(1.0..20.0), term: rand(1...240), user_id: user_id)
    end
  end

  def create_contract(num = 1, data)
    num.times do
      Contract.create(lender_id: data[:l_id], borrower_id: data[:b_id], loan_request_id: data[:l_r_id], loan_offer_id: data[:l_o_id], status: data[:status])
    end
  end

end
