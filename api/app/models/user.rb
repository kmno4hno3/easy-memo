class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  after_create :update_access_token!

  validates :email, presence: true

  def update_access_token!
    # friendly_token:ランダムな20文字のトークンを生成
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end
end
