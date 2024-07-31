class PayloadSerializer < Panko::Serializer
  include ImagableSerializer
  attributes :id, :name, :phone, :groups_i_applied, :groups_i_belong_to, :num_of_participation_by_rating

  def groups_i_applied
    groups = object.application_forms.map {|form| form.group.id}
    groups
  end

  def groups_i_belong_to
    groups = object.groups.map {|group| group.id}
    groups
  end

  def num_of_participation_by_rating
    statuses = Rating.statuses.keys
    counts = statuses.each_with_object({}) { |status, hash| hash[status] = 0 }
    ratings = object.user_groups.map { |user_group| user_group.part.rating.status }
    ratings.each { |status| counts[status] += 1 }
    counts
  end
end
