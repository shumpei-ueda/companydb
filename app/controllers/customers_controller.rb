class CustomersController < ApplicationController
  def new
    @customer = Customer.new
    @admin_pass
    @error_message
  end


  def create
    @customer = Customer.new(
        name: params[:customer_name],
    )
    @admin_pass = params[:admin_pass]
    if @customer.name.present? && @admin_pass = "1234"
      @customer.save
      flash[:notice] = "登録が完了しました"
      redirect_to("/signup")
    end

  end
end
