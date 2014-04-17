task :set_deploy_ip, :stage, :ip do |t, args|
  if args.empty?
    STDOUT.print "What stage? "
    stage = STDIN.gets.chomp
    STDOUT.print "Enter the IP address: "
    ip = STDIN.gets.chomp
  else
    stage = args[:stage]
    ip = args[:ip]
  end
  conf_file = Rails.root.join("config/deploy/#{stage}.rb")
  str = IO.read(conf_file).gsub(/server '\S*'/, "server '#{ip}'")
  IO.write(conf_file, str)
end
