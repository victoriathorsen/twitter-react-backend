if Rails.env === 'production' 
    Rails.application.config.session_store :cookie_store, key: '_twitter-clone', domain: 'twitter-clone-json-api'
else
    Rails.application.config.session_store :cookie_store, key: '_twitter-clone'
end