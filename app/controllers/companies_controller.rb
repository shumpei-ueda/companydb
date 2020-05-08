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


    @results = []
    if @company_name.present?
      @companies = Company.eager_load(
        :company_phone_numbers,
        :company_addresses,
        :company_listings,
        :company_presidents,
        :company_web_urls,
        :company_contact_forms,
        :company_facebooks,
        :company_twitters,
        :company_industries,
        :company_sectors,
        :company_fax_numbers,
        :adoption_phone_numbers,
        :adoption_email_addresses,
        :company_media_ads
      ).where(
        'name like ?', "%#{@company_name}%"
      )
      @companies.each do |company|
        company_name = company.name
        established_date = company.established_date
        corporate_num = company.corporate_num
        #電話番号の抽出
        if company.company_phone_numbers.present?
          phone_numbers = company.company_phone_numbers.select { |phone_number| phone_number.is_invalid.blank? }
          phone_number = phone_numbers.present? ? phone_numbers.last.phone_number : nil
        else
          phone_number = nil
        end
        #住所の抽出
        if company.company_addresses.present?
          addresses = company.company_addresses.select { |address| address.is_invalid.blank? }
          address = addresses.present? ? addresses.last.address : nil
        else
          address = nil
        end
        #上場情報抽出
        if company.company_listings.present?
          listings = company.company_listings.select { |listing| listing.is_invalid.blank? }
          listing = listings.present? ? listings.last.listed : nil
        else
          listing = nil
        end
        #代表情報抽出
        if company.company_presidents.present?
          presidents = company.company_presidents.select { |president| president.is_invalid.blank? }
          president_name = presidents.present? ? presidents.last.president_name : nil
        else
          president_name = nil
        end
        #企業HP情報抽出
        if company.company_web_urls.present?
          web_urls = company.company_web_urls.select { |web_url| web_url.is_invalid.blank? }
          web_url = web_urls.present? ? web_urls.last.url : nil
        else
          web_url = nil
        end
        #お問い合わせフォーム抽出
        if company.company_contact_forms.present?
          contact_forms = company.company_contact_forms.select { |contact_form| contact_form.is_invalid.blank? }
          contact_form = contact_forms.present? ? contact_forms.last.contact_form_url : nil
        else
          contact_form = nil
        end
        #Facebook情報抽出
        if company.company_facebooks.present?
          facebooks = company.company_facebooks.select { |facebook| facebook.is_invalid.blank? }
          facebook_url = facebooks.present? ? facebooks.last.url : nil
        else
          facebook_url = nil
        end
        #Twitter情報抽出
        if company.company_twitters.present?
          twitters = company.company_twitters.select { |twitter| twitter.is_invalid.blank? }
          twitter_url = twitters.present? ? twitters.last.url : nil
        else
          twitter_url = nil
        end
        #業界情報抽出
        if company.company_industries.present?
          industries = company.company_industries.select { |industry| industry.is_invalid.blank? }
          industry_id = industries.present? ? industries.last.industry_id : nil
          industry = industry_id.present? ? Industry.find_by(industry_id).name : nil
        else
          industry = nil
        end
        #業種情報抽出
        if company.company_sectors.present?
          sectors = company.company_sectors.select { |sector| sector.is_invalid.blank? }
          sector_id = sectors.present? ? sectors.last.sector_id : nil
          sector = sector_id.present? ? Sector.find_by(sector_id).name : nil
        else
          sector = nil
        end
        #fax情報抽出
        if company.company_fax_numbers.present?
          fax_numbers = company.company_fax_numbers.select { |fax_number| fax_number.is_invalid.blank? }
          fax_number = fax_numbers.present? ? fax_numbers.last.fax_number : nil
        else
          fax_number = nil
        end
        #採用電話番号抽出
        if company.adoption_phone_numbers.present?
          adoption_phone_numbers = company.adoption_phone_numbers.select { |adoption_phone_number| adoption_phone_number.is_invalid.blank? }
          adoption_phone_number = adoption_phone_numbers.present? ? adoption_phone_numbers.last.phone_number : nil
        else
          adoption_phone_number = nil
        end
        #採用メールアドレス抽出
        if company.adoption_email_addresses.present?
          adoption_email_addresses = company.adoption_email_addresses.select { |adoption_email_address| adoption_email_address.is_invalid.blank? }
          adoption_email_address = adoption_email_addresses.present? ? adoption_email_addresses.last.phone_number : nil
        else
          adoption_email_address = nil
        end


        result = {company_name: company_name,
                  corporate_num: corporate_num,
                  established_date: established_date,
                  address: address,
                  listing: listing,
                  president_name: president_name,
                  phone_number: phone_number,
                  web_url: web_url,
                  contact_form: contact_form,
                  facebook_url: facebook_url,
                  twitter_url: twitter_url,
                  industry: industry,
                  sector: sector,
                  fax_number: fax_number,
                  adoption_phone_number: adoption_phone_number,
                  adoption_email_address: adoption_email_address}

        @results.push(result)

      end
    end

    @count = @results.count
    @results
    render("companies/search_form")

  end


end
