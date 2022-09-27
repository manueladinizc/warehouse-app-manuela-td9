class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items #verifica que produtos j fieram parte de algum pedido

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, format: {with: /\A[a-zA-Z0-9-]{20}\z/, message: "Deve conter 20 caracteres"}
  validate :min_weight, :min_width, :min_height, :min_depth
  validates :sku, uniqueness: true
 
  def min_weight
    if (self.weight.present? && self.weight <= 0)
      self.errors.add(:weight, "deve ser maior que 0")
       end
  end

  def min_width
    if (self.width.present? && self.width <= 0)
       self.errors.add(:width, "deve ser maior que 0")
       end
  end

  def min_height
    if (self.height.present? && self.height <= 0)
      self.errors.add(:height, "deve ser maior que 0")
    end
  end

  def min_depth
    if (self.depth.present? && self.depth <= 0)
      self.errors.add(:depth, "deve ser maior que 0")
       end
  end

end

