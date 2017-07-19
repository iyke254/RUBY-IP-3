class Client
    attr_reader(:name, :stylist_id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @stylist_id = attributes.fetch(:list_id)
    end

    define_singleton_method(:all) do
      returned_tasks = DB.exec("SELECT * FROM tasks;")
      tasks = []
      returned_tasks.each() do |task|
        name = task.fetch("name")
        list_id = task.fetch("list_id").to_i() # The information comes out of the database as a string.
        tasks.push(Task.new({:name => name, :list_id => list_id}))
      end
      tasks
    end

    define_method(:save) do
      DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{@name}', #{@list_id});")
    end

    def delete
      DB.exec("DELETE FROM tasks WHERE list_id = list_id");
    end
end