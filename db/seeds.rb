#! /usr/local/bin/ruby
# encoding: utf-8

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
Platform.delete_all
Language.delete_all
# Recommendation.delete_all
# UsersPlatforms.delete_all
# UsersLanguages.delete_all
Discipline.delete_all


des = Discipline.create({name: 'Developer'})
des.languages << Language.create({name: 'Xcode', on_page: true})
des.languages << Language.create({name: 'JavaScript', on_page: true})
des.languages << Language.create({name: 'ROR', on_page: true})
des.languages << Language.create({name: 'C++', on_page: true})
des.languages << Language.create({name: 'Java', on_page: true})
des.languages << Language.create({name: '.net', on_page: true})

des.languages << Language.create({name: 'A#', on_page: false})
des.languages << Language.create({name: 'A-0 System', on_page: false})
des.languages << Language.create({name: 'A+', on_page: false})
des.languages << Language.create({name: 'A++', on_page: false})
des.languages << Language.create({name: 'ABAP', on_page: false})
des.languages << Language.create({name: 'ABC', on_page: false})
des.languages << Language.create({name: 'ABC ALGOL', on_page: false})
des.languages << Language.create({name: 'ABLE', on_page: false})
des.languages << Language.create({name: 'ABSET', on_page: false})
des.languages << Language.create({name: 'ABSYS', on_page: false})

des.languages << Language.create({name: 'Abundance', on_page: false})
des.languages << Language.create({name: 'ACC', on_page: false})
des.languages << Language.create({name: 'Accent', on_page: false})
des.languages << Language.create({name: 'Ace DASL', on_page: false})
des.languages << Language.create({name: 'ACT-III', on_page: false})
des.languages << Language.create({name: 'Action!', on_page: false})
des.languages << Language.create({name: 'ActionScript', on_page: false})
des.languages << Language.create({name: 'Ada', on_page: false})
des.languages << Language.create({name: 'Adenine', on_page: false})
des.languages << Language.create({name: 'Agda', on_page: false})

des.languages << Language.create({name: 'Agilent VEE', on_page: false})
des.languages << Language.create({name: 'Agora', on_page: false})
des.languages << Language.create({name: 'AIMMS', on_page: false})
des.languages << Language.create({name: 'Alef', on_page: false})
des.languages << Language.create({name: 'ALF', on_page: false})
des.languages << Language.create({name: 'ALGOL 58', on_page: false})
des.languages << Language.create({name: 'ALGOL 60', on_page: false})
des.languages << Language.create({name: 'ALGOL 68', on_page: false})
des.languages << Language.create({name: 'Alice', on_page: false})
des.languages << Language.create({name: 'Alma-0', on_page: false})

des.languages << Language.create({name: 'AmbientTalk', on_page: false})
des.languages << Language.create({name: 'Amiga E', on_page: false})
des.languages << Language.create({name: 'AMOS', on_page: false})
des.languages << Language.create({name: 'AMPL', on_page: false})
des.languages << Language.create({name: 'APL', on_page: false})
des.languages << Language.create({name: 'AppleScript', on_page: false})
des.languages << Language.create({name: 'Arc', on_page: false})
des.languages << Language.create({name: 'ARexx', on_page: false})
des.languages << Language.create({name: 'Argus', on_page: false})
des.languages << Language.create({name: 'AspectJ', on_page: false})

des.languages << Language.create({name: 'ASP.NET', on_page: false})
des.languages << Language.create({name: 'Assembly language', on_page: false})
des.languages << Language.create({name: 'ATS', on_page: false})
des.languages << Language.create({name: 'Ateji PX', on_page: false})
des.languages << Language.create({name: 'AutoHotkey', on_page: false})
des.languages << Language.create({name: 'Autocoder', on_page: false})
des.languages << Language.create({name: 'AutoIt', on_page: false})
des.languages << Language.create({name: 'AutoLISP / Visual LISP', on_page: false})
des.languages << Language.create({name: 'Averest', on_page: false})
des.languages << Language.create({name: 'AWK', on_page: false})

