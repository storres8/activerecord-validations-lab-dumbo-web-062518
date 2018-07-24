class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"] }
  validate :is_clickbait?

  def is_clickbait?
    clickbait_titles = ["Won't Believe", "Secret", "Top", "Guess"]
    count = 0
    clickbait_titles.each do |bait|
      if self.title.to_s.include? bait
        count += 1
      end
    end
    if count == 0
      errors.add(:title, "must be clickbait")
    end
  end
end
