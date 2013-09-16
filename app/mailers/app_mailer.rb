class AppMailer < ActionMailer::Base
  default from: "noreply@bdnt.org"

  def endorsement(recommendi, recommender, skill)
    @recommendi = recommendi
    @recommender = recommender
    @skill = skill
    mail(:to => @recommendi.email, :subject => "Congratulations! you got an endorsement")
  end
end