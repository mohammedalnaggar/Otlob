class FriendshipsController < ApplicationController

    def index
        @users = User.all
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
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to friendship_path(current_user.try(:id))
  end
  
  

end
