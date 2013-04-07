class SkillService

  def self.search(params)
    skills = Skill.scoped
    skills = SkillDecorator.decorate(skills.uniq, :search_params => params)
    skills
  end

end
