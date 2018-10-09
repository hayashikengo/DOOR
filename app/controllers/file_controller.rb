
class FileController < ApplicationController
  def upload
    gtm = GoogleTrendsManager.new(file_params[:file])
    trends = gtm.get_trends

    binding.pry
  
    trends
  end

  private

  def file_params
    params.permit(:file)
  end
end