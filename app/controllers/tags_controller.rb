class TagsController < ApplicationController
    # create
    ### though will this be handled in the recipe interaction instead?

    def index
        tags = Tag.all 
        render json: tags, except: [:created_at, :updated_at]
    end

    def show
        tag = Tag.find(params[:id])
        render json: tag, except: [:created_at, :updated_at]
    end
    ### wait on this one
end
