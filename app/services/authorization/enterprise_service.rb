#-- encoding: UTF-8

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2020 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

class Authorization::EnterpriseService
  attr_accessor :type

  GUARDED_ACTIONS = %i(define_custom_style
                       multiselect_custom_fields
                       edit_attribute_groups
                       work_package_query_relation_columns
                       attribute_help_texts
                       two_factor_authentication
                       ldap_groups
                       custom_fields_in_projects_list
                       custom_actions
                       conditional_highlighting
                       readonly_work_packages
                       attachment_filters
                       board_view
                       grid_widget_wp_graph).freeze

  def initialize(type)
        self.type = type
  end

  # Return a true ServiceResult if the token contains this particular action.
  def call(action)
    allowed = process(action)

    result(allowed)
  end

  private

  def process(action)
    # Every non-expired token
    GUARDED_ACTIONS.include?(action)
  end

  def result(bool)
    ServiceResult.new(success: bool, result: bool)
  end
end
