class Book < ApplicationRecord
belongs_to :user
belongs_to :category
# book_image となっているところは好きな名前で良い
has_attached_file :book_image, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_image, content_type: /\Aimage\/.*\z/
end
