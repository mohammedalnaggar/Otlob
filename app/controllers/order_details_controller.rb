class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :edit, :update, :destroy]

  def index
    @order_users = OrderUser.select('id').where('order_id = (?) ',params[:order_id])
    @order_details = OrderDetail.where('order_user_id IN (?) ',@order_users)
  end

  def show
  end

  def new
    @order_info = OrderDetail.where('order_user_id = (?) ',params[:order_user_id]).count
    if @order_info == 0
       @order_detail = OrderDetail.new
    else
      @order_detail = OrderDetail.where('order_user_id = (?) ',params[:order_user_id])
      redirect_to edit_order_order_user_order_detail_path(params[:order_id],params[:order_user_id],@order_detail.ids)
    end
  end


  def edit
  end


  def create
    @orderUser= OrderUser.find( params[:order_user_id])
    @order_detail = @orderUser.order_details.build(order_detail_params)

    respond_to do |format|
      if @order_detail.save
        format.html { redirect_to order_order_user_order_details_path, notice: 'Order detail was successfully created.' }
        format.json { render :show, status: :created, location: @order_detail }
      else
        format.html { render :new }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @order_detail.update(order_detail_params)
        format.html { redirect_to order_order_user_order_detail_path, notice: 'Order detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_detail }
      else
        format.html { render :edit }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @order_detail.destroy
    respond_to do |format|
      format.html { redirect_to order_order_user_order_details_path, notice: 'Order detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order_detail = OrderDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_detail_params
      params.require(:order_detail).permit(:item , :amount , :price , :comment )
    end
end
