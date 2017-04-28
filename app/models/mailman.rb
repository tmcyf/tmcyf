class Mailman
  def initialize
    @gibbon = Gibbon::Request.new
    @campaign_id = ENV['MAILCHIMP_CAMPAIGN_ID']
  end

  def subscribe(user)
    @hashed_email = lower_case_and_md5_hash_email(user)
    if !mailchimp_member?(user)
      @gibbon.lists(@campaign_id).members.create(
        body: {
          email_address: user.email,
          status: "subscribed",
          merge_fields:
            { FNAME: user.fname, LNAME: user.lname }
        }
      )
    else
      @gibbon.lists(@campaign_id).members(@hashed_email).upsert(
        body: {
          status: "subscribed"
        }
      )
    end
    user.email_contact = true
  end

  def unsubscribe(user)
    @hashed_email = lower_case_and_md5_hash_email(user)
    if mailchimp_member?(user)
      @gibbon.lists(@campaign_id).members(@hashed_email).update(
        body: {
          status: "unsubscribed"
        }
      )
    end
    user.email_contact = false
  end

  def mailchimp_member?(user)
    @hashed_email = lower_case_and_md5_hash_email(user)
    get_list.body['members'].detect do |u|
      u['id'] == @hashed_email
    end
  end

  def get_list
    count = get_list_count
    @gibbon.lists(@campaign_id).members.retrieve(params: {"count": count})
  end

  def get_list_count
    # @gibbon.lists(@campaign_id).retrieve['stats']['member_count']
    @gibbon.lists(@campaign_id).retrieve(params: {"fields": "stats.member_count"}).body['stats']['member_count']
  end

  protected
  
  def lower_case_and_md5_hash_email(user)
    downcased_email = user.email.downcase
    hashed_email = Digest::MD5.hexdigest(downcased_email)
    hashed_email
  end
end
