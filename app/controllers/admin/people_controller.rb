class Admin::PeopleController < AdminController

  ## optional filters for defining usage according to Casein::AdminUser access_levels
  # before_filter :needs_admin, :except => [:action1, :action2]
  # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

  def index

    #@is_collaborator = params[:is_collaborator]
    #@is_consultant = params[:is_consultant]
    @casein_page_title = 'People'

    @people = Person.where(nil)

    @people = @people.order(sort_order(:name)).paginate :page => params[:page]
  end

  def show
    @casein_page_title = 'View person'
    @person = Person.find params[:id]
  end

  def new
    @casein_page_title = 'Add a new person'
    @person = Person.new
  end

  def create
    @person = Person.new person_params

    if @person.save
      flash[:notice] = 'Person created'
      redirect_to casein_people_path
    else
      flash.now[:warning] = 'There were problems when trying to create a new person'
      render :action => :new
    end
  end

  def update
    @casein_page_title = 'Update person'

    @person = Person.find params[:id]

    if @person.update_attributes person_params
      flash[:notice] = 'Person has been updated'
      redirect_to casein_people_path
    else
      flash.now[:warning] = 'There were problems when trying to update this person'
      render :action => :show
    end
  end

  def destroy
    @person = Person.find params[:id]

    @person.destroy
    flash[:notice] = 'Person has been deleted'
    redirect_to casein_people_path
  end

  private

  def person_params
    params.require(:person).permit(:name, :birthday, :description, :email, :is_morphosis, :is_employed, :is_collaborator, :is_consultant, :start_date, :end_date, :website, :location)
  end

end