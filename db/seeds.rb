# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# tools
# Tool.create({name: 'Xcode'})
# Tool.create({name: 'NetBeans'})
# Tool.create({name: 'Ruby Mine'})
# Tool.create({name: 'Emacs'})

#discipline
des = Discipline.create({name: 'Developer'})
des.languages << Language.create({name: 'Xcode', on_page: true})
des.languages << Language.create({name: 'JavaScript', on_page: true})
des.languages << Language.create({name: 'ROR', on_page: true})
des.languages << Language.create({name: 'C++', on_page: true})
des.languages << Language.create({name: 'Java', on_page: true})
des.languages << Language.create({name: '.net', on_page: true})
des.languages << Language.create({name: 'Ceylon', on_page: false})
des.languages << Language.create({name: 'Cesil', on_page: false})
des.languages << Language.create({name: 'Cel', on_page: false})
des.languages << Language.create({name: 'Cecil', on_page: false})
des.languages << Language.create({name: 'CDuce', on_page: false})
des.languages << Language.create({name: 'Cayenne', on_page: false})
des.languages << Language.create({name: 'Candle', on_page: false})
des.languages << Language.create({name: 'Caml', on_page: false})
des.languages << Language.create({name: 'C Shell', on_page: false})
des.languages << Language.create({name: 'Cache ObjectScript', on_page: false})
des.languages << Language.create({name: 'C/AL', on_page: false})
des.languages << Language.create({name: 'C#', on_page: false})
des.languages << Language.create({name: 'C++', on_page: false})
des.languages << Language.create({name: 'C--', on_page: false})
des.languages << Language.create({name: 'C', on_page: false})
des.languages << Language.create({name: 'BuildProfessional', on_page: false})
des.languages << Language.create({name: 'BUGSYS', on_page: false})
des.languages << Language.create({name: 'BPEL', on_page: false})
des.languages << Language.create({name: 'BREW', on_page: false})
des.languages << Language.create({name: 'Bourne shell', on_page: false})
des.languages << Language.create({name: 'Boomerang', on_page: false})
des.languages << Language.create({name: 'Boo', on_page: false})
des.languages << Language.create({name: 'Bon', on_page: false})
des.languages << Language.create({name: 'Blue', on_page: false})


des.platforms << Platform.create({name: 'IOS', on_page: true})
des.platforms << Platform.create({name: 'Android', on_page: true})
des.platforms << Platform.create({name: 'OSX', on_page: true})
des.platforms << Platform.create({name: 'Windows', on_page: true})
des.platforms << Platform.create({name: 'Ubuntu', on_page: true})
des.platforms << Platform.create({name: 'REST', on_page: true})
des.platforms << Platform.create({name: 'Fedora', on_page: false})
des.platforms << Platform.create({name: 'Linux', on_page: false})
des.platforms << Platform.create({name: 'FireFox', on_page: false})
des.platforms << Platform.create({name: 'Chrome  ', on_page: false})

des = Discipline.create({name: 'Designer'})
des.platforms << Platform.create({name: 'UI', on_page: true})
des.platforms << Platform.create({name: 'UX', on_page: true})
des.platforms << Platform.create({name: 'Mobile', on_page: true})
des.platforms << Platform.create({name: 'Web Apps', on_page: true})
des.platforms << Platform.create({name: 'Video', on_page: true})
des.platforms << Platform.create({name: 'Desktop apps', on_page: true})
des.platforms << Platform.create({name: '3D', on_page: true})
des.platforms << Platform.create({name: 'Branding', on_page: true})


des.languages << Language.create({name: 'Adobe Illustrator', on_page: true})
des.languages << Language.create({name: 'Adobe Photoshop', on_page: true})
des.languages << Language.create({name: 'Adobe InDesign', on_page: true})
des.languages << Language.create({name: 'JavaScript', on_page: true})
des.languages << Language.create({name: 'CSS', on_page: true})
des.languages << Language.create({name: 'HTML', on_page: true})

