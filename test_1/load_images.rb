require 'nokogiri'
require 'open-uri'
require 'fileutils'
require 'domainatrix'
require 'pry-byebug'

class BlankURI < StandardError
end

class InvalidURI < StandardError
end

class LoadImages
  def self.from(url, dir: 'images', debug: true)
    LoadImages.new(url, dir, debug).work
  end

  def initialize(url, dir, debug)
    @url = url
    @dir = dir
    @images = []
    @debug = debug
  end

  def work
    valid_url?(@url, raise_error: true)
    prepare_directory
    get_images
    save_images
  end

  private

  def get_images
    log_message "Start to get images from #{@url}"
    @images = Nokogiri::HTML(open(@url)).xpath("//img/@src").map(&:to_s).uniq
    log_message "End to get images from #{@url}. Images count: #{@images.count}"
  end

  def save_images
    log_message "Start to save images"
    images_count = @images.count

    @images.each_with_index do |image_url, index|
      image_url = prepare_image_url(image_url)
      log_message "[#{index+1}/#{images_count}] Load image from url: #{image_url}"

      if valid_url?(image_url)
        File.open(file_name(image_url), 'wb'){ |f| f.write(open(image_url).read) }
      end
    end
    log_message "End to get images"
  end

  def valid_url?(url, raise_error: false)
    if !@url || @url.empty?
      log_message "URL is blank: #{@url}"
      raise BlankURI if raise_error
      return false
    end

    unless @url =~ /^#{URI::regexp(%w(http https))}$/
      log_message "URL is not valid: #{@url}"
      raise InvalidURI if raise_error
      return false
    end

    true
  end

  def prepare_directory
    correct_directory
    FileUtils.mkdir_p(@dir) unless File.directory?(@dir)
  end

  def prepare_image_url(url)
    base_url = Domainatrix.parse(@url)
    image_url = Domainatrix.parse(url)

    if url.match?(%r{^\/\/})
      url = "#{base_url.scheme}:#{url}"
    elsif url.match?(%r{^\/})
      url = "#{base_url.scheme}://#{base_url.host}#{url}"
    end

    url
  end

  def correct_directory
    @dir = 'images' if !@dir || @dir.empty?
  end

  def log_message(message)
    puts "\t[#{Time.now}] #{message}" if @debug
  end

  def file_name(file)
    [@dir, File.basename(file)].join('/')
  end
end

# LoadImages.from('https://www.shutterstock.com/', dir: 'shutterstock')
# LoadImages.from('https://pixabay.com/', dir: 'pixabay')
# LoadImages.from('https://www.pexels.com/', dir: 'pexels')