des.languages << Language.create({name: 'Axum', on_page: false})
des.languages << Language.create({name: 'Babbage', on_page: false})
des.languages << Language.create({name: 'BAIL', on_page: false})
des.languages << Language.create({name: 'Bash', on_page: false})
des.languages << Language.create({name: 'BASIC', on_page: false})
des.languages << Language.create({name: 'bc', on_page: false})
des.languages << Language.create({name: 'BCPL', on_page: false})
des.languages << Language.create({name: 'BeanShell', on_page: false})
des.languages << Language.create({name: 'Batch (Windows/Dos)', on_page: false})
des.languages << Language.create({name: 'Bertrand', on_page: false})

des.languages << Language.create({name: 'BETA', on_page: false})
des.languages << Language.create({name: 'Bigwig', on_page: false})
des.languages << Language.create({name: 'Bistro', on_page: false})
des.languages << Language.create({name: 'BitC', on_page: false})
des.languages << Language.create({name: 'BLISS', on_page: false})
des.languages << Language.create({name: 'Blue', on_page: false})
des.languages << Language.create({name: 'Bon', on_page: false})
des.languages << Language.create({name: 'Boo', on_page: false})
des.languages << Language.create({name: 'Boomerang', on_page: false})
des.languages << Language.create({name: 'Bourne shell', on_page: false})

des.languages << Language.create({name: 'BREW', on_page: false})
des.languages << Language.create({name: 'BPEL', on_page: false})
des.languages << Language.create({name: 'BUGSYS', on_page: false})
des.languages << Language.create({name: 'BuildProfessional', on_page: false})
des.languages << Language.create({name: 'C', on_page: false})
des.languages << Language.create({name: 'C--', on_page: false})
des.languages << Language.create({name: 'A/AL', on_page: false})
des.languages << Language.create({name: 'Caché ObjectScript', on_page: false})
des.languages << Language.create({name: 'C Shell', on_page: false})
des.languages << Language.create({name: 'Caml', on_page: false})

des.languages << Language.create({name: 'Candle', on_page: false})
des.languages << Language.create({name: 'Cayenne', on_page: false})
des.languages << Language.create({name: 'CDuce', on_page: false})
des.languages << Language.create({name: 'Cecil', on_page: false})
des.languages << Language.create({name: 'Cel', on_page: false})
des.languages << Language.create({name: 'Cesil', on_page: false})
des.languages << Language.create({name: 'Ceylon', on_page: false})
des.languages << Language.create({name: 'CFML', on_page: false})
des.languages << Language.create({name: 'Cg', on_page: false})
des.languages << Language.create({name: 'Ch', on_page: false})

des.languages << Language.create({name: 'Chapel', on_page: false})
des.languages << Language.create({name: 'CHAIN', on_page: false})
des.languages << Language.create({name: 'Charity', on_page: false})
des.languages << Language.create({name: 'Charm', on_page: false})
des.languages << Language.create({name: 'Chef', on_page: false})
des.languages << Language.create({name: 'CHILL', on_page: false})
des.languages << Language.create({name: 'CHIP-8', on_page: false})
des.languages << Language.create({name: 'chomski', on_page: false})
des.languages << Language.create({name: 'ChucK', on_page: false})
des.languages << Language.create({name: 'CICS', on_page: false})

des.languages << Language.create({name: 'Cilk', on_page: false})
des.languages << Language.create({name: 'CL (IBM)', on_page: false})
des.languages << Language.create({name: 'Claire', on_page: false})
des.languages << Language.create({name: 'Clarion', on_page: false})
des.languages << Language.create({name: 'Clean', on_page: false})
des.languages << Language.create({name: 'Clipper', on_page: false})
des.languages << Language.create({name: 'CLIST', on_page: false})
des.languages << Language.create({name: 'Clojure', on_page: false})
des.languages << Language.create({name: 'CLU', on_page: false})
des.languages << Language.create({name: 'CMS-2', on_page: false})

des.languages << Language.create({name: 'COBOL', on_page: false})
des.languages << Language.create({name: 'CobolScript', on_page: false})
des.languages << Language.create({name: 'Cobra', on_page: false})
des.languages << Language.create({name: 'CODE', on_page: false})
des.languages << Language.create({name: 'CoffeeScript', on_page: false})
des.languages << Language.create({name: 'Cola', on_page: false})
des.languages << Language.create({name: 'ColdC', on_page: false})
des.languages << Language.create({name: 'ColdFusion', on_page: false})
des.languages << Language.create({name: 'Cool', on_page: false})
des.languages << Language.create({name: 'COMAL', on_page: false})

