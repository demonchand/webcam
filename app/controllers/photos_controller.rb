class PhotosController < ApplicationController
  def create
    @photo = Photo.new(params[:photo])
    @photo.image = File.new(upload_path)
    @photo.save

    redirect_to @photo
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.all
  end

  def upload
    File.open(upload_path, 'w') do |f|
      #      f.write request.raw_post
      f.write request.raw_post.force_encoding("UTF-8")
    end
    render :text => "ok"
  end

  private

  def upload_path # is used in upload and create
    file_name = session[:session_id].to_s + '.jpg'
    #    File.join(RAILS_ROOT, 'public', 'uploads', file_name)
    File.join(Rails.root.to_s, 'public', 'uploads', file_name)
  end
end
