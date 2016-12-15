td-agent: install-repo install-gelf-plugin conf-rsyslog conf-td-agent conf-input


install-deb:
	ansible-playbook main.yml -i localhost -t install_td_agent_deb

install-repo:
	ansible-playbook main.yml -i localhost -t install_td_agent_repo

remove:
	ansible-playbook main.yml -i localhost -t remove_td_agent

install-gelf-plugin:
	ansible-playbook main.yml -i localhost -t install_gelf_plugin


configure: conf-rsyslog conf-td-agent conf-input conf-output

conf-rsyslog:
	ansible-playbook main.yml -i localhost -t configure_rsyslog

conf-td-agent:
	ansible-playbook main.yml -i localhost -t configure_td_agent_server

conf-input:
	ansible-playbook main.yml -i localhost -t configure_input

conf-output:
	ansible-playbook main.yml -i localhost -t configure_output


input: input-apt input-audit input-chrony input-fail2ban input-hhvm input-lynis input-mysql input-nginx input-php-fpm input-rsyslog input-syslog input-unattended-upgrades

input-apt:
	ansible-playbook main.yml -i localhost -t input_apt

input-audit:
	ansible-playbook main.yml -i localhost -t input_audit

input-chrony:
	ansible-playbook main.yml -i localhost -t input_chrony

input-fail2ban:
	ansible-playbook main.yml -i localhost -t input_fail2ban

input-hhvm:
	ansible-playbook main.yml -i localhost -t input_hhvm

input-lynis:
	ansible-playbook main.yml -i localhost -t input_lynis

input-mysql:
	ansible-playbook main.yml -i localhost -t input_mysql

input-nginx:
	ansible-playbook main.yml -i localhost -t input_nginx

input-php-fpm:
	ansible-playbook main.yml -i localhost -t input_php_fpm

input-rsyslog:
	ansible-playbook main.yml -i localhost -t input_rsyslog

input-syslog:
	ansible-playbook main.yml -i localhost -t input_syslog

input-unattended-upgrades:
	ansible-playbook main.yml -i localhost -t input_unattended_upgrades


logs-permissions:
ansible-playbook main.yml -i localhost -t logs_permissions


start-agent-ui:
	/usr/sbin/td-agent-ui start

fluentd-ui: install-fluentd-ui start-fluentd-ui

install-fluentd-ui:
	ansible-playbook main.yml -i localhost -t install_fluentd_ui

start-fluentd-ui:
	ansible-playbook main.yml -i localhost -t start_fluentd_ui

restart-agent:
	service td-agent restart


sample-log:
	curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test

sample-logger:
	logger -t foo.bar "hello world"

localhost:
	cp -f localhost /etc/ansible/hosts


rbenv: localhost rbenv-dl rbenv-update-vars rbenv-role rbenv-install

rbenv-dl:
	ansible-galaxy install zzet.rbenv

rbenv-update-vars:
	cp -rf galaxy/zzet.rbenv/defaults/main.yml /etc/ansible/roles/zzet.rbenv/defaults/main.yml

rbenv-role:
	cp -rf galaxy/zzet.rbenv/role.yml /etc/ansible/roles/zzet.rbenv/role.yml

rbenv-install:
	ansible-playbook /etc/ansible/roles/zzet.rbenv/role.yml


rvm: localhost rvm-dl rvm-update-vars rvm-role rvm-install

rvm-dl:
	ansible-galaxy install rvm_io.rvm1-ruby

rvm-update-vars:
	cp -rf galaxy/rvm_io.rvm1-ruby/defaults/main.yml /etc/ansible/roles/rvm_io.rvm1-ruby/defaults/main.yml

rvm-role:
	cp -rf galaxy/rvm_io.rvm1-ruby/role.yml /etc/ansible/roles/rvm_io.rvm1-ruby/role.yml

rvm-install:
	ansible-playbook /etc/ansible/roles/rvm_io.rvm1-ruby/role.yml


.PHONY: localhost
