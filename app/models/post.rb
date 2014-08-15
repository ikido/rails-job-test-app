class Post < ActiveRecord::Base

  # generates default permalink, that can be overriden by user
  def default_permalink
    "#{self.id}-#{self.title.parameterize}"
  end

end
