require('rspec')
  require('pg')
  require('spec_helper')
  require('task')

  describe(Task) do
    describe(".all") do
      it("is empty at first") do
        expect(Task.all()).to(eq([]))
      end
    end

    describe("#save") do
      it("adds a task to the array of saved tasks") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1})
        test_task.save()
        expect(Task.all()).to(eq([test_task]))
      end
    end

    describe("#description") do
      it("lets you read the description out") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1})
        expect(test_task.description()).to(eq("learn SQL"))
      end
    end

    describe("#list_id") do
      it("lets you read the list ID out") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1})
        expect(test_task.list_id()).to(eq(1))
      end
    end

    describe("#==") do
      it("is the same task if it has the same description and list ID") do
        task1 = Task.new({:description => "learn SQL", :list_id => 1})
        task2 = Task.new({:description => "learn SQL", :list_id => 1})
        expect(task1).to(eq(task2))
      end
    end
  end

  describe(".find") do
      it("returns a list by its ID") do
        test_list = List.new({:name => "Moringaschool stuff", :id => nil})
        test_list.save()
        test_list2 = List.new({:name => "Home stuff", :id => nil})
        test_list2.save()
        expect(List.find(test_list2.id())).to(eq(test_list2))
      end
    end

    describe("#tasks") do
      it("returns an array of tasks for that list") do
        test_list = List.new({:name => "Moringaschool stuff", :id => nil})
        test_list.save()
        test_task = Task.new({:description => "Learn SQL", :list_id => test_list.id()})
        test_task.save()
        test_task2 = Task.new({:description => "Review Ruby", :list_id => test_list.id()})
        test_task2.save()
        expect(test_list.tasks()).to(eq([test_task, test_task2]))
      end
    end