des.languages << Language.create({name: 'Combined Programming Language (CPL)', on_page: false})
des.languages << Language.create({name: 'Common Intermediate Language (CIL)', on_page: false})
des.languages << Language.create({name: 'Common Lisp', on_page: false})
des.languages << Language.create({name: 'COMPASS', on_page: false})
des.languages << Language.create({name: 'Component Pascal', on_page: false})
des.languages << Language.create({name: 'COMIT', on_page: false})
des.languages << Language.create({name: 'Constraint Handling Rules (CHR)', on_page: false})
des.languages << Language.create({name: 'Converge', on_page: false})
des.languages << Language.create({name: 'Coral 66', on_page: false})
des.languages << Language.create({name: 'Corn', on_page: false})

des.languages << Language.create({name: 'CorVision', on_page: false})
des.languages << Language.create({name: 'Coq', on_page: false})
des.languages << Language.create({name: 'COWSEL', on_page: false})
des.languages << Language.create({name: 'CPL', on_page: false})
des.languages << Language.create({name: 'csh', on_page: false})
des.languages << Language.create({name: 'CSP', on_page: false})
des.languages << Language.create({name: 'Csound', on_page: false})
des.languages << Language.create({name: 'Curl', on_page: false})
des.languages << Language.create({name: 'Curry', on_page: false})
des.languages << Language.create({name: 'Cyclone', on_page: false})

des.languages << Language.create({name: 'Cython', on_page: false})
des.languages << Language.create({name: 'D', on_page: false})
des.languages << Language.create({name: 'DASL', on_page: false})
des.languages << Language.create({name: 'Dart', on_page: false})
des.languages << Language.create({name: 'DataFlex', on_page: false})
des.languages << Language.create({name: 'Datalog', on_page: false})
des.languages << Language.create({name: 'DATATRIEVE', on_page: false})
des.languages << Language.create({name: 'dBase', on_page: false})
des.languages << Language.create({name: 'dc', on_page: false})
des.languages << Language.create({name: 'DCL', on_page: false})

des.languages << Language.create({name: 'Deesel', on_page: false})
des.languages << Language.create({name: 'Delphi', on_page: false})
des.languages << Language.create({name: 'DinkC', on_page: false})
des.languages << Language.create({name: 'DIBOL', on_page: false})
des.languages << Language.create({name: 'Dog', on_page: false})
des.languages << Language.create({name: 'Draco', on_page: false})
des.languages << Language.create({name: 'Dylan', on_page: false})
des.languages << Language.create({name: 'DYNAMO', on_page: false})
des.languages << Language.create({name: 'E', on_page: false})
des.languages << Language.create({name: 'E#', on_page: false})

des.languages << Language.create({name: 'Ease', on_page: false})
des.languages << Language.create({name: 'Easy PL/I', on_page: false})
des.languages << Language.create({name: 'EASYTRIEVE PLUS', on_page: false})
des.languages << Language.create({name: 'ECMAScript', on_page: false})
des.languages << Language.create({name: 'Edinburgh IMP', on_page: false})
des.languages << Language.create({name: 'EGL', on_page: false})
des.languages << Language.create({name: 'Eiffel', on_page: false})
des.languages << Language.create({name: 'ELAN', on_page: false})
des.languages << Language.create({name: 'Elixir', on_page: false})
des.languages << Language.create({name: 'Elm', on_page: false})

des.languages << Language.create({name: 'Emacs Lisp', on_page: false})
des.languages << Language.create({name: 'Emerald', on_page: false})
des.languages << Language.create({name: 'Epigram', on_page: false})
des.languages << Language.create({name: 'Erlang', on_page: false})
des.languages << Language.create({name: 'es', on_page: false})
des.languages << Language.create({name: 'Escapade', on_page: false})
des.languages << Language.create({name: 'Escher', on_page: false})
des.languages << Language.create({name: 'ESPOL', on_page: false})
des.languages << Language.create({name: 'Esterel', on_page: false})
des.languages << Language.create({name: 'Etoys', on_page: false})

