#class Users::RegistrationsController < Devise::RegistrationsController
#  def create
#    super do |resource|
#      if resource.persisted?
#        sign_in(resource)
#      end
#    end
#  end
#end
