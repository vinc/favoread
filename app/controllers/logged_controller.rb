class LoggedController < ApplicationController
  before_action :require_login
end
