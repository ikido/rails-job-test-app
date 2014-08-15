class AddPermalinkToPosts < ActiveRecord::Migration
  def up

    add_column :posts, :permalink, :string

    # find_in_batches allows us to process a lot of posts,
    # without loading all of them in memory. This is valuable
    # when you have a million of posts, who knows

    Post.find_in_batches do |posts|

      # We could use p.update_attributes too,
      # but this is a safe guess

      # We could also add some default title,
      # in case p.title is blank, but here we assume
      # that every post should have title

      # We could also append numbers if there is a record
      # with the same title, instead of prepending it,
      # but this seems like a better and consistent solution for me

      potsts.each do |p|
        p.permalink = p.default_permalink
        p.save
      end
    end

  end

  def down
    remove_column :posts, :permalink
  end

end
