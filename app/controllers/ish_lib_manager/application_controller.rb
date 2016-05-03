
module IshLibManager
  class ApplicationController < ActionController::Base
  end
end

def puts! args, label=''
  puts "+++ +++ #{label}"
  puts args.inspect
end
