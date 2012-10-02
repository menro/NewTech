ActiveAdmin.register Company  do

  # Create sections on the index screen
  scope :all, :default => true

  actions :index, :edit, :update, :destroy

  filter :name
  filter :founded_year

  index do
    column :name
    column :founded_year
    column :enabled
    default_actions
  end

  controller do

    def edit
      @company = CompanyService::edit(params[:id])
    end

    def update
      @company = CompanyService::update(params[:id], params[:company])
      if @company.errors.empty?
        flash[:notice] = "Company was successfully updated."
        redirect_to admin_companies_url
      else
        flash.now[:error] = @company.errors.full_messages.join(" ")
        render :edit
      end
    end

  end

  form :partial => "form"

end
