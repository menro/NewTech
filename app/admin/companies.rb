ActiveAdmin.register Company  do

  # Create sections on the index screen
  scope :all, :default => true

  actions :index, :show, :edit, :update, :destroy

  filter :name
  filter :founded_year

  index do
    column :name
    column :founded_year
    column :enabled
    default_actions
  end

  show do |company|
    attributes_table do
      row :id
      row :name
      row :user
      row :city
      row :county
      row :zipcode do 
        link_to company.zipcode.code, admin_zipcode_path(company.zipcode_id)
      end
      row :category
      row :raising_money
      row :money_raisig_expired_at
      row :homepage_url
      row :facebook
      row :twitter
      row :jobs_url
      row :address
      row :address2
      row :founded_year
      row :email_address
      row :phone_number
      row :description
      row :overview
      row :latitude
      row :longitude
      row :jobs_count
      row :kickstarter_url
      row :kickstarter_end_date
      row :permalink
      row :enabled
      row :presented
      row :presentation_date
      row :created_at
      row :updated_at
    end
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
