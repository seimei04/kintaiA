class Base < ApplicationRecord
  validates :id, presence: true, uniqueness: true
  validates :base_name,  presence: true, length: { maximum: 20 }
  validates :base_type, presence: true
  
 
end
