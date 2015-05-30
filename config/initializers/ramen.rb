RamenRails.config do |config|
  # Your Ramen Organization ID
  config.organization_id = configatron.ramen.organization_id 

  # Your Ramen Organization Secret
  config.organization_secret = configatron.ramen.organization_secret 


  ## Important note regarding `-> {}` vs. `Proc.new {}`
  ##
  ## Use `Proc.new {}` and not `-> {}`. There's some inconsistency
  ## in how instance_eval works across Ruby versions that will bite
  ## you in the butt otherwise.


  ## How we access the currently logged in user. This object
  ## should respond to #email(String), #id(String),
  ## #created_at(Time) and #name(String)
  #
  # config.current_user = Proc.new { current_user }


  ## How we access the labels for the currently logged in user.
  ## This is an array of strings.
  #
  # config.current_user_labels = Proc.new { current_user.labels.map(&:name) }


  ## How we access the current user "value". This is
  ## a Float. It can represent whatever you want.
  ##
  ## If config.current_user is empty, this will be ignored
  #
  # config.current_user_value = Proc.new { current_user_value }


  ## Custom Links to add to the Ramen Tray
  ## You can add up to 3. Each requires a `title`.
  ## Each requires a `callback` or an `href`.
  ## Links w/ `href` will have target="_blank".
  ## `callback` is a *string*, not a JS closure even
  ## if you override these values in your markup.
  #
  # config.custom_links = [
  #   {
  #     title: "Submit a bug",
  #     callback: "$('#submit_bug').modal('show')"  #<-- String!
  #   },
  #   {
  #     title: "Knowledge Base",
  #     href: "/knowedge_base"
  #   }
  # ]
end
