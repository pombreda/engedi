class ResourcesController < ApplicationController
  include ResourcesHelper

  def index
  end

  def sync
  end

  def run_sync
    file = params[:file]
    if ['.xls', '.xlsx'].include? File.extname(file.original_filename)
      synchronise file
      success_message 'Sync complete'
    else
      error_message 'Please upload an excel file'
    end
    redirect_to resources_path
  end

end
