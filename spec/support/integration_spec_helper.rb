module IntegrationSpecHelper
  def login_with_oauth(service = :twitter)
    visit "/auth/#{service}"
  end
  def login_with_twitter_default_user(service = :twitter)
    visit "/auth/#{service}"
    @user = User.where(username: "12345").first      # Twitter oAuth mocked user
  end
end