des.languages << Language.create({name: 'Adobe Adobe Audition', on_page: false})
des.languages << Language.create({name: 'Adobe After Effects', on_page: false})
des.languages << Language.create({name: 'Adobe Bridge', on_page: false})
des.languages << Language.create({name: 'Adobe CC', on_page: false})
des.languages << Language.create({name: 'Adobe Dreamweaver ', on_page: false})
des.languages << Language.create({name: 'Adobe Fireworks', on_page: false})
des.languages << Language.create({name: 'Adobe Flash Professional', on_page: false})
des.languages << Language.create({name: 'Adobe Lightroom', on_page: false})
des.languages << Language.create({name: 'Adobe Muse', on_page: false})


des = Discipline.create({name: 'Operations'})
des.platforms << Platform.create({name: 'IOS', on_page: true})
des.platforms << Platform.create({name: 'Android', on_page: true})
des.platforms << Platform.create({name: 'OSX', on_page: true})
des.platforms << Platform.create({name: 'Windows', on_page: true})
des.platforms << Platform.create({name: 'Ubuntu', on_page: true})
des.platforms << Platform.create({name: 'REST', on_page: true})
des.platforms << Platform.create({name: 'Fedora', on_page: true})
des.platforms << Platform.create({name: 'Linux', on_page: true})
des.platforms << Platform.create({name: 'Chrome  ', on_page: true})
des.platforms << Platform.create({name: 'FireFox', on_page: false})


des = Discipline.create({name: 'BD'})
des.platforms << Platform.create({name: 'B2B', on_page: true})
des.platforms << Platform.create({name: 'B2C', on_page: true})
des.platforms << Platform.create({name: 'C2C', on_page: true})

des.languages << Language.create({name: 'Contracts', on_page: true})
des.languages << Language.create({name: 'Negotiating', on_page: true})
des.languages << Language.create({name: 'M&A', on_page: true})


des = Discipline.create({name: 'Marketing'})
des.platforms << Platform.create({name: 'B2B', on_page: true})
des.platforms << Platform.create({name: 'B2C', on_page: true})
des.platforms << Platform.create({name: 'C2C', on_page: true})
des.platforms << Platform.create({name: 'SEO', on_page: true})
des.platforms << Platform.create({name: 'PPC', on_page: true})
des.platforms << Platform.create({name: 'Great Writer', on_page: true})
des.platforms << Platform.create({name: 'Usability', on_page: false})

des.languages << Language.create({name: 'PR', on_page: true})
des.languages << Language.create({name: 'Branding', on_page: true})
des.languages << Language.create({name: 'Web Analytics', on_page: true})
des.languages << Language.create({name: 'Advertising', on_page: true})
des.languages << Language.create({name: 'guerilla marketing', on_page: true})
des.languages << Language.create({name: 'Consumer Acquisition', on_page: true})
des.languages << Language.create({name: 'viral marketing', on_page: true})
des.languages << Language.create({name: 'Customer Loyalty', on_page: true})

des.languages << Language.create({name: 'shopping cart', on_page: false})
des.languages << Language.create({name: 'conversion rate', on_page: false})


des = Discipline.create({name: 'Entrepreneur'})

des.platforms << Platform.create({name: 'Advertising', on_page: true})
des.platforms << Platform.create({name: 'ecommerce', on_page: true})
des.platforms << Platform.create({name: 'B2B', on_page: true})
des.platforms << Platform.create({name: 'B2C', on_page: true})
des.platforms << Platform.create({name: 'C2C', on_page: true})

des.languages << Language.create({name: 'Product', on_page: true})
des.languages << Language.create({name: 'Financials', on_page: true})
des.languages << Language.create({name: 'Legal', on_page: true})
des.languages << Language.create({name: 'Funding', on_page: true})
des.languages << Language.create({name: 'Accounting', on_page: true})
des.languages << Language.create({name: 'HR', on_page: true})


# languages


# platforms




#skills
# SkillType.create({name: 'design'})
# SkillType.create({name: 'coding'})
# SkillType.create({name: 'Database design'})
# SkillType.create({name: 'API development'})
# SkillType.create({name: 'UI'})
# SkillType.create({name: 'Server Administration'})
# SkillType.create({name: 'Enterpreneurial'})
# SkillType.create({name: 'UX'})

#Job Type
# JobType.create({name: 'Software Engineer'})
# JobType.create({name: 'UI Designer'})
# JobType.create({name: 'Database Administrator'})
# JobType.create({name: 'Front end Developer'})

#WorkLocationType
# WorkLocationType.create({name: 'remote'})
# WorkLocationType.create({name: 'onsite'})


