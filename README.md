[![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2FIntegratedMLandDashboardSample&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2FIntegratedMLandDashboardSample)   


# IntegratedMLandDashboardSample

A simple data analysis example created in IntegratedML and Dashboard

# IRIS version 

IRIS for Windows (x86-64) 2022.1.2 (Build 574U) Fri Jan 13 2023 15:08:27 EST

# ZPM installation

zpm:USER>install IntegratedMLandDashboardSample

# Process Deployment 


Use or create a new namespace

Import code into the corresponding namespace

Execute in Terminal:

Do # # class (customizemashinelerningandaanalysis. Util. Tool) Deployment()

The front-end is the dist folder under the Vue folder. Before using it, open dist static config.js and modify the IP and port to be used by the back-end server. Then you need to modify the test of iframeUrl to "Analysis"+the namespace used by the backend, such as "AnalysisUSER"

Then start the front-end file (you can place the dist folder in tomcat to start using)

The access address is:

Ip: port/dist


![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/323ada13-d45e-4b3b-a451-165dec5ffcce)


# HOW TO USE

Taking women.csv as an example

1. Select a CSV file to upload, and the CSV file name and data column name must not contain other symbols such as spaces

2. Fill in the column name that needs to be predicted, such as “height”

3. Click OK to wait for the interface to return

After successfully returning, refresh the current page and click on the secondary option under the Model List. The newly generated project will appear

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/1c406a3a-758d-497d-a42e-eda648a62b6c)

① After filling in other values, clicking ② OK will generate a predicted value at ③

④ The embedded iris dashboard displays some data previously imported into CSV


# Other CSV displays


![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/e9334c6c-a8b3-4aff-9570-d914d5d796c0)

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/76a73470-c395-492e-bbe6-a6c602dd92c0)

# Unit Testing

  Set ^UnitTestRoot=your modules dir +"\src"+namespace+"\integratedmlanddashboardsample\src" (such C:\InterSystems\HealthConnect\mgr\.modules\USER\integratedmlanddashboardsample\src)

  do ##class(%UnitTest.Manager).RunTest("UnitTests")

# Tips

Due to the embedded dashboard of iris on the page, if you encounter cross domain issues that cannot be displayed properly, you can visit iris to view the chart

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/d527f988-4703-40a2-ad48-d05c842b0c7d)


