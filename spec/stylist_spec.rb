require('rspec')
  require('pg')
  require('spec_helper')
  require('client')

  describe(Client) do
    describe(".all") do
      it("is empty at first") do
        expect(Client.all()).to(eq([]))
      end
    end

    describe("#save") do
      it("adds a client to the array of saved clients") do
        test_client = Client.new({:name => "learn SQL", :stylist_id => 1})
        test_client.save()
        expect(Client.all()).==([test_client])
      end
    end

    describe("#name") do
      it("lets you read the name out") do
        test_client = Client.new({:name => "learn SQL", :stylist_id => 1})
        expect(test_client.name()).==("learn SQL")
      end
    end

    describe("#stylist_id") do
      it("lets you read the stylist ID out") do
        test_client = Client.new({:name => "learn SQL", :stylist_id => 1})
        expect(test_client.stylist_id()).==(1)
      end
    end

    describe("#==") do
      it("is the same client if it has the same name and stylist ID") do
        client1 = Client.new({:name => "learn SQL", :stylist_id => 1})
        client2 = Client.new({:name => "learn SQL", :stylist_id => 1})
        expect(client1).==(client2)
      end
    end
  end

  describe(".find") do
      it("returns a stylist by its ID") do
        test_stylist = Stylist.new({:name => "Moringaschool stuff", :id => nil})
        test_stylist.save()
        test_stylist2 = Stylist.new({:name => "Home stuff", :id => nil})
        test_stylist2.save()
        expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
      end
    end

    describe("#clients") do
      it("returns an array of clients for that stylist") do
        test_stylist = Stylist.new({:name => "Moringaschool stuff", :id => nil})
        test_stylist.save()
        test_client = Client.new({:name => "Learn SQL", :stylist_id => test_stylist.id()})
        test_client.save()
        test_client2 = Client.new({:name => "Review Ruby", :stylist_id => test_stylist.id()})
        test_client2.save()
        expect(test_stylist.clients()).==([test_client, test_client2])
      end
    end

    describe("#update") do
      it("lets you update stylists in the database") do
        stylist = Stylist.new({:name => "Moringa School stuff", :id => nil})
        stylist.save()
        stylist.update({:name => "Homework stuff"})
        expect(stylist.name()).to(eq("Homework stuff"))
      end
    end

    describe("#delete") do
      it("lets you delete a stylist from the database") do
        stylist = Stylist.new({:name => "Moringa School stuff", :id => nil})
        stylist.save()
        stylist2 = Stylist.new({:name => "House stuff", :id => nil})
        stylist2.save()
        stylist.delete()
        expect(Stylist.all()).to(eq([stylist2]))
      end
      
      it("deletes a stylist's clients from the database") do
        stylist = Stylist.new({:name => "Moringa School stuff", :id => nil})
        stylist.save()
        client = Client.new({:name => "learn SQL", :stylist_id => stylist.id()})
        client.save()
        client2 = Client.new({:name => "Review Ruby", :stylist_id => stylist.id()})
        client2.save()
        stylist.delete()
        expect(Client.all()).to(eq([]))
      end
    end