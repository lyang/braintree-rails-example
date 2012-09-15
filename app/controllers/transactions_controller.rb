class TransactionsController < ApplicationController
  before_filter :find_user, :find_customer, :find_credit_card
  before_filter :find_transaction, :except => [:new, :create]
  before_filter :restricted_update, :only => :update
  
  def index
    @transactions = (@credit_card || @customer).transactions    
  end

  def new
    @transaction = @customer.transactions.build(:amount => "10.00")
  end

  def create
    @transaction = @customer.transactions.build(params[:transaction])
    if @transaction.save
      flash[:notice] = "Transaction has been successfully created."
      redirect_to user_customer_transaction_path(@user, @transaction.id)
    else
      flash.now[:alert] = @transaction.errors[:base].join("\n")
      render :new
    end
  end

  def update
    if @transaction.send(params[:operation])
      flash[:notice] = "Transaction has been #{params[:operation]}."
    else
      puts @transaction.errors.full_messages.join("\n")
      flash[:alert] = @transaction.errors[:base].join("\n")
    end    
    redirect_to user_customer_transactions_path(@user)
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer
    @customer = BraintreeRails::Customer.find(@user.customer_id) if @user.customer_id.present?
    redirect_to user_path(@user) and return if @customer.nil?
  end
  
  def find_credit_card
    @credit_card = @customer.credit_cards.find(params[:credit_card_id]) if params[:credit_card_id].present?
  end
  
  def find_transaction
    @transaction = @customer.transactions.find(params[:id])
  end

  def restricted_update
    return true if ['submit_for_settlement', 'void', 'refund'].include?(params[:operation])
    flash[:alert] =  "Unknow operation: #{params[:operation]}!"
    redirect_to user_customer_transaction_path(@user, @transaction.id) and return
  end
end