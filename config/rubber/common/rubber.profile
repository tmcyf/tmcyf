<%
  @path = "/etc/profile.d/rubber.sh"
  current_path = "/mnt/#{rubber_env.app_name}-#{Rubber.env}/current" 
%>

# convenience to simply running rails console, etc with correct env
export RUBBER_ENV=<%= Rubber.env %>
export RAILS_ENV=<%= Rubber.env %>
alias current="cd <%= current_path %>"
alias release="cd <%= Rubber.root %>"
export MANDRILL_USERNAME=admin@tmcyf.org
export MANDRILL_API_KEY=346eXRpmRJ2rN7D_g8Wx9Q
export MAILCHIMP_API_KEY=028484059a4faff5cd8e02f6b84d5ff1-us6
export STRIPE_API_KEY=sk_test_EJ1Hda4iDYLwoEI7UCCC0QOP
export STRIPE_PUBLIC_KEY=pk_test_kPzuqE3wLFBn1MMbjYVSMQ0P
export SECRET_KEY_BASE=5bd93a096a9ed744897e382634db2d8fcc686b4dd9255a59eecd1774d4307c65ad7d769d7aae588075b1053ae0a31562dab7bb916dc687a04f84525aa9c1a6c2
export AWS_ACCESS_KEY=AKIAIXCEUI2LMR2VFGEA
export AWS_SECRET_KEY=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
export AWS_ACCOUNT=062338450394
export S3_BUCKET=app-uploads-dev
export TWILIO_NUMBER=2816282505
export TWILIO_SID=AC24bf8cd56cf0d6be27d375b81f461c6f
export TWILIO_TOKEN=7f848416516e193d122db566ffa691f0