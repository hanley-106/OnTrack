class GraderPreviousGradeCourse < ApplicationRecord
  has_and_belongs_to_many :grader
end