class Ability
  
  include CanCan::Ability
  def initialize(user)
    
    #
    # signed in user
    #
    unless user.blank?
      
      can [ :create, :new ], Gallery
      can [ :edit, :update, :destroy_photo, :show, :show_long ], Gallery do |g|
        g.user == user
      end

      can [ :new ], Message

      can [ :upload, :driver, :set_profile_photo, :new_profile_photo ], Photo
      can [ :move, :edit, :update, :show ], Photo do |photo|
        photo.user == user
      end
      can [ :show ], Photo do |photo|
        photo.viewer_ids.include? user.id || user == photo.user
      end
      can [ :destroy ], Photo do |photo|
        if photo.user == user
          if photo.gallery.blank?
            true
          elsif photo.gallery.is_anonymous
            false
          else
            true
          end
        else
          false
        end
      end

      can [ :new, :create, :search, :index, :my_index ], Report
      can [ :edit, :update, :show, :delete ], Report do |r|
        r.user == user
      end

      can [ :newsitems_new, :newsitems_create ], Site
      
      can [ :organizer, :photos, :new_profile, :create_profile, :edit_profile, :update_profile ], User
      can [ :edit, :update, :update_profile ], User do |uu|
        uu == user
      end

      can [ :new ], Venue

      can [ :new, :create ], Video

      #
      # manager    group_id 1
      # moderator  group_id 2
      #
      if user[:group_id] <= 2        
        can [ :manage ], CitiesUser
        can [ :manage ], City
        can [ :manage ], Country
        can [ :manage ], Day
        can [ :manage ], Event
        can [ :manage ], Feature
        can [ :manage ], Gallery
        can [ :manage ], Newsitem
        can [ :manage ], Nodeitem
        can [ :manage ], Photo
        can [ :manage ], Report
        can [ :manage ], Site
        can [ :manage ], Tag
        can [ :manage ], User
        can [ :manage ], UserProfile
        can [ :manage ], Venue
        can [ :manage ], Video
        can [ :manage ], Welcome
        can [ :manage ], Manager
        can [ :manage ], ManagerCity
        can [ :manage ], ManagerFeature
        can [ :manage ], ManagerGallery
        can [ :manage ], ManagerNewsitem
        can [ :manage ], ManagerPhoto
        can [ :manage ], ManagerReport
        can [ :manage ], ManagerSite
        can [ :manage ], ManagerTag
        can [ :manage ], ManagerUser
        can [ :manage ], ManagerVenue
      end

      #
      # if admin
      #
      can :manage, :all do
        user.group_id.to_s == "1"
      end

    end    
    user ||= User.new
    
    ###
    ### applies to all users
    ###
    
    can [ :error500, :search ], Manager

    can [ :create_missing ],  Site

    can [ :home ], Welcome
  end
end

