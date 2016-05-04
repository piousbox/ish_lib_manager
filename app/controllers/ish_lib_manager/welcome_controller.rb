
module IshLibManager

  class WelcomeController < IshLibManager::ApplicationController

    def home
      @page_title = 'Welcome home!'

      authorize! :home, Welcome.new      
    end
    
  end
  
end
