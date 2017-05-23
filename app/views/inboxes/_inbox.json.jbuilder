json.extract! inbox, :id, :shortmessage, :sender, :reseiver, :read, :created_at, :updated_at
json.url inbox_url(inbox, format: :json)
