class CompaniesController < ApplicationController
  before_action :authenticate_user

  def new

  end

  def search_form
    @prefectures = Prefecture.all
    @industries = Industry.all
    @sectors = Sector.all


  end

  def search
    company_name = params[:company_name]
    prefectures = params[:prefectures]

    company_ids = []

    company_all_ids = Company.all.pluck(:id)

    company_ids_name = company_name.present? ? Company.where('name like ?', "%#{company_name}%").pluck(:id) : company_all_ids


    company_ids_prefectures = prefectures.present? ? CompanyAddress.where(prefecture_id: prefectures).pluck(:company_id) : company_all_ids

    dup = company_ids_name & company_ids_prefectures

    company_ids << dup

    company_ids.flatten!

    @company_ids_uniq = company_ids.uniq

    @results = []
    if @company_ids_uniq.present?
      @company_ids_uniq.each do |company_id|
        company = Company.find_by(id: company_id)
        company_name = company.name
        corporate_num = company.corporate_num
        established_date = company.established_date
        address = company.address.present? ? company.address.address : nil
        listing = company.listing.present? ? company.listing.listed : nil # TODO 上場かどうかにまで変換する
        president_name = company.president.present? ? company.president.president_name : nil
        phone_number = company.phone_number.present? ? company.phone_number.phone_number : nil
        web_url = company.web_url.present? ? company.web_url.url : nil
        contact_form = company.contact_form.present? ? company.contact_form.contact_form_url : nil
        fasebook_url = company.facebook.present? ? company.facebook.url : nil
        twitter_url = company.twitter.present? ? company.twitter.url : nil
        industry = company.industry.present? ? company.industry.industry_id : nil
        if industry.present?
          industry = Industry.find_by(id: industry)
        end
        sector = company.sector.present? ? company.sector.sector_id : nil
        if sector.present?
          sector = Sector.findby(id: sector)
        end
        fax_number = company.fax_number.present? ? company.fax_number.fax_number : nil
        adoption_phone_number = company.adoption_phone_number.present? ? company.adoption_phone_number.phone_number : nil
        adoption_email_address = company.adoption_email_address.present? ? company.adoption_email_address.email_address : nil


        result = {company_name: company_name,
                  corporate_num: corporate_num,
                  established_date: established_date,
                  address: address,
                  listing: listing,
                  president_name: president_name,
                  phone_number: phone_number,
                  web_url: web_url,
                  contact_form: contact_form,
                  fasebook_url: fasebook_url,
                  twitter_url: twitter_url,
                  industry: industry,
                  sector: sector,
                  fax_number: fax_number,
                  adoption_phone_number: adoption_phone_number,
                  adoption_email_address: adoption_email_address}

        @results.push(result)

      end
    end

    @count = @company_ids_uniq.count
    @results


  end


end
