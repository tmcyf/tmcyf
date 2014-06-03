class WomensRetreatRegistration < ActiveRecord::Base
  enum academic_classification: [ :intermediate, :high_school, :undergraduate, 
                                  :graduate, :postgraduate ]
  enum parish: [ :trinity, :horeb, :oklahoma, :sehion, :carollton, :st_paul, 
                 :farmers_branch, :austin, :immanuel ]

  def parish_display_name(parish_keyword)
    names = {
      trinity: "Trinity Mar Thoma Church",
      horeb: "Horeb Mar Thoma Church, Colorado",
      oklahoma: "Mar Thoma Church of Oklahoma",
      sehion: "Sehion Mar Thoma Church",
      carollton: "Carrollton Mar Thoma Church",
      st_paul: "St. Paul's Mar Thoma Church",
      farmers_branch: "Farmer's Branch Mar Thoma Church",
      austin: "Austin Mar Thoma Church",
      immanuel: "Immanuel Mar Thoma Church"
    }
    names[parish_keyword]
  end
end
