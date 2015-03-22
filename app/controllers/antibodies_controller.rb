class AntibodiesController < ApplicationController
  respond_to :html

  load_and_authorize_resource

  def index
    respond_with(@antibodies)
  end

  def show
    respond_with(@antibody)
  end

  def new
    @antibody = Antibody.new
    respond_with(@antibody)
  end

  def edit
  end

  def create
    @antibody = Antibody.new(antibody_params)
    @antibody.save
    respond_with(@antibody)
  end

  def update
    @antibody.update(antibody_params)
    respond_with(@antibody)
  end

  def destroy
    @antibody.destroy
    respond_with(@antibody)
  end

  private
  def antibody_params
    params.require(:antibody).permit(:name)
  end
end
