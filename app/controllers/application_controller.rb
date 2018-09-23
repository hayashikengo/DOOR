class ApplicationController < ActionController::Base
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]
end
