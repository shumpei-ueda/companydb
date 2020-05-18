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
    @sort

  end

  def search
    @company_name = params[:company_name]
    @all_prefectures = Prefecture.all
    @hokkaido_tohoku = @all_prefectures.select{|p| p.id.between?(1, 7)}
    @kantou = @all_prefectures.select{|p|p.id.between?(8, 14)}
    @hokuriku_toukai = @all_prefectures.select{|p|p.id.between?(15, 23)}
    @kinki = @all_prefectures.select{|p|p.id.between?(24, 30)}
    @tyugoku = @all_prefectures.select{|p|p.id.between?(31,35 )}
    @shikoku = @all_prefectures.select{|p|p.id.between?(36, 39)}
    @kyushu = @all_prefectures.select{|p|p.id.between?(40, 47)}
    @all_industries = Industry.all
    @all_sectors = Sector.all
    @prefectures = params[:prefectures]&.map(&:to_i)
    @per = params[:per]
    # @order = params[:order]



    @companies = DemoCompany
    @companies = @companies.where('name like ?', "%#{@company_name.tr("a-zA-Z0-9&',.-", "ａ-ｚＡ-Ｚ０-９＆’，．－")}%") if @company_name.present?
    @companies = @companies.where(prefecture_id: @prefectures) if @prefectures.present?
    @companies = @companies.where("prtimes_flag > 0") if @use_prtimes = !!params[:prtimes]
    @companies = @companies.where("mynavi_flag > 0") if @use_mynavi = !!params[:mynavi]
    # @companies = @companies.order(@order => "DESC") if @order.present?

    @results = @companies == DemoCompany || !@companies ? [] : @companies.page(params[:page]).per(@per)
    @count = @companies.count
    render("companies/search_form")

  end


end
