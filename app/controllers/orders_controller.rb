class OrdersController < ApplicationController
  before_action :set_order, only: [ :edit, :update, :destroy]
  #before_action :delete_records ,only: [:index]

  def index
    @orders = Order.where('user_id = (?)',current_user.try(:id))
    @involvedOrders = OrderUser.where('user_id = (?)',current_user.try(:id))
  end

  def show
    @order = Order.find(params[:id])
    @order_users = @order.order_users
  end

  def new
    @order = Order.new
  end


  def edit
  end

  def create
    @order = current_user.orders.build(order_params)
    @orderUser = @order.order_users.build(:user_id => current_user.try(:id) , :status => 1)
    respond_to do |format|
      if @order.save && @orderUser.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish
    @order = Order.find(params[:id])
    @order.update(status: 1)
    redirect_to orders_path
  end

  

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def delete_records
      @order=OrderUser.select("id").where('order_id NOT IN (?)',Order.select("id").all).destroy_all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:restaurant, :user, :status)
    end
end
