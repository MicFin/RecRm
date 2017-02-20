# app/models/user_version.rb
class UserVersion < PaperTrail::Version
  self.table_name = :user_versions
  # https://github.com/airblade/paper_trail#configuration
  self.sequence_name = :user_versions_id_seq
  attr_accessor :ip_address 
end