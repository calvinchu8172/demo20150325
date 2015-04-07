class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
    end

    add_column :events, :category_id, :integer
    add_index :events, :category_id

    Category.create( :name => "Course" )
    Category.create( :name => "Meeting" )
    Category.create( :name => "Conference" )
    Category.create( :name => "Party" )
    Category.create( :name => "Happy Hours" )
  end

end