des.languages << Language.create({name: 'Euclid', on_page: false})
des.languages << Language.create({name: 'Euler', on_page: false})
des.languages << Language.create({name: 'Euphoria', on_page: false})
des.languages << Language.create({name: 'EusLisp Robot Programming Language', on_page: false})
des.languages << Language.create({name: 'CMS EXEC', on_page: false})
des.languages << Language.create({name: 'EXEC 2', on_page: false})
des.languages << Language.create({name: 'F', on_page: false})
des.languages << Language.create({name: 'F#', on_page: false})
des.languages << Language.create({name: 'Factor', on_page: false})
des.languages << Language.create({name: 'Falcon', on_page: false})

des.languages << Language.create({name: 'Fancy', on_page: false})
des.languages << Language.create({name: 'Fantom', on_page: false})
des.languages << Language.create({name: 'FAUST', on_page: false})
des.languages << Language.create({name: 'Felix', on_page: false})
des.languages << Language.create({name: 'Ferite', on_page: false})
des.languages << Language.create({name: 'FFP', on_page: false})
des.languages << Language.create({name: 'Fjölnir', on_page: false})
des.languages << Language.create({name: 'FL', on_page: false})
des.languages << Language.create({name: 'Flavors', on_page: false})
des.languages << Language.create({name: 'Flex', on_page: false})


on_page_array = "FLOW-MATIC,FOCAL,FOCUS,FOIL,FORMAC,@Formula,Forth,Fortran,Fortress,FoxBase,FoxPro,FP,FPr,Franz Lisp,Frink,F-Script,FSProg,G,Game Maker Language,GameMonkey Script,GAMS,GAP,G-code,Genie,GDL,Gibiane,GJ,GEORGE,GLSL,GNU E,GM,Go,Go!,GOAL,Gödel,Godiva,GOM (Good Old Mad),Goo,Gosu,GOTRAN,GPSS,GraphTalk,GRASS,Groovy,HAL/S,Hamilton C shell,Harbour,Hartmann pipelines,Haskell,Haxe,High Level Assembly,HLSL,Hop,Hope,Hugo,Hume,HyperTalk,IBM Basic assembly language,IBM HAScript,IBM Informix-4GL,IBM RPG,ICI,Icon,Id,IDL,Idris,IMP,Inform,Io,Ioke,IPL,IPTSCRAE,ISLISP,ISPF,ISWIM,J,J#,J++,JADE,Jako,JAL,Janus,JASS,,,JCL,JEAN,,JOSS,Joule,JOVIAL,Joy,JScript,JavaFX Script,Julia,K,Kaleidoscope,Karel,Karel++,Kaya,KEE,KIF,Kojo,KRC,KRL,KRL (KUKA Robot Language),KRYPTON,ksh,L,L# .NET,LabVIEW,Ladder,Lagoona,LANSA,Lasso,LaTeX,Lava,LC-3,Leadwerks Script,Leda,Legoscript,LIL,LilyPond,Limbo,Limnor,LINC,Lingo,Linoleum,LIS,LISA,Lisaac,Lisp - ISO/IEC 13816,Lite-C,Lithe,Little b,Logo,Logtalk,LPC,LSE,LSL,LiveCode,Lua,Lucid,Lustre,LYaPAS,Lynx,M,M2001,M4,Machine code,MAD (Michigan Algorithm Decoder),MAD/I,Magik,Magma,make,Maple,MAPPER (Unisys/Sperry) now part of BIS,MARK-IV (Sterling/Informatics) now VISION:BUILDER of CA,Mary,MASM Microsoft Assembly x86,Mathematica,MATLAB,Maxima (see also Macsyma),Max (Max Msp - Graphical Programming Environment),MaxScript internal language 3D Studio Max,Maya (MEL),MDL,Mercury,Mesa,Metacard,Metafont,MetaL,Microcode,MicroScript,MIIS,MillScript,MIMIC,Mirah,Miranda,MIVA Script,ML,Moby,Model 204,Modelica,Modula,Modula-2,Modula-3,Mohol,MOO,Mortran,Mouse,MPD,MSIL - deprecated name for CIL,MSL,MUMPS,Napier88,NASM,NATURAL,Neko,Nemerle,NESL,Net.Data,NetLogo,NetRexx,NewLISP,NEWP,Newspeak,NewtonScript,NGL,Nial,Nice,Nickle,NPL,Not eXactly C (NXC),Not Quite C (NQC),Nu,NSIS,NWScript,o:XML,Oak,Oberon,Obix,OBJ2,Object Lisp,ObjectLOGO,Object REXX,Object Pascal,Objective-C,Objective-J,Obliq,Obol,OCaml,occam,occam-π,Octave,OmniMark,Onyx,Opa,Opal,OpenEdge ABL,OPL,OPS5,OptimJ,Orc,ORCA/Modula-2,Oriel,Orwell,Oxygene,Oz,P#,PARI/GP,Pascal - ISO 7185,Pawn,PCASTL,PCF,PEARL"
on_page_array.split(',').each do |name|
  next if name.blank?
  des.languages << Language.create({name: name, on_page: false})
