Class customizemashinelerningandaanalysis.DB Extends %Persistent
{

/// 表名
Property TableName;

/// 需要的参数列
Property Plist;

/// 预测值
Property PValue;

Storage Default
{
<Data name="DBDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TableName</Value>
</Value>
<Value name="3">
<Value>Plist</Value>
</Value>
<Value name="4">
<Value>PValue</Value>
</Value>
</Data>
<DataLocation>^customizemashinelerningFA35.DBD</DataLocation>
<DefaultData>DBDefaultData</DefaultData>
<IdLocation>^customizemashinelerningFA35.DBD</IdLocation>
<IndexLocation>^customizemashinelerningFA35.DBI</IndexLocation>
<StreamLocation>^customizemashinelerningFA35.DBS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

