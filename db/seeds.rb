# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# tools
Tool.create({name: 'Xcode'})
Tool.create({name: 'NetBeans'})
Tool.create({name: 'Ruby Mine'})
Tool.create({name: 'Emacs'})

# languages
Language.create({name: 'C#'})
Language.create({name: 'C++'})
Language.create({name: 'Ruby'})
Language.create({name: 'Javascript'})
Language.create({name: 'Cocos2d'})

# platforms
Platform.create({name: 'IOS'})
Platform.create({name: 'Android'})
Platform.create({name: 'Web'})
Platform.create({name: 'REST APIs'})
Platform.create({name: 'Linux'})

#skills
SkillType.create({name: 'design', stars: 2})
SkillType.create({name: 'coding', stars: 3})
SkillType.create({name: 'Database design', stars: 5})
SkillType.create({name: 'API development', stars: 5})
SkillType.create({name: 'UI', stars: 4})
SkillType.create({name: 'Server Administration', stars: 3})
SkillType.create({name: 'Enterpreneurial', stars: 5})
SkillType.create({name: 'UX', stars: 5})

#Job Type
JobType.create({name: 'Software Engineer'})
JobType.create({name: 'UI Designer'})
JobType.create({name: 'Database Administrator'})
JobType.create({name: 'Front end Developer'})

