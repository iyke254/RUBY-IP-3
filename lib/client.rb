class Client
    attr_reader(:name, :stystylist_id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @stystylist_id = attributes.fetch(:stylist_id)
    end

    define_singleton_method(:all) do
      returned_tasks = DB.exec("SELECT * FROM tasks;")
      tasks = []
      returned_tasks.each() do |task|
        name = task.fetch("name")
        stylist_id = task.fetch("stylist_id").to_i() # The information comes out of the database as a string.
        tasks.push(Task.new({:name => name, :stylist_id => stylist_id}))
      end
      tasks
    end

    define_method(:save) do
      DB.exec("INSERT INTO tasks (name, stylist_id) VALUES ('#{@name}', #{@stylist_id});")
    end

    def delete
      DB.exec("DELETE FROM tasks WHERE stylist_id = stylist_id");
    end
end