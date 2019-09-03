# frozen_string_literal: true

class CreateTeamsFromCsvJob < ApplicationJob
  queue_as :default

  require 'csv'

  def perform(*_args)
    filename = File.dirname(File.dirname(File.expand_path(__FILE__))) + '/csvthing.csv'
    @teams_array = []
    @managers_array = []
    @created = 0
    @existing = 0
    CSV.foreach(filename) do |row|
      @teams_array << row[2]
    end
    CSV.foreach(filename) do |row|
      @managers_array << row[11]
    end
    @teams_array.zip(@managers_array).each do |team_name, manager_name|
      @team = Team.create(name: team_name, manager_attributes: { first_name: manager_name })
      if @team.save
        @created += 1
    else
      @existing += 1
    end

    end
    puts('==================JOB DONE============================')
    puts("         Created #{@created} teams ")
    puts("         Existing #{@existing} teams")
    puts('==================JOB DONE============================')
    TeamMailer.send_report(@created, @existing).deliver_now
    end
  end
