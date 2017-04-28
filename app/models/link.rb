class Link < ApplicationRecord
  validates :slug, length: { maximum: 4 }
  validates :given_url, :format => URI::regexp(%w(http https)), allow_blank: true 
  after_create :generate_slug

  def generate_slug
    self.slug = self.title if self.title
    self.slug = Random.rand(77778888).to_s(36)[0..3] if self.slug == ""
    if Link.find_by_slug(self.slug)
    	self.given_url = Link.find_by_slug(self.slug).given_url
     end
     self.clicks = Link.find_by_given_url(self.given_url).id
     self.slug = Link.find(self.clicks).slug if self.clicks != self.id
      
    self.save
    
  end

  def display_slug
   "http://localhost:3000/" + self.slug.to_s
  end
end
