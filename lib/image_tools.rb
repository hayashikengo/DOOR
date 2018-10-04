class ImageTools
  attr_accessor :contents
  @@images_dir_path = "app/assets/images/".freeze
  @@content_images_dir_path = "#{@@images_dir_path}content/".freeze
  @@instant_images_dir_path = "#{@@images_dir_path}instant/".freeze

  def initialize()
    @contents = {}
    prepare_contents()
  end

  def composite_notification(notifications = {})
    return if notifications.blank?

    # type: suspicious_person_info, weather, influenza
    notifications.each do |type_sym, message|
      type = type_sym.to_s
      # TODO 引数のnotificationsの内容を背景に合成する
    end

    # 画像の合成
    # imageListFrom = Magick::ImageList.new("from.jpg")
    # imageListFrame = Magick::ImageList.new("frame.png")
    # imageList = imageListFrom.composite(imageListFrame, 0, 0, Magick::OverCompositeOp)
    # imageList.write("to.png")
  end

  private

  def prepare_contents()
    Dir.glob(@@content_images_dir_path + "*.png") do |png_file_path|
      import_png(png_file_path)
    end
  end

  def import_png(png_file_path)
    png_file_name = File.basename(URI.parse(png_file_path).path, ".png")

    unless @contents[png_file_name.to_sym]
      @contents[png_file_name.to_sym] = Magick::ImageList.new(png_file_path).first
    end
  end
end
