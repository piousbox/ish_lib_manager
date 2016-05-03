
module IshLibManager

  class WelcomeController < IshLibManager::ApplicationController

    def home
      @page_title = 'Welcome home!'
      
      render :action => 'empty', :layout => 'ish_lib_manager/application_legacy_foundation'
    end
    
  end
  
end
