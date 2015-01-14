class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company_name
      t.integer :weekly_hours
      t.text :description
      t.string :location
      t.text :application

      t.belongs_to :user

      t.timestamps
    end
  end
end