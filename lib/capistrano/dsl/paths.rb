module Capistrano
  module DSL
    module Paths

      def nginx_sites_available_file
        "/etc/nginx/sites-available/#{fetch(:full_app_name)}.conf"
      end

      def nginx_sites_enabled_file
        "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}.conf"
      end

      def nginx_service_path
        '/etc/init.d/nginx'
      end

      def nginx_default_pid_file
        '/run/nginx.pid'
      end

      def nginx_default_sites_available_file
        '/etc/nginx/sites-available/default'
      end

      def nginx_default_sites_enabled_file
        '/etc/nginx/sites-enabled/default'
      end

      # ssl related files
      def nginx_default_ssl_cert_file_name
        "#{fetch(:nginx_ssl_cert)}.crt"
      end

      def nginx_default_ssl_cert_key_file_name
        "#{fetch(:nginx_ssl_cert)}.key"
      end

      def nginx_ssl_cert_file
        "/etc/ssl/certs/#{fetch(:nginx_ssl_cert)}.crt"
      end

      def nginx_ssl_cert_key_file
        "/etc/ssl/private/#{fetch(:nginx_ssl_cert_key)}.key"
      end

      # log files
      def nginx_access_log_file
        shared_path.join('log/nginx.access.log')
      end

      def nginx_error_log_file
        shared_path.join('log/nginx.error.log')
      end

      def unicorn_initd_tmp_file
        "#{fetch(:tmp_dir)}/#{fetch(:unicorn_service)}"
      end

      def unicorn_initd_file
        "/etc/init.d/#{fetch(:unicorn_service)}"
      end

      def unicorn_config
        shared_path.join('config/unicorn.rb')
      end

      def unicorn_pid
        shared_path.join('tmp/pids/unicorn.pid')
      end

      def unicorn_log_file
        shared_path.join('log/unicorn.stdout.log')
      end

      def unicorn_error_log_file
        shared_path.join('log/unicorn.stderr.log')
      end

    end
  end
end