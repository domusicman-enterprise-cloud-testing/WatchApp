class Api::V1::WatchesController < ApplicationController
  before_action :set_watch, only: [:show]

  def index
    @watches = Watch.all
    @watches = @watches.search(params[:search]) if params[:search].present?
    @watches = @watches.by_brand(params[:brand]) if params[:brand].present?
    @watches = @watches.by_year(params[:year]) if params[:year].present?
    @watches = @watches.by_movement_type(params[:movement_type]) if params[:movement_type].present?
    
    @watches = @watches.page(params[:page]).per(params[:per_page] || 20)
    
    render json: {
      watches: @watches.map { |watch| watch_json(watch) },
      meta: {
        current_page: @watches.current_page,
        total_pages: @watches.total_pages,
        total_count: @watches.total_count,
        per_page: @watches.limit_value
      }
    }
  end

  def show
    render json: { watch: watch_json(@watch) }
  end

  private

  def set_watch
    @watch = Watch.find(params[:id])
  end

  def watch_json(watch)
    {
      id: watch.id,
      brand: watch.brand,
      model: watch.model,
      full_name: watch.full_name,
      year: watch.year,
      case_diameter: watch.case_diameter,
      case_thickness: watch.case_thickness,
      lug_width: watch.lug_width,
      reference_number: watch.reference_number,
      caliber: watch.caliber,
      movement_type: watch.movement_type,
      features: watch.features,
      complications: watch.complications,
      description: watch.description,
      created_at: watch.created_at,
      updated_at: watch.updated_at
    }
  end
end
