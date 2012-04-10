class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, :app_key
      t.references :app_type

      t.timestamps
    end
  end
end
