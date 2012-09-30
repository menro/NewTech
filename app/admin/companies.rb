ActiveAdmin.register Company  do

  # Create sections on the index screen
  scope :all, :default => true

  filter :name
  filter :founded_year

  index do
    column :name
    column :founded_year
    column :enabled
    default_actions
  end

  controller do

    def new
      @company = CompanyService::build
    end

    def create
      @company = CompanyService::create_by_user(current_user, params[:company])
      if @company.persisted?
        redirect_to admin_companies_url, :notice => "Company added correctly."
      else
        flash.now[:warning] = "Some errors are occured. fix it please! Remember to upload the image before submit"
        render :new
      end
    end

    def edit
      @company = CompanyService::edit(params[:id])
    end

    def update
      @company = CompanyService::update_by_user(current_user, params[:id], params[:company])
      if @company.errors.empty?
        redirect_to admin_companies_url
      else
        flash.now[:error] = @company.errors.full_messages.join(" ")
        render :edit
      end
    end

  end

  form :partial => "form"

end