end

des.platforms << Platform.create({name: 'IOS', on_page: true})
des.platforms << Platform.create({name: 'Android', on_page: true})
des.platforms << Platform.create({name: 'OSX', on_page: true})
des.platforms << Platform.create({name: 'Windows', on_page: true})
des.platforms << Platform.create({name: 'Ubuntu', on_page: true})
des.platforms << Platform.create({name: 'REST', on_page: true})
des.platforms << Platform.create({name: 'Fedora', on_page: false})
des.platforms << Platform.create({name: 'Linux', on_page: false})
des.platforms << Platform.create({name: 'FireFox', on_page: false})
des.platforms << Platform.create({name: 'Adobe AIR', on_page: false})
des.platforms << Platform.create({name: 'Adobe Flex', on_page: false})
des.platforms << Platform.create({name: 'Xamarin', on_page: false})
des.platforms << Platform.create({name: 'DOS', on_page: false})



des = Discipline.create({name: 'Designer'})
des.platforms << Platform.create({name: 'UI', on_page: true})
des.platforms << Platform.create({name: 'UX', on_page: true})
des.platforms << Platform.create({name: 'Mobile', on_page: true})
des.platforms << Platform.create({name: 'Web Apps', on_page: true})
des.platforms << Platform.create({name: 'Video', on_page: true})
des.platforms << Platform.create({name: 'Desktop apps', on_page: true})
des.platforms << Platform.create({name: '3D', on_page: true})
des.platforms << Platform.create({name: 'Branding', on_page: true})

des.platforms << Platform.create({name: 'Print', on_page: false})
des.platforms << Platform.create({name: 'Marketing communications', on_page: false})
des.platforms << Platform.create({name: 'instructional', on_page: false})
des.platforms << Platform.create({name: 'eLearning', on_page: false})
des.platforms << Platform.create({name: 'Packaging', on_page: false})
des.platforms << Platform.create({name: 'identity', on_page: false})


des.languages << Language.create({name: 'Adobe Illustrator', on_page: true})
des.languages << Language.create({name: 'Adobe Photoshop', on_page: true})
des.languages << Language.create({name: 'Adobe InDesign', on_page: true})
des.languages << Language.create({name: 'JavaScript', on_page: true})
des.languages << Language.create({name: 'CSS', on_page: true})
des.languages << Language.create({name: 'HTML', on_page: true})
des.languages << Language.create({name: 'Microsoft Powerpoint', on_page: true})
des.languages << Language.create({name: 'FInale Cut Pro', on_page: true})

off_page_array = "Adobe Adobe Audition,Adobe After Effects,Adobe Bridge,Adobe CC,Adobe Dreamweaver ,Adobe Fireworks,Adobe Flash Professional,Adobe Lightroom,Adobe Muse,Adobe PageMaker,,Adobe Prelude ,Adobe Premiere Pro,Adobe SpeedGrade ,Apple Aperture,Apple Final Cut pro,Apple GarageBand,Apple Ibooks Author,Apple keynote,Apple Logic Studio,Apple Motion,Apple Numbers,Apple Pages,Autodesk AutoCAD,Autodesk Maya,Autodesk Mudbox,Blender,Canvas,Cinema 4D,DAZ Studio,Flame,Gimp,Maxon Cinema 4D Studio,Maya,Microsofot Project,Microsoft Excel,Microsoft Office,Microsoft Powerpoint,Microsoft Visio,Microsoft Word,PaintShop Pro X4,Pro Engineer,Revit,Serif Photoplus,Serif Photoplus,SketchUp,SolidWorks,SmithMicro Poser,Strata Design 3D,SmithMicro Poser,Strata Design 3D,Axure,ADDIE,Audience analysis,,,Adobe Connect,Camtasia Studio,Moodle"
off_page_array.split(',').each do |name|
  next if name.blank?
  des.languages << Language.create({name: name, on_page: false})
