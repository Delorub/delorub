module ActiveAdminShared::ControllerRedirects
  extend ActiveSupport::Concern

  def self.included dsl
    dsl.send :controller do
      class_eval do
        def create
          create! do |format|
            format.html { redirect_to collection_path } if resource.valid?
          end
        end
      end
    end

    dsl.send :controller do
      class_eval do
        def update
          update! do |format|
            format.html { redirect_to collection_path } if resource.valid?
          end
        end
      end
    end
  end
end
