class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string "titulo"
      t.string "subtitulo"
      t.text "patron"
      t.string "ruta"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
