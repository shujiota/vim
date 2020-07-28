# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

source /vagrant/APP/myrungo/app.env
# User specific environment and startup programs
alias down_now='sudo shutdown now'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
alias rungo='cd /vagrant/APP/myrungo'
alias rungo_vi='cd /vagrant/APP/myrungo; vim'
alias rungo_s='cd /vagrant/APP/myrungo; rails s -b 0.0.0.0'
alias rungo_c='cd /vagrant/APP/myrungo; rails c'
export MECAB_PATH=/usr/lib64/libmecab.so.2
alias ps_p='ps aux | grep [p]uma'
alias schema_db='bundle exec ridgepole -c config/database.yml --apply -f db/schemas/Schemafile'
alias db_schema='bundle exec ridgepole -c config/database.yml -E development --split --export -o db/schemas/Schemafile'
alias cap_deploy='bundle exec cap production deploy'
set bell-style none
alias cat_bash='cat ~/.bash_profile'
alias source_bash='source ~/.bash_profile'
alias rungo_scp_sql='scp conoha_myrungo:~/myrungo.sql /vagrant/APP/myrungo/zzz'
alias rungo_import_sql='mysql -u root -p myrungo_development < /vagrant/APP/myrungo/zzz/myrungo.sql'
alias rungo_export_sql='mysqldump -u  root -p myrungo_development > /vagrant/APP/myrungo/zzz/myrungo.sql'
