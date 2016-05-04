
class IshLibManager::GalleriesController < IshLibManager::ApplicationController

  before_filter :set_lists
  
  def index
    authorize! :index, Gallery
    redirect_to galleries_thumb_path
  end

  def index_title
    authorize! :index, Gallery
    @galleries = Gallery.unscoped.where( :is_trash => false ).order_by( :created_at => :desc )
  end

  def index_thumb
    authorize! :index, Gallery
    @galleries = Gallery.unscoped.where( :is_trash => false ).order_by( :created_at => :desc ).page( params[:galleries_page] ).per( 10 )
  end

  def index_mini
    authorize! :index, Gallery
    @galleries = Gallery.all
  end

  def new
    authorize! :new, Gallery
    @gallery = Gallery.new
    @cities_list = City.list
    @tags_list = Tag.list
  end

  def create
    authorize! :create, Gallery
    @gallery = Gallery.new(params[:gallery].permit(:name, :city, :tag, :is_public, :is_done, :is_feature))
    @gallery.user = current_user
    @gallery.site = @site
    authorize! :create, @gallery

    if @gallery.save
      # expire_page :controller => 'galleries', :action => 'index', :domainname => @site.domain
      # expire_page :controller => 'sites', :action => 'show', :domainname => @site.domain
      flash[:notice] = 'Success'
      redirect_to manager_galleries_path
    else
      flash[:error] = 'No Luck. ' + @gallery.errors.inspect
      @cities_list = City.list
      @tags_list = Tag.list
      render :action => 'new'
    end
  end

  def edit
    @gallery = Gallery.unscoped.find params[:id]
    authorize! :edit, @gallery
  end

  def update
    @gallery = Gallery.unscoped.find params[:id]
    authorize! :update, @gallery
    
    if @gallery.update_attributes( params[:gallery].permit( :username, :name, :galleryname, :subhead, :descr, :lang,
                                                            :is_trash, :is_public, :is_done, :is_feature,
                                                            :tag_id, :city_id, :venue_id, :site_id, :user_id, :site_id ) )
      flash[:notice] = 'Success.'
      redirect_to manager_galleries_path
    else
      flash[:error] = 'No Luck. ' + @gallery.errors
      render :action => :edit
    end
  end                           

  def show
    @gallery = Gallery.unscoped.find params[:id]
    authorize! :show, @gallery
    @photos = @gallery.photos.unscoped.where({ :is_trash => false })
  end

  def destroy
    @gallery = Gallery.unscoped.find params[:id]
    authorize! :destroy, @gallery
    
    @gallery.is_trash = true
    @gallery.save
    flash[:notice] = 'Logically deleted gallery.'
    redirect_to manager_galleries_title_path
  end

end

