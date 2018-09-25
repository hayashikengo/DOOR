class PatrolUserCity < ApplicationRecord
  belongs_to :user
  belongs_to :city
end
