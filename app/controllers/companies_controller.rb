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
    @all_prefectures = Prefecture.all
    @all_industries = Industry.all
    @all_sectors = Sector.all
    @prefectures = params[:prefectures]
    @per = params[:per]
    @order = params[:order]

    
    @companies = DemoCompany
    @companies = @companies.where('name like ?', "%#{@company_name.tr("a-zA-Z0-9&',.-", "ａ-ｚＡ-Ｚ０-９＆’，．－")}%") if @company_name.present?
    @companies = @companies.where(prefecture_id: @prefectures) if @prefectures.present?
    @companies = @companies.where("prtimes_flag > 0") if @use_prtimes = !!params[:prtimes]
    @companies = @companies.where("mynavi_flag > 0") if @use_mynavi = !!params[:mynavi]
    @companies = @companies.order(@order => "DESC") if @order.present?

    @results = @companies == DemoCompany || !@companies ? [] : @companies.page(params[:page]).per(@per)

    @count = @companies.count
    render("companies/search_form")

  end


end
