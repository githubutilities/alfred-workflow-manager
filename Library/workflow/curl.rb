require 'open-uri'

module Workflow
  class Curl
    def self.download(workflow_download_link, workflow_file)
        # create a temp file
        src = open(workflow_download_link)
        puts workflow_download_link
        type = src.content_type

        if !File.exists?("#{CACHES_DIRECTORY}")
            puts `mkdir #{CACHES_DIRECTORY}`
        end

        if type == "application/zip"
            filepath = '#{CACHES_DIRECTORY}/tmp.zip'
        else
            filepath = "#{CACHES_DIRECTORY}/#{workflow_file}"
        end

        open(filepath, 'wb') do |file|
            file << src.read
        end

        src.close()
        src.unlink()

        filename = File.basename(filepath, File.extname(filepath))
        if type == 'application/zip'
            # extract zip file
            puts `cd #{CACHES_DIRECTORY} && unzip tmp.zip && rm tmp.zip`
        end
        puts `cd #{CACHES_DIRECTORY} && unzip #{workflow_file} -d #{WORKFLOW_PATH}/#{filename}`
    end
  end
end
