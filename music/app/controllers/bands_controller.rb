class BandsController < ApplicationController

    def index
        @all_bands  = Band.all
        render :index
    end

    def show
        @band = Band.find(params[:id])
        if @band
            render :show
        else
            render :index
        end
    end

    def new
        @band = Band.new
        render :new
    end

    def create
        @band = Band.new(band_params)

        if !Band.find_by(name: @band.name) && @band.save
            redirect_to band_url(@band)
        else
            redirect_to bands_url
        end
        
    end

    def edit
        @band = Band.new
        render :edit
    end


    def update
        @band = Band.find_by(name: band_params[:name])
        if @band
            
        end
        redirect_to bands_url

    end


    private
    def band_params
        params.require(:band).permit( :name)
    end
end