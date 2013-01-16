#coding: utf-8
#文件管理器
class FileManagerController < ApplicationController
  include Galdomedia::TinymceFilemanager

  # accept only jpeg and gif for images
  image_accept_mime_types ['image/jpeg', 'image/gif', 'image/png']

  # limit image file size to 2MB
  image_file_size_limit 2.megabytes

  # accept only mpeg and flash files(swf) for media
  media_accept_mime_types ['video/mpeg', 'application/x-shockwave-flash']

  # limit media file size to 15MB
  media_file_size_limit 15.megabytes

  #thumbs created into '_small_' subdir
  thumbs_subdir 'small'

  #images save to RAILS_ROOT/public/manager/images thumbs in RAILS_ROOT/public/manager/images/_small_
  image_save_into_public_subdir 'system/images'

  #images save to RAILS_ROOT/public/manager/images thumbs in RAILS_ROOT/public/manager/images/_small_
  media_save_into_public_subdir 'system/media'

end
