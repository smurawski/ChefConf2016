Describe 'webserver' {
  it 'has IIS enabled' {
    (Get-WindowsFeature web-server).installed |
      should be $true
  }
}