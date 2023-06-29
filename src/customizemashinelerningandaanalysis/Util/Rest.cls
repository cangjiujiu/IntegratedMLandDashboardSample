Class customizemashinelerningandaanalysis.Util.Rest Extends %CSP.REST
{

Parameter HandleCorsRequest = "true";

XData UrlMap [ XMLNamespace = "http://www.bjgoodwill.com/urlmap" ]
{
<Routes>
  <Route Url="/*" Method="OPTIONS" Call="GetStatus"/>
  <Route Url="/Init" Method="POST" Call="Init"/>
  
 <Route Url="/add" Method="POST" Call="add"/>
 <Route Url="/getMenuList" Method="GET" Call="getMenuList"/>
  <Route Url="/getContent" Method="POST" Call="getContent"/>
  <Route Url="/getPredict" Method="POST" Call="getPredict"/>
</Routes>
}

ClassMethod Init() As %Status
{
	//set tt=##class(%CSP.BinaryStream).%New()
	//w tt.FileName
	//W %request.MimeData("input",1)
	set stream=%request.MimeData("input",1)
	//w stream.FileName
	set table={}
	set table.TableName=$p(stream.FileName,".csv",1)
	set table.Properties=[]
	set table.Predict=%request.Data("Predict",1)
	set line1=stream.ReadLine()
	set length=$l(line1,",")
	for i=1:1:length
	{
		Do table.Properties.%Push($p(line1,",",i))
	}
	//set Predict=%request.Data("Predict",1)
	set stream2=%request.MimeData("input",1)
	Do ##class(customizemashinelerningandaanalysis.Util.Tool).CreateTable(table)
	Do ##class(customizemashinelerningandaanalysis.Data.women113).import(stream2)
	Do ##class(customizemashinelerningandaanalysis.Data.women113).createModel()
	Do ##class(customizemashinelerningandaanalysis.Util.Tool).TrainModel("Customize"_table.TableName)
    //Do ##class(customizemashinelerningandaanalysis.Util.Tool).createHistogramKPI($p(stream.FileName,".csv",1),"height")
    //Do ##class(customizemashinelerningandaanalysis.Util.Tool).createBubbleKPI($p(stream.FileName,".csv",1),"height")
    // Do ##class(customizemashinelerningandaanalysis.Util.Tool).createPieKPI($p(stream.FileName,".csv",1))
     //Do ##class(customizemashinelerningandaanalysis.Util.Tool).copydashboarf($p(stream.FileName,".csv",1),"weight")
	Quit $$$OK
}

ClassMethod add() As %Status
{
	set stream=%request.MimeData("input",1)
	set table={}
	set table.TableName=$p(stream.FileName,".csv",1)
	set table.Properties=[]
	set table.Predict=%request.Data("Predict",1)
	set line1=stream.ReadLine()
	set length=$l(line1,",")
	for i=1:1:length
	{
		Do table.Properties.%Push($p(line1,",",i))
	}
	set stream2=%request.MimeData("input",1)
	Do ##class(customizemashinelerningandaanalysis.Util.Tool).CreateTable(table)
	Do $ClassMethod("customizemashinelerningandaanalysis.Data."_table.TableName_"","import",stream2)
	Do $ClassMethod("customizemashinelerningandaanalysis.Data."_table.TableName_"","createModel")
	Do ##class(customizemashinelerningandaanalysis.Data.women).import(stream2)
    Do ##class(customizemashinelerningandaanalysis.Data.women).createModel()
	Do ##class(customizemashinelerningandaanalysis.Util.Tool).TrainModel("Customize"_table.TableName)
	Do ##class(customizemashinelerningandaanalysis.Util.Tool).createHistogramKPI($p(stream.FileName,".csv",1),table.Predict)
    Do ##class(customizemashinelerningandaanalysis.Util.Tool).createBubbleKPI($p(stream.FileName,".csv",1),table.Predict)
    Do ##class(customizemashinelerningandaanalysis.Util.Tool).createPieKPI($p(stream.FileName,".csv",1))
    set tablename=$p(stream.FileName,".csv",1)
      &sql(select Plist,PValue into:Plist,:PValue from customizemashinelerningandaanalysis.DB where TableName=:tablename)
    
       set other=$replace(Plist,","_PValue,"")
    set other=$replace(Plist,","_PValue,"")
    set other=$replace(Plist,PValue_",","")
    Do ##class(customizemashinelerningandaanalysis.Util.Tool).copydashboarf($p(stream.FileName,".csv",1),other)
	Quit $$$OK
}

ClassMethod getMenuList() As %Status
{
	set array=[]
	set sql="SELECT * from customizemashinelerningandaanalysis.DB "
  	Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sql)
    Set rset = statement.%Execute()
    while rset.%Next(){
	   // w "aaaaa"
	   set temp=rset.%Get("TableName")   
	    Do array.%Push("/Predict/"_temp)
	 }
	
	//SET array=["/Predict/women115","/Predict/women1"]
	//SET ob={"name"}
	w array.%ToJSON()
	Quit $$$OK
}

ClassMethod getContent() As %Status
{
	set ob={}
	set array=[]
	set Type=%request.Data("Type",1)
    //获取具体的值
    &sql(select Plist,PValue into:Plist,:PValue from customizemashinelerningandaanalysis.DB where TableName=:Type)
    
    set length=$l(Plist,",")
    set i=0
    for i=1:1:length
    {
	    if ($p(Plist,",",i)'=PValue){
	       Do array.%Push($p(Plist,",",i))
	    }
	    
	    
	}
	set ob.array=array
	set ob.pValue=PValue
    w ob.%ToJSON()
	Quit $$$OK
}

ClassMethod getPredict() As %Status
{
	
	//&sql()
	//w "wwww",!
		/*
		
		
		*/
 //	w %request.Data("input",1)
	set OB={}.%FromJSON(%request.Data("input",1))
	set Type=OB.name
	
	&sql(select Plist,PValue into:Plist,:PValue from customizemashinelerningandaanalysis.DB where TableName=:Type)
	
	//set length=##class(%DynamicArray).%New()
	SET length=OB.ValueList.%Size()-1
	set i=0
	set value=""
	w length,!
	for i=0:1:length
	{
	
		//if (OB.ValueList.%Get(i)'="")&&(OB.ValueList.%Get(i)'="null"){
				w OB.ValueList.%Get(i),!
	     	set value=value_"'"_OB.ValueList.%Get(i)_"',"
	     	w value,!
		//}
	  	
	 	
	}
	
	 set sql="SELECT PREDICT(Customize"_OB.name_" WITH("_$e(value,1,*-1)_")) as result"
	 w sql,!
  	Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sql)
    Set rset = statement.%Execute()
    while rset.%Next(){
	   // w "aaaaa"
	  w "---resultFlag---"_ rset.%Get("result")   
	    
	 }
	Quit $$$OK
}

}

