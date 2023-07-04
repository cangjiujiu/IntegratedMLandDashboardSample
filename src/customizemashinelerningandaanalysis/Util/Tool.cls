Class customizemashinelerningandaanalysis.Util.Tool
{

// 创建表并将csv数据导入至表

// 动态生成类

/// /创建预测模型
ClassMethod CreateTable(Input As %DynamicObject) As %Status
{
	/*set Input=
	  {
		"Predict":"name2",
	    "TableName":"xxxx",
	    "Properties":[
	        "name1","name2"	    
	    ]
	   }*/
	   
	   
    set array=Input.Properties
    set itor=array.%GetIterator()
   
	//class名 属性名 每个属性的路径 
	
	set methodl = ##class(%Dictionary.MethodDefinition).%New()
	set methodl.FormalSpec=""
	set methodl.ClassMethod=1
	set methodl.Name = "import"
	set methodl.ReturnType="%Status"
	set methodl.ClassMethod=1
	set methodl.FormalSpec="Input:%Stream.GlobalCharacter"
	set imp = methodl.Implementation
	do imp.MoveToEnd() 
	Set class = ##class(%Dictionary.ClassDefinition).%New()
	Set class.Name="customizemashinelerningandaanalysis.Data."_Input.TableName ///xmljh1000
	Set class.Super="%Persistent"
	set class.ProcedureBlock=1
	
	do imp.WriteLine("    set line=Input.ReadLine() ")

	do imp.WriteLine("    set line=Input.ReadLine()")
	do imp.WriteLine("    while line'="""" ")
	do imp.WriteLine("    {")
	set sql1=""
	set sql2=""
	set sql3=""
	set i=1
	//set length=$
	WHILE itor.%GetNext(.key,.value)
	{
		    do imp.WriteLine("    set "_value_"=$p(line,"","","_i_")")
		    set i=i+1
			set Property=##class(%Dictionary.PropertyDefinition).%New()
		    set Property.Name=value
		    set Property.Type="%Numeric"
		    do class.Properties.Insert(Property)
		    set sql1=sql1_value_","
		    set sql2=sql2_":"_value_","
		    if (value'=Input.Predict)
		    {
			    set sql3=sql3_value_" float,"
			}
		    //do imp.WriteLine("    &sql(insert into customizemashinelerningandaanalysis_Data."" (name1,name2)values(:name1,:name2))")
	
		
	}
	 //	w "---",!
    do imp.WriteLine("    &sql(insert into customizemashinelerningandaanalysis_Data."_Input.TableName_"("_$e(sql1,1,*-1)_")values("_$e(sql2,1,*-1)_"))")
    do imp.WriteLine("    set line=Input.ReadLine()")
    do imp.WriteLine("    }")
	do imp.WriteLine("    Quit $$$OK")
	Do class.Methods.Insert(methodl)
	w "---",!
    set method2 = ##class(%Dictionary.MethodDefinition).%New()
	set method2.FormalSpec=""
	set method2.ClassMethod=1
	set method2.Name = "createModel"
	set method2.ReturnType="%Status"

	//set method2.FormalSpec="Input:%Stream.GlobalCharacter"
	set imp2 = method2.Implementation
	do imp2.MoveToEnd()
	do imp2.WriteLine("    set sql=""CREATE MODEL Customize"_Input.TableName_" PREDICTING ("_Input.Predict_")   with("_$e(sql3,1,*-1)_" ) from customizemashinelerningandaanalysis_Data."_Input.TableName_"""")
	do imp2.WriteLine("    Set statement = ##class(%SQL.Statement).%New()")
	do imp2.WriteLine("    Set qStatus = statement.%Prepare(sql)")
	do imp2.WriteLine("    Set rset = statement.%Execute()")
	do imp2.WriteLine("    Quit $$$OK")
	Do class.Methods.Insert(method2)
	
	
	Do class.%Save()
	
	Do $System.OBJ.Compile("customizemashinelerningandaanalysis.Data."_Input.TableName)
	set plist=$e(sql1,1,*-1)
	&sql(insert into customizemashinelerningandaanalysis.DB (TableName,Plist,PValue)values(:Input.TableName,:plist,:Input.Predict))
	Quit $$$OK
}

// 将csv数据导入至表

ClassMethod ImportCsv(TableName As %String, Input As %Stream.GlobalCharacter) As %Status
{
	set tableName=TableName
	//w "--",!
	//set line=Input.ReadLine() ///第一行是属性名  name1 name2
	Do $classmethod("customizemashinelerningandaanalysis.Data."_TableName,"import",Input)
	
	
	Quit $$$OK
}

ClassMethod CreateTest() As %Status
{
	
	
	Quit $$$OK
}

// 创建模型等 模型命名格式

ClassMethod CreateModel(TableName As %String, PREDICTProperty As %String) As %Status
{
	Do $classmethod("customizemashinelerningandaanalysis.Data."_TableName,"createModel")
        Quit  $$$OK
}

ClassMethod TrainModel(TableName) As %Status
{
	
	set sql="TRAIN MODEL "_TableName_""
	w sql,!
	Set statement = ##class(%SQL.Statement).%New()
	Set qStatus = statement.%Prepare(sql)
	w qStatus,!
	Set rset = statement.%Execute()
    Quit $$$OK
}

/// /创建BI页面
/// 生成kpi
ClassMethod createHistogramKPI(ClassName, predictValue) As %Status
{
	Set HistogramKPI = ##class(%Dictionary.ClassDefinition).%New()
	set HistogramKPI.Name="customizemashinelerningandaanalysis.DeepSee."_ClassName_".HistogramKPI"
	Do HistogramKPI.%Save()
    Do $System.OBJ.Compile("customizemashinelerningandaanalysis.DeepSee."_ClassName_".HistogramKPI")
	Set HistogramKPI = ##class(%Dictionary.ClassDefinition).%OpenId("customizemashinelerningandaanalysis.DeepSee."_ClassName_".HistogramKPI")
	set xdata=##class(%Dictionary.XDataDefinition).%New()
	set xdata.parent=HistogramKPI
	set xdata.Name="KPI"
	set xdata.XMLNamespace="http://www.intersystems.com/deepsee/kpi"
	Do xdata.Data.WriteLine("<kpi xmlns=""http://www.intersystems.com/deepsee/kpi""")
    Do xdata.Data.WriteLine("name=""customizemashinelerningandaanalysis/DeepSee/"_ClassName_"/HistogramKPI""")
    Do xdata.Data.WriteLine("sourceType=""manual""")
    Do xdata.Data.WriteLine("caption=""HistogramKPI""")
    Do xdata.Data.WriteLine(">")
    Do xdata.Data.WriteLine("<property name=""count""/>")
    Do xdata.Data.WriteLine("</kpi>")
    Do xdata.%Save()
   	Set HistogramKPI = ##class(%Dictionary.ClassDefinition).%OpenId("customizemashinelerningandaanalysis.DeepSee."_ClassName_".HistogramKPI")
   	Set HistogramKPI.Super="%DeepSee.KPI"
	set HistogramKPI.System=4
	set parameterl = ##class(%Dictionary.ParameterDefinition).%New()
	set parameterl.Name="DOMAIN"
	set parameterl.Default="Ensemble"
	do HistogramKPI.Parameters.Insert(parameterl)
	set parameter2 = ##class(%Dictionary.ParameterDefinition).%New()
	set parameter2.Name="RESOURCE"
	set parameter2.Default="%Ens_Dashboard"
	do HistogramKPI.Parameters.Insert(parameter2)
	set methodl = ##class(%Dictionary.MethodDefinition).%New()
	set methodl.FormalSpec=""
	set methodl.Name = "%OnLoadKPI"
	set methodl.ReturnType="%Status"
	set methodl.ClassMethod=0
	set imp = methodl.Implementation
	do imp.MoveToEnd()
	do imp.WriteLine("    &sql(select MAX("_predictValue_"),MIN("_predictValue_") INTO:MAXVALUE,:MINVLUE from customizemashinelerningandaanalysis_Data."_ClassName_" )")
	do imp.WriteLine("    set temp=(MAXVALUE-MINVLUE)/10")
	do imp.WriteLine("    set i=1")
	do imp.WriteLine("    for i=1:1:9")
	do imp.WriteLine("    {")
	do imp.WriteLine("    set min=MINVLUE+((i-1)*temp)")
	do imp.WriteLine("    set max=MINVLUE+((i)*temp)")
	do imp.WriteLine("    set counta=0")
	do imp.WriteLine("    &sql(select count(1)into :counta  from customizemashinelerningandaanalysis_Data."_ClassName_" where "_predictValue_">=:min and "_predictValue_"<:max)	")
	do imp.WriteLine("    Set ..%seriesNames(i) = min_""~""_max")
	do imp.WriteLine("    Set ..%data(i,""count"") =counta")
	do imp.WriteLine("    Set ..%seriesCount = i	")
	do imp.WriteLine("    }")
	do imp.WriteLine("    Quit $$$OK")
	Do HistogramKPI.Methods.Insert(methodl)
	Do HistogramKPI.%Save()
    Do $System.OBJ.Compile("customizemashinelerningandaanalysis.DeepSee."_ClassName_".HistogramKPI")
	Quit $$$OK
}

ClassMethod createBubbleKPI(ClassName, predictValue) As %Status
{
	Set BubbleKPI = ##class(%Dictionary.ClassDefinition).%New()
	set BubbleKPI.Name="customizemashinelerningandaanalysis.DeepSee."_ClassName_".BubbleKPI"
	set BubbleKPI.ProcedureBlock=1
	Do BubbleKPI.%Save()
    Do $System.OBJ.Compile("customizemashinelerningandaanalysis.DeepSee."_ClassName_".BubbleKPI")
	Set BubbleKPI = ##class(%Dictionary.ClassDefinition).%OpenId("customizemashinelerningandaanalysis.DeepSee."_ClassName_".BubbleKPI")
	
	set xdata=##class(%Dictionary.XDataDefinition).%New()
	set xdata.parent=BubbleKPI
	set xdata.Name="KPI"
	set xdata.XMLNamespace="http://www.intersystems.com/deepsee/kpi"
	Do xdata.Data.WriteLine("<kpi xmlns=""http://www.intersystems.com/deepsee/kpi""")
    Do xdata.Data.WriteLine("name=""customizemashinelerningandaanalysis/DeepSee/"_ClassName_"/BubbleKPI""")
    Do xdata.Data.WriteLine("sourceType=""manual""")
    Do xdata.Data.WriteLine("caption=""BubbleKPI""")
    Do xdata.Data.WriteLine(">")

    Do xdata.Data.WriteLine("<property name=""Value""/>")
    Do xdata.Data.WriteLine("<property name=""p1""/>")
    Do xdata.Data.WriteLine("<property name=""count""/>")
    //Do xdata.Data.WriteLine("<filter name=""p1"" displayName="""" sql=""SELECT  name FROM %Dictionary.CompiledProperty where parent ='customizemashinelerningandaanalysis.Data."_ClassName_"' and name not in ('%%OID','%Concurrency','"_predictValue_"')"" multiSelect=""false""/>")
    Do xdata.Data.WriteLine("</kpi>")
    
    Do xdata.%Save()
    
	//set HistogramKPI=##class()
   	Set BubbleKPI = ##class(%Dictionary.ClassDefinition).%OpenId("customizemashinelerningandaanalysis.DeepSee."_ClassName_".BubbleKPI")
    Set BubbleKPI.Super="%DeepSee.KPI"
	set BubbleKPI.System=4
	set parameterl = ##class(%Dictionary.ParameterDefinition).%New()
	set parameterl.Name="DOMAIN"
	set parameterl.Default="Ensemble"
	do BubbleKPI.Parameters.Insert(parameterl)
	set parameter2 = ##class(%Dictionary.ParameterDefinition).%New()
	set parameter2.Name="RESOURCE"
	set parameter2.Default="%Ens_Dashboard"
	do BubbleKPI.Parameters.Insert(parameter2)
	set methodl = ##class(%Dictionary.MethodDefinition).%New()
	set methodl.FormalSpec=""
	set methodl.Name = "%OnLoadKPI"
	set methodl.ReturnType="%Status"
	set methodl.ClassMethod=0
	set imp = methodl.Implementation
	do imp.MoveToEnd()
	do imp.WriteLine("    Set filter = ..%filterValues")
	do imp.WriteLine("    If filter.p1'="""" {")
	do imp.WriteLine("    set sql=""select ""_filter.p1_"" as p1,"_predictValue_" as p2,count("_predictValue_")as countnum from customizemashinelerningandaanalysis_Data."_ClassName_" group by "_predictValue_",""_filter.p1_""""")
	do imp.WriteLine("    }else{")
	do imp.WriteLine("    	   &sql(SELECT  name into:tempname FROM %Dictionary.CompiledProperty where parent ='customizemashinelerningandaanalysis.Data."_ClassName_"' and name not in ('%%OID','%Concurrency','"_predictValue_"'))")	
	do imp.WriteLine("    	   set sql=""select ""_tempname_"" as p1,"_predictValue_" as p2,count("_predictValue_")as countnum from customizemashinelerningandaanalysis_Data."_ClassName_" group by "_predictValue_"""")
	do imp.WriteLine("    }")
	do imp.WriteLine("    Set statement = ##class(%SQL.Statement).%New()")
	do imp.WriteLine("    Set qStatus = statement.%Prepare(sql)")
	do imp.WriteLine("    Set rset = statement.%Execute()")
	do imp.WriteLine("    Set row = 1")
	do imp.WriteLine("    while rset.%Next(){")
	do imp.WriteLine("    	 Set ..%seriesNames(row) = ""Name""")
	do imp.WriteLine("    	 Set ..%data(row,""p1"") =rset.%Get(""p1"")")
	do imp.WriteLine("    	 Set ..%data(row,""Value"") = rset.%Get(""p2"")")
	do imp.WriteLine("    	 Set ..%data(row,""count"") =  rset.%Get(""countnum"")")
	do imp.WriteLine("    	 Set ..%seriesCount = row	")	
	do imp.WriteLine("    	 set row=row+1")
	do imp.WriteLine("    }")
	do imp.WriteLine("    Quit $$$OK")
    Do BubbleKPI.Methods.Insert(methodl)
    w BubbleKPI.%Save()
    Do $System.OBJ.Compile("customizemashinelerningandaanalysis.DeepSee."_ClassName_".BubbleKPI")
	Quit $$$OK
}

ClassMethod createPieKPI(ClassName) As %Status
{
	Set PieKPI = ##class(%Dictionary.ClassDefinition).%New()
	set PieKPI.Name="customizemashinelerningandaanalysis.DeepSee."_ClassName_".PieKPI"
	set PieKPI.ProcedureBlock="1"
	Do PieKPI.%Save()
    Do $System.OBJ.Compile("customizemashinelerningandaanalysis.DeepSee."_ClassName_".PieKPI")
	Set PieKPI = ##class(%Dictionary.ClassDefinition).%OpenId("customizemashinelerningandaanalysis.DeepSee."_ClassName_".PieKPI")
	set xdata=##class(%Dictionary.XDataDefinition).%New()
	set xdata.parent=PieKPI
	set xdata.Name="KPI"
	set xdata.XMLNamespace="http://www.intersystems.com/deepsee/kpi"
	Do xdata.Data.WriteLine("<kpi xmlns=""http://www.intersystems.com/deepsee/kpi""")
    Do xdata.Data.WriteLine("name=""customizemashinelerningandaanalysis/DeepSee/"_ClassName_"/PieKPI""")
    Do xdata.Data.WriteLine("sourceType=""manual""")
    Do xdata.Data.WriteLine("caption=""PieKPI""")
    Do xdata.Data.WriteLine(">")
	set sql="SELECT  name FROM %Dictionary.CompiledProperty where parent ='customizemashinelerningandaanalysis.Data."_ClassName_"' and name not in ('%%OID','%Concurrency')"
	Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sql)
    Set rset = statement.%Execute()
    while rset.%Next(){
        Do xdata.Data.WriteLine("<property name="""_rset.%Get("name")_"""/>")	
    }
    Do xdata.Data.WriteLine("</kpi>")
    Do xdata.%Save()
   	Set PieKPI = ##class(%Dictionary.ClassDefinition).%OpenId("customizemashinelerningandaanalysis.DeepSee."_ClassName_".PieKPI")
    Set PieKPI.Super="%DeepSee.KPI"
	set PieKPI.System=4
	set parameterl = ##class(%Dictionary.ParameterDefinition).%New()
	set parameterl.Name="DOMAIN"
	set parameterl.Default="Ensemble"
	do PieKPI.Parameters.Insert(parameterl)
	set parameter2 = ##class(%Dictionary.ParameterDefinition).%New()
	set parameter2.Name="RESOURCE"
	set parameter2.Default="%Ens_Dashboard"
	do PieKPI.Parameters.Insert(parameter2)
	set methodl = ##class(%Dictionary.MethodDefinition).%New()
	set methodl.FormalSpec=""
	set methodl.Name = "%OnLoadKPI"
	set methodl.ReturnType="%Status"
	set methodl.ClassMethod=0
	set imp = methodl.Implementation
	do imp.MoveToEnd()
	set i=1
	set j=0
	
	set sql="SELECT  name FROM %Dictionary.CompiledProperty where parent ='customizemashinelerningandaanalysis.Data."_ClassName_"' and name not in ('%%OID','%Concurrency')"
	Set statement = ##class(%SQL.Statement).%New()
    Set qStatus = statement.%Prepare(sql)
    Set rset = statement.%Execute()
    while rset.%Next(){
	    Do imp.WriteLine("   set j="_j_"")
        Do imp.WriteLine("   &sql(select MAX("_rset.%Get("name")_"),MIN("_rset.%Get("name")_") INTO:MAXVALUE,:MINVLUE from customizemashinelerningandaanalysis_Data."_ClassName_" )")
        Do imp.WriteLine("   set temp=(MAXVALUE-MINVLUE)/10")
		Do imp.WriteLine("   set i=1")
			//Do imp.WriteLine("   set j="_((j*10)))
		Do imp.WriteLine("   for i=i:1:9")
		Do imp.WriteLine("   {")
		Do imp.WriteLine("   	set min=MINVLUE+((i-1)*temp)")
		Do imp.WriteLine("   	set max=MINVLUE+((i)*temp)")
		Do imp.WriteLine("   	set counta=0")
		Do imp.WriteLine("   	&sql(select count(1)into :counta  from customizemashinelerningandaanalysis_Data."_ClassName_" where "_rset.%Get("name")_">=:min and "_rset.%Get("name")_"<:max)	")	
		Do imp.WriteLine("   	Set ..%seriesNames((j*10)+i) = min_""~""_max")
		Do imp.WriteLine("   	Set ..%data((j*10)+i,"""_rset.%Get("name")_""") =counta")
	    Do imp.WriteLine("   	Set ..%seriesCount = (j*10)+i	")
	    //Do imp.WriteLine("     set j=j+1")
		Do imp.WriteLine("   }")
        set j=j+1
    }
    Do imp.WriteLine("   Quit $$$OK")
	Do PieKPI.Methods.Insert(methodl)
	Do PieKPI.%Save()
    Do $System.OBJ.Compile("customizemashinelerningandaanalysis.DeepSee."_ClassName_".PieKPI")
	Quit $$$OK
}

ClassMethod copydashboarf(ClassName, valuelist) As %Status
{
	//复制这个
  //%DeepSee_Dashboard.Definition
     &sql(select ID into :ID from  %DeepSee_Dashboard.Definition where fullname='customizemashinelerningandaanalysis/Dashboard/Analysis.dashboard')
     &sql(select folder into :folder from  %DeepSee_Dashboard.Definition order by ID desc)
  	 set sourceClass=##class(%DeepSee.Dashboard.Definition).%OpenId(ID)
  	 set targetClass=##class(%DeepSee.Dashboard.Definition).%New()
     //set targetClass=sourceClass.%ConstructClone(sourceClass)
     //set targetClass.folder=folder+1
     //W "=="
     set targetClass.name=ClassName_"Analysis"
     //set targetClass.documentName="customizemashinelerningandaanalysis/Dashboard-"_ClassName_"Analysis.dashboard.DFI"
     set targetClass.fullName="customizemashinelerningandaanalysis/Dashboard/"_ClassName_"Analysis.dashboard"
    // w sourceClass.widgets.Size
     set targetClass.snapGrid=1
      set targetClass.snapTo=1
      set targetClass.title=ClassName_"Analysis"
     set i=1
     for i=1:1:sourceClass.widgets.Size
     {
	     
	     set temp=sourceClass.widgets.GetAt(i)
	    
	    // w temp.dataSource,!
	 
	     set temp.dataSource="customizemashinelerningandaanalysis/DeepSee/"_ClassName_"/"_temp.name_"KPI.kpi"
	     set controls=temp.controls
	     
	     set jlength=temp.controls.Size
	     for j=1:1:jlength
	     {
		     // w temp.controls.GetAt(j).targetProperty
		     if (temp.controls.GetAt(j).targetProperty="p1")
		     {
			     
			     w temp.controls.GetAt(j).valueList,"ww",!
			     //&sql(SELECT  name FROM %Dictionary.CompiledProperty where parent ='customizemashinelerningandaanalysis.Data."__"' and name not in ('%%OID','%Concurrency','name2'))
			    // set jlength.GetAt(j).valueList=valuelist,jlength.GetAt(j).displayList="weight"    
			     set temp.controls.GetAt(j).valueList=valuelist
			 }
		     
		 }
	    
	     Do targetClass.widgets.Insert(temp)
	 }
     do targetClass.%Save()
     Quit $$$OK
}

ClassMethod Deployment() As %Status
{
	set ns=$namespace
	//1.创建web应用程序
	new $namespace
	zn "%sys"
	Set property("AutheEnabled")=64,property("IsNameSpaceDefault")=0,property("MatchRoles")="%All:%All,:%All",property("GroupById")="%ISCMgtPortal",property("NameSpace")=ns,property("DeepSeeEnabled")=0,property("DispatchClass")="customizemashinelerningandaanalysis.Util.Rest"
	Set tSC=##Class(Security.Applications).Create("/CustomizeMashineLerningAndAnalysis" ,.property)
	///创建一个匿名访问用的
	Set sc("AutheEnabled")=64,sc("IsNameSpaceDefault")=1,sc("MatchRoles")="%All:%All,:%All",sc("GroupById")="%ISCMgtPortal",sc("NameSpace")=ns,sc("DeepSeeEnabled")=1
	Set tSC=##Class(Security.Applications).Create("/Analysis"_ns,.sc)
	Quit $$$OK
	//2.打开分析
}

}

