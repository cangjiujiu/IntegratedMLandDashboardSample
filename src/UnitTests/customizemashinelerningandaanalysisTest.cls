Class UnitTests.customizemashinelerningandaanalysisTest Extends %UnitTest.TestCase
{

// 创建表并将csv数据导入至表

// 动态生成类

ClassMethod ClassTest() As %Status
{
	set testStream=##class(%Stream.GlobalCharacter).%New()
	Do testStream.WriteLine("test1,test2")
	Do testStream.WriteLine("1,2")
	Do testStream.WriteLine("2,4")
	Do testStream.WriteLine("3,6")
	Do testStream.WriteLine("4,8")
	Do testStream.WriteLine("5,10")
	Do testStream.WriteLine("6,12")
	set tablename="test"
	
	set table=
	  {
		"Predict":"name2",
	    "TableName":"test",
	    "Properties":[
	        "test1","test2"	    
	    ]
	   }
	
	//Do ##class(customizemashinelerningandaanalysis.Util.Tool).CreateTable(table)
	//Do $ClassMethod("customizemashinelerningandaanalysis.Data.test","import",testStream)
	//Do $ClassMethod("customizemashinelerningandaanalysis.Data.test","createModel")

	//Do ##class(customizemashinelerningandaanalysis.Util.Tool).TrainModel("Customize"_tablename)
	Do ##class(customizemashinelerningandaanalysis.Util.Tool).createHistogramKPI($p(tablename,".csv",1),"test1")
    Do ##class(customizemashinelerningandaanalysis.Util.Tool).createBubbleKPI($p(tablename,".csv",1),"test1")
    Do ##class(customizemashinelerningandaanalysis.Util.Tool).createPieKPI($p(tablename,".csv",1))
    set tablename=$p(tablename,".csv",1)
     &sql(select Plist,PValue into:Plist,:PValue from customizemashinelerningandaanalysis.DB where TableName=:tablename)
    set other=$replace(Plist,","_PValue,"")
    set other=$replace(Plist,","_PValue,"")
    set other=$replace(Plist,PValue_",","")
    Do ##class(customizemashinelerningandaanalysis.Util.Tool).copydashboarf(tablename,other)
    Quit $$$OK
}

}

