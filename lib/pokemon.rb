require 'pry'
class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize (id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES(?, ?)
        SQL
        db.execute(sql, name, type)
        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL

        mon = db.execute(sql, id)[0]
        pokemon = self.new(id: mon[0], name: mon[1], type: mon[2], db: db)
        pokemon
    end

end

# 