class Stylist
    attr_reader(:name, :id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_singleton_method(:all) do
      returned_stylists = DB.exec("SELECT * FROM stylists;")
      stylists = []
      returned_stylists.each() do |stylist|
        name = stylist.fetch("name")
        id = stylist.fetch("id").to_i()
        stylists.push(Stylist.new({:name => name, :id => id}))
      end
      stylists
    end

    define_method(:save) do
      result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_stylist|
      self.name().==(another_stylist.name()).&(self.id().==(another_stylist.id()))
    end

    define_singleton_method(:find) do |id|
      found_stylist = nil
      Stylist.all().each() do |stylist|
        if stylist.id().==(id)
          found_stylist = stylist
        end
      end
      found_stylist
    end

    define_method(:tasks) do
      list_tasks = []
      tasks = DB.exec("SELECT * FROM tasks WHERE stylist_id = #{self.id()};")
      tasks.each() do |client|
        name = client.fetch("name")
        stylist_id = client.fetch("stylist_id").to_i()
        list_tasks.push(Task.new({:name => name, :stylist_id => stylist_id}))
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
      DB.exec("DELETE FROM tasks WHERE stylist_id = #{self.id()};")
    end
  end