class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @items = Item.new
  end

  def edit
  end

  def create
    @items = Item.new(item_params)

    respond_to do |format|
      if @items.save
        format.html { redirect_to @items, notice: 'item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @items }
      else
        format.html { render action: 'new' }
        format.json { render json: @items.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @items.update(item_params)
        format.html { redirect_to @items, notice: 'item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @items.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @items.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @items = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :author, :isbn, :is_available)
    end
end