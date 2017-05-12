class Link < ApplicationRecord
  belongs_to :user, optional: true

  baselink = 'http://localhost:3000/'
  validates :slug, length: { maximum: 4 }, uniqueness: {
    message: ->(object, data) do 
      "#{ENV['BASE_URL']}#{data[:value]} allready enter and it`s long URL - #{Link.find_by_slug(object.slug).given_url}"
      
    end
  }
  validates :given_url, :format => URI::regexp(%w(http https)), allow_blank: true, uniqueness: {
    message: ->(object, data) do 
      "#{data[:value]} allready enter and it`s shorten URL - #{ENV['BASE_URL']}#{Link.find_by_given_url(object.given_url).slug}"
      
    end
  }
  after_create :generate_slug

  def generate_slug
    #self.slug = self.title if self.title
    self.slug = Random.rand(77778888).to_s(36)[0..3] if self.slug == ""
    # if Link.find_by_slug(self.slug)
    # 	self.given_url = Link.find_by_slug(self.slug).given_url
    #  end
    #  self.clicks = Link.find_by_given_url(self.given_url).id
    #  self.slug = Link.find(self.clicks).slug if self.clicks != self.id
         
    agent = Mechanize.new
    page = agent.get(self.given_url)
    self.title = page.title
    
      
    self.save
    
  end

  def display_slug
   "http://localhost:3000/" + self.slug.to_s
  end

    def perform(link_id)

  end
end
