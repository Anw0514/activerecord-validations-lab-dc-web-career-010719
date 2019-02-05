class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validate :clickbait, unless: Proc.new { |a| a.title.blank? }

  def clickbait
    bait_words = ["Won't Believe", "Secret", "Top [number]", "Guess"]
    truth = 0
    bait_words.each do |word|
      if self.title.include?(word)
        truth += 1
      end
    end
    if truth == 0
      errors.add(:title, "must be clickbait")
    end
  end
end
