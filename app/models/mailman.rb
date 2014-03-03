class Mailman
	def initialize
    @gibbon = Gibbon::API.new
		@campaign_id = ENV['MAILCHIMP_CAMPAIGN_ID']
    Gibbon::API.throws_exceptions = false
	end

  def subscribe(user)
		subscribe(user) if !mailchimp_member?(user)
  end

  def subscribe
		unsubscribe(user) if mailchimp_member?(user)
  end

	def mailchimp_member?(user)
    @gibbon.lists.members(id: @campaign_id)['data'].each do |u|
			return true if u['email'] == user.email
		end
	end

	def subscribe(user)
		@gibbon.lists.subscribe(id: @campaign_id,
														 email: {email: user.email},
                             merge_vars: {FNAME: user.fname, LNAME: user.lname},
                             double_optin: false)
  end
end
