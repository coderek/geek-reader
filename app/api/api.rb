module Reader

  class API < Grape::API
    version 'v1', using: :header, vendor: :coderek
    format :json

    get do
      "hello world"
    end
  end
end
