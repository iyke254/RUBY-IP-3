class Stylist
    attr_reader(:name, :id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_singleton_method(:all) do
      returned_stylists = DB.exec("SELECT * FROM stylists;")
      stylists = []
      returned_stylists.each() do |list|
        name = list.fetch("name")
        id = list.fetch("id").to_i()
        stylists.push(List.new({:name => name, :id => id}))
      end
      stylists
    end

    define_method(:save) do
      result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_list|
      self.name().==(another_list.name()).&(self.id().==(another_list.id()))
    end

    define_singleton_method(:find) do |id|
      found_list = nil
      List.all().each() do |list|
        if list.id().==(id)
          found_list = list
        end
      end
      found_list
    end

    define_method(:tasks) do
      list_tasks = []
      tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id()};")
      tasks.each() do |task|
        description = task.fetch("description")
        list_id = task.fetch("list_id").to_i()
        list_tasks.push(Task.new({:description => description, :list_id => list_id}))
      end
      list_tasks
    end

    define_method(:update) do |attributes|
      @name = attributes.fetch(:name)
      @id = self.id()
      DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{@id};")
    end

    define_method(:delete) do
      DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
      DB.exec("DELETE FROM tasks WHERE list_id = #{self.id()};")
    end
  end