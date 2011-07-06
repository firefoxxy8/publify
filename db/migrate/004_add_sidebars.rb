class AddSidebars < ActiveRecord::Migration
  class Sidebar < ActiveRecord::Base
  end

  def self.up
    say_with_time "Creating sidebars" do
      create_table :sidebars do |t|
        t.column :controller, :string
        t.column :active_position, :integer
        t.column :active_config, :text
        t.column :staged_position, :integer
        t.column :staged_config, :text
      end

      Sidebar.create(:active_position=>0, :controller=>'page', :active_config=>'--- !map:HashWithIndifferentAccess
      maximum_pages: "10"')
      Sidebar.create(:active_position=>1, :controller=>'category', :active_config=>'--- !map:HashWithIndifferentAccess
      empty: false
      count: true')
      Sidebar.create(:active_position=>2, :controller=>'archives', :active_config=>'--- !map:HashWithIndifferentAccess
      show_count: true
      count: "10"')
      Sidebar.create(:active_position=>3, :controller=>'static', :active_config=>'--- !map:HashWithIndifferentAccess
      body: "<ul>\n  <li><a href=\"http://www.typosphere.org\" title=\"Typo\">Typosphere</a></li>\n  <li><a href=\"http://typogarden.org\">Typogarden</a></li>\n  <li><a href=\"http://t37.net.com\" title=\"Ergonomie Web\">Fr\xC3\xA9d\xC3\xA9ric</a></li>\n  <li><a href=\"http://www.matijs.net/\" title=\"Matijs\">Matijs</a></li>\n  <li><a href=\"http://blog.shingara.fr\" title=\"Cyril\">Cyril</a></li>\n\n\
        </ul>\n"
      title: Links'
      )
      Sidebar.create(:active_position=>4, :controller=>'meta', :active_config=>'--- !map:HashWithIndifferentAccess
      title: Meta')
    end
  end

  def self.down
    drop_table :sidebars
  end
end


