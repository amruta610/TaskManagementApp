class Task < ApplicationRecord
    before_save :capitalize_first_letter

  validates :name, presence: true
  validates :category, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  private

  # Capitalizes the first letter of the task name
  def capitalize_first_letter
    self.name = self.name.capitalize
  end
end
