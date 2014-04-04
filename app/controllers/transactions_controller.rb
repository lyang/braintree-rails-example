class TransactionsController < ApplicationController
  before_filter :find_transactions
  before_filter :find_transaction, except: [:new, :create]
  before_filter :restricted_update, only: :update
  helper_method :transaction_path, :transactions_path

  def index; end

  def show; end

  def new
    @transaction = @transactions.build(amount: rand(1..25))
  end

  def create
    @transaction = @transactions.build(params[:transaction].merge(params.slice(:device_data)))
    if @transaction.save
      flash[:notice] = "Transaction has been successfully created."
      redirect_to transaction_path(@transaction)
    else
      flash[:alert] = @transaction.errors.full_messages.join(".\n")
      render :new
    end
  end

  def update
    if @transaction.send(params[:operation])
      flash[:notice] = "Transaction has been #{params[:operation]}."
    else
      flash[:alert] = @transaction.errors.full_messages.join(".\n")
    end
    redirect_to transactions_path
  end

  protected

  def find_transactions
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @customer = @user.customer if @user
      @credit_card = @customer.credit_cards.find(params[:credit_card_id]) if params[:credit_card_id].present?
      @transactions = @credit_card.present? ? @credit_card.transactions : @customer.transactions
    else
      @transactions = BraintreeRails::Transactions.new(nil)
    end
  end

  def find_transaction
    @transaction = @transactions.find(params[:id])
  end

  def restricted_update
    return true if ['submit_for_settlement', 'void', 'refund'].include?(params[:operation])
    flash[:alert] =  "Unknow operation: #{params[:operation]}!"
    redirect_to transactions_path and return
  end

  def transactions_path
    path ||= user_customer_credit_card_transactions_path(@user, @credit_card) if @credit_card
    path ||= user_customer_transactions_path(@user) if @user
    path ||= super
  end


  def transaction_path(transaction, options={})
    path ||= user_customer_credit_card_transaction_path(@user, @credit_card, transaction, options) if @credit_card
    path ||= user_customer_transaction_path(@user, transaction, options) if @user
    path ||= super(transaction, options)
  end
end
