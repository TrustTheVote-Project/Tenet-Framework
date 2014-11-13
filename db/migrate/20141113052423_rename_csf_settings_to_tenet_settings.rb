class RenameCsfSettingsToTenetSettings < ActiveRecord::Migration
  def change
    rename_table :csf_settings, :tenet_settings
  end
end
