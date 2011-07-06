class AddArticleUserId < ActiveRecord::Migration
  class Article < ActiveRecord::Base
  end

  class User < ActiveRecord::Base
  end

  def self.up
    say_with_time "Linking article authors to users" do
      add_column :articles, :user_id, :integer

      Article.reset_column_information

      Article.all.each do |art|
        art.user_id = (User.find_by_name(art.author).id rescue nil)
      end

      user_first = User.first

      if user_first.nil?
        user_id = 1
      else
        user_id = user_first.id
      end

      Article.find(:all, :conditions => 'user_id IS NULL').each do |art|
        art.user_id = user_id
        art.save!
      end
    end
  end

  def self.down
    remove_column :articles, :user_id
  end
end
