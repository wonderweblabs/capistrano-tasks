# encoding: UTF-8

# DESCRIPTION
# Several task to bootstrap the inital server setup for a rails application
# e.g.
#  - create the config files on the server
#  - fill the secrets.yml with random keys

namespace :bootstrap do
  desc 'Takes linked_files config, try to find the .example.yml and create the file at shared_path on server'
  task :configs do
    files = fetch(:linked_files)

    files.each do |file_path|
      upload_example_or_create_file(file_path)
    end
  end

  # search for example file and upload or touch the file on the server
  def upload_example_or_create_file(name)
    on roles(:app) do
      server_path = File.join(shared_path, name)
      local_path = local_example_path(name)

      if local_path.nil?
        execute "touch #{server_path}"
      else
        upload!(local_path, server_path)
      end
    end
  end

  # returns example file path if available or nil
  def local_example_path(name)
    example = "#{name[0..-5]}.example.yml"

    File.file?(example) ? example : nil
  end
end
