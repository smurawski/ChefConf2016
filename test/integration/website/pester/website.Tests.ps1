Describe 'webserver' {
  it 'has IIS enabled' {
    (Get-WindowsFeature web-server).installed |
      should be $true
  }
  it 'returns "hi" on port 80' {
    irm -usebasic http://localhost | 
     should match 'hi'
  }
}