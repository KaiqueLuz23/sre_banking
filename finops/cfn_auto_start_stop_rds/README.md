### Resources
Os seguintes recursos da AWS são criados a partir deste modelo:
  *	<b>Funções lambda</b>:
      *	AutoStartRDSInstance
      *	AutoStopRDSInstance
      *	RDSStartWeekDay
      *	RDSStopWeekDay
      *	RDSStartWeekEnd
      *	RDSStopWeekEnd
  *	<b>Regras do EventBridge</b>:
      *	AutoStartRDSRule
      *	AutoStopRDSRule
      *	RDSStartStopWeekDayRule
      *	RDSStartStopWeekEndRule
  *	<b>Recursos do IAM</b>:
      *	LambdaRDSStartStopRole (role)
      *	LambdaRDSStartStopPolicy (inline policy)
  *	<b>Grupos de logs do CloudWatch</b>:
      *	/aws/lambda/AutoStartRDSInstance
      *	/aws/lambda/AutoStopRDSInstance
      *	/aws/lambda/RDSStartWeekDay
      *	/aws/lambda/RDSStopWeekDay
      *	/aws/lambda/RDSStartWeekEnd
      *	/aws/lambda/RDSStopWeekEnd
