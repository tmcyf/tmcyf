class ServiceGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :service_name, type: :string

  def copy_service_file
    template "service.rb.erb", "app/services/#{file_name}.rb"
    template "service_spec.rb.erb", "spec/services/#{file_name}_spec.rb"
  end

  private
  def file_name
    service_name.underscore
  end
end
