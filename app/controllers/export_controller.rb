# encoding: UTF-8
class ExportController < ApplicationController
  before_filter :set_account, :authenticate

  def show
    @season = Season.find(params[:id])
    book = Spreadsheet::Workbook.new
    #book.add_format Spreadsheet::Format.new(:number_format => 'YYYY-MM-DD hh:mm:ss')
    headline = Spreadsheet::Format.new :color => :blue,
                                       :weight => :bold,
                                       :size => 18
    bold = Spreadsheet::Format.new :weight => :bold

    sheet1 = book.create_worksheet :name => "Info #{@season.name}"
    sheet1.row(0).default_format = headline
    sheet1.column(0).default_format = bold
    sheet1.row(0).insert 0, "Info #{@season.name}"
    sheet1.row(2).concat ['Kund',@season.organization.name]
    sheet1.row(3).concat ['Period',@season.name]
    sheet1.row(4).concat ['Deadline',@season.deadline]
    sheet1.row(6).concat ['Utdrag per den',Time.now]
    sheet1.column(0).width = 13
    sheet1.column(1).width = 18

    @season.groups.each do |g|
      sheet = book.create_worksheet :name => g.name
      sheet.row(0).default_format = bold
      sheet.column(1).width = 17
      sheet.column(2).width = 17
      sheet.column(5).width = 14
      sheet.column(6).width = 11
      sheet.column(8).width = 13
      sheet.column(9).width = 11
      sheet.column(11).width = 14
      sheet.column(12).width = 20
      sheet.column(13).width = 15
      sheet.row(0).concat ["id", "Skapad", "Uppdaterad", "Namn", "E-post", "Adress", "Postnummer", "Postort", "Personnummer", "Mobiltelefon", "Allergier", "Förälders namn", "Förälders e-post", "Förälders telefon", "Extra info"]
      row = 1
      g.registrations.each do |r|
        sheet.row(row).concat r.row_array
        row = row + 1
      end
    end
    book.write Rails.root.join('tmp',"#{@season}.xls")
    send_file Rails.root.join('tmp',"#{@season}.xls"), :type=>"application/vnd.ms-excel"
  end



  protected
    def set_account
      @organization = Organization.find_by_subdomain(request.subdomains.first)
    end

    def authenticate
        if user = authenticate_with_http_basic { |u, p| @organization.authenticate(u, p) }
          @current_user = user
        else
          request_http_basic_authentication
        end
    end
end
