class Job < ActiveRecord::Base
  has_and_belongs_to_many :tags

  has_attached_file :logo, :styles => {:medium => "300x300>", :thumb => "60x60"}

  validates :title, length: { minimum: 4 }
  validates :company_name, presence: true
  validates :description, presence: true
  validates :application, presence: true

  validates_attachment :logo, :presence => true,
                       :content_type => { :content_type => /^image\/(png|gif|jpeg)/ },
                       :size => {:in => 0..500.kilobytes}

  validates :tags, presence: true

  def formatted_tags
    tags_string = String.new
    tags.each_with_index do |tag, index|
      tags_string << tag.name
      if index < (tags.size - 1)
        tags_string << ", "
      end
    end
    return tags_string
  end


end
