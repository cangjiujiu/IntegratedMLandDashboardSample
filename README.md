# IntegratedMLandDashboardSample
Create a new namespace

Terminal uses zpm IntegratedMLandDashboardSample to install the project to a new namespace

Import and compile CustomizeMaschineLerningAndaAnalysis-Dashboard-Analysis.dashboard.xml

Execution

Do # # class (customizemashinelerningandaanalysis. Util. Tool). Deployment()

Modify Vue file and add config.js in dist/static

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/7854fb42-d65d-4300-a052-588b0fc82534)


Change 2 to "/Analysis"+create a namespace name such as "/AnalysisUSER"

Then start the front-end package, you can use tomcat

If you are deploying dist locally through tomcat, visit the localhost: 52774/dist access page

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/323ada13-d45e-4b3b-a451-165dec5ffcce)



Taking women.csv as an example

1. Select a CSV file to upload, and the CSV file name and data column name must not contain other symbols such as spaces

2. Fill in the column name that needs to be predicted, such as “height”

3. Click OK to wait for the interface to return

After successfully returning, refresh the current page and click on the secondary option under the Model List. The newly generated project will appear

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/1c406a3a-758d-497d-a42e-eda648a62b6c)

① After filling in other values, clicking ② OK will generate a predicted value at ③

④ The embedded iris dashboard displays some data previously imported into CSV


Other CSV displays


![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/e9334c6c-a8b3-4aff-9570-d914d5d796c0)

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/76a73470-c395-492e-bbe6-a6c602dd92c0)

Due to the embedded dashboard of iris on the page, if you encounter cross domain issues that cannot be displayed properly, you can visit iris to view the chart

![image](https://github.com/cangjiujiu/IntegratedMLandDashboardSample/assets/124135718/d527f988-4703-40a2-ad48-d05c842b0c7d)


