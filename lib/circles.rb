# frozen_string_literal: true

# rubocop:disable Style/Documentation

module Circles
  def empty
    "\u25cb"
  end

  def red
    "\e[31m\u25cf\e[0m"
  end

  def yellow
    "\e[33m\u25cf\e[0m"
  end
end
