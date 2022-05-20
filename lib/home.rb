require 'pg'

class Home

  def self.all
    connection = pg_connection
    result = connection.exec("SELECT * FROM homes;")
    connection.close
    return result
  end

  def self.select(id:)
    connection = pg_connection
    result = connection.exec_params("SELECT * FROM homes WHERE id = $1;", [id.to_i])
    connection.close
    return result.first
  end
  
  def self.create(home_name:, description:, price:, owner_id:)
    connection = pg_connection
    connection.exec_params(
      "INSERT INTO homes (home_name, description, price, owner_id) VALUES($1, $2, $3, $4);",
        [home_name, description, price, owner_id]
    )
    connection.close
  end

  def self.pg_connection
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect("postgres://localhost:5432/makersbnb")
    end
  end
end