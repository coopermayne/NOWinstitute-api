class Admin::NewsItemsController < AdminController

  ## optional filters for defining usage according to Casein::AdminUser access_levels
  # before_filter :needs_admin, :except => [:action1, :action2]
  # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]

  def index
    @casein_page_title = 'News items'
    unless params[:d] || params[:u]
      params[:d] = 'down'
    end

    @news_items
    @news_items = NewsItem.order(sort_order(:created_at)).paginate :page => params[:page]
  end

  def show
    @casein_page_title = 'View news item'
    @news_item = NewsItem.find params[:id]
  end

  def new
    @casein_page_title = 'Add a new news item'
    @news_item = NewsItem.new
  end

  def create
    @news_item = NewsItem.new news_item_params

    if @news_item.save
      flash[:notice] = 'News item created'
      redirect_to casein_news_items_path
    else
      flash.now[:warning] = 'There were problems when trying to create a new news item'
      render :action => :new
    end
  end

  def update
    @casein_page_title = 'Update news item'

    @news_item = NewsItem.find params[:id]

    if @news_item.update_attributes news_item_params
      flash[:notice] = 'News item has been updated'
      redirect_to casein_news_items_path
    else
      flash.now[:warning] = 'There were problems when trying to update this news item'
      render :action => :show
    end
  end

  def destroy
    @news_item = NewsItem.find params[:id]

    @news_item.destroy
    flash[:notice] = 'News item has been deleted'
    redirect_to casein_news_items_path
  end

  private

  def news_item_params
    params.require(:news_item).permit(
      :title,
      :description,
      :overview,
      :place_name,
      :street_address,
      :start_date,
      :news_type_id
    )
  end

end