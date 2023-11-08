import urllib.request
import re

n=1         # number of draw results to return back
user_agent='Mozilla 5.0 (Windows; U; Windows NT 5.1; en-Us; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7'
urlLotto = "https://resultsservice.lottery.ie/rest/GetResults?drawType=Lotto&lastNumberOfDraws="+str(n)
headers={'User-Agent':user_agent,}
request = urllib.request.Request(urlLotto, None, headers)
response = urllib.request.urlopen(request)
data = response.read().decode('utf-8')

print(data) # print raw data in XML format - for testing only - remove before submission

print("Lotto Draw Results\n")
lottoDrawDate = re.findall("<DrawDate>(.*)</DrawDate>", data, re.DOTALL)
lottoResults = re.findall("<Number>(.*?)</Number>", data, re.DOTALL)
for num in lottoResults:
    print(num, end=" ")