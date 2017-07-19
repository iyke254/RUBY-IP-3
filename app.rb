require('sinatra')
  require('sinatra/reloader')
  require('./lib/client')
  require('./lib/stylist')
  also_reload('lib/**/*.rb')
  require("pg")

  DB = PG.connect({:dbname => "hair_salons"})

  get("/") do
    erb(:index)
  end

  get("/stylists/new") do
    erb(:stylist_form)
  end

  post("/stylists") do
    name = params.fetch("name")
    stylist = Stylist.new({:name => name, :id => nil})
    stylist.save()
    erb(:stylist_success)
  end

  get("/stylists") do
    @stylists = Stylist.all()
    erb(:stylists)
  end

  get('/add') do
    @stylists = Stylist.all()
    erb(:description_form)
  end

  get("/stylists/:id") do
    @stylist = Stylist.find(params.fetch("id").to_i())
    erb(:stylist)
  end

  post("/clients") do
    name = params.fetch("name")
    stylist_id = params.fetch("stylist_id").to_i()
    @stylist = Stylist.find(stylist_id)
    @client = Client.new({:name => name, :stylist_id => stylist_id})
    @client.save()
    erb(:client_success)
  end

  get("/stylists/:id/edit") do
    @stylist = Stylist.find(params.fetch("id").to_i())
    erb(:stylist_edit)
  end

  patch("/stylists/:id") do
    name = params.fetch("name")
    @stylist = Stylist.find(params.fetch("id").to_i())
    @stylist.update({:name => name})
    erb(:stylist_success)
  end

  delete("/stylists/:id") do
    @stylist = Stylist.find(params.fetch("id").to_i())
    @stylist.delete()
    @stylists = Stylist.all()
    erb(:stylist_success)
  end