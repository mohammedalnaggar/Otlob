class FriendshipsController < ApplicationController

    def index
        @users = User.where('id NOT IN (?) AND id != (?)',Friendship.select("friend_id").where(user_id: current_user.try(:id)),current_user.try(:id)) 
    end

    def create
        @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
        if @friendship.save
            redirect_to friendship_path(current_user.try(:id))
        else
          flash[:notice] = "Unable to add friend."
        #   redirect_to root_url
        end
    end

    def show
        @user = User.find(params[:id])
    end
  
    
  def destroy
      @friendship = current_user.friendships.find(params[:id])
      @groups = current_user.groups
      for group in @groups
        if group.users.include? @friendship.friend
            @x= group.users.select('id').find(@friendship.friend.id)
            group.group_members.where('user_id = (?)',@x).destroy_all
        end
      end
      @friendship.destroy
      flash[:notice] = "Removed friendship."
      redirect_to friendship_path(current_user.try(:id))
  end
  
  

end
