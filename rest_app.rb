require 'rack'
require 'json'

require_relative 'lib/person'
require_relative 'lib/actions'
require_relative 'lib/presenter'

GlobalState = {
  records: []
}

class RestApp
  def self.call(env)
    request = Rack::Request.new env
    route(request)
  end

  def self.route(request)
    case [request.request_method, request.path]
    when ["POST", "/records"]
      post_records(request)
    when ["GET", "/records/gender"]
      build_get_response(
        Actions.sort_by_gender(GlobalState[:records])
      )
    when ["GET", "/records/birthdate"]
      build_get_response(
        Actions.sort_by_birth_date(GlobalState[:records])
      )
    when ["GET", "/records/name"]
      build_get_response(
        Actions.sort_by_last_name(GlobalState[:records])
      )
    when ["GET", "/clean"]
      GlobalState[:records] = []
      [200, {}, []]
    else
      [404, {}, []]
    end
  end

  def self.post_records(request)
    payload = JSON.parse(request.body.read)
    person = Actions.build_person_from_string(
      payload["data"],
      payload["delimiter"]
    )
    GlobalState[:records] << person
    [
      201,
      {'Content-Type' => 'application/json'},
      [{records: GlobalState[:records].size}.to_json]
    ]
  end

  def self.build_get_response(people)
    data = Presenter.people_to_json(people)
    [200, {'Content-Type' => 'application/json'}, [data.to_s]]
  end
end
