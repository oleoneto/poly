# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  include ActionText::Attachable

  include Poly::Concerns::Archiver
  include Poly::Concerns::Commentator
  include Poly::Concerns::Followable
  include Poly::Concerns::Reactor
  include Poly::Concerns::Sharer
  include Poly::Concerns::Sortable
  include Poly::Concerns::Trasher

  has_prefix_id :user

  has_many :articles, class_name: 'Poly::Article', foreign_key: :author_id

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email
  validates_length_of :first_name, minimum: 2, maximum: 20
  validates_length_of :last_name, minimum: 2, maximum: 20

  def name
    "#{first_name} #{last_name}"
  end

  def verified?
    true
  end
end
