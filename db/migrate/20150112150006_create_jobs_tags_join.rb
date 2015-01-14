class CreateJobsTagsJoin < ActiveRecord::Migration
  def change
    create_table :jobs_tags, id: false do |t|
      t.belongs_to :job, index: true
      t.belongs_to :tag, index: true
    end
  end
end
