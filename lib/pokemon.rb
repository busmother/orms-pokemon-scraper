#parametize : db.execute( "INSERT INTO Products ( stockID, Name ) VALUES ( ?, ? )", [id, name])
#without parametize: db.execute( "INSERT INTO Products ( stockID, Name ) VALUES ( #{id}, #{name} )" )

class Pokemon
    attr_accessor :name, :type, :id, :db
    
    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def update
        sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
        DB[:conn].execute(sql, @name, @type, @id)
      end

    def self.save(name, type, db)
          sql = <<-SQL
          INSERT INTO pokemon (name, type)
          VALUES (?,?)
          SQL
          db.execute(sql, name, type)
          @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon
        WHERE id = ?
        SQL
        results = db.execute(sql,id)[0]
        Pokemon.new(id:results[0], name:results[1], type:results[2], db: db)
    end
end
