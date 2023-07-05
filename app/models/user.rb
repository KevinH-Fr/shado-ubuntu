class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_voter

  has_one :fan
  has_one :athlete


 # has_many :campaigns

  has_many :notifications, as: :recipient, dependent: :destroy

  accepts_nested_attributes_for :fan, :athlete 
 # after_initialize :build_athlete  # Add this callback to initialize the athlete object



end
