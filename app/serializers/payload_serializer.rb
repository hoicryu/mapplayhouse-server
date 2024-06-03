class PayloadSerializer < Panko::Serializer
  include ImagableSerializer
  attributes :id, :name, :groups_i_applied, :groups_i_belong_to 

  def groups_i_applied
    groups = object.application_forms.map {|form| form.group.id}
    groups
  end

  def groups_i_belong_to
    groups = object.groups.map {|group| group.id}
    groups
  end
end
