module Workflow
  class List
    def self.generate_xml(workflows)
      xml = []
      xml << "<?xml version='1.0'?><items>"

      if workflows.empty?
        xml << """
          <item valid='no'>
            <title>No results</title>
          </item>"""
      else
        workflows.each do |workflow|
          xml << """
            <item uid='#{workflow["workflow_name"]}' arg='#{workflow["workflow_download_link"]}'>
              <title>#{workflow["workflow_name"]}</title>
              <subtitle>#{workflow["workflow_description_small"]}</subtitle>
              <icon>icon.png</icon>
            </item>"""
        end
      end

      xml << "</items>"
      xml.join
    end
  end
end
