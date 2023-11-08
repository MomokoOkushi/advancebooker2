class Message < ApplicationRecord
  belongs_to :user　#なぜか初めから書いてあった
  belongs_to :room　#なぜか初めから書いてあった
  
  validates :content, presence: true, length: { maximun:140} 
end
