class My::ApplicationController < ApplicationController
  before_action do
    not_found unless user_signed_in?
  end
end
