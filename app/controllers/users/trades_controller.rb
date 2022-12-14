module Users
  class TradesController < ApplicationController
    before_action :set_trade, only: %i[ show edit update destroy ]

    # GET /trades or /trades.json
    def index
      #binding.pry
      @trades = current_user.trades
    end

    # GET /trades/1 or /trades/1.json
    def show
    end

    # GET /trades/new
    def new
      #@trade = current_user.trades.new
      @trade = current_user.trades.new
    end

    # GET /trades/1/edit
    def edit
    end

    # POST /trades or /trades.json
    def create
      if logged_in?
        @trade = current_user.trades.build(trade_params)
      else 
        redirect_to home_path
      end

      respond_to do |format|
        if @trade.save
          format.html { redirect_to user_trade_url(current_user, @trade), notice: "Trade was successfully created." }
          format.json { render :show, status: :created, location: @trade }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @trade.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /trades/1 or /trades/1.json
    def update
      respond_to do |format|
        if @trade.update(trade_params)
          format.html { redirect_to trade_url(@trade), notice: "Trade was successfully updated." }
          format.json { render :show, status: :ok, location: @trade }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @trade.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /trades/1 or /trades/1.json
    def destroy
      @trade.destroy

      respond_to do |format|
        format.html { redirect_to user_trades_url, notice: "Trade was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
    
      # Use callbacks to share common setup or constraints between actions.
      def set_trade
        @trade = current_user.trades.find(params[:id])
        #@trade = current_user.trades.find(params[:id]) # here on 
      end

      # Only allow a list of trusted parameters through.
      def trade_params
        params.require(:trade).permit(:tax, :ticker, :long_short, :volume, :price_in, :price_out)
      end
  end
end