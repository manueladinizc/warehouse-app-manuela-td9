class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, format: {with: /\A[a-zA-Z0-9-]{20}\z/, message: "Deve conter 20 caracteres"}
  validates :weight, format: {with: /[0-9]/, message: "deve conter 20 caracteres"}
  # validate :minWeight, :minWidth, :minHeight, :minDepth

  # def minWeight
  #   if weight <= 0
  #     errors.add(:weight, "deve ser maior que 0")
  #      end
  # end

  # def minWidth
  #   if width <= 0
  #      errors.add(:width, "deve ser maior que 0")
  #      end
  # end

  # def minHeight
  #   if height <= 0
  #     errors.add(:height, "deve ser maior que 0")
  #   end
  # end

  # def minDepth
  #   if depth <= 0
  #     errors.add(:depth, "deve ser maior que 0")
  #      end
  # end

end

