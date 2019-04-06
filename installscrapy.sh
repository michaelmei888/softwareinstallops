# requires python_venv_installation.sh

#ref: http://doc.scrapy.org/en/latest/intro/install.html#intro-install

#################################################
# Using a virtual environment (recommended)
################################################

cd SCRAPY_WORKSPACE_ROOT
virtualenv -p /usr/local/bin/python3.7 venv
source /venv/bin/activate

pip install scrapy

scrapy startproject tutorial

cd tutorial 

# >>>>> Create a spider in the project called "quotes"
#import scrapy
#class QuotesSpider(scrapy.Spider):
#    name = "quotes"
#    def start_requests(self):
#        urls = [
#            'http://quotes.toscrape.com/page/1/',
#            'http://quotes.toscrape.com/page/2/',
#        ]
#        for url in urls:
#            yield scrapy.Request(url=url, callback=self.parse)
#
#    def parse(self, response):
#        page = response.url.split("/")[-2]
#        filename = 'quotes-%s.html' % page
#        with open(filename, 'wb') as f:
#            f.write(response.body)
#        self.log('Saved file %s' % filename)
# <<<<< End of the file

#Run the spider
scrapy crawl quotes

#################################################
# Deploy a scrapyd program
################################################

#server side deamon to run the scrapy service.
#access it via http restful interfaces
pip install scrapyd

#to pack and deploy the egg file via scrapy versionadd interface
pip install git+https://github.com/scrapy/scrapyd-client

