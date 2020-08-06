// Ensemble Production that reads input, finds the longest palidromes, and outputs the results
// Should contain instances of each of the Palidrome business hosts (Service, Process, Operation)
Class src.PalindromeProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="src.PalindromeProduction.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Read String Svc" Category="Test Palindrome" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="CallInterval">60</Setting>
    <Setting Target="Adapter" Name="FilePath">G:\Temp\Test\In</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Split Palindrome Op</Setting>
  </Item>
  <Item Name="Split Palindrome Op" Category="Test Palindrome" ClassName="src.Hosts.PalindromeOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="FilePath">G:\Temp\Test\Out\</Setting>
  </Item>
</Production>
}
}
