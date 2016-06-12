class KfConfig < RailsSettings::CachedSettings
  validates :var, uniqueness: true
end
