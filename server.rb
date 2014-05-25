# Sinatra Mocking Server
# Run with `ruby server.rb` before executing the test suite within Xcode
# Install sinatra with `sudo gem install sinatra`

require 'rubygems'
require 'sinatra'
require 'json'

apiBase = '/lootrserver/api/v1/'


configure do
  set :logging, true
  set :dump_errors, true
  set :public_folder, Proc.new { File.expand_path(File.join(root, 'Fixtures')) }
  
end

def render_fixture(filename)
  send_file File.join(settings.public_folder, filename)
end


#===============================================================================================


#*************************#
#   LOOTS                 #
#*************************#


# Creates a route that will match /loots/latitude/47.226/longitude/8.818/distance/100
# PUNKT nicht KOMMA
get apiBase + 'loots/latitude/:lat/longitude/:long/distance/:dist' do
  if params[:dist] < '0'
    status 404
  else  
    render_fixture('lootList.json')
  end
end

# Creates a route that will match /loots/latitude/47.226/longitude/8.818/count/4
# PUNKT nicht KOMMA
get apiBase + 'loots/latitude/:lat/longitude/:long/count/:count' do
  if params[:count] < '0'
    status 404
  else  
  render_fixture('lootList.json')
  end
end

# BENÖTIGT TOKEN:
# https://username:token@www.lootrapp.com/api/v1/loots/3
# Creates a route that will match /loots/3
get apiBase + 'loots/:id' do
  if params[:id] == '666'
    status 404
  else
    render_fixture('lootSingle.json')
  end
end

# BENÖTIGT TOKEN:
# https://username:token@www.lootrapp.com/api/v1/loots
# Creates a route that will match /loots
post apiBase + 'loots' do
  render_fixture('lootPost.json')
  status 201
end


#===============================================================================================


#*************************#
#   CONTENTS              #
#*************************#


# BENÖTIGT TOKEN:
# https://username:token@www.lootrapp.com/api/v1/contents
# Creates a route that will match /contents
post apiBase + 'contents' do
  if params[:id] == '666'
    status 404
  else
    render_fixture('contentsSingle.json')
    status 201
  end
end


#===============================================================================================


#*************************#
#   REPORTS               #
#*************************#


# BENÖTIGT TOKEN:
# https://username:token@www.lootrapp.com/api/v1/reports
# Creates a route that will match /reports
get apiBase + 'reports' do
  render_fixture('reportsList.json')
end

# BENÖTIGT TOKEN:
# https://username:token@www.lootrapp.com/api/v1/reports/3
# Creates a route that will match /reports/3
get apiBase + 'reports/:id' do
  if params[:id] == '666'
    status 404
  else
    render_fixture('reportsSingle.json')
  end
end

# BENÖTIGT TOKEN:
# https://username:token@www.lootrapp.com/api/v1/reports
# Creates a route that will match /reports
post apiBase + 'reports' do
  headers 'Location' => apiBase + "reports/12"
  render_fixture('reportsSingle.json');
  status 201
end


#===============================================================================================


#*************************#
#   USERS                 #
#*************************#


# Creates a route that will match /users
post apiBase + 'users' do
  if params[:username] == '666'
    status 401
  else
    status 201
  end
end

# Creates a route that will match /users/login
post apiBase + 'users/login' do
  if params[:username] == '666'
    status 401
  else
    render_fixture('usersToken.json')
  end
end
