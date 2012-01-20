if VIM::evaluate('g:vorax_store_passwords') == '1'
  # load only if store password option is on
  # sudo apt-get install libopenssl-ruby1.8
  require 'openssl'
  require 'base64'
end

module Vorax

  class PasswordRepository

    def initialize(repo_file, private_key_file, public_key_file, password)
      @repo_file = repo_file
      @private_key_file = private_key_file
      @password = password
      @private_key = OpenSSL::PKey::RSA.new(File.read(private_key_file), password) if private_key_file && private_key_file != ""
      @public_key_file = public_key_file
      @public_key = OpenSSL::PKey::RSA.new(File.read(public_key_file)) if public_key_file && public_key_file != ""
      @passwd_db = {}
      load_db()
    end

    def add_password(key, password)
      if password == ""
        @passwd_db[key] = ""
      else
        @passwd_db[key] = Base64.encode64(encrypt(password)).gsub(/\n/, "")
      end
      store()
    end

    def remove_profile(key)
      @passwd_db.delete(key)
      store()
    end

    def exists?(profile)
      @passwd_db.has_key?(profile)
    end

    def skip?(profile)
      @passwd_db.has_key?(profile) && @passwd_db[profile] == ""
    end

    def get_password(key)
      pwd = ""
      enc_passwd = @passwd_db[key]
      if enc_passwd && enc_passwd != ""
        enc_passwd = Base64.decode64(enc_passwd)
        pwd = decrypt(enc_passwd)
      end
      pwd
    end

    def self.generate_keys(private_key_file, public_key_file, password)
      rsa_key = OpenSSL::PKey::RSA.new(2048)
      cipher =  OpenSSL::Cipher::Cipher.new('des3')
      private_key = rsa_key.to_pem(cipher, password)
      public_key = rsa_key.public_key.to_pem
      prv_file = File.new(private_key_file, 'w')
      prv_file.puts(private_key)
      prv_file.close
      pub_file = File.new(public_key_file, 'w')
      pub_file.puts(public_key)
      pub_file.close
    end

    private

    def load_db
      if File.readable?(@repo_file)
        File.open(@repo_file) do |f|
          while line = f.gets
            # the negative second arg is because we want empty fields as well
            parts = line.chomp.split(/""/, -1)
            if parts.length == 2
              @passwd_db[parts[0]] = parts[1]
            end
          end
        end
      elsif !File.exists?(@repo_file)
        # create the file
        File.open(@repo_file, 'w')
      end
    end

    def store
      if File.writable?(@repo_file)
        File.open(@repo_file, 'w+') do |f|
          @passwd_db.each_key do |k|
            f.puts k + "\"\"" + @passwd_db[k]
          end
        end
      end
    end

    def encrypt(text)
      @public_key.public_encrypt(text)
    end

    def decrypt(text)
      @private_key.private_decrypt(text)
    end

  end

end