end

des = Discipline.create({name: 'Operations'})
des.platforms << Platform.create({name: 'Amazon', on_page: true})
des.platforms << Platform.create({name: 'Windows', on_page: true})
des.platforms << Platform.create({name: 'Ubuntu', on_page: true})
des.platforms << Platform.create({name: 'Fedora', on_page: true})
des.platforms << Platform.create({name: 'Linux', on_page: true})

des.platforms << Platform.create({name: 'FireFox', on_page: false})
des.platforms << Platform.create({name: 'Open Source', on_page: false})
des.platforms << Platform.create({name: 'Chrome', on_page: false})
des.platforms << Platform.create({name: 'Rackspace', on_page: false})
des.platforms << Platform.create({name: 'Digital Ocean', on_page: false})

des.languages << Language.create({name: 'scripting', on_page: true})
des.languages << Language.create({name: 'config', on_page: true})
des.languages << Language.create({name: 'python', on_page: true})
des.languages << Language.create({name: 'Ruby', on_page: true})
des.languages << Language.create({name: 'Bash', on_page: true})

des.languages << Language.create({name: 'Ruby', on_page: false})
des.languages << Language.create({name: 'Bash', on_page: false})
des.languages << Language.create({name: 'NLB', on_page: false})
des.languages << Language.create({name: 'CDN', on_page: false})
des.languages << Language.create({name: 'Caching', on_page: false})
des.languages << Language.create({name: 'Casandra', on_page: false})
des.languages << Language.create({name: 'ngnix', on_page: false})
des.languages << Language.create({name: 'Apache', on_page: false})
des.languages << Language.create({name: 'MongoDB', on_page: false})
des.languages << Language.create({name: 'PostgreSQL', on_page: false})
des.languages << Language.create({name: 'Redis', on_page: false})
des.languages << Language.create({name: 'CouchDB', on_page: false})
des.languages << Language.create({name: 'ElasticSearch', on_page: false})
des.languages << Language.create({name: 'MariaDB', on_page: false})

des = Discipline.create({name: 'BD'})
des.platforms << Platform.create({name: 'B2B', on_page: true})
des.platforms << Platform.create({name: 'B2C', on_page: true})
des.platforms << Platform.create({name: 'C2C', on_page: true})
des.platforms << Platform.create({name: 'Client Engagement', on_page: true})
des.platforms << Platform.create({name: 'Decision Making', on_page: true})
des.platforms << Platform.create({name: 'Business models', on_page: true})
des.platforms << Platform.create({name: 'Partner Identification', on_page: true})
des.platforms << Platform.create({name: 'sales', on_page: true})

des.languages << Language.create({name: 'Contracts', on_page: true})
des.languages << Language.create({name: 'Negotiating', on_page: true})
des.languages << Language.create({name: 'M&A', on_page: true})
des.languages << Language.create({name: 'Strategy', on_page: true})
des.languages << Language.create({name: 'Communication', on_page: true})
des.languages << Language.create({name: 'Presentation', on_page: true})
des.languages << Language.create({name: 'Prospecting', on_page: true})

des.languages << Language.create({name: 'Product', on_page: true})
des.languages << Language.create({name: 'Customer Acquisition', on_page: true})
des.languages << Language.create({name: 'entrepreneurial', on_page: true})
des.languages << Language.create({name: 'problem solving', on_page: true})
des.languages << Language.create({name: 'analytical thinker', on_page: true})

des = Discipline.create({name: 'Marketing'})
des.platforms << Platform.create({name: 'B2B', on_page: true})
des.platforms << Platform.create({name: 'B2C', on_page: true})
des.platforms << Platform.create({name: 'C2C', on_page: true})
des.platforms << Platform.create({name: 'SEO', on_page: true})
des.platforms << Platform.create({name: 'PPC', on_page: true})
des.platforms << Platform.create({name: 'Great Writer', on_page: true})
des.platforms << Platform.create({name: 'Usability', on_page: true})

