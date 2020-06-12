class Token < ApplicationRecord
  # relations
  has_many :packs, dependent: :destroy

  # callbacks
  before_create :generate_key

  # validations
  validates :key, presence: true, uniqueness: true, allow_blank: true

  # scopes
  scope :active, -> { where(active: true).where('expires_at IS NULL OR expires_at >= ?', Time.current) }
  scope :expired, -> { where.not(expires_at: nil).where('expires_at < ?', Time.current) }
  scope :permanent, -> { where(expires_at: nil) }

  def self.expire!
    expired.update_all(active: false)
  end

  def permanent?
    expires_at.nil?
  end

  protected

  def generate_key
    self.key = loop do
      random_key = SecureRandom.urlsafe_base64(24)
      break random_key unless Token.exists?(key: random_key)
    end
  end
end
