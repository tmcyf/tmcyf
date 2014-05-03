class Mailman
  def initialize
    @gibbon = Gibbon::API.new
    @campaign_id = ENV['MAILCHIMP_CAMPAIGN_ID']
    Gibbon::API.throws_exceptions = false
  end

  def subscribe(user)
    if !mailchimp_member?(user)
      @gibbon.lists.subscribe(id: @campaign_id,
          email: {email: user.email},
          merge_vars: {FNAME: user.fname, LNAME: user.lname},
          double_optin: false)
    end
  end

  def unsubscribe
    if mailchimp_member?(user)
      @gibbon.lists.unsubscribe(id: @campaign_id,
          email: {email: user.email})
    end
  end

  def mailchimp_member?(user)
    @gibbon.lists.members(id: @campaign_id)['data'].detect do |u|
      u['email'] == user.email
    end
  end

end
