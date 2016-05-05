
require 'spec_helper'

RSpec.describe IshLibManager::NewsitemsController, :type => :controller do

  render_views

  before :each do
    setup_users
    sign_in :user, @manager

    setup_sites
    #it 'should create new newsitem' do
    #  old_n_newsitems = @city.newsitems.length
    #  ( old_n_newsitems > 0 ).should eql true
    #  newsitem = { :descr => 'newsiten new descr' }
    #  post :create_newsitem, :city_id => @city.id, :newsitem => newsitem
    #  response.should be_redirect
    #  new_n_newsitems = City.find( @city.id ).newsitems.length
    #  ( new_n_newsitems - 1 ).should eql old_n_newsitems
    #end

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.user = @user
    @r1.save
    @r9 = FactoryGirl.create :r9
    Report.all.each do |report|
      report.site = @site
      report.save
    end

    Gallery.unscoped.each do |gallery|
      gallery.remove
    end
    @gallery = Gallery.create :name => 'some-gallery-name', :user => @manager, :site => @site
    flag = @gallery.save
    puts! @gallery.errors unless flag
    flag.should eql true

    Tag.all.each { |c| c.remove }
    
    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio
    n = Newsitem.new :descr => 'first newsitem' 
    @city.newsitems << n
    
    Gallery.all.each { |g| g.remove }
    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]
  end

  describe 'city newsitems' do
    it 'should GET new newsitem' do
      get :new, :city_id => @city.id
      response.should be_success
    end

  end  

    
end
