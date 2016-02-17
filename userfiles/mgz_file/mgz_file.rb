
#
# CBRAIN Project
#
# Copyright (C) 2008-2012
# The Royal Institution for the Advancement of Learning
# McGill University
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Model for MGZ structural files.
class MgzFile < SingleFile

  Revision_info=CbrainFileRevision[__FILE__] #:nodoc:

  # We are using the MincFile's volume viewer code almost
  # exactly as-is. The only difference will be in a tiny
  # snippet of javascript code that we provide in
  # our model's "views" subdirectory, "_volume_viewer_loader.html.erb"
  # which will be substituted inside Minc's volume viewer javascript code.
  has_viewer MincFile.find_viewer(:volume_viewer)

  has_content :method => :stream_unzip_content, :type => :text


  def self.file_name_pattern #:nodoc:
    /\.mgz$/i
  end

  def self.pretty_type #:nodoc:
      "MGZ Structural File"
  end

  def stream_unzip_content
    if self.name =~ /\.mgz$/i
      IO.popen("gunzip -c #{self.cache_full_path}") { |fh| fh.readlines.join }
    else
      File.open(self.cache_full_path, "r").read
    end
  end

end
