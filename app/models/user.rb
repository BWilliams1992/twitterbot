class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]

  has_many :twitbots

  def email_required?
    false
  end

  def self.from_omniauth(auth)
    #looks for user in the database with the twitter provider uid supplied and
    #will create them if not present
    user = where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] #assumes that user doesnt want to set password so sets random password.
      user.name = auth.info.name
      user.username = auth.info.nickname
    end

    #updates the user with the access token and secret and saves to the database
    user.update(
      token: auth.credentials.token,
      secret: auth.credentials.secret
    )

    user
  end

  #generates client object for use with twitter loads the users
  #access and secret tokens along with the apps tokens
  def twitter_client
    #Dotenv.load
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV[ 'twitter_api_public']
      config.consumer_secret     = ENV[ 'twitter_api_secret' ]
      config.access_token        = self.token
      config.access_token_secret = self.secret
    end
  end



end
