
class FileController < ApplicationController
  def upload
    gtm = GoogleTrendsManager.new(file_params[:file])
    trends = gtm.get_trends.map{|key, val| [Time.parse(key), val.to_i]}
    
    latest_trend_score = trends.max[1]
    binding.pry
    if latest_trend_score > 25
      User.all.each_with_index do |user, i|
        next if user.line_user_id.blank?
        text = "<インフルエンザ>\n東京都でインフルエンザが流っています。"
        response = send_message_text(text, user.line_user_id)
        puts "Sent message. to:#{user.displayName} line_user_id:#{user.line_user_id} response:#{response}"
      end
    end

    redirect_to root_url
  end

  private

  def file_params
    params.permit(:file)
  end

  def send_message_text(text, to)
    @line_bot_client ||= LineBotClient.new
    @line_bot_client.pushMessage('text', text, to)
  end
end