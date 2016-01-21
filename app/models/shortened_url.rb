require_relative 'visit'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, :submitter_id, :presence => true
  validates :short_url, :uniqueness => true

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: "User"

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(:submitter_id => user.id,
      :long_url => long_url, :short_url => random_code)
  end

  def num_clicks
    Visit.where(shortened_url_id: self.id).count
  end

  def num_uniques
    Visit.select(:visitor_id).where(shortened_url_id: self.id).distinct.count
  end

end
