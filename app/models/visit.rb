class Visit < ActiveRecord::Base
  validates :shortened_url_id, :presence => true
  validates :visitor_id, :presence => true

  belongs_to :visitor,
    foreign_key: :visitor_id,
    primary_key: :id,
    class_name: "User"

  belongs_to :visited_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: "ShortenedUrl"

  def self.record_visit!(user, shortened_url)
    create!(
      visitor_id: user.id,
      shortened_url_id: shortened_url.id
    )
  end

  

end