des.languages << Language.create({name: 'PR', on_page: true})
des.languages << Language.create({name: 'Branding', on_page: true})
des.languages << Language.create({name: 'Web Analytics', on_page: true})
des.languages << Language.create({name: 'Advertising', on_page: true})
des.languages << Language.create({name: 'guerilla marketing', on_page: true})
des.languages << Language.create({name: 'Consumer Acquisition', on_page: true})
des.languages << Language.create({name: 'viral marketing', on_page: true})
des.languages << Language.create({name: 'Customer Loyalty', on_page: true})

off_page_array = "shopping cart,conversion rate,Affiliate Marketing,Strategy,Communications,Ecommerce,Content Analytics,Business Intelligence,Communications,Social Content,Direct to Consumer,Online Merchandising,Optimization,Digital Relationship Marketing,eMarketing Strategy"
off_page_array.split(',').each do |name|
  next if name.blank?
  des.languages << Language.create({name: name, on_page: false})    
end

des = Discipline.create({name: 'Mentor'})
des.platforms << Platform.create({name: 'Advertising', on_page: true})
des.platforms << Platform.create({name: 'ecommerce', on_page: true})
des.platforms << Platform.create({name: 'B2B', on_page: true})
des.platforms << Platform.create({name: 'B2C', on_page: true})
des.platforms << Platform.create({name: 'C2C', on_page: true})
des.platforms << Platform.create({name: 'Think big', on_page: true})

des.languages << Language.create({name: 'Product', on_page: true})
des.languages << Language.create({name: 'Financials', on_page: true})
des.languages << Language.create({name: 'Legal', on_page: true})
des.languages << Language.create({name: 'Funding', on_page: true})
des.languages << Language.create({name: 'Accounting', on_page: true})
des.languages << Language.create({name: 'HR', on_page: true})
des.languages << Language.create({name: 'Motivation', on_page: true})
des.languages << Language.create({name: 'Sales', on_page: true})

des.languages << Language.create({name: 'Prioritize', on_page: false})
des.languages << Language.create({name: 'Forcasting', on_page: false})
des.languages << Language.create({name: 'Technical', on_page: false})
des.languages << Language.create({name: 'Design', on_page: false})

discipline = Discipline.find_by_name('Developer')
discipline.languages_name = 'Languages'
discipline.platforms_name = 'Platforms'
discipline.save

discipline = Discipline.find_by_name('Designer')
discipline.languages_name = 'Tools'
discipline.platforms_name = 'Specialites'
discipline.save

discipline = Discipline.find_by_name('Operations')
discipline.languages_name = 'Skills'
discipline.platforms_name = 'Platforms'
discipline.save

discipline = Discipline.find_by_name('Business Development')
discipline.languages_name = 'Skills'
discipline.platforms_name = 'Expertise'
discipline.save

discipline = Discipline.find_by_name('Marketing')
discipline.languages_name = 'Experience'
discipline.platforms_name = 'Skills'
discipline.save

discipline = Discipline.find_by_name('Mentor')
discipline.languages_name = 'Skills'
discipline.platforms_name = 'Expertise'
discipline.save



countries = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Antarctic Territory", "British Indian Ocean Territory", "British Virgin Islands", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Canton and Enderbury Islands", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos [Keeling] Islands", "Colombia", "Comoros", "Congo - Brazzaville", "Congo - Kinshasa", "Cook Islands", "Costa Rica", "Croatia", "Cuba", "Cyprus", "Czech Republic", "Côte d’Ivoire", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Dronning Maud Land", "East Germany", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands", "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia", "French Southern Territories", "French Southern and Antarctic Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard Island and McDonald Islands", "Honduras", "Hong Kong SAR China", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Johnston Island", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau SAR China", "Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Metropolitan France", "Mexico", "Micronesia", "Midway Islands", "Moldova", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar [Burma]", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "Neutral Zone", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "North Korea", "North Vietnam", "Northern Mariana Islands", "Norway", "Oman", "Pacific Islands Trust Territory", "Pakistan", "Palau", "Palestinian Territories", "Panama", "Panama Canal Zone", "Papua New Guinea", "Paraguay", "People's Democratic Republic of Yemen", "Peru", "Philippines", "Pitcairn Islands", "Poland", "Portugal", "Puerto Rico", "Qatar", "Romania", "Russia", "Rwanda", "Réunion", "Saint Barthélemy", "Saint Helena", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Saudi Arabia", "Senegal", "Serbia", "Serbia and Montenegro", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "South Korea", "Spain", "Sri Lanka", "Sudan", "Suriname", "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syria", "São Tomé and Príncipe", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "U.S. Minor Outlying Islands", "U.S. Miscellaneous Pacific Islands", "U.S. Virgin Islands", "Uganda", "Ukraine", "Union of Soviet Socialist Republics", "United Arab Emirates", "United Kingdom", "United States", "Unknown or Invalid Region", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Wake Island", "Wallis and Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe", "Åland Islands"]

