module Workflow
  class Remote
    @@workflows = JSON.parse(IO.read("#{FILE_CACHE}"))

    def self.index(query = nil)
      return @@workflows
    end

    def self.get(id)
      @@workflows.each do |workflow|
        if workflow["workflow_download_link"] == id
          return workflow
        end
      end
    end

    def self.search(query)
      ret = Array.new
      @@workflows.each do |workflow|
        haystack = workflow["workflow_name"]
        if !haystack.downcase.include?(query.downcase)
        else
          ret.push workflow
        end
      end
      return ret
    end
  end
end
