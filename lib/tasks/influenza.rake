namespace :influenza do
  desc "東京都の不審者情報取得"
  task :push_message_batch => :environment do
    # TODO インフルエンザ情報追加
    google_trends_manager = GoogleTrendsManager.new('インフルエンザ', 'JP-13')

    # TODO インフルエンザ情報push通知
  end
end