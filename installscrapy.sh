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

#Just for eggifying purpose
pip install git+https://github.com/scrapy/scrapyd-client

#put the configuration on the current deploying directory
cat scrapyd.conf 

#[scrapyd]
#eggs_dir    = eggs
#logs_dir    = logs
#items_dir   =
#jobs_to_keep = 5
#dbs_dir     = dbs
#max_proc    = 0
#max_proc_per_cpu = 4
#finished_to_keep = 100
#poll_interval = 5.0
#bind_address = 0.0.0.0
#http_port   = 6800
#debug       = off
#runner      = scrapyd.runner
#application = scrapyd.app.application
#launcher    = scrapyd.launcher.Launcher
#webroot     = scrapyd.website.Root
#[services]
#schedule.json     = scrapyd.webservice.Schedule
#cancel.json       = scrapyd.webservice.Cancel
#addversion.json   = scrapyd.webservice.AddVersion
#listprojects.json = scrapyd.webservice.ListProjects
#listversions.json = scrapyd.webservice.ListVersions
#listspiders.json  = scrapyd.webservice.ListSpiders
#delproject.json   = scrapyd.webservice.DeleteProject
#delversion.json   = scrapyd.webservice.DeleteVersion
#listjobs.json     = scrapyd.webservice.ListJobs
#daemonstatus.json = scrapyd.webservice.DaemonStatus

#to pack the egg file to the current dir named as release.egg
scrapyd-deploy -p tutorial -v 1 --build-egg=./releasev1.egg

#deploy the egg file via scrapy versionadd interface
curl http://{deployed ip}:6800/addversion.json -F project=tutorial -F version=1 -F egg=@releasev1.egg

#schedule the spider via scrapy schedule interface
curl http://{deployed ip}:6800/schedule.json -d project=tutorial -d spider={spider name in the egg}

