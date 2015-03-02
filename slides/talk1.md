% Project_1a Report
% SuperCh-SE-NCSU
  Zhewei Hu, Liang Dong, Shupeng Niu
% March 3rd, 2015
#Project Ideas: 

<center>
<div style="font-size:40px" align="left">
- Our team want to develop a website<br/>which can be used for customers to find the latest information about used cars easily and efficiently.
</div>
</center>



#Milestones:

- Beta Launch (Finished)
- Version_1: Minimal functionality (Processing)
- Version_2: Full functionality (Processing, Scrapy)
- Unit Test, Integrate Test and System Test (Processing, during development period)
- Finish final reports

#Goals:  

- Develop a website, offering car buyers the integrated information of used cars, based on customers’ needs and several most useful factors (model, year, website link and price range).
- To be more specific, based on a customer’s needs(car model, year of make, mileage,etc) we find the posts on craiglist, which agree with the customer’s needs and look up the price for the car on sale on the post from Kbb. 
Then our website will show the customer the posts(link to the original posts on craiglist) with cars he is interested in on sale and the price from Kbb. 
- <b>Advantage:</b> Right now, people have to go to craiglist to find the car they are interested in with a seller’s price, and then go to kbb, checking out the review price.It’s a pain to look up cars’ kbb price again and again.
Our website will do the two jobs for customers automatically, and people can get updated information emailed to them from our website’s subscription service.

#Term Versions:

- Version_1: Minimal functionality (According to customers’ selected conditions on our website, send them emails including several most useful factors stated above from 2 websites, Craglist and kbb.)

- Version_2: Full functionality (Build a database of customers login information and search records. Everytime customer login our website, they will get latest information since last login. Customers can also get updated information from our website’s subscription service, eg. one time per day.)

#Two approaches: 
 
We will develop this website using self-developed Python regular expression and Scrapy (a fast high-level screen scraping and web crawling framework, used to crawl websites and extract structured data from their pages) using <b>Agile Development Model</b>. 

- <div style="font-size:30px"><b> Self-developed Python regular expression:</b></div>
<i>We are going to use python urllib module which opens a communication link with a URL to download the raw content of the web site. Then we parse the raw content using regular expression and design data structure to store the information.</i>
<p>Follow our public repository <u><a href="https://github.com/SuperCh-SE-NCSU/ProjectScraping">ProjectScraping</a></u> in Github</p>
- <div style="font-size:30px"><b>Scrapy:</b></div> 
<i>Scrapy is an open-course and collaborative framework for extracting the data you need from websites in a fast, simple, yet extensible way.</i>

#Information sources:

<center>
<div style="font-size:50px" align="left">
- <u><a href="http://www.craigslist.org/about/sites">Craigslist</a></u>
- <u><a href="http://www.kbb.com">kbb</a>.</u>
</div> 
</center>
#Workflow:

<img align=center src="../img/workflow.png">

#Subscribe website:

<img align=center src="../img/Subscribe website.png" style="width:549px;height=285px">

- We built a friendly webpage to help users subscribe our email service.
- We have already deployed this <u><a href="https://rocky-spire-5172.herokuapp.com/" target="_blank">webpage on Heroku</a></u>.
- On this webpage you need type your name, car maker, car model, year and your real email address to subscribe.


#Subscribe website:

<img align=center src="../img/Subscribe website1.png" style="width:549px;height=285px">

- We imported enough information about popular car makers and car models, you can find what you need quickly.
- We specified input restrictions to ensure the data collected from users is 100 percent right.
- When user clicks the button, his/her data will be stored in database.

#Function design for model:

- <b>Kbb function:</b> kbbGetData(sess, make,model,year).
- <b>Craigslist function:</b> craglistsearch(cmake,cmodel,cstartyear,cendyear,cminprice,cmaxprice,ctime).
- <b>compare prices function:</b> carlist_with_kbb_price = craglistsearchKbb(carlist).
- carlist_with_kbb_price will call kbbPrice to get the kbb price for every car.

#Craigslist data:

<img align=right src="../img/Crawl.png" style="width:526px;height=600px">

- We can obtain data from Craigslist with restrictions, such as car maker, car model and car year.
- We can obtain data from Craglist with specified parameters, such as car maker, car model and car year.
- We will do crawling everyday for each user according to information they offered.

#kbb data:

<img align=right src="../img/kbb.png" style="width:664px;height=437px">

- We can obtain data from kbb with specified parameters, such as car maker, car model and car year.
- kbb is a dynamic website (different kinds of cars have different vehicleids), so we have to do crawling everyday for each user, according to information they offered.

#Email Service:

<img align=center src="../img/Email service.png" style="width:626px;height=325px">

- If users subscribed our email service, we will send them one email per day,containing the car information they specified.
- Users can unsubscribe, if he/she have already found a suitable car they need.
- Email above is just an sample email. We will send information with specific car price to users.

