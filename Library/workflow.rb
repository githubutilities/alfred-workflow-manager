require 'net/http'
require 'net/https'
require 'json'


HOST = "http://raw.githubusercontent.com"
WORKFLOW_PATH = "~/Library/Application\\ Support/Alfred\\ 2/Alfred.alfredpreferences/workflows"
FILE_CACHE = "workflow_api.json"
CACHES_DIRECTORY = "./Caches"

module Workflow
  require "./Library/workflow/list"
  require "./Library/workflow/remote"
  require "./Library/workflow/curl"

  def self.index
    workflows = Workflow::Remote.index()
    puts Workflow::List.generate_xml(workflows)
  end

  def self.search
    query = ARGV[1]
    if query && query != ""
      workflows = Workflow::Remote.search(query)
      puts Workflow::List.generate_xml(workflows)
    else
      self.index()
    end
  end

  def self.download
    id = ARGV[1]
    workflow = Workflow::Remote.get(id)
    workflow_download_link = workflow["workflow_download_link"]
    workflow_file = workflow["workflow_file"]
    Workflow::Curl.download(workflow_download_link, workflow_file)
  end
end

########################## Script goes here
case ARGV[0]
  when "index"
    if ARGV[1].nil?
      Workflow.index
    else
      Workflow.search
    end

  when "download"
    Workflow.download
end
