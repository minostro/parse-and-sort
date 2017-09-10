require_relative 'lib/actions'
require_relative 'lib/presenter'

module CommandLineApp
  def self.main(filepath, delimiter)
    people = Actions.build_people_from_file(filepath, delimiter)
    output1(people, delimiter)
    output2(people, delimiter)
    output3(people, delimiter)
  end

  private
  def self.output1(people, delimiter)
    data = Presenter.people_to_string(
      Actions.sort_by_gender(people),
      delimiter
    )
    print "Output 1:\n"
    print "=" * 50 + "\n"
    print data + "\n"
    print "=" * 50 + "\n"
  end

  def self.output2(people, delimiter)
    data = Presenter.people_to_string(
      Actions.sort_by_birth_date(people),
      delimiter
    )
    print "Output 2:\n"
    print "=" * 50 + "\n"
    print data + "\n"
    print "=" * 50 + "\n"
  end

  def self.output3(people, delimiter)
    data = Presenter.people_to_string(
      Actions.sort_by_last_name(people),
      delimiter
    )
    print "Output 3:\n"
    print "=" * 50 + "\n"
    print data + "\n"
    print "=" * 50 + "\n"
  end
end
