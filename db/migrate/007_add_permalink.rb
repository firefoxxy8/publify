class AddPermalink < ActiveRecord::Migration
  class Article < ActiveRecord::Base
    include BareMigration

    def stripped_title(title)
      # this is a copynpaste of the routine in article.rb
      # so the one in article.rb can change w/o breaking this.
      self.title.gsub(/<[^>]*>/,'').to_url
    end
  end

  class Category < ActiveRecord::Base
    include BareMigration

    def stripped_name
      # copynpaste from category.rb
      self.name.to_url
    end
  end

  def self.up
    say_with_time "Adding categories permalink" do
    add_column :categories, :permalink, :string
    add_index :categories, :permalink
      Category.find_and_update {|c| c.permalink ||= c.stripped_name }
      Article.find_and_update  {|a| a.permalink ||= a.stripped_title }
    end
  end


  def self.down
    STDERR.puts "Removing categories permalink"
    remove_index :categories, :permalink
    remove_column :categories, :permalink
  end
end
