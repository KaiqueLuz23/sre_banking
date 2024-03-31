### Recursos
Os seguintes recursos da AWS são criados a partir deste modelo:
  *	<b>Funções lambda</b>:
      *	AutoStartEC2Instance
      *	AutoStopEC2Instance
      *	EC2StartWeekDay
      *	EC2StopWeekDay
      *	EC2StartWeekEnd
      *	EC2StopWeekEnd
  *	<b>Regras do EventBridge</b>:
      *	AutoStartEC2Rule
      *	AutoStopEC2Rule
      *	EC2StartStopWeekDayRule
      *	EC2StartStopWeekEndRule
  *	<b>Recursos do IAM</b>:
      *	LambdaEC2StartStopRole (role)
      *	LambdaEC2StartStopPolicy (inline policy)
  *	<b>Grupos de logs do CloudWatch</b>:
      *	/aws/lambda/AutoStartEC2Instance
      *	/aws/lambda/AutoStopEC2Instance
      *	/aws/lambda/EC2StartWeekDay
      *	/aws/lambda/EC2StopWeekDay
      *	/aws/lambda/EC2StartWeekEnd
      *	/aws/lambda/EC2StopWeekEnd