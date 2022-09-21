class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, format: {with: /\A[a-zA-Z0-9-]{20}\z/, message: "Deve conter 20 caracteres"}
  validate :min_weight, :min_width, :min_height, :min_depth
  validates :sku, uniqueness: true

  def min_weight
    if (weight.nil? || weight <= 0)
      errors.add(:weight, "deve ser maior que 0")
       end
  end

  def min_width
    if (width.nil? || width <= 0)
       errors.add(:width, "deve ser maior que 0")
       end
  end

  def min_height
    if (height.nil? || height <= 0)
      errors.add(:height, "deve ser maior que 0")
    end
  end

  def min_depth
    if (depth.nil? || depth <= 0)
      errors.add(:depth, "deve ser maior que 0")
       end
  end

end

