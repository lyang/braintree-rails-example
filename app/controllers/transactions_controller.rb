class TransactionsController < ApplicationController
  before_filter :find_transactions
  before_filter :find_transaction, :except => [:index, :new, :create, :tr_create]
  before_filter :restricted_update, :only => :update
  before_filter :parse_tr_data, :only => :tr_create
  helper_method :transaction_path, :transactions_path

  def new
    @transaction = @transactions.build(:amount => rand(1..25))
  end

  def create
    @transaction = @transactions.build(params[:transaction])
    if @transaction.save
      flash[:notice] = "Transaction has been successfully created."
      redirect_to transaction_path(@transaction)
    else
      flash.now[:alert] = @transaction.errors.full_messages.join("\n")
      render :new
    end
  end

  def update
    if @transaction.send(params[:operation])
      flash[:notice] = "Transaction has been #{params[:operation]}."
    else
      flash[:alert] = @transaction.errors.full_messages.join("\n")
    end
    redirect_to transactions_path
  end

  def tr_create
    if @transaction.persisted?
      flash[:notice] = "Transaction has been successfully created."
      redirect_to transaction_path(@transaction) and return
    else
      render :new
    end
  end

  protected

  def find_transactions
    @user = User.find(params[:user_id]) if params[:user_id].present?
    @customer = BraintreeRails::Customer.find(@user.customer_id) if @user && @user.customer_id.present?
    @credit_card = @customer.credit_cards.find(params[:credit_card_id]) if params[:credit_card_id].present?
    @transactions = BraintreeRails::Transactions.new(@customer, @credit_card)
  end

  def find_transaction
    @transaction = @transactions.find(params[:id])
  end

  def restricted_update
    return true if ['submit_for_settlement', 'void', 'refund'].include?(params[:operation])
    flash[:alert] =  "Unknow operation: #{params[:operation]}!"
    redirect_to transactions_path and return
  end

  def parse_tr_data
    result = Braintree::TransparentRedirect.confirm(request.query_string)
    if result.success?
      @transaction = BraintreeRails::Transaction.new(result.transaction)
    else
      @transaction = BraintreeRails::Transaction.new(result.params[:transaction])
      @transaction.add_errors(result.errors)
    end
  end

  def transactions_path
    path ||= user_customer_credit_card_transactions_path(@user, @credit_card.id) if @credit_card
    path ||= user_customer_transactions_path(@user) if @user
    path ||= super
  end


  def transaction_path(transaction, options={})
    path ||= user_customer_credit_card_transaction_path(@user, @credit_card.id, transaction.id, options) if @credit_card
    path ||= user_customer_transaction_path(@user, transaction.id, options) if @user
    path ||= super(transaction.id, options)
  end
end
