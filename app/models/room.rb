class Room < ApplicationRecord
  belongs_to :user #なぜか初めから書いてあった
  
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  
end
