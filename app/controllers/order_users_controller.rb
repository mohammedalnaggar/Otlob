class OrderUsersController < ApplicationController
  before_action :set_order_user, only: [:edit, :update, :destroy]

  
  def index
    @order_users =OrderUser.where('order_id = (?)',params[:order_id])
  end

  
  # can be set to return user profile
  def show
    @order_users =OrderUser.where('order_id = (?) and user_id = (?)',params[:order_id],params[:id])
  end

  def new
    @users = User.where('id IN (?) AND id NOT IN (?)',Friendship.select("friend_id").where(user_id: current_user.try(:id)),OrderUser.select("user_id").where('order_id = (?)',params[:order_id]))
  end

  # GET /order_users/1/edit
  def edit
  end


  def create
    @order = Order.find( params[:order_id])
    @orderUser = @order.order_users.build(:user_id => params[:user_id])
    if @orderUser.save
        redirect_to order_order_users_path
    else
        flash[:notice] = "Unable to add user."
        #   redirect_to root_url
    end
  end

  # PATCH/PUT /order_users/1
  # PATCH/PUT /order_users/1.json
  def update
    respond_to do |format|
      if @order_user.update(order_user_params)
        format.html { redirect_to @order_user, notice: 'Order user was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_user }
      else
        format.html { render :edit }
        format.json { render json: @order_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_user.destroy
    respond_to do |format|
      format.html { redirect_to order_order_users_path, notice: 'Order user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_user
      @order_user = OrderUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_user_params
      params.require(:order_user).permit(:order_id, :user_id, :status)
    end
end
