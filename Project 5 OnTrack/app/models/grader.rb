class Grader < ApplicationRecord
  has_and_belongs_to_many :descriptions
end
