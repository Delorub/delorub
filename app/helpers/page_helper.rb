module PageHelper
  def how_it_works_path
    page_path 'how-it-works'
  end

  def about_path
    page_path 'about'
  end

  def company_path
    page_path 'company'
  end

  def how_to_master_path
    page_path 'how-to-master'
  end

  def terms_path
    page_path 'terms'
  end

  def policy_path
    page_path 'policy'
  end

  def page_path name
    "/#{name}"
  end
end
