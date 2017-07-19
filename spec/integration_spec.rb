require('capybara/rspec')
  require('./app')
  Capybara.app = Sinatra::Application
  set(:show_exceptions, false)

  describe('adding a new stylist', {:type => :feature}) do
    it('allows a user to click a stylist to see the clients and details for it') do
      visit('/stylists/new')
      click_button('Add New Stylist')
      fill_in('name', :with =>'Moringaschool Work')
      click_button('Add')
      expect(page).to have_content('Success!')
    end
  end

  describe('viewing all of the stylists', {:type => :feature}) do
    it('allows a user to see all of the stylists that have been created') do
      stylist = Stylist.new({:name => 'Moringaschool Homework', :id => nil})
      stylist.save()
      visit('/')
      click_link('View All Stylists')
      expect(page).to have_content(stylist.name)
    end
  end

  describe('seeing details for a single stylist', {:type => :feature}) do
    it('allows a user to click a stylist to see the clients and details for it') do
      test_stylist = Stylist.new({:name => 'School stuff', :id => nil})
      test_stylist.save()
      test_client = Client.new({:name => "learn SQL", :stylist_id => test_stylist.id()})
      test_client.save()
      visit('/stylists')
      click_link(test_stylist.name())
      expect(page).to have_content(test_client.name())
    end
  end

  describe('adding clients to a stylist', {:type => :feature}) do
    it('allows a user to add a client to a stylist') do
      test_stylist = Stylist.new({:name => 'School stuff', :id => nil})
      test_stylist.save()
      visit("/add")
      fill_in("Name of the client", {:with => "Learn SQL"})
      click_button("Add client")
      expect(page).to have_content("Success!")
    end
  end