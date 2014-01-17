#HW8

### Load HW6.rda and attach the XML library
require(XML)

### Part 1.  Create the data frame
### Look at the instructions in HW6.pdf.
### Functions you'll want to use: xmlParse(), xmlRoot(), xpathSApply(), xmlGetAttr().
### It also might make it easier to use: xmlToList(), merge().

### Load the data frame called LatLon from HW6.rda.  

### Parse the XML document at:
### http://www.stanford.edu/~vcs/StatData/factbook.xml
### and create an XML "tree" in R 

part1 <- xmlParse("http://www.stanford.edu/~vcs/StatData/factbook.xml")
part1.list <- xmlToList(part1)
catalog <- xmlRoot(part1)
class(catalog)

getNodeSet(catalog, '//field[@name="Infant mortality rate"]')
getNodeSet(catalog, '//field[@name="Population"]')

### Use XPath to extract the infant mortality and the CIA country codes from the XML tree
infant <- xpathSApply(part1, "//field[@name='Infant mortality rate']/rank", xmlGetAttr, "number")
country <- xpathSApply(part1, "//field[@name='Infant mortality rate']/rank", xmlGetAttr, "country")

###   
### Create a data frame called IM using this XML file.
IM <- cbind(infant,country)
colnames(IM) <- c("Infant.Mortality", "CIA.Codes")
### The data frame should have 2 columns: for Infant Mortality and CIA.Codes.

### Extract the country populations from the same XML document
population <- xpathSApply(part1, "//field[@name='Population']/rank", xmlGetAttr, "number")
country <- xpathSApply(part1, "//field[@name='Population']/rank", xmlGetAttr, "country")

### Create a data frame called Pop using these data.
Pop <- cbind(population, country)
colnames(Pop) <- c("Population", "CIA.Codes")
### This data frame should also have 2 columns, for Population and CIA.Codes.

### Merge the two data frames to create a data frame called IMPop with 3 columns:
### IM, Pop, and CIA.Codes
IMPop <- merge(IM, Pop, ID="CIA.Codes")

### Now merge IMPop with LatLon (from HW8.rda) to create a data frame called AllData that has 6 columns
### for Latitude, Longitude, CIA.Codes, Country Name, Population, and Infant Mortality
IMPop$CIA.Codes <- toupper(as.character(IMPop$CIA.Codes))
AllData <- merge(IMPop, LatLon, ID="CIA.Codes")

### Part 2.  Create a KML document
### Make the KML document described in HW6.pdf.  It should have the basic
### structure shown in that document.  You can use the addPlacemark function below to make
### the Placemark nodes, you just need to complete the line for the Point node and
### figure out how to use the function.

makeBaseDocument = function(){
### This code creates the template KML document 
  doc = newXMLDoc()
  root = newXMLNode("kml", namespaceDefinitions = c(xmlns = "http://www.opengis.net/kml2.2"), doc = doc)
  document = newXMLNode("Document", parent=root, doc=doc)
  newXMLNode("Name","Country Facts", parent = document, doc = doc) 
  newXMLNode("Description", "Infant Mortality", parent = document, doc = doc) 
  doc
}

part2 <- makeBaseDocument()

addPlacemark = function(lat, lon, ctryCode, ctryName, pop, infM, parent, 
                        inf1, pop1, style = FALSE)
  
{ prt=newXMLNode("Folder", parent = parent)
  newXMLNode("Name", "Country Facts",parent = prt)
{
    for (i in 1:length(ctryName))
    {
     pm = newXMLNode("Placemark", newXMLNode("name", ctryName[i]), attrs = c(id = as.character(ctryCode[i])),parent = prt)
     newXMLNode("styleUrl", paste("#YOR", inf1[i], "-", pop1[i], sep = ''), parent = pm)        
     newXMLNode("description", paste(ctryName[i], "\n Population: ", pop[i],"\n Infant Mortality: ", infM[i], sep =""), parent = pm)
     newXMLNode("Point", newXMLNode("coordinates", paste(lat[i], lon[i], 0, sep=",")), parent = pm)
    }
          
      ### You need to fill in the code for making the Point node above, including coordinates.
      ### The line below won't work until you've run the code for the next section to set up
      ### the styles.
      
      
    }
  }


addPlacemark(lat=AllData$Latitude, lon = AllData$Longitude, ctryCode = AllData$CIA.Codes, ctryName = AllData$Country.Name,
             pop = AllData$Population, infM = AllData$Infant.Mortality, parent = getNodeSet(part2,"/kml/Document"), inf1 = AllData$Infant.Mortality, 
             pop1 = AllData$Population)


saveXML(part2, "Part2.kml")
### Save your KML document here, call it Part2.kml, and open it in Google Earth.
### (You will need to install Google Earth.)  
### It should have pushpins for all the countries.


### Part 3.  Add Style to your KML
### Now you are going to make the visualizatiion a bit fancier.  Pretty much all the code is given to you
### below to create style elements that are to be placed near the top of the document.
### These , you just need to figure out what it all does.

### Start fresh with a new KML document, by calling makeBaseDocument()

part3 = makeBaseDocument()

### The following code is an example of how to create cut points for 
### different categories of infant mortality and population size.
### Figure out what cut points you want to use and modify the code to create these 
### categories.
infCut = cut(as.numeric(AllData[,2]), breaks = quantile(as.numeric(AllData[,2]), seq(0,1,length=6)), include.lowest = TRUE)
infCut = as.numeric(infCut)

popCut = cut(log(as.numeric(AllData[,3])), breaks=quantile(log(as.numeric(AllData[,3])), seq(0,1,length=6)), include.lowest = TRUE)
popCut = as.numeric(popCut)

### Now figure out how to add styles and placemarks to doc2
### You'll want to use the addPlacemark function with style = TRUE

### Below is code to make style nodes. 
### You should not need to do much to it.

### You do want to figure out what scales to you for the sizes of your circles
scal = c(0.5, 1, 3, 5, 10)
col=c("blue","green","orange","red","yellow")

addStyle = function(col1, pop1, parent, urlBase, scales = scal)
{
  st = newXMLNode("Style", attrs = c("id" = paste("YOR", col1, "-", pop1, sep="")), parent = parent)
  newXMLNode("IconStyle", 
             newXMLNode("scale", scales[pop1]), 
             newXMLNode("Icon", paste(urlBase, "color_label_circle_", col[col1], ".png", sep ="")), parent = st)
}

# This next part adds the style references to the doc2 xml document
for (k in 1:5)
{
  for (j in 1:5)
  {
    addStyle(j, k, parent = getNodeSet(part3,"/kml/Document"), 'http://www.stanford.edu/~vcs/StatData/circles/')
  }
}

# This next part runs the addPlacemark function. Since the style variable is set to be TRUE, the style elements
# will be populated within the Placemark node. 
addPlacemark(lat=AllData$Latitude, lon = AllData$Longitude, ctryCode = AllData$CIA.Codes, ctryName = AllData$Country.Name,
             pop = AllData$Population, infM = AllData$Infant.Mortality, parent = getNodeSet(part3,"/kml/Document"), inf1 = infCut, 
             pop1 = popCut, style = TRUE)


### Finally, save your KML document, call it Part3.kml and open it in Google Earth to 
### verify that it works.  For this assignment, you only need to submit your code, 
### nothing else.  You can assume that the grader has already loaded HW6.rda.
saveXML(doc2, "Part3.kml")
