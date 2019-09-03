# frozen_string_literal: true

class TeamMailer < ApplicationMailer
  def send_report(teams_created, existing_already)
    @created = teams_created
    @existing = existing_already
    mail(
      to: 'some_email_address@gmail.com',
      bcc: '',
      subject: 'Teams',
      message: teams_created

    )
  end
end
