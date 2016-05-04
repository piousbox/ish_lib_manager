
module IshLibManager
  class ApplicationController < ActionController::Base
    layout 'ish_lib_manager/application'

    def set_lists
      @tags_list = Tag.all.list
      @sites_list = Site.all.list
      @cities_list = City.all.list
      @venues_list = Venue.all.list
      @users_list = User.all.list
    
      @reports_list = Report.all.list
      @galleries_list = Gallery.all.list
      @videos_list = Video.all.list
    end

    # cancan
    check_authorization
    rescue_from CanCan::AccessDenied do |exception|
      puts! exception, 'cancan exception is'
      redirect_to root_url, :alert => exception.message
    end
    
  end
end

def puts! args, label=''
  puts "+++ +++ #{label}"
  puts args.inspect
end
