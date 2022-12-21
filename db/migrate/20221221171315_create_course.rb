class CreateCourse < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_name, null: false
      t.timestamps
    end
  end
end
