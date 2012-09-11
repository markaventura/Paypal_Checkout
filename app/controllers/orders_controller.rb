class OrdersController < ApplicationController

  def express
    response = EXPRESS_GATEWAY.setup_purchase(100,
      :ip                 => request.remote_ip,
      :return_url         => new_order_url,
      :cancel_return_url  => products_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def index
    response = EXPRESS_GATEWAY.setup_purchase(100,
     :ip                 => request.remote_ip,
     :return_url         => new_order_url,
     :cancel_return_url  => new_order_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
    @order = Order.all
  end
  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new(:express_token => params[:token])
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /ordersw
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.ip_address = request.remote_ip
      if @order.save
        if @order.purchase
          render :action => "success"
        else
          puts "*********************"
          puts @order.response
          puts "*********************"
          render :action => "failure"
        end
      else
        render :action => 'new'
      end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
