class CompaniesController < ApplicationController
  before_action :authenticate_user

  def new

  end

  def search_form
    @prefectures = Prefecture.all
    @industries = Industry.all
    @sectors = Sector.all
    @results
    @count
    @company_name

  end

  def search
    @company_name = params[:company_name]
    @prefectures = Prefecture.all
    @industries = Industry.all
    @sectors = Sector.all
    prefectures = params[:prefectures]

    if @company_name.present?
      @companies = DemoCompany.where('name like ?', "%#{@company_name.tr("a-zA-Z", "ａ-ｚＡ-Ｚ")}%")
      @companies = @companies.where(prefecture_name: prefectures) if params[:prefectures].present?
      @companies = @companies.where("prtimes_flag > 0") if params[:prtimes]
      @companies = @companies.where("mynavi_flag > 0") if params[:mynavi]
    end
    @results = @companies

    @count = @results.count
    @results
    render("companies/search_form")

  end


end
