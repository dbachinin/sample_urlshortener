class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :links, dependent: :destroy
  has_many :inboxes, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte]



   def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end



    def self.from_omniauth(auth)
      if User.where(email: auth.info.email).exists?
        user = User.where(email: auth.info.email).first
        user.provider = auth.provider
        user.uid = auth.uid
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name  # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
        return user
      else
        User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0,20]
          user.name = auth.info.name  # assuming the user model has a name
         
        end
      end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.vk_data"] && session["devise.vk_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end



end
