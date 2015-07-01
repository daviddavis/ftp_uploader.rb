require 'net/ftp'
require 'logger'
require 'yaml'

settings = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yml'))
host = settings[:ftp][:host]
user = settings[:ftp][:username]
password = settings[:ftp][:password]
remote_path = settings[:ftp][:path]
log = Logger.new(STDOUT)

files = Dir[settings[:local_files]]

if files.empty?
  log.info("No files found.")
  exit
end

files.each do |filename|
  log.info("Found #{filename}")
  file = File.open("#{filename}", "rb")

  Net::FTP.open(host, user, password) do |ftp|
    path = File.join(remote_path, File.basename(filename))
    ftp.putbinaryfile(file, path)
    log.info("Uploaded #{filename}")
  end

  File.delete(filename)
  log.info("Removed #{filename}")
end