countries.each do |country|
  Country.find_or_create_by_name(country)
end

states =  [["United States ", "Colorado"], ["United States", "Alabama"], ["United States", "Alaska"], ["United States", "Arizona"], ["United States", "Arkansas"], ["United States", "California"], ["United States", "Connecticut"], ["United States", "Delaware"], ["United States", "Florida"], ["United States", "Georgia"], ["United States", "Hawaii"], ["United States", "Idaho"], ["United States", "Illinois"], ["United States", "Indiana"], ["United States", "Iowa"], ["United States", "Kansas"], ["United States", "Kentucky"], ["United States", "Louisiana"], ["United States", "Maine"], ["United States", "Maryland"], ["United States", "Massachusetts"], ["United States", "Michigan"], ["United States", "Minnesota"], ["United States", "Mississippi"], ["United States", "Missouri"], ["United States", "Montana"], ["United States", "Nebraska"], ["United States", "Nevada"], ["United States", "New Hampshire"], ["United States", "New Jersey"], ["United States", "New Mexico"], ["United States", "New York"], ["United States", "North Carolina"], ["United States", "North Dakota"], ["United States", "Ohio"], ["United States", "Oklahoma"], ["United States", "Oregon"], ["United States", "Pennsylvania"], ["United States", "Rhode Island"], ["United States", "South Carolina"], ["United States", "South Dakota"], ["United States", "Tennessee"], ["United States", "Texas"], ["United States", "Utah"], ["United States", "Vermont"], ["United States", "Virginia"], ["United States", "Washington"], ["United States", "West Virginia"], ["United States", "Wisconsin"], ["United States", "Wyoming"], ["Canada", "Alberta"]]

states.each do |state|
  c = Country.find_by_name(state.first)
  s = State.find_or_create_by_name(state.last)
  s.country = c
  s.save!
end

counties = [["Colorado", "Adams"], ["Colorado", "Arapahoe"], ["Colorado", "Archuleta"], ["Colorado", "Boulder"], ["Colorado", "Broomfield"], ["Colorado", "Chaffee"], ["Colorado", "Clear Creek"], ["Colorado", "Delta"], ["Colorado", "Denver"], ["Colorado", "Douglas"], ["Colorado", "Eagle"], ["Colorado", "El Paso"], ["Colorado", "Elbert"], ["Colorado", "Fremont"], ["Colorado", "Garfield"], ["Colorado", "Gilpin"], ["Colorado", "Grand"], ["Colorado", "Gunnison"], ["Colorado", "Hinsdale"], ["Colorado", "Jefferson"], ["Colorado", "Kit Carson"], ["Colorado", "La Plata"], ["Colorado", "Larimer"], ["Colorado", "Logan"], ["Colorado", "Mesa"], ["Colorado", "Moffat"], ["Colorado", "Montezuma"], ["Colorado", "Montrose"], ["Colorado", "Ouray"], ["Colorado", "Park"], ["Colorado", "Pitkin"], ["Colorado", "Prowers"], ["Colorado", "Pueblo"], ["Colorado", "Rio Blanco"], ["Colorado", "Rio Grande"], ["Colorado", "Routt"], ["Colorado", "San Miguel"], ["Colorado", "Summit"], ["Colorado", "Teller"], ["Colorado", "Weld"], ["New York", "New York"], ["Alberta", "Capital Region"]]

counties.each do |county|
  s = State.find_by_name(county.first)
  c = County.find_or_create_by_name(county.last)
  c.state = s
  c.save!
end


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


