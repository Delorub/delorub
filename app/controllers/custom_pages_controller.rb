class CustomPagesController < ApplicationController
  skip_before_filter :show_global_container

  def how_to_master
  end

  def how_it_works
  end
end
