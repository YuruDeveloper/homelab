resource "null_resource" "SshSetup" {
  triggers = {
    container_id = var.ContainerId
  }

  provisioner "local-exec" {
    interpreter = ["PowerShell", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]
    command     = <<-EOF
      $sshArgs = @("-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null", "${var.ProxmoxUserName}@${var.ProxmoxUrl}")
      $scpArgs = @("-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null")
      $localScript = Join-Path ([System.IO.Path]::GetTempPath()) "terraform-alpine-ssh-setup-${var.VmId}.sh"
      $remoteScript = "/tmp/terraform-alpine-ssh-setup-${var.VmId}.sh"
      $script = @'
#!/bin/sh
set -eu

vmid="$1"
sshd_config="/etc/ssh/sshd_config"

pct exec "$vmid" -- apk add --no-cache openssh python3
pct exec "$vmid" -- rc-update add sshd || true
pct exec "$vmid" -- rc-service sshd start || true

pct exec "$vmid" -- python3 -c '
from pathlib import Path

p = Path("/etc/ssh/sshd_config")
directives = {
    "PermitRootLogin": "PermitRootLogin yes",
    "PasswordAuthentication": "PasswordAuthentication no",
    "PubkeyAuthentication": "PubkeyAuthentication yes",
}

lines = []
for line in p.read_text(errors="replace").replace("\ufeff", "").splitlines():
    key = line.lstrip("#").split(None, 1)[0] if line.lstrip("#").split(None, 1) else ""
    if key not in directives:
        lines.append(line)

lines.extend(directives.values())
p.write_text("\n".join(lines) + "\n")
'
pct exec "$vmid" -- rc-service sshd restart
'@

      $script = $script -replace "`r`n", "`n"
      [System.IO.File]::WriteAllText($localScript, $script, [System.Text.UTF8Encoding]::new($false))

      & scp @scpArgs $localScript "${var.ProxmoxUserName}@${var.ProxmoxUrl}:$remoteScript"
      if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

      & ssh @sshArgs chmod 700 $remoteScript
      if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

      & ssh @sshArgs $remoteScript ${var.VmId}
      if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

      & ssh @sshArgs rm -f $remoteScript
      if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

      Remove-Item -LiteralPath $localScript -Force
    EOF
  }
}
