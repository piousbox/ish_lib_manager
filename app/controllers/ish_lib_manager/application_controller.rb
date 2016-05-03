
module IshLibManager
  class ApplicationController < ActionController::Base
    layout 'ish_lib_manager/application'
  end
end

def puts! args, label=''
  puts "+++ +++ #{label}"
  puts args.inspect
end
