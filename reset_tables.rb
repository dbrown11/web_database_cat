$:.unshift File.join(File.dirname(__FILE__), 'lib')
require "database_connection"

# This file sets up the database tables. If you change any of the contents
# of this file, you should rerun `ruby reset_tables.rb` to ensure that your
# database tables are re-created.

def reset_tables(db)
  db.run("DROP TABLE IF EXISTS animals;")
  db.run("CREATE TABLE animals (id SERIAL PRIMARY KEY, species TEXT NOT NULL);")

  db.run("DROP TABLE IF EXISTS board_entries;")
  db.run("CREATE TABLE board_entries (id SERIAL PRIMARY KEY, number TEXT NOT NULL, description TEXT NOT NULL);")

  db.run("DROP TABLE IF EXISTS comments;")
  db.run("CREATE TABLE comments (
        id_comment SERIAL PRIMARY KEY,
        comment TEXT NOT NULL,
        id_advert INTEGER NOT NULL);")

  # Add your table creation SQL here
  # Each one should be a pair of lines:
  #   db.run("DROP TABLE IF EXISTS ...;")
  #   db.run("CREATE TABLE ... (id SERIAL PRIMARY KEY, ...);")
end

dev_db = DatabaseConnection.new("localhost", "web_application_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "web_application_test")
reset_tables(test_db)
