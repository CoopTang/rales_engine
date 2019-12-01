class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number,
                        :result

  # validates :credit_card_expiration_date, allow_blank: true

  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }
end
