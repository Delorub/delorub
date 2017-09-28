SitemapGenerator::Sitemap.default_host = Figaro.env.base_url
SitemapGenerator::Sitemap.namer = SitemapGenerator::SimpleNamer.new(:sitemap, extension: '.xml')
SitemapGenerator::Sitemap.create(compress: false) do
  group(sitemaps_path: 'sitemaps/', compress: false, namer: SitemapGenerator::SimpleNamer.new(:main, extension: '.xml'), include_root: true) do
    add categories_path
    add tasks_path
    add new_task_path
    Place.only_cities.each do |city|
      add city.slug + '/tasks'
    end
  end

  Category.all.each do |category|
    group(sitemaps_path: 'sitemaps/', namer: SitemapGenerator::SimpleNamer.new(category.slug, extension: '.xml'), compress: false) do
      add category_tasks_path(category)
      add new_task_path(category)
      Place.only_cities.each do |city|
        add category_tasks_path(category, city_code: city.slug)
      end
    end
  end
end
