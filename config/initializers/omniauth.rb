OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '631129164038-v1hjdlebka5u7be4q2jpebdublrjkl5r.apps.googleusercontent.com', 'QQPOwpL3PbiboAr01kyj4J2e', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

provider :facebook, '591426697874912', 'da507c284b8ecbce65857c1427373294', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
