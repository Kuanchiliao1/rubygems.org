class GemDownloadResource < Avo::BaseResource
  self.title = :inspect
  self.includes = %i[rubygem version]

  field :title, as: :text, link_to_resource: true do |model, _resource, _view|
    if model.version
      "#{model.version.full_name} (#{model.count.to_fs(:delimited)})"
    elsif model.rubygem
      "#{model.rubygem} (#{model.count.to_fs(:delimited)})"
    else
      "All Gems (#{model.count.to_fs(:delimited)})"
    end
  end

  field :rubygem, as: :belongs_to
  field :version, as: :belongs_to
  field :count, as: :number, sortable: true, index_text_align: :right, format_using: ->(value) { value.to_fs(:delimited) }

  field :id, as: :id, hide_on: :index
end
