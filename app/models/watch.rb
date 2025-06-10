class Watch < ApplicationRecord
  validates :brand, presence: true
  validates :model, presence: true
  validates :year, presence: true, numericality: { greater_than: 1800, less_than_or_equal_to: Date.current.year }
  
  scope :by_brand, ->(brand) { where(brand: brand) if brand.present? }
  scope :by_year, ->(year) { where(year: year) if year.present? }
  scope :by_movement_type, ->(movement_type) { where(movement_type: movement_type) if movement_type.present? }
  scope :search, ->(query) {
    if query.present?
      where("brand LIKE ? OR model LIKE ? OR caliber LIKE ? OR reference_number LIKE ?", 
            "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    end
  }
  
  def full_name
    "#{brand} #{model}"
  end